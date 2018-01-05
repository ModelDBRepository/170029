% function to run the ODE model to compute cytokine expression

function [X] = odefnIL10KO(t, x, p, LPSstim)

global h ssdeg
h = h + 1;

% LPS stimulus
if t > 0
    LPS = LPSstim;
else
    LPS = 0;
end

%% cytokine expression rates
	
v1_a	=	p(1);                                       %	activation rate,  IL-1b
v1_2	=	LPS/(LPS + p(2));                           %	LPS activates IL-1b
v1_3	=	(x(1)^p(5))/(x(1)^p(5) + p(4)^p(5));        %	IL-1b activates IL-1b
v1_4	=	(x(2)^p(8))/(x(2)^p(8) + p(7)^p(8));        %	TNFa activates IL-1b
v1_5	=	(p(10)^p(11))/(x(3)^p(11) + p(10)^p(11));	%	IL-6 inhibits IL-1b
v1_6	=	1;	%	IL-10 inhibits IL-1b
v1_7	=	(p(16)^p(17))/(x(6)^p(17) + p(16)^p(17));	%	CCL5 inhibits IL-1b
v1_d	=	p(19)*x(1);                                 %	passive degradation of IL-1b
	
v2_a	=	p(20);                                      %	activation rate,  TNFa
v2_2	=	LPS/(LPS + p(21));                          %	LPS activates TNFa
v2_3	=	(x(1)^p(24))/(x(1)^p(24) + p(23)^p(24));    %	IL-1b activates TNFa
v2_4	=	(x(2)^p(27))/(x(2)^p(27) + p(26)^p(27));    %	TNFa activates TNFa
v2_5	=	(p(29)^p(30))/(x(3)^p(30) + p(29)^p(30));	%	IL-6 inhibits TNFa
v2_6	=	(p(32)^p(33))/(x(4)^p(33) + p(32)^p(33));	%	TGFb inhibits TNFa
v2_7	=	1;	%	IL-10 inhibits TNFa
v2_8	=	(p(38)^p(39))/(x(6)^p(39) + p(38)^p(39));	%	CCL5 inhibits TNFa
v2_d	=	p(41)*x(2);                                 %	passive degradation of TNFa
	
v3_a	=	p(42);                                      %	activation rate,  IL-6
v3_2	=	LPS/(LPS + p(43));                          %	LPS activates IL-6
v3_3	=	(x(2)^p(46))/(x(2)^p(46) + p(45)^p(46));    %	TNFa activates IL-6
v3_4	=	1;	%	IL-10 inhibits IL-6
v3_5	=	(p(51)^p(52))/(x(6)^p(52) + p(51)^p(52));	%	CCL5 inhibits IL-6
v3_d	=	p(54)*x(3);                                 %	passive degradation of IL-6
	
v4_a	=	p(55);                                      %	activation rate,  TGFb
v4_2	=	(x(2)^p(57))/(x(2)^p(57) + p(56)^p(57));    %	TNFa activates TGFb
v4_3	=	(x(4)^p(60))/(x(4)^p(60) + p(59)^p(60));    %	TGFb activates TGFb
v4_d	=	p(62)*x(4);                                 %	passive degradation of TGFb
	
% v5_a	=	p(63);                                      %	activation rate,  IL-10
% v5_2	=	LPS/(LPS + p(64));                          %	LPS activates IL-10
% v5_3	=	(x(2)^p(67))/(x(2)^p(67) + p(66)^p(67));    %	TNFa activates IL-10
% v5_4	=	(x(3)^p(70))/(x(3)^p(70) + p(69)^p(70));    %	IL-6 activates IL-10
% v5_5	=	(p(72)^p(73))/(x(6)^p(73) + p(72)^p(73));	%	CCL5 inhibits IL-10
% v5_d	=	p(75)*x(5);                                 %	passive degradation of IL-10
	
v6_a	=	p(76);                                      %	activation rate,  CCL5
v6_2	=	LPS/(LPS + p(77));                          %	LPS activates CCL5
v6_3	=	(x(1)^p(80))/(x(1)^p(80) + p(79)^p(80));    %	IL-1b activates CCL5
v6_4	=	(x(2)^p(83))/(x(2)^p(83) + p(82)^p(83));    %	TNFa activates CCL5
v6_5	=	(x(3)^p(86))/(x(3)^p(86) + p(85)^p(86));    %	IL-6 activates CCL5
v6_6	=	(p(88)^p(89))/(x(4)^p(89) + p(88)^p(89));	%	TGFb inhibits CCL5
v6_7	=	1;	%	IL-10 inhibits CCL5
v6_d	=	p(94)*x(6);                                 %	passive degradation of CCL5

%%% set the concentration-independent degradation rate constants 
%%% these constants are set at the initial time step
if h == 1
    ssdeg = zeros(1,6);
    ssdeg(1) = v1_a * v1_2 * v1_3 * v1_4 * v1_5 * v1_6 * v1_7 - v1_d;
    ssdeg(2) = v2_a * v2_2 * v2_3 * v2_4 * v2_5 * v2_6 * v2_7 * v2_8 - v2_d;
    ssdeg(3) = v3_a * v3_2 * v3_3 * v3_4 * v3_5 - v3_d;
    ssdeg(4) = v4_a * v4_2 * v4_3 - v4_d;
    ssdeg(5) = 0;
    ssdeg(6) = v6_a * v6_2 * v6_3 * v6_4 * v6_5 * v6_6 * v6_7 - v6_d;
end

%% ODEs to compute cytokine expression

X       = zeros(6,1);
X(1)    = v1_a * v1_2 * v1_3 * v1_4 * v1_5 * v1_6 * v1_7 - v1_d - ssdeg(1);        % IL-1b
X(2)    = v2_a * v2_2 * v2_3 * v2_4 * v2_5 * v2_6 * v2_7 * v2_8 - v2_d - ssdeg(2); % TNFa
X(3)    = v3_a * v3_2 * v3_3 * v3_4 * v3_5 - v3_d - ssdeg(3);                      % IL-6
X(4)    = v4_a * v4_2 * v4_3 - v4_d - ssdeg(4);                                    % TGFb
X(5)    = 0;                                                                       % IL-10
X(6)    = v6_a * v6_2 * v6_3 * v6_4 * v6_5 * v6_6 * v6_7 - v6_d - ssdeg(6);        % CCL5

end

