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

* This file is included in the main program file PEP-w-t_v4.1.gms              *

*==============================================================================
*   6.2.1 Closures
*==============================================================================
* Some closure rules are included in the LOOP in 6.2.2 below, because some
* statements include lagged variables with a (...,time-1) index and the .L
* suffix in their right-hand side (see section 6.2.2.2). These statements cannot
* be executed correctly before the solution for period time-1 has been computed.
* Other closures are defined outside of the LOOP.

*==============================================================================
*  6.2.1.1 Choice of multifactor productivity
*==============================================================================
*  6.2.1.1.1 Input for multifactor productivity
*==============================================================================
* Multifactor productivity is retrieved from a model BAU solution with
* endogenous A_VA(z,time) in equation 3, and exogenous real GDPs, fixed at
* values that are projected using Fouré, Benassy-Quéré and Fontagné projected
* growth rates. So the solution is forced to follow the GDP projected growth
* paths. The solution values of A_VA are stored as parameter A_VA_RES.
*-------------------------------------------------------------------------------

PARAMETER
 A_VA_RES(z,time)     Value of A_VA to reproduce real GDP projections
 GX(z,time)           Current government expenditures on goods and services in region z
 G_REALX(z,time)      Current real government expenditures on goods and services in region z
 INDX(k,j,z,time)     Volume of new type k capital investment to industry j in region z
 sh0X(z,time)         Intercept (household savings)
 sh1X(z,time)         Household savings rate
;

$GDXIN B_line.gdx
$LOAD A_VA_RES, sh0X, sh1X, GX, G_REALX, INDX

*==============================================================================
*  6.2.1.1.2 Choice of multifactor productivity
*==============================================================================
* If you want to reproduce the real GDP projections, set:
 A_VA.FX(z,time)     = A_VA_RES(z,time);
* Otherwise, simply put A_VA equal to one:
* A_VA.FX(z,time)     = 1;

*==============================================================================
*   6.2.1.2 Choice of reference region
*==============================================================================
* By default, the reference region is USA,
 zr(z)           = no;
 zr('USA')       = yes;
*zr('ChinaHK')   = yes;
 z1(z)           = NOT[zr(z)];


*==============================================================================
*   6.2.1.3 Choice between closures FE and FP
*==============================================================================
*$ontext
* FP CLOSURE: fixed PIXGDPs; numeraire is exchange rate of reference region
* The exchange rates are endogenous, except for the reference region.
 e.FX(zr,time)      = eO(zr);
 PIXGDP.FX(z,time)  = PIXGDPO(z)/sum(zr,eO(zr));
*$offtext

$ontext
* FE CLOSURE: fixed exchange rates; numeraire is PIXGDP of reference region
* The exchange rates can be fixed at arbitrary values
 PIXGDP.FX(zr,time)  = PIXGDPO(zr);
 e.FX(z,time)        = eO(z);
$offtext

*==============================================================================
*   6.2.1.4 Other exogenous variables
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
*   6.2.2 Solution
*==============================================================================
* Resolution for the BAU
* Begin LOOP over time periods
*==============================================================================

* EndTime is the final year for model resolution.
* Parameter EndTime is defined in the main program.
LOOP[time$(time.val le EndTime),
* T(time) is a subset of set TIME. It was previously empty. It now contains
* a single element: it is the current value of the TIME index.
T(time) = YES;

*==============================================================================
*   6.2.2.1 Initialisation
*==============================================================================

$INCLUDE INIT.gms

*==============================================================================
*   6.2.2.2 Variables fixed each period according to their lagged values
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
*   6.2.2.3 Resolution
*==============================================================================

SOLVE PEPWT USING CNS;

* The single element in subset T(time) is removed, and the subset is now empty.
T(time)          = NO;
* End of LOOP over time periods
];

*==============================================================================
*   6.2.3 Results
*==============================================================================
$INCLUDE BAU_RESULTS.gms
