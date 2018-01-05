%%% parameters for microglia model
function [p] = params()

%	%	IL1b	%	%	%%%%%	%	%	%%%%%%%%%%	
p	(	1	)	=	1	;	%	activation rate constant, IL-1b	
p	(	2	)	=	3	;	%	K, LPS -> IL1b	Lee et al., 1993
p	(	3	)	=	1	;	%	delay, LPS -> IL1b	
p	(	4	)	=	1	;	%	K, IL1b -> IL1b	Estimation
p	(	5	)	=	1	;	%	nH, IL1b -> IL1b	
p	(	6	)	=	1	;	%	delay, IL1b -> IL1b	
p	(	7	)	=	3.16;	%	K, TNFa -> IL1b	Estimation
p	(	8	)	=	1	;	%	nH, TNFa -> IL1b	
p	(	9	)	=	5	;	%	delay, TNFa -> IL1b	
p	(	10	)	=	5	;	%	K, IL6 --| IL1b	Minogue et al., 2012
p	(	11	)	=	1	;	%	nH, IL6 --| IL1b	
p	(	12	)	=	1	;	%	delay, IL6 --| IL1b	
p	(	13	)	=	20	;	%	K, IL10 --| IL1b	
p	(	14	)	=	1	;	%	nH, IL10 --| IL1b	
p	(	15	)	=	1	;	%	delay, IL10 --| IL1b	
p	(	16	)	=	900	;	%	K, CCL5 --| IL1b	Gamo et al., 2008
p	(	17	)	=	1	;	%	nH, CCL5 --| IL1b	
p	(	18	)	=	1	;	%	delay, CCL5 --| IL1b	
p	(	19	)	=	0.01;	%	passive degradation, IL-1b	

%	%	TNFa	%	%	%%%%%	%	%	%%%%%%%%%%	
p	(	20	)	=	900	;	%	activation rate constant, TNFa	
p	(	21	)	=	29	;	%	K, LPS -> TNFa	Chao et al., 1992
p	(	22	)	=	1	;	%	delay, LPS -> TNFa	
p	(	23	)	=	1.61;	%	K, IL1b -> TNFa	Chao et al., 1995a
p	(	24	)	=	1	;	%	nH, IL1b -> TNFa	
p	(	25	)	=	1	;	%	delay, IL1b -> TNFa	
p	(	26	)	=	0.05;	%	K, TNFa -> TNFa	Kuno et al., 2005
p	(	27	)	=	1	;	%	nH, TNFa -> TNFa	
p	(	28	)	=	1	;	%	delay, TNFa -> TNFa	
p	(	29	)	=	35.7;	%	K, IL6 --| TNFa	Chao et al., 1995a
p	(	30	)	=	1	;	%	nH, IL6 --| TNFa	
p	(	31	)	=	1	;	%	delay, IL6 --| TNFa	
p	(	32	)	=	0.05;	%	K, TGFb --| TNFa	Chao et al., 1995a,b
p	(	33	)	=	1	;	%	nH, TGFb --| TNFa	
p	(	34	)	=	1	;	%	delay, TGFb --| TNFa	
p	(	35	)	=	0.011;	%	K, IL10 --| TNFa	Chao et al., 1995a
p	(	36	)	=	1	;	%	nH, IL10 --| TNFa	
p	(	37	)	=	1	;	%	delay, IL10 --| TNFa	
p	(	38	)	=	973	;	%	K, CCL5 --| TNFa	Gamo et al., 2008
p	(	39	)	=	1	;	%	nH, CCL5 --| TNFa	
p	(	40	)	=	1	;	%	delay, CCL5 --| TNFa	
p	(	41	)	=	0.1	;	%	passive degradation, TNFa	
	
%	%	IL6	%	%	%%%%%	%	%	%%%%%%%%%%	
p	(	42	)	=	0.4	;	%	activation rate constant, IL6	
p	(	43	)	=	100	;	%	K, LPS -> IL6	Chao et al., 1992
p	(	44	)	=	1	;	%	delay, LPS -> IL6	
p	(	45	)	=	5	;	%	K, TNFa -> IL6	Minogue et al., 2012
p	(	46	)	=	1	;	%	nH, TNFa -> IL6	
p	(	47	)	=	1	;	%	delay, TNFa -> IL6	
p	(	48	)	=	20	;	%	K, IL10 --| IL6	
p	(	49	)	=	1	;	%	nH, IL10 --| IL6	
p	(	50	)	=	1	;	%	delay, IL10 --| IL6	
p	(	51	)	=	100	;	%	K, CCL5 --| IL6	Gamo et al., 2008
p	(	52	)	=	1	;	%	nH, CCL5 --| IL6	
p	(	53	)	=	1	;	%	delay, CCL5 --| IL6	
p	(	54	)	=	0.01;	%	passive degradation, IL6	

%	%	TGFb	%	%	%%%%%	%	%	%%%%%%%%%%	
p	(	55	)	=	40	;	%	activation rate constant, TGFb	
p	(	56	)	=	55	;	%	K, TNFa -> TGFb	Chao et al., 1995
p	(	57	)	=	1	;	%	nH, TNFa -> TGFb	
p	(	58	)	=	1	;	%	delay, TNFa -> TGFb	
p	(	59	)	=	15	;	%	K, TGFb -> TGFb	proposed
p	(	60	)	=	1	;	%	nH, TGFb -> TGFb	
p	(	61	)	=	1	;	%	delay, TGFb -> TGFb	
p	(	62	)	=	0.01;	%	passive degradation, TGFb	
	
%	%	IL10	%	%	%%%%%	%	%	%%%%%%%%%%	
p	(	63	)	=	10	;	%	activation rate constant, IL10	
p	(	64	)	=	100	;	%	K, LPS -> IL10	Sheng et al., 1995
p	(	65	)	=	1	;	%	delay, LPS -> IL10	
p	(	66	)	=	22.2;	%	K, TNFa -> IL10	Sheng et al., 1995
p	(	67	)	=	0.5	;	%	nH, TNFa -> IL10	
p	(	68	)	=	1	;	%	delay, TNFa -> IL10	
p	(	69	)	=	20	;	%	K, IL6 -> IL10	Sheng et al., 1995
p	(	70	)	=	1	;	%	nH, IL6 -> IL10	
p	(	71	)	=	1	;	%	delay, IL6 -> IL10	
p	(	72	)	=	30	;	%	K, CCL5 --| IL10	Skuljek et al., 2011
p	(	73	)	=	1	;	%	nH, CCL5 --| IL10	
p	(	74	)	=	1	;	%	delay, CCL5 --| IL10	
p	(	75	)	=	0.01;	%	passive degradation, IL10	

%	%	CCL5	%	%	%%%%%	%	%	%%%%%%%%%%	
p	(	76	)	=	3	;	%	activation rate constant, CCL5	
p	(	77	)	=	5	;	%	K, LPS -> CCL5	Hu et al., 1999
p	(	78	)	=	1	;	%	delay, LPS -> CCL5	
p	(	79	)	=	1	;	%	K, IL1b -> CCL5	Hu et al., 1999
p	(	80	)	=	1	;	%	nH, IL1b -> CCL5	
p	(	81	)	=	1	;	%	delay, IL1b -> CCL5	
p	(	82	)	=	2	;	%	K, TNFa -> CCL5	Hu et al., 1999
p	(	83	)	=	2	;	%	nH, TNFa -> CCL5	
p	(	84	)	=	1	;	%	delay, TNFa -> CCL5	
p	(	85	)	=	3	;	%	K, IL6 -> CCL5	Hu et al., 1999
p	(	86	)	=	1	;	%	nH, IL6 -> CCL5	
p	(	87	)	=	1	;	%	delay, IL6 -> CCL5	
p	(	88	)	=	1	;	%	K, TGFb --| CCL5	Hu et al., 1999
p	(	89	)	=	2	;	%	nH, TGFb --| CCL5	
p	(	90	)	=	1	;	%	delay, TGFb --| CCL5	
p	(	91	)	=	30	;	%	K, IL10 --| CCL5	Hu et al., 1999
p	(	92	)	=	1	;	%	nH, IL10 --| CCL5	
p	(	93	)	=	1	;	%	delay, IL10 --| CCL5	
p	(	94	)	=	0.001;	%	passive degradation, CCL5	
