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
*                         Andre Lemelin, Veronique Robichaud                   *
*                         and Bernard Decaluwe                                 *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

* This file is included in the program file SIM_SOLVE-25-18.gms

*==============================================================================
*  6.3.8 Output
*==============================================================================
* This program computes supplementary result variables
* and prepares a GDX file and an XLS file of all results.

*==============================================================================
*   6.3.8.1 Supplementary result variables
*==============================================================================
*    6.3.8.1.1 Declaration of supplementary result variables
*==============================================================================
Parameter
GROWTH_REAL_GDP(z,time,scen)  Real GDP growth
GROWTH_REAL_GDP_W(time,scen)  Real world GDP growth
g_exogro(z,time)              Exogenous growth for exogenously growing variables except labor
FishPMX(z,zj,time,scen)       Ficher price index of bilateral trade
FishQIM(z,time,scen)          Fisher quantity index of imports
FishPIM(z,time,scen)          Fisher price index of imports
FishQEX(z,time,scen)          Fisher quantity index of exports
FishPEX(z,time,scen)          Fisher price index of exports
FishQMX(z,zj,time,scen)       Fisher quantity index of bilateral trade
FishPMX(z,zj,time,scen)       Ficher price index of bilateral trade
TAU(j,z,time,scen)            Implicit ad valorem equivalent tax rate on value added
TAUO(j,z)                     Implicit ad valorem equivalent tax rate on value added
PIXITW(time,scen)             Fisher price index of worldwide investment expenditures
PIXKDC(z,time,scen)           Fisher price index of capital services
PIXKDCW(time,scen)            Fisher price index of worldwide capital services
PIXLDC(z,time,scen)           Fisher price index of labor services
PIXLDCW(time,scen)            Fisher price index of worldwide labor services
QIXITW(time,scen)             Fisher quantity index of worldwide investment expenditures
QIXKDC(z,time,scen)           Fisher quantity index of capital services
QIXKDCW(time,scen)            Fisher quantity index of worldwide capital services
QIXLDC(z,time,scen)           Fisher quantity index of labor services
QIXLDCW(time,scen)            Fisher quantity index of worldwide labor services
TBAL(z,time,scen)             Trade balance
Mvalue(z,time,scen)           Value of imports
Xvalue(z,time,scen)           Value of exports
Pop(z,time)                   Population (million)
;

TAUO(j,z)      = sum{time$(ord(time)=1),valTIP(j,z,time,'bau')/[valPVA(j,z,time,'bau')*valVA(j,z,time,'bau')]};

*==============================================================================
*   Taking account of the existence or not of a feasible solution
*==============================================================================
EndTime = MIN(EndTime,LastGood('BAU'),LastGood('SIM'));

* Begin LOOP over time periods
* EndTime is the final year for model resolution.
* Parameter EndTime is defined in the main program.
LOOP{scen,
LOOP[time$(time.val le EndTime),

*==============================================================================
*    6.3.8.1.2 Computation of supplementary result variables
*==============================================================================

 TBAL(z,time,scen)             = valCAB(z,time,scen) - vale(z,time,scen)*
                                [valRFass(z,time,scen) - valRDebt(z,time,scen)];

 GROWTH_REAL_GDP(z,time,scen)$[ord(time) gt 1]
                 = [valGDP_BP_REAL(z,time,scen)/valGDP_BP_REAL(z,time-1,scen)
                   -1]*100;
 GROWTH_REAL_GDP_W(time,scen)$[ord(time) gt 1]
                 = [valGDP_BP_W_REAL(time,scen)/valGDP_BP_W_REAL(time-1,scen)
                   -1]*100;
 g_exogro(z,time)$[ord(time) gt 1]
                 = [exogro(z,time)/exogro(z,time-1)-1]*100;

*==============================================================================
*    6.3.8.1.3 Fisher price and volume indexes
*==============================================================================
 FishQMX(zj,z,time,scen)$(SUM[i,IMO(i,zj,z)] gt 0)
       = {(SUM[i,valIM(i,zj,z,time,scen)*PWMO(i,zj,z)]
           /
           SUM[i,IMO(i,zj,z)*PWMO(i,zj,z)]
           )*(
           SUM[i,valIM(i,zj,z,time,scen)*valPWM(i,zj,z,time,scen)]
           /
           SUM[i,IMO(i,zj,z)*valPWM(i,zj,z,time,scen)]
          )}**0.5;

 FishPMX(zj,z,time,scen)$(SUM[i,IMO(i,zj,z)] gt 0)
       = {(SUM[i,IMO(i,zj,z)*valPWM(i,zj,z,time,scen)]
           /
           SUM[i,IMO(i,zj,z)*PWMO(i,zj,z)]
           )*(
           SUM[i,valIM(i,zj,z,time,scen)*valPWM(i,zj,z,time,scen)]
           /
           SUM[i,valIM(i,zj,z,time,scen)*PWMO(i,zj,z)]
          )}**0.5;

 FishQIM(z,time,scen)
       = {[(eO(z)*SUM{(i,zj),valIM(i,zj,z,time,scen)*[PWMO(i,zj,z)+
           SUM(ij,PWMGO(ij)*tmrg(ij,i,zj,z))]}
           )/(
           eO(z)*SUM{(i,zj),IMO(i,zj,z)*[PWMO(i,zj,z)+
           SUM(ij,PWMGO(ij)*tmrg(ij,i,zj,z))]}
         )]*[(
           vale(z,time,scen)*SUM{(i,zj),valIM(i,zj,z,time,scen)*
           [valPWM(i,zj,z,time,scen)+
           SUM(ij,valPWMG(ij,time,scen)*tmrg(ij,i,zj,z))]}
           )/(
           vale(z,time,scen)*SUM{(i,zj),IMO(i,zj,z)*
           [valPWM(i,zj,z,time,scen)
           +SUM(ij,valPWMG(ij,time,scen)*tmrg(ij,i,zj,z))]}
         )]}**0.5;

 FishPIM(z,time,scen)
       = {[(vale(z,time,scen)*SUM{(i,zj),IMO(i,zj,z)*[valPWM(i,zj,z,time,scen)+
            SUM(ij,valPWMG(ij,time,scen)*tmrg(ij,i,zj,z))]}
            )/(
            eO(z)*SUM{(i,zj),IMO(i,zj,z)*[PWMO(i,zj,z)+
            SUM(ij,PWMGO(ij)*tmrg(ij,i,zj,z))]}
          )]*[(
            vale(z,time,scen)*SUM{(i,zj),valIM(i,zj,z,time,scen)*
            [valPWM(i,zj,z,time,scen)+
            SUM(ij,valPWMG(ij,time,scen)*tmrg(ij,i,zj,z))]}
            )/(
            eO(z)*SUM{(i,zj),valIM(i,zj,z,time,scen)*[PWMO(i,zj,z)+
            SUM(ij,PWMGO(ij)*tmrg(ij,i,zj,z))]}
          )]}**0.5;

 FishQEX(z,time,scen)
       = {[(eO(z)*{SUM[(j,zj),valEX(j,z,zj,time,scen)*PWXO(j,z,zj)]+
            SUM[j,valMRGN(j,z,time,scen)*PWMGO(j)]}
            )/(
            eO(z)*{SUM[(j,zj),EXO(j,z,zj)*PWXO(j,z,zj)]+
            SUM[j,MRGNO(j,z)*PWMGO(j)]}
          )]*[(
            vale(z,time,scen)*{SUM[(j,zj),valEX(j,z,zj,time,scen)*
            valPWX(j,z,zj,time,scen)]+SUM[j,valMRGN(j,z,time,scen)*
            valPWMG(j,time,scen)]}
            )/(
            vale(z,time,scen)*{SUM[(j,zj),EXO(j,z,zj)*valPWX(j,z,zj,time,scen)]+
            SUM[j,MRGNO(j,z)*valPWMG(j,time,scen)]}
          )]}**0.5;

 FishPEX(z,time,scen)
       = {[(vale(z,time,scen)*{SUM[(j,zj),EXO(j,z,zj)*valPWX(j,z,zj,time,scen)]+
            SUM[j,MRGNO(j,z)*valPWMG(j,time,scen)]}
            )/(
            eO(z)*{SUM[(j,zj),EXO(j,z,zj)*PWXO(j,z,zj)]+
            SUM[j,MRGNO(j,z)*PWMGO(j)]}
          )]*[(
            vale(z,time,scen)*{SUM[(j,zj),valEX(j,z,zj,time,scen)*
            valPWX(j,z,zj,time,scen)]+SUM[j,valMRGN(j,z,time,scen)*
            valPWMG(j,time,scen)]}
          )/(
            eO(z)*{SUM[(j,zj),valEX(j,z,zj,time,scen)*PWXO(j,z,zj)]+
            SUM[j,valMRGN(j,z,time,scen)*PWMGO(j)]}
          )]}**0.5;

TAU(j,z,time,scen)  = valTIP(j,z,time,scen)/[valPVA(j,z,time,scen)*valVA(j,z,time,scen)];

PIXKDC(z,time,scen)           = {[sum(j,(1+TAU(j,z,time,scen))*valRC(j,z,time,scen)*KDCO(j,z))/
                                  sum(j,(1+TAUO(j,z))*RCO(j,z)*KDCO(j,z))
                                 ]*[
                                  sum(j,(1+TAU(j,z,time,scen))*valRC(j,z,time,scen)*valKDC(j,z,time,scen))/
                                  sum(j,(1+TAUO(j,z))*RCO(j,z)*valKDC(j,z,time,scen))]
                                }**0.5;

QIXKDC(z,time,scen)           = {[sum(j,(1+TAUO(j,z))*RCO(j,z)*valKDC(j,z,time,scen))/
                                  sum(j,(1+TAUO(j,z))*RCO(j,z)*KDCO(j,z))
                                 ]*[
                                  sum(j,(1+TAU(j,z,time,scen))*valRC(j,z,time,scen)*valKDC(j,z,time,scen))/
                                  sum(j,(1+TAU(j,z,time,scen))*valRC(j,z,time,scen)*KDCO(j,z))]
                                }**0.5;

PIXKDCW(time,scen)            = {[sum((j,z),(1+TAU(j,z,time,scen))*valRC(j,z,time,scen)*KDCO(j,z)/vale(z,time,scen))/
                                  sum((j,z),(1+TAUO(j,z))*RCO(j,z)*KDCO(j,z)/eO(z))
                                 ]*[
                                  sum((j,z),(1+TAU(j,z,time,scen))*valRC(j,z,time,scen)*valKDC(j,z,time,scen)/vale(z,time,scen))/
                                  sum((j,z),(1+TAUO(j,z))*RCO(j,z)*valKDC(j,z,time,scen)/eO(z))]
                                }**0.5;

QIXKDCW(time,scen)            = {[sum((j,z),(1+TAUO(j,z))*RCO(j,z)*valKDC(j,z,time,scen)/eO(z))/
                                  sum((j,z),(1+TAUO(j,z))*RCO(j,z)*KDCO(j,z)/eO(z))
                                 ]*[
                                  sum((j,z),(1+TAU(j,z,time,scen))*valRC(j,z,time,scen)*valKDC(j,z,time,scen)/vale(z,time,scen))/
                                  sum((j,z),(1+TAU(j,z,time,scen))*valRC(j,z,time,scen)*KDCO(j,z)/vale(z,time,scen))]
                                }**0.5;

PIXLDC(z,time,scen)           = {[sum(j,(1+TAU(j,z,time,scen))*valWC(j,z,time,scen)*LDCO(j,z))/
                                  sum(j,(1+TAUO(j,z))*WCO(j,z)*LDCO(j,z))
                                 ]*[
                                  sum(j,(1+TAU(j,z,time,scen))*valWC(j,z,time,scen)*valLDC(j,z,time,scen))/
                                  sum(j,(1+TAUO(j,z))*WCO(j,z)*valLDC(j,z,time,scen))]
                                }**0.5;

QIXLDC(z,time,scen)           = {[sum(j,(1+TAUO(j,z))*WCO(j,z)*valLDC(j,z,time,scen))/
                                  sum(j,(1+TAUO(j,z))*WCO(j,z)*LDCO(j,z))
                                 ]*[
                                  sum(j,(1+TAU(j,z,time,scen))*valWC(j,z,time,scen)*valLDC(j,z,time,scen))/
                                  sum(j,(1+TAU(j,z,time,scen))*valWC(j,z,time,scen)*LDCO(j,z))]
                                }**0.5;

PIXLDCW(time,scen)            = {[sum((j,z),(1+TAU(j,z,time,scen))*valWC(j,z,time,scen)*LDCO(j,z)/vale(z,time,scen))/
                                  sum((j,z),(1+TAUO(j,z))*WCO(j,z)*LDCO(j,z)/eO(z))
                                 ]*[
                                  sum((j,z),(1+TAU(j,z,time,scen))*valWC(j,z,time,scen)*valLDC(j,z,time,scen)/vale(z,time,scen))/
                                  sum((j,z),(1+TAUO(j,z))*WCO(j,z)*valLDC(j,z,time,scen)/eO(z))]
                                }**0.5;

QIXLDCW(time,scen)            = {[sum((j,z),(1+TAUO(j,z))*WCO(j,z)*valLDC(j,z,time,scen)/eO(z))/
                                  sum((j,z),(1+TAUO(j,z))*WCO(j,z)*LDCO(j,z)/eO(z))
                                 ]*[
                                  sum((j,z),(1+TAU(j,z,time,scen))*valWC(j,z,time,scen)*valLDC(j,z,time,scen)/vale(z,time,scen))/
                                  sum((j,z),(1+TAU(j,z,time,scen))*valWC(j,z,time,scen)*LDCO(j,z)/vale(z,time,scen))]
                                }**0.5;

PIXITW(time,scen)             = {[sum((j,z),valPK(z,time,scen)*ITO(z)/
                                            (vale(z,time,scen)*PKO(z)))/
                                  sum((j,z),ITO(z)/eO(z))
                                 ]*[
                                  sum((j,z),valIT(z,time,scen)/eO(z))/
                                  sum((j,z),PKO(z)*valIT(z,time,scen)/
                                            (eO(z)*valPK(z,time,scen)))]
                                }**0.5;

QIXITW(time,scen)             = {[sum((j,z),PKO(z)*valIT(z,time,scen)/
                                            (eO(z)*valPK(z,time,scen)))/
                                  sum((j,z),ITO(z)/eO(z))
                                 ]*[
                                  sum((j,z),valIT(z,time,scen)/vale(z,time,scen))/
                                  sum((j,z),valPK(z,time,scen)*ITO(z)/
                                            (vale(z,time,scen)*PKO(z)))]
                                }**0.5;

 Mvalue(z,time,scen)
       = vale(z,time,scen)*SUM{(i,zj),valIM(i,zj,z,time,scen)*
         [valPWM(i,zj,z,time,scen)+SUM(ij,valPWMG(ij,time,scen)*
         tmrg(ij,i,zj,z))]};

 Xvalue(z,time,scen)
       = vale(z,time,scen)*{SUM[(j,zj),valEX(j,z,zj,time,scen)*
         valPWX(j,z,zj,time,scen)]+SUM[j,valMRGN(j,z,time,scen)*
         valPWMG(j,time,scen)]};

 Pop(z,t1) = POPO(z);
 Pop(z,time)$[ord(time) gt 1] = Pop(z,time-1)*[1+g_POP(z,time-1)];
];
* End of LOOP over scenarios
};

*==============================================================================
*   6.3.8.2 Creation of result file
*==============================================================================
*   6.3.8.2.1 Creation of gdx result file
*==============================================================================
execute_unload 'results_PEP-w-t-fin_ALL',
 valA_VA, valC, valCAB, valCABX, valCG, valCI, valCMIN, valCTH, valCTH_REAL,
 valDD, valDEP, valDI, valDIT, valDS, vale, valEX, valEXT, valG, ValG_REAL,
 valGDP_BP, valGDP_BP_REAL, valGDP_BP_W, valGDP_BP_W_REAL, valGDP_FD, valGDP_IB,
 valGDP_MP, valGDP_MP_REAL, valIM, valIMT, valIND, valINV, valIR, valIT,
 valIT_REAL, valKD, valKDC, valKS, valLD, valLDC, valLS, valMRGN, valP, valPC,
 valPCI, valPD, valPE, valPET, valPIXCON, valPIXGDP, valPIXGDP_W, valPIXGVT,
 valPIXINV, valPK, valPL, valPM, valPMT, valPP, valPVA, valPWM, valPWMG, valPWX,
 valQ, valR, valRC, valRTI, valSG, valSH, valsh0, valsh1, valSROW, valTDH,
 valTIC, valTICT, valTIK, valTIKT, valTIM, valTIMT, valTIP, valTIPT, valTIW,
 valTIWT, valTIX, valTIXT, valTPRCTS, valTPRODN, valttdh0, valttdh1, valttic,
 valttik, valttim, valttip, valttiw, valttix, valU, valVA, valW, valWC, valWTI,
 valXS, valYDH, valYG, valYH, valYHK, valYHL, valYROW, GROWTH_REAL_GDP,
 GROWTH_REAL_GDP_W, g_exogro, FishQMX, FishPMX, FishQIM, FishPIM, FishQEX,
 FishPEX, PIXITW, PIXKDC, PIXKDCW, PIXLDC, PIXLDCW, QIXITW, QIXKDC, QIXKDCW,
 QIXLDC, QIXLDCW, TBAL, Mvalue, Xvalue, Pop, valDebt, valDebt_Lst, valEqty_old,
 valEqty, valFasset, valFasset_Lst, valFinW, valPTF_W, valPtfInv, valRDebt,
 valRFass, valRR_Debt, valRR_Eqty, valRR_Fasset, valRR_FinW, valWealth, NetIIP;

* When using a version of Excel prior to 2007, the number of rows is limited
* to 65536. In the current version of PEP w-t, the results for a few variables
* exceed this limit. Of course, adding periods/commodities/regions will
* automatically translate into even more rows. In all cases, the GDX file
* "results_PEP-w-t_ALL" created above alows reading the results regardless
* of the size of each set.
* The following code produces a GDX and an Excel files with only the main
* results.
execute_unload 'results_PEP-w-t-fin_MAIN',
 valCAB, valCABX, valCTH, valCTH_REAL, valDEP, vale, valG, ValG_REAL, valGDP_BP,
 valGDP_BP_REAL, valGDP_BP_W, valGDP_BP_W_REAL, valGDP_FD, valGDP_IB, valGDP_MP,
 valGDP_MP_REAL, valIR, valIT, valIT_REAL, valKDC, valKS, valLDC, valLS,
 valPIXCON, valPIXGDP, valPIXGDP_W, valPIXGVT, valPIXINV, valPK, valPVA, valQ,
 valRC, valSG, valSH, valsh0, valsh1, valSROW, valttdh0, valttdh1, valU, valVA,
 valW, valWC, valYDH, valYG, valYH, valYHK, valYHL, valYROW, GROWTH_REAL_GDP,
 GROWTH_REAL_GDP_W, g_exogro, FishQMX, FishPMX, FishQIM, FishPIM, FishQEX,
 FishPEX, PIXITW, PIXKDC, PIXKDCW, PIXLDC, PIXLDCW, QIXITW, QIXKDC, QIXKDCW,
 QIXLDC, QIXLDCW, TBAL, Mvalue, Xvalue, Pop, valDebt, valDebt_Lst, valEqty_old,
 valEqty, valFasset, valFasset_Lst, valFinW, valPTF_W, valPtfInv, valRDebt,
 valRFass, valRR_Debt, valRR_Eqty, valRR_Fasset, valRR_FinW, valWealth, NetIIP;
*==============================================================================
*   6.4.2.2 Creation of xls result file
*==============================================================================
* All results (for Excel version 2007 and up)
* The following lines produce an Excel spreadsheet for each variable. When
* running successive simulations with different variables in the Excel output
* file, it is suggested to rename or delete the Excel file in which the results
* are stored as GAMS will only overwrite the variables that where present in the
* previous run, leaving the older variables at their previous values.

$ontext
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valA_VA rng=valA_VA!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valC rng=valC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valCAB rng=valCAB!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valCABX rng=valCABX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valCG rng=valCG!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valCI rng=valCI!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valCMIN rng=valCMIN!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valCrdtMg rng=valCrdtMg!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valCTH rng=valCTH!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valCTH_REAL rng=valCTH_REAL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valDD rng=valDD!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valDebt rng=valDebt!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valDebt_Lst rng=valDebt_Lst!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valDEP rng=valDEP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valDI rng=valDI!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valDIT rng=valDIT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valDS rng=valDS!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=vale rng=vale!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valEqty rng=valEqty!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valEqty_old rng=valEqty_old!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valEX rng=valEX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valEXT rng=valEXT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valFasset rng=valFasset!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valFasset_Lst rng=valFasset_Lst!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valFinW rng=valFinW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valG rng=valG!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=ValG_REAL rng=ValG_REAL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valGDP_BP rng=valGDP_BP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valGDP_BP_REAL rng=valGDP_BP_REAL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valGDP_BP_W rng=valGDP_BP_W!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valGDP_BP_W_REAL rng=valGDP_BP_W_REAL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valGDP_FD rng=valGDP_FD!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valGDP_IB rng=valGDP_IB!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valGDP_MP rng=valGDP_MP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valGDP_MP_REAL rng=valGDP_MP_REAL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valIM rng=valIM!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valIMT rng=valIMT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valIND rng=valIND!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valINV rng=valINV!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valIR rng=valIR!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valIT rng=valIT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valIT_REAL rng=valIT_REAL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valKD rng=valKD!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valKDC rng=valKDC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valKS rng=valKS!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valLD rng=valLD!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valLDC rng=valLDC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valLS rng=valLS!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valMRGN rng=valMRGN!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valP rng=valP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPC rng=valPC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPCI rng=valPCI!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPD rng=valPD!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPE rng=valPE!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPET rng=valPET!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPIXCON rng=valPIXCON!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPIXGDP rng=valPIXGDP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPIXGDP_W rng=valPIXGDP_W!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPIXGVT rng=valPIXGVT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPIXINV rng=valPIXINV!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPK rng=valPK!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPL rng=valPL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPM rng=valPM!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPMT rng=valPMT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPP rng=valPP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPTF_W rng=valPTF_W!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPtfInv rng=valPtfInv!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPVA rng=valPVA!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPWM rng=valPWM!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPWMG rng=valPWMG!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valPWX rng=valPWX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valQ rng=valQ!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valR rng=valR!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valRC rng=valRC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valRDebt rng=valRDebt!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valRFass rng=valRFass!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valRR_Debt rng=valRR_Debt!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valRR_Eqty rng=valRR_Eqty!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valRR_Fasset rng=valRR_Fasset!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valRR_FinW rng=valRR_FinW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valRTI rng=valRTI!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valSG rng=valSG!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valSH rng=valSH!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valsh0 rng=valsh0!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valsh1 rng=valsh1!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valSROW rng=valSROW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTDH rng=valTDH!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIC rng=valTIC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTICT rng=valTICT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIK rng=valTIK!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIKT rng=valTIKT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIM rng=valTIM!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIMT rng=valTIMT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIP rng=valTIP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIPT rng=valTIPT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIW rng=valTIW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIWT rng=valTIWT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIX rng=valTIX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTIXT rng=valTIXT!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTPRCTS rng=valTPRCTS!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valTPRODN rng=valTPRODN!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valttdh0 rng=valttdh0!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valttdh1 rng=valttdh1!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valttic rng=valttic!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valttik rng=valttik!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valttim rng=valttim!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valttip rng=valttip!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valttiw rng=valttiw!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valttix rng=valttix!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valU rng=valU!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valVA rng=valVA!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valW rng=valW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valWC rng=valWC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valWealth rng=valWealth!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valWTI rng=valWTI!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valXS rng=valXS!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valYDH rng=valYDH!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valYG rng=valYG!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valYH rng=valYH!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valYHK rng=valYHK!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valYHL rng=valYHL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=valYROW rng=valYROW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=NetIIP rng=NetIIP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=GROWTH_REAL_GDP rng=GROWTH_REAL_GDP!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=GROWTH_REAL_GDP_W rng=GROWTH_REAL_GDP_W!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=g_exogro rng=g_exogro!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=FishPMX rng=FishPMX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=FishQIM rng=FishQIM!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=FishPIM rng=FishPIM!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=FishQEX rng=FishQEX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=FishPEX rng=FishPEX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=FishQMX rng=FishQMX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=FishPMX rng=FishPMX!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=PIXITW rng=PIXITW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=PIXKDC rng=PIXKDC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=PIXKDCW rng=PIXKDCW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=PIXLDC rng=PIXLDC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=PIXLDCW rng=PIXLDCW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=QIXITW rng=QIXITW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=QIXKDC rng=QIXKDC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=QIXKDCW rng=QIXKDCW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=QIXLDC rng=QIXLDC!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=QIXLDCW rng=QIXLDCW!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=TBAL rng=TBAL!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=Mvalue rng=Mvalue!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=Xvalue rng=Xvalue!';
Execute 'gdxxrw results_PEP-w-t_ALL.gdx par=Pop rng=Pop!';
$offtext

* Main results (for all Excel version)
Execute '=gdx2xls results_PEP-w-t-fin_MAIN.gdx';

*==============================================================================
*   6.4.3 Creation of parameter files
*==============================================================================
execute_unload 'Parameters',
 A_K, aij, B_KD, B_LD, B_M1, B_M2, B_VA, B_X1, B_X2, beta_D_X1, beta_EX_X1,
 beta_FinW1, beta_FinW2, beta_KD, beta_LD, beta_M1, beta_M2, beta_PTF1,
 beta_PTF2, beta_PTF_W, beta_VA, beta_X2, delta, eta, frisch, g_GDP, g_LS,
 g_POP, g_SDR, gamma_GVT, gamma_INV, gamma_LES, exogro, io, phi, RES, rde0,
 rfa0, rho_KD, rho_LD, rho_M1, rho_M2, rho_VA, rho_X1, rho_X2, sigma_FinW,
 sigma_INV, sigma_KD, sigma_LD, sigma_M1, sigma_M2, sigma_PTF, sigma_PTF_W,
 sigma_VA, sigma_X1, sigma_X2, sigma_Y, tmrg, v
execute '=gdx2xls parameters.gdx';
