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
*                         Helene Maisonnave and Bernard Decaluwe.              *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*


* This program computes values for the simulation scenario,
* and prepares a GDX file and an XLS file of all results.
 valC(i,h,time,'sim1')         = C.l(i,h,time);
 valCAB(time,'sim1')           = CAB.l(time);
 valCG(i,time,'sim1')          = CG.l(i,time);
 valCI(j,time,'sim1')          = CI.l(j,time);
 valCMIN(i,h,time,'sim1')      = CMIN.l(i,h,time);
 valCTH(h,time,'sim1')         = CTH.l(h,time);
 valCTH_REAL(h,time,'sim1')    = CTH_REAL.l(h,time);
 valDD(i,time,'sim1')          = DD.l(i,time);
 valDI(i,j,time,'sim1')        = DI.l(i,j,time);
 valDIT(i,time,'sim1')         = DIT.l(i,time);
 valDS(j,i,time,'sim1')        = DS.l(j,i,time);
 vale(time,'sim1')             = e.l(time);
 valEX(j,i,time,'sim1')        = EX.l(j,i,time);
 valEXD(i,time,'sim1')         = EXD.l(i,time);
 valG(time,'sim1')             = G.l(time);
 valG_REAL(time,'sim1')        = G_REAL.l(time);
 valGDP_BP(time,'sim1')        = GDP_BP.l(time);
 valGDP_BP_REAL(time,'sim1')   = GDP_BP_REAL.l(time);
 valGDP_FD(time,'sim1')        = GDP_FD.l(time);
 valGDP_IB(time,'sim1')        = GDP_IB.l(time);
 valGDP_MP(time,'sim1')        = GDP_MP.l(time);
 valGDP_MP_REAL(time,'sim1')   = GDP_MP_REAL.l(time);
 valGFCF(time,'sim1')          = GFCF.l(time);
 valGFCF_PRI_REAL(time,'sim1') = GFCF_PRI_REAL.l(time);
 valGFCF_PUB_REAL(time,'sim1') = GFCF_PUB_REAL.l(time);
 valIM(i,time,'sim1')          = IM.l(i,time);
 valIND(k,j,time,'sim1')       = IND.l(k,j,time);
 valINV(i,time,'sim1')         = INV.l(i,time);
 valINV_PRI(i,time,'sim1')     = INV_PRI.l(i,time);
 valINV_PUB(i,time,'sim1')     = INV_PUB.l(i,time);
 valIR(time,'sim1')            = IR.l(time);
 valIT(time,'sim1')            = IT.l(time);
 valIT_PRI(time,'sim1')        = IT_PRI.l(time);
 valIT_PUB(time,'sim1')        = IT_PUB.l(time);
 valKD(k,j,time,'sim1')        = KD.l(k,j,time);
 valKDC(j,time,'sim1')         = KDC.l(j,time);
 valKS(k,time,'sim1')          = KS.l(k,time);
 valLD(l,j,time,'sim1')        = LD.l(l,j,time);
 valLDC(j,time,'sim1')         = LDC.l(j,time);
 valLS(l,time,'sim1')          = LS.l(l,time);
 valMRGN(i,time,'sim1')        = MRGN.l(i,time);
 valP(j,i,time,'sim1')         = P.l(j,i,time);
 valPC(i,time,'sim1')          = PC.l(i,time);
 valPCI(j,time,'sim1')         = PCI.l(j,time);
 valPD(i,time,'sim1')          = PD.l(i,time);
 valPE(i,time,'sim1')          = PE.l(i,time);
 valPE_FOB(i,time,'sim1')      = PE_FOB.l(i,time);
 valPIXCON(time,'sim1')        = PIXCON.l(time);
 valPIXGDP(time,'sim1')        = PIXGDP.l(time);
 valPIXGVT(time,'sim1')        = PIXGVT.l(time);
 valPIXINV_PRI(time,'sim1')    = PIXINV_PRI.l(time);
 valPIXINV_PUB(time,'sim1')    = PIXINV_PUB.l(time);
 valPK_PRI(time,'sim1')        = PK_PRI.l(time);
 valPK_PUB(time,'sim1')        = PK_PUB.l(time);
 valPL(i,time,'sim1')          = PL.l(i,time);
 valPM(i,time,'sim1')          = PM.l(i,time);
 valPP(j,time,'sim1')          = PP.l(j,time);
 valPT(j,time,'sim1')          = PT.l(j,time);
 valPVA(j,time,'sim1')         = PVA.l(j,time);
 valPWM(i,time,'sim1')         = PWM.l(i,time);
 valPWX(i,time,'sim1')         = PWX.l(i,time);
 valQ(i,time,'sim1')           = Q.l(i,time);
 valR(k,j,time,'sim1')         = R.l(k,j,time);
 valRC(j,time,'sim1')          = RC.l(j,time);
 valRTI(k,j,time,'sim1')       = RTI.l(k,j,time);
 valSF(f,time,'sim1')          = SF.l(f,time);
 valSG(time,'sim1')            = SG.l(time);
 valSH(h,time,'sim1')          = SH.l(h,time);
 valsh0(h,time,'sim1')         = sh0.l(h,time);
 valsh1(h,time,'sim1')         = sh1.l(h,time);
 valSROW(time,'sim1')          = SROW.l(time);
 valTDF(f,time,'sim1')         = TDF.l(f,time);
 valTDFT(time,'sim1')          = TDFT.l(time);
 valTDH(h,time,'sim1')         = TDH.l(h,time);
 valTDHT(time,'sim1')          = TDHT.l(time);
 valTIC(i,time,'sim1')         = TIC.l(i,time);
 valTICT(time,'sim1')          = TICT.l(time);
 valTIK(k,j,time,'sim1')       = TIK.l(k,j,time);
 valTIKT(time,'sim1')          = TIKT.l(time);
 valTIM(i,time,'sim1')         = TIM.l(i,time);
 valTIMT(time,'sim1')          = TIMT.l(time);
 valTIP(j,time,'sim1')         = TIP.l(j,time);
 valTIPT(time,'sim1')          = TIPT.l(time);
 valTIW(l,j,time,'sim1')       = TIW.l(l,j,time);
 valTIWT(time,'sim1')          = TIWT.l(time);
 valTIX(i,time,'sim1')         = TIX.l(i,time);
 valTIXT(time,'sim1')          = TIXT.l(time);
 valTPRCTS(time,'sim1')        = TPRCTS.l(time);
 valTPRODN(time,'sim1')        = TPRODN.l(time);
 valTR(ag,agj,time,'sim1')     = TR.l(ag,agj,time);
 valtr0(h,time,'sim1')         = tr0.l(h,time);
 valtr1(h,time,'sim1')         = tr1.l(h,time);
 valttdf0(f,time,'sim1')       = ttdf0.l(f,time);
 valttdf1(f,time,'sim1')       = ttdf1.l(f,time);
 valttdh0(h,time,'sim1')       = ttdh0.l(h,time);
 valttdh1(h,time,'sim1')       = ttdh1.l(h,time);
 valttic(i,time,'sim1')        = ttic.l(i,time);
 valttik(k,j,time,'sim1')      = ttik.l(k,j,time);
 valttim(i,time,'sim1')        = ttim.l(i,time);
 valttip(j,time,'sim1')        = ttip.l(j,time);
 valttiw(l,j,time,'sim1')      = ttiw.l(l,j,time);
 valttix(i,time,'sim1')        = ttix.l(i,time);
 valU(k,j,time,'sim1')         = U.l(k,j,time);
 valVA(j,time,'sim1')          = VA.l(j,time);
 valVSTK(i,time,'sim1')        = VSTK.l(i,time);
 valW(l,time,'sim1')           = W.l(l,time);
 valWC(j,time,'sim1')          = WC.l(j,time);
 valWTI(l,j,time,'sim1')       = WTI.l(l,j,time);
 valXS(j,i,time,'sim1')        = XS.l(j,i,time);
 valXST(j,time,'sim1')         = XST.l(j,time);
 valYDF(f,time,'sim1')         = YDF.l(f,time);
 valYDH(h,time,'sim1')         = YDH.l(h,time);
 valYF(f,time,'sim1')          = YF.l(f,time);
 valYFK(f,time,'sim1')         = YFK.l(f,time);
 valYFTR(f,time,'sim1')        = YFTR.l(f,time);
 valYG(time,'sim1')            = YG.l(time);
 valYGK(time,'sim1')           = YGK.l(time);
 valYGTR(time,'sim1')          = YGTR.l(time);
 valYH(h,time,'sim1')          = YH.l(h,time);
 valYHK(h,time,'sim1')         = YHK.l(h,time);
 valYHL(h,time,'sim1')         = YHL.l(h,time);
 valYHTR(h,time,'sim1')        = YHTR.l(h,time);
 valYROW(time,'sim1')          = YROW.l(time);
 valPIXCON_C(t1,'sim1')        = PIXCON.l(t1);
 valPIXGDP_C(t1,'sim1')        = PIXGDP.l(t1);
 valPIXINV_PRI_C(t1,'sim1')    = PIXINV_PRI.l(t1);
 valPIXINV_PUB_C(t1,'sim1')    = PIXINV_PUB.l(t1);
loop[time$(ORD(time) gt 1),
 valPIXCON_C(time,'sim1')      = valPIXCON_C(time-1,'sim1')*SUM[i,PC.l(i,time)*SUM[h,C.l(i,h,time-1)]]
                               /SUM[i,PC.l(i,time-1)*SUM[h,C.l(i,h,time-1)]];
 valPIXGDP_C(time,'sim1')      = valPIXGDP_C(time-1,'sim1')*{SUM[j,PVA.l(j,time)*VA.l(j,time-1)]
                               /SUM[j,PVA.l(j,time-1)*VA.l(j,time-1)]*SUM[j,PVA.l(j,time)
                               *VA.l(j,time)]/SUM[j,PVA.l(j,time-1)*VA.l(j,time)]}**0.5;
 valPIXINV_PRI_C(time,'sim1')  = valPIXINV_PRI_C(time-1,'sim1')*PROD[i$gamma_INVPRI(i),
                           (PC.l(i,time)/PC.l(i,time-1))**gamma_INVPRI(i)];
 valPIXINV_PUB_C(time,'sim1')  = valPIXINV_PUB_C(time-1,'sim1')*PROD[i$gamma_INVPUB(i),
                           (PC.l(i,time)/PC.l(i,time-1))**gamma_INVPUB(i)];
];

 valC(i,h,time,'var')$valC(i,h,time,'bau')                 =  (valC(i,h,time,'sim1')/valC(i,h,time,'bau')-1)*100;
 valCAB(time,'var')$valCAB(time,'bau')                     =  (valCAB(time,'sim1')/valCAB(time,'bau')-1)*100;
 valCG(i,time,'var')$valCG(i,time,'bau')                   =  (valCG(i,time,'sim1')/valCG(i,time,'bau')-1)*100;
 valCI(j,time,'var')$valCI(j,time,'bau')                   =  (valCI(j,time,'sim1')/valCI(j,time,'bau')-1)*100;
 valCMIN(i,h,time,'var')$valCMIN(i,h,time,'bau')           =  (valCMIN(i,h,time,'sim1')/valCMIN(i,h,time,'bau')-1)*100;
 valCTH(h,time,'var')$valCTH(h,time,'bau')                 =  (valCTH(h,time,'sim1')/valCTH(h,time,'bau')-1)*100;
 valCTH_REAL(h,time,'var')$valCTH_REAL(h,time,'bau')       =  (valCTH_REAL(h,time,'sim1')/valCTH_REAL(h,time,'bau')-1)*100;
 valDD(i,time,'var')$valDD(i,time,'bau')                   =  (valDD(i,time,'sim1')/valDD(i,time,'bau')-1)*100;
 valDI(i,j,time,'var')$valDI(i,j,time,'bau')               =  (valDI(i,j,time,'sim1')/valDI(i,j,time,'bau')-1)*100;
 valDIT(i,time,'var')$valDIT(i,time,'bau')                 =  (valDIT(i,time,'sim1')/valDIT(i,time,'bau')-1)*100;
 valDS(j,i,time,'var')$valDS(j,i,time,'bau')               =  (valDS(j,i,time,'sim1')/valDS(j,i,time,'bau')-1)*100;
 vale(time,'var')$vale(time,'bau')                         =  (vale(time,'sim1')/vale(time,'bau')-1)*100;
 valEX(j,i,time,'var')$valEX(j,i,time,'bau')               =  (valEX(j,i,time,'sim1')/valEX(j,i,time,'bau')-1)*100;
 valEXD(i,time,'var')$valEXD(i,time,'bau')                 =  (valEXD(i,time,'sim1')/valEXD(i,time,'bau')-1)*100;
 valG(time,'var')$valG(time,'bau')                         =  (valG(time,'sim1')/valG(time,'bau')-1)*100;
 valG_REAL(time,'var')$valG_REAL(time,'bau')               =  (valG_REAL(time,'sim1')/valG_REAL(time,'bau')-1)*100;
 valGDP_BP(time,'var')$valGDP_BP(time,'bau')               =  (valGDP_BP(time,'sim1')/valGDP_BP(time,'bau')-1)*100;
 valGDP_BP_REAL(time,'var')$valGDP_BP_REAL(time,'bau')     =  (valGDP_BP_REAL(time,'sim1')/valGDP_BP_REAL(time,'bau')-1)*100;
 valGDP_FD(time,'var')$valGDP_FD(time,'bau')               =  (valGDP_FD(time,'sim1')/valGDP_FD(time,'bau')-1)*100;
 valGDP_IB(time,'var')$valGDP_IB(time,'bau')               =  (valGDP_IB(time,'sim1')/valGDP_IB(time,'bau')-1)*100;
 valGDP_MP(time,'var')$valGDP_MP(time,'bau')               =  (valGDP_MP(time,'sim1')/valGDP_MP(time,'bau')-1)*100;
 valGDP_MP_REAL(time,'var')$valGDP_MP_REAL(time,'bau')     =  (valGDP_MP_REAL(time,'sim1')/valGDP_MP_REAL(time,'bau')-1)*100;
 valGFCF(time,'var')$valGFCF(time,'bau')                   =  (valGFCF(time,'sim1')/valGFCF(time,'bau')-1)*100;
 valGFCF_PRI_REAL(time,'var')$valGFCF_PRI_REAL(time,'bau') =  (valGFCF_PRI_REAL(time,'sim1')/valGFCF_PRI_REAL(time,'bau')-1)*100;
 valGFCF_PUB_REAL(time,'var')$valGFCF_PUB_REAL(time,'bau') =  (valGFCF_PUB_REAL(time,'sim1')/valGFCF_PUB_REAL(time,'bau')-1)*100;
 valIM(i,time,'var')$valIM(i,time,'bau')                   =  (valIM(i,time,'sim1')/valIM(i,time,'bau')-1)*100;
 valIND(k,j,time,'var')$valIND(k,j,time,'bau')             =  (valIND(k,j,time,'sim1')/valIND(k,j,time,'bau')-1)*100;
 valINV(i,time,'var')$valINV(i,time,'bau')                 =  (valINV(i,time,'sim1')/valINV(i,time,'bau')-1)*100;
 valINV_PRI(i,time,'var')$valINV_PRI(i,time,'bau')         =  (valINV_PRI(i,time,'sim1')/valINV_PRI(i,time,'bau')-1)*100;
 valINV_PUB(i,time,'var')$valINV_PUB(i,time,'bau')         =  (valINV_PUB(i,time,'sim1')/valINV_PUB(i,time,'bau')-1)*100;
 valIR(time,'var')$valIR(time,'bau')                       =  (valIR(time,'sim1')/valIR(time,'bau')-1)*100;
 valIT(time,'var')$valIT(time,'bau')                       =  (valIT(time,'sim1')/valIT(time,'bau')-1)*100;
 valIT_PRI(time,'var')$valIT_PRI(time,'bau')               =  (valIT_PRI(time,'sim1')/valIT_PRI(time,'bau')-1)*100;
 valIT_PUB(time,'var')$valIT_PUB(time,'bau')               =  (valIT_PUB(time,'sim1')/valIT_PUB(time,'bau')-1)*100;
 valKD(k,j,time,'var')$valKD(k,j,time,'bau')               =  (valKD(k,j,time,'sim1')/valKD(k,j,time,'bau')-1)*100;
 valKDC(j,time,'var')$valKDC(j,time,'bau')                 =  (valKDC(j,time,'sim1')/valKDC(j,time,'bau')-1)*100;
 valKS(k,time,'var')$valKS(k,time,'bau')                   =  (valKS(k,time,'sim1')/valKS(k,time,'bau')-1)*100;
 valLD(l,j,time,'var')$valLD(l,j,time,'bau')               =  (valLD(l,j,time,'sim1')/valLD(l,j,time,'bau')-1)*100;
 valLDC(j,time,'var')$valLDC(j,time,'bau')                 =  (valLDC(j,time,'sim1')/valLDC(j,time,'bau')-1)*100;
 valLS(l,time,'var')$valLS(l,time,'bau')                   =  (valLS(l,time,'sim1')/valLS(l,time,'bau')-1)*100;
 valMRGN(i,time,'var')$valMRGN(i,time,'bau')               =  (valMRGN(i,time,'sim1')/valMRGN(i,time,'bau')-1)*100;
 valP(j,i,time,'var')$valP(j,i,time,'bau')                 =  (valP(j,i,time,'sim1')/valP(j,i,time,'bau')-1)*100;
 valPC(i,time,'var')$valPC(i,time,'bau')                   =  (valPC(i,time,'sim1')/valPC(i,time,'bau')-1)*100;
 valPCI(j,time,'var')$valPCI(j,time,'bau')                 =  (valPCI(j,time,'sim1')/valPCI(j,time,'bau')-1)*100;
 valPD(i,time,'var')$valPD(i,time,'bau')                   =  (valPD(i,time,'sim1')/valPD(i,time,'bau')-1)*100;
 valPE(i,time,'var')$valPE(i,time,'bau')                   =  (valPE(i,time,'sim1')/valPE(i,time,'bau')-1)*100;
 valPE_FOB(i,time,'var')$valPE_FOB(i,time,'bau')           =  (valPE_FOB(i,time,'sim1')/valPE_FOB(i,time,'bau')-1)*100;
 valPIXCON(time,'var')$valPIXCON(time,'bau')               =  (valPIXCON(time,'sim1')/valPIXCON(time,'bau')-1)*100;
 valPIXGDP(time,'var')$valPIXGDP(time,'bau')               =  (valPIXGDP(time,'sim1')/valPIXGDP(time,'bau')-1)*100;
 valPIXGVT(time,'var')$valPIXGVT(time,'bau')               =  (valPIXGVT(time,'sim1')/valPIXGVT(time,'bau')-1)*100;
 valPIXINV_PRI(time,'var')$valPIXINV_PRI(time,'bau')       =  (valPIXINV_PRI(time,'sim1')/valPIXINV_PRI(time,'bau')-1)*100;
 valPIXINV_PUB(time,'var')$valPIXINV_PUB(time,'bau')       =  (valPIXINV_PUB(time,'sim1')/valPIXINV_PUB(time,'bau')-1)*100;
 valPK_PRI(time,'var')$valPK_PRI(time,'bau')               =  (valPK_PRI(time,'sim1')/valPK_PRI(time,'bau')-1)*100;
 valPK_PUB(time,'var')$valPK_PUB(time,'bau')               =  (valPK_PUB(time,'sim1')/valPK_PUB(time,'bau')-1)*100;
 valPL(i,time,'var')$valPL(i,time,'bau')                   =  (valPL(i,time,'sim1')/valPL(i,time,'bau')-1)*100;
 valPM(i,time,'var')$valPM(i,time,'bau')                   =  (valPM(i,time,'sim1')/valPM(i,time,'bau')-1)*100;
 valPP(j,time,'var')$valPP(j,time,'bau')                   =  (valPP(j,time,'sim1')/valPP(j,time,'bau')-1)*100;
 valPT(j,time,'var')$valPT(j,time,'bau')                   =  (valPT(j,time,'sim1')/valPT(j,time,'bau')-1)*100;
 valPVA(j,time,'var')$valPVA(j,time,'bau')                 =  (valPVA(j,time,'sim1')/valPVA(j,time,'bau')-1)*100;
 valPWM(i,time,'var')$valPWM(i,time,'bau')                 =  (valPWM(i,time,'sim1')/valPWM(i,time,'bau')-1)*100;
 valPWX(i,time,'var')$valPWX(i,time,'bau')                 =  (valPWX(i,time,'sim1')/valPWX(i,time,'bau')-1)*100;
 valQ(i,time,'var')$valQ(i,time,'bau')                     =  (valQ(i,time,'sim1')/valQ(i,time,'bau')-1)*100;
 valR(k,j,time,'var')$valR(k,j,time,'bau')                 =  (valR(k,j,time,'sim1')/valR(k,j,time,'bau')-1)*100;
 valRC(j,time,'var')$valRC(j,time,'bau')                   =  (valRC(j,time,'sim1')/valRC(j,time,'bau')-1)*100;
 valRTI(k,j,time,'var')$valRTI(k,j,time,'bau')             =  (valRTI(k,j,time,'sim1')/valRTI(k,j,time,'bau')-1)*100;
 valSF(f,time,'var')$valSF(f,time,'bau')                   =  (valSF(f,time,'sim1')/valSF(f,time,'bau')-1)*100;
 valSG(time,'var')$valSG(time,'bau')                       =  (valSG(time,'sim1')/valSG(time,'bau')-1)*100;
 valSH(h,time,'var')$valSH(h,time,'bau')                   =  (valSH(h,time,'sim1')/valSH(h,time,'bau')-1)*100;
 valsh0(h,time,'var')$valsh0(h,time,'bau')                 =  (valsh0(h,time,'sim1')/valsh0(h,time,'bau')-1)*100;
 valsh1(h,time,'var')$valsh1(h,time,'bau')                 =  (valsh1(h,time,'sim1')/valsh1(h,time,'bau')-1)*100;
 valSROW(time,'var')$valSROW(time,'bau')                   =  (valSROW(time,'sim1')/valSROW(time,'bau')-1)*100;
 valTDF(f,time,'var')$valTDF(f,time,'bau')                 =  (valTDF(f,time,'sim1')/valTDF(f,time,'bau')-1)*100;
 valTDFT(time,'var')$valTDFT(time,'bau')                   =  (valTDFT(time,'sim1')/valTDFT(time,'bau')-1)*100;
 valTDH(h,time,'var')$valTDH(h,time,'bau')                 =  (valTDH(h,time,'sim1')/valTDH(h,time,'bau')-1)*100;
 valTDHT(time,'var')$valTDHT(time,'bau')                   =  (valTDHT(time,'sim1')/valTDHT(time,'bau')-1)*100;
 valTIC(i,time,'var')$valTIC(i,time,'bau')                 =  (valTIC(i,time,'sim1')/valTIC(i,time,'bau')-1)*100;
 valTICT(time,'var')$valTICT(time,'bau')                   =  (valTICT(time,'sim1')/valTICT(time,'bau')-1)*100;
 valTIK(k,j,time,'var')$valTIK(k,j,time,'bau')             =  (valTIK(k,j,time,'sim1')/valTIK(k,j,time,'bau')-1)*100;
 valTIKT(time,'var')$valTIKT(time,'bau')                   =  (valTIKT(time,'sim1')/valTIKT(time,'bau')-1)*100;
 valTIM(i,time,'var')$valTIM(i,time,'bau')                 =  (valTIM(i,time,'sim1')/valTIM(i,time,'bau')-1)*100;
 valTIMT(time,'var')$valTIMT(time,'bau')                   =  (valTIMT(time,'sim1')/valTIMT(time,'bau')-1)*100;
 valTIP(j,time,'var')$valTIP(j,time,'bau')                 =  (valTIP(j,time,'sim1')/valTIP(j,time,'bau')-1)*100;
 valTIPT(time,'var')$valTIPT(time,'bau')                   =  (valTIPT(time,'sim1')/valTIPT(time,'bau')-1)*100;
 valTIW(l,j,time,'var')$valTIW(l,j,time,'bau')             =  (valTIW(l,j,time,'sim1')/valTIW(l,j,time,'bau')-1)*100;
 valTIWT(time,'var')$valTIWT(time,'bau')                   =  (valTIWT(time,'sim1')/valTIWT(time,'bau')-1)*100;
 valTIX(i,time,'var')$valTIX(i,time,'bau')                 =  (valTIX(i,time,'sim1')/valTIX(i,time,'bau')-1)*100;
 valTIXT(time,'var')$valTIXT(time,'bau')                   =  (valTIXT(time,'sim1')/valTIXT(time,'bau')-1)*100;
 valTPRCTS(time,'var')$valTPRCTS(time,'bau')               =  (valTPRCTS(time,'sim1')/valTPRCTS(time,'bau')-1)*100;
 valTPRODN(time,'var')$valTPRODN(time,'bau')               =  (valTPRODN(time,'sim1')/valTPRODN(time,'bau')-1)*100;
 valTR(ag,agj,time,'var')$valTR(ag,agj,time,'bau')         =  (valTR(ag,agj,time,'sim1')/valTR(ag,agj,time,'bau')-1)*100;
 valtr0(h,time,'var')$valtr0(h,time,'bau')                 =  (valtr0(h,time,'sim1')/valtr0(h,time,'bau')-1)*100;
 valtr1(h,time,'var')$valtr1(h,time,'bau')                 =  (valtr1(h,time,'sim1')/valtr1(h,time,'bau')-1)*100;
 valttdf0(f,time,'var')$valttdf0(f,time,'bau')             =  (valttdf0(f,time,'sim1')/valttdf0(f,time,'bau')-1)*100;
 valttdf1(f,time,'var')$valttdf1(f,time,'bau')             =  (valttdf1(f,time,'sim1')/valttdf1(f,time,'bau')-1)*100;
 valttdh0(h,time,'var')$valttdh0(h,time,'bau')             =  (valttdh0(h,time,'sim1')/valttdh0(h,time,'bau')-1)*100;
 valttdh1(h,time,'var')$valttdh1(h,time,'bau')             =  (valttdh1(h,time,'sim1')/valttdh1(h,time,'bau')-1)*100;
 valttic(i,time,'var')$valttic(i,time,'bau')               =  (valttic(i,time,'sim1')/valttic(i,time,'bau')-1)*100;
 valttik(k,j,time,'var')$valttik(k,j,time,'bau')           =  (valttik(k,j,time,'sim1')/valttik(k,j,time,'bau')-1)*100;
 valttim(i,time,'var')$valttim(i,time,'bau')               =  (valttim(i,time,'sim1')/valttim(i,time,'bau')-1)*100;
 valttip(j,time,'var')$valttip(j,time,'bau')               =  (valttip(j,time,'sim1')/valttip(j,time,'bau')-1)*100;
 valttiw(l,j,time,'var')$valttiw(l,j,time,'bau')           =  (valttiw(l,j,time,'sim1')/valttiw(l,j,time,'bau')-1)*100;
 valttix(i,time,'var')$valttix(i,time,'bau')               =  (valttix(i,time,'sim1')/valttix(i,time,'bau')-1)*100;
 valU(k,j,time,'var')$valU(k,j,time,'bau')                 =  (valU(k,j,time,'sim1')/valU(k,j,time,'bau')-1)*100;
 valVA(j,time,'var')$valVA(j,time,'bau')                   =  (valVA(j,time,'sim1')/valVA(j,time,'bau')-1)*100;
 valVSTK(i,time,'var')$valVSTK(i,time,'bau')               =  (valVSTK(i,time,'sim1')/valVSTK(i,time,'bau')-1)*100;
 valW(l,time,'var')$valW(l,time,'bau')                     =  (valW(l,time,'sim1')/valW(l,time,'bau')-1)*100;
 valWC(j,time,'var')$valWC(j,time,'bau')                   =  (valWC(j,time,'sim1')/valWC(j,time,'bau')-1)*100;
 valWTI(l,j,time,'var')$valWTI(l,j,time,'bau')             =  (valWTI(l,j,time,'sim1')/valWTI(l,j,time,'bau')-1)*100;
 valXS(j,i,time,'var')$valXS(j,i,time,'bau')               =  (valXS(j,i,time,'sim1')/valXS(j,i,time,'bau')-1)*100;
 valXST(j,time,'var')$valXST(j,time,'bau')                 =  (valXST(j,time,'sim1')/valXST(j,time,'bau')-1)*100;
 valYDF(f,time,'var')$valYDF(f,time,'bau')                 =  (valYDF(f,time,'sim1')/valYDF(f,time,'bau')-1)*100;
 valYDH(h,time,'var')$valYDH(h,time,'bau')                 =  (valYDH(h,time,'sim1')/valYDH(h,time,'bau')-1)*100;
 valYF(f,time,'var')$valYF(f,time,'bau')                   =  (valYF(f,time,'sim1')/valYF(f,time,'bau')-1)*100;
 valYFK(f,time,'var')$valYFK(f,time,'bau')                 =  (valYFK(f,time,'sim1')/valYFK(f,time,'bau')-1)*100;
 valYFTR(f,time,'var')$valYFTR(f,time,'bau')               =  (valYFTR(f,time,'sim1')/valYFTR(f,time,'bau')-1)*100;
 valYG(time,'var')$valYG(time,'bau')                       =  (valYG(time,'sim1')/valYG(time,'bau')-1)*100;
 valYGK(time,'var')$valYGK(time,'bau')                     =  (valYGK(time,'sim1')/valYGK(time,'bau')-1)*100;
 valYGTR(time,'var')$valYGTR(time,'bau')                   =  (valYGTR(time,'sim1')/valYGTR(time,'bau')-1)*100;
 valYH(h,time,'var')$valYH(h,time,'bau')                   =  (valYH(h,time,'sim1')/valYH(h,time,'bau')-1)*100;
 valYHK(h,time,'var')$valYHK(h,time,'bau')                 =  (valYHK(h,time,'sim1')/valYHK(h,time,'bau')-1)*100;
 valYHL(h,time,'var')$valYHL(h,time,'bau')                 =  (valYHL(h,time,'sim1')/valYHL(h,time,'bau')-1)*100;
 valYHTR(h,time,'var')$valYHTR(h,time,'bau')               =  (valYHTR(h,time,'sim1')/valYHTR(h,time,'bau')-1)*100;
 valYROW(time,'var')$valYROW(time,'bau')                   =  (valYROW(time,'sim1')/valYROW(time,'bau')-1)*100;
 valPIXCON_C(t1,'var')$valPIXCON_C(t1,'bau')         =  (valPIXCON_C(t1,'sim1')/valPIXCON_C(t1,'bau')-1)*100;
 valPIXGDP_C(t1,'var')$valPIXGDP_C(t1,'bau')         =  (valPIXGDP_C(t1,'sim1')/valPIXGDP_C(t1,'bau')-1)*100;
 valPIXINV_PRI_C(t1,'var')$valPIXINV_PRI_C(t1,'bau') =  (valPIXINV_PRI_C(t1,'sim1')/valPIXINV_PRI_C(t1,'bau')-1)*100;
 valPIXINV_PUB_C(t1,'var')$valPIXINV_PUB_C(t1,'bau') =  (valPIXINV_PUB_C(t1,'sim1')/valPIXINV_PUB_C(t1,'bau')-1)*100;
 valPIXCON_C(time,'var')$valPIXCON_C(time,'bau')           =  (valPIXCON_C(time,'sim1')/valPIXCON_C(time,'bau')-1)*100;
 valPIXGDP_C(time,'var')$valPIXGDP_C(time,'bau')           =  (valPIXGDP_C(time,'sim1')/valPIXGDP_C(time,'bau')-1)*100;
 valPIXINV_PRI_C(time,'var')$valPIXINV_PRI_C(time,'bau')   =  (valPIXINV_PRI_C(time,'sim1')/valPIXINV_PRI_C(time,'bau')-1)*100;
 valPIXINV_PUB_C(time,'var')$valPIXINV_PUB_C(time,'bau')   =  (valPIXINV_PUB_C(time,'sim1')/valPIXINV_PUB_C(time,'bau')-1)*100;

execute_unload "Results",
 valC, valCAB, valCG, valCI, valCMIN, valCTH, valCTH_REAL, valDD, valDI, valDIT,
 valDS, vale, valEX, valEXD, valG, valG_REAL, valGDP_BP, valGDP_BP_REAL,
 valGDP_FD, valGDP_IB, valGDP_MP, valGDP_MP_REAL, valGFCF, valGFCF_PRI_REAL,
 valGFCF_PUB_REAL, valIM, valIND, valINV, valINV_PRI, valINV_PUB, valIR, valIT,
 valIT_PRI, valIT_PUB, valKD, valKDC, valKS, valLD, valLDC, valLS, valMRGN,
 valP, valPC, valPCI, valPD, valPE, valPE_FOB, valPIXCON, valPIXCON_C, valPIXGDP,
 valPIXGDP_C, valPIXGVT, valPIXGVT_C, valPIXINV_PRI, valPIXINV_PRI_C,
 valPIXINV_PUB, valPIXINV_PUB_C, valPK_PRI, valPK_PUB, valPL, valPM, valPP,
 valPT, valPVA, valPWM, valPWX, valQ, valR, valRC, valRTI, valSF, valSG, valSH,
 valsh0, valsh1, valSROW, valTDF, valTDFT, valTDH, valTDHT, valTIC, valTICT,
 valTIK, valTIKT, valTIM, valTIMT, valTIP, valTIPT, valTIW, valTIWT, valTIX,
 valTIXT, valTPRCTS, valTPRODN, valTR, valtr0, valtr1, valttdf0, valttdf1,
 valttdh0, valttdh1, valttic, valttik, valttim, valttip, valttiw, valttix,
 valU, valVA, valVSTK, valW, valWC, valWTI, valXS, valXST, valYDF, valYDH,
 valYF, valYFK, valYFTR, valYG, valYGK, valYGTR, valYH, valYHK, valYHL, valYHTR,
 valYROW;
Execute '=gdx2xls results.gdx';

execute_unload "Parameters",
 aij, alpha, A_K_PRI, A_K_PUB, B_KD, B_LD, B_M, B_VA, B_X, B_XT, beta_KD,
 beta_LD, beta_M, beta_VA, beta_X, beta_XT, delta, eta, frisch, gamma_GVT,
 gamma_INVPRI, gamma_INVPUB, gamma_LES, io, lambda_RK, lambda_TR, lambda_WL, n,
 phi, pop, rho_KD, rho_LD, rho_M, rho_VA, rho_X, rho_XT, sigma_INV, sigma_KD,
 sigma_LD, sigma_M, sigma_VA, sigma_X, sigma_XT, sigma_XD, sigma_Y, tmrg,
 tmrg_X, v;
execute '=gdx2xls parameters.gdx';

