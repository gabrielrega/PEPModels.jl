*==============================================================================*
*                                                                              *
*           Except where otherwise noted, this work is licensed under          *
*               http://creativecommons.org/licenses/by-nc-sa/3.0/              *
*                                                                              *
*                                                                              *
*  You are free to share, to copy, distribute and transmit the work under      *
*  the following conditions:                                                   *
*                                                                              *
*  - Attribution:         You must attribute the work to:                      *
*                         Veronique Robichaud, Andre Lemelin,                  *
*                         Bernard Decaluwe and Helene Maisonnave.              *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

* This file is included in the main program file PEP-w-t_v4.1.gms

*==============================================================================
*   Taking account of the existence or not of a feasible solution
*==============================================================================
PARAMETER
 SolStop
 If_Feasibl(time,scen)    Optimality status code
 StatSolver(time,scen)    Solver status code
 LastGood(scen)           Last feasible solution year
;
 SolStop = 0;
 LastGood(scen)=Endtime;
 file Status / 'ModelStatus.xls'/;
* Column separator: 6 = tab-separated file
*                   5 = comma-separated file
     Status.pc=6;
* Number of decimal places (maximum 10)
     Status.nd=0;

*==============================================================================
*  6.3.1 Closures
*==============================================================================
* Some closure rules are included in the LOOP in 6.3.2 below, because some
* statements include lagged variables with a (...,time-1) index and the .L
* suffix in their right-hand side (see section 6.3.2.3). These statements cannot
* be executed correctly before the solution for period time-1 has been computed.
* Other closures are defined outside of the LOOP.

*==============================================================================
*  6.3.1.1 Choice of multifactor productivity
*==============================================================================
* If you want to reproduce the real GDP projections, set:
 A_VA.FX(z,time)     = A_VA_RES(z,time);
* Otherwise, simply put A_VA equal to one:
* A_VA.FX(z,time)     = 1;

*==============================================================================
*   6.3.1.2 Choice of reference region
*==============================================================================
* By default, the reference region is USA,
zr(z) = no;
zr('USA')        = yes;
*zr('ChinaHK')   = yes;
z1(z)            = NOT[zr(z)];

*==============================================================================
*   6.3.1.3 Choice between closures FE and FP
*==============================================================================
*$ontext
* FP CLOSURE: fixed PIXGDPs; numeraire is exchange rate of reference region
* The exchange rates are endogenous, except for the reference region.
 e.lo(z,time)       = eps;
 e.up(z,time)       = inf;
 e.FX(zr,time)      = eO(zr);
 PIXGDP.FX(z,time)  = PIXGDPO(z)/sum(zr,eO(zr));
*$offtext

$ontext
* FE CLOSURE: fixed exchange rates; numeraire is PIXGDP of reference region
* The exchange rates can be fixed at arbitrary values
 PIXGDP.lo(z,time)   = eps;
 PIXGDP.up(z,time)   = inf;
 PIXGDP.FX(zr,time)  = PIXGDPO(zr);
 e.FX(z,time)        = eO(z);
$offtext

*==============================================================================
*   6.3.1.4 Updating exogenous variables
*==============================================================================
 CABX.FX(z1,time)    = CABXO(z1)*cabix(z1,time);
 G_REAL.FX(z,time)   = G_REALX(z,time);
 IND.fx(k,pub,z,time)= INDX(k,pub,z,time);

 sh0.fx(z,time)      = sh0X(z,time);
 sh1.fx(z,time)      = sh1X(z,time);
 ttdh0.fx(z,time)    = ttdh0O(z)*exogro(z,time);
 ttdh1.fx(z,time)    = ttdh1O(z);
 ttic.fx(i,z,time)   = tticO(i,z);
 ttik.fx(k,j,z,time) = ttikO(k,j,z);
 ttim.fx(i,zj,z,time)= ttimO(i,zj,z);
 ttip.fx(j,z,time)   = ttipO(j,z);
 ttiw.fx(l,j,z,time) = ttiwO(l,j,z);
 ttix.fx(i,z,zj,time)= ttixO(i,z,zj);

*==============================================================================
*   6.3.2 Solution
*==============================================================================
* Resolution for the simulation scenario
* Begin LOOP over time periods
*==============================================================================

* EndTime is the final year for model resolution.
* Parameter EndTime is defined in the main program.
LOOP[time${(time.val le EndTime) and (SolStop eq 0)},
* T(time) is a subset of set TIME. It was previously empty. It now contains
* a single element: it is the current value of the TIME index.
T(time) = YES;

*==============================================================================
*   6.3.2.1 Initialisation
*==============================================================================
$INCLUDE INIT.gms

*==============================================================================
*   6.3.2.2 Bounds on variables
*==============================================================================
 DS.LO(i,z,time)$(ord(time) gt 1)     = 0.0001*DS.l(i,z,time-1);
 EX.LO(i,z,zj,time)$(ord(time) gt 1)  = 0.0001*EX.l(i,z,zj,time-1);
 EXT.LO(i,z,time)$(ord(time) gt 1)    = 0.0001*EXT.l(i,z,time-1);
 IM.LO(i,zj,z,time)$(ord(time) gt 1)  = 0.0001*IM.l(i,zj,z,time-1);
 KDC.LO(j,z,time)$(ord(time) gt 1)    = 0.0001*KDC.l(j,z,time-1);
 LD.LO(l,j,z,time)$(ord(time) gt 1)   = 0.0001*LD.l(l,j,z,time-1);
 LDC.LO(j,z,time)$(ord(time) gt 1)    = 0.0001*LDC.l(j,z,time-1);
 R.LO(k,j,z,time)$(ord(time) gt 1)    = 0.0001*R.l(k,j,z,time-1);
 RC.LO(j,z,time)$(ord(time) gt 1)     = 0.0001*RC.l(j,z,time-1);
 RTI.lo(k,bus,z,time)$(ord(time) gt 1)= 0.0001*RTI.l(k,bus,z,time-1);
 U.LO(z,time)$(ord(time) gt 1)        = 0.0001*U.l(z,time-1);
 WC.LO(j,z,time)$(ord(time) gt 1)     = 0.0001*WC.l(j,z,time-1);

*==============================================================================
*   6.3.2.3 Variables fixed each period according to their lagged values
*==============================================================================
 CMIN.FX(i,z,t1)     = CMINO(i,z);
 CMIN.FX(i,z,time)$[ord(time) gt 1]
                     = CMIN.l(i,z,time-1)*[1+g_POP(z,time-1)];

 KD.fx(k,j,z,t1)$KDO(k,j,z)
                     = KDO(k,j,z);
 KD.fx(k,j,z,time)${[ord(time) gt 1] and KDO(k,j,z)}
                     = KD.l(k,j,z,time-1)*[1-delta(z)]+IND.l(k,j,z,time-1);

 LS.FX(l,z,t1)       = LSO(l,z);
 LS.FX(l,z,time)$[ord(time) gt 1]
                     = LS.l(l,z,time-1)*[1+g_LS(z,time-1)];

*==============================================================================
*   6.3.2.4 Simulation scenario
*==============================================================================
* ttim.fx(i,zj,z,time)= 2*ttimO(i,zj,z);
* ttim.fx(i,zj,z,time)= 0;
 G_REAL.FX(z,time)   = 1.1*G_REALX(z,time);

*==============================================================================
*   6.3.2.5 Resolution
*==============================================================================

SOLVE PEPWT USING CNS;
*==============================================================================
*   Taking account of the existence or not of a feasible solution
*==============================================================================
 If_Feasibl(time,'SIM') = PEPWT.modelstat;
 StatSolver(time,'SIM') = PEPWT.solvestat;

 Solstop = 1$(PEPWT.modelstat ne 16);
 LastGood('SIM')$(PEPWT.modelstat ne 16)= (time.val-1);

 put Status;
 put 'SIM', time.val, 'Optimality status', PEPWT.Tmodstat, 'Solver status', PEPWT.Tsolstat  /;

* The single element in subset T(time) is removed, and the subset is now empty.
T(time)          = NO;
* End of LOOP over time periods
];

*==============================================================================
*  6.3.3 Simulation results
*==============================================================================
$INCLUDE SIM_RESULTS.gms
*==============================================================================
*  6.4 Output
*==============================================================================
$INCLUDE XLS_RESULTS.gms
