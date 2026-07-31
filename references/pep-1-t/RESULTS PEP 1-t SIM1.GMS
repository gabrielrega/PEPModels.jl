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
 valC(i,h,t,'sim1')         = C.l(i,h,t);
 valCAB(t,'sim1')           = CAB.l(t);
 valCG(i,t,'sim1')          = CG.l(i,t);
 valCI(j,t,'sim1')          = CI.l(j,t);
 valCMIN(i,h,t,'sim1')      = CMIN.l(i,h,t);
 valCTH(h,t,'sim1')         = CTH.l(h,t);
 valCTH_REAL(h,t,'sim1')    = CTH_REAL.l(h,t);
 valDD(i,t,'sim1')          = DD.l(i,t);
 valDI(i,j,t,'sim1')        = DI.l(i,j,t);
 valDIT(i,t,'sim1')         = DIT.l(i,t);
 valDS(j,i,t,'sim1')        = DS.l(j,i,t);
 vale(t,'sim1')             = e.l(t);
 valEX(j,i,t,'sim1')        = EX.l(j,i,t);
 valEXD(i,t,'sim1')         = EXD.l(i,t);
 valG(t,'sim1')             = G.l(t);
 valG_REAL(t,'sim1')        = G_REAL.l(t);
 valGDP_BP(t,'sim1')        = GDP_BP.l(t);
 valGDP_BP_REAL(t,'sim1')   = GDP_BP_REAL.l(t);
 valGDP_FD(t,'sim1')        = GDP_FD.l(t);
 valGDP_IB(t,'sim1')        = GDP_IB.l(t);
 valGDP_MP(t,'sim1')        = GDP_MP.l(t);
 valGDP_MP_REAL(t,'sim1')   = GDP_MP_REAL.l(t);
 valGFCF(t,'sim1')          = GFCF.l(t);
 valGFCF_PRI_REAL(t,'sim1') = GFCF_PRI_REAL.l(t);
 valGFCF_PUB_REAL(t,'sim1') = GFCF_PUB_REAL.l(t);
 valIM(i,t,'sim1')          = IM.l(i,t);
 valIND(k,j,t,'sim1')       = IND.l(k,j,t);
 valINV(i,t,'sim1')         = INV.l(i,t);
 valINV_PRI(i,t,'sim1')     = INV_PRI.l(i,t);
 valINV_PUB(i,t,'sim1')     = INV_PUB.l(i,t);
 valIR(t,'sim1')            = IR.l(t);
 valIT(t,'sim1')            = IT.l(t);
 valIT_PRI(t,'sim1')        = IT_PRI.l(t);
 valIT_PUB(t,'sim1')        = IT_PUB.l(t);
 valKD(k,j,t,'sim1')        = KD.l(k,j,t);
 valKDC(j,t,'sim1')         = KDC.l(j,t);
 valKS(k,t,'sim1')          = KS.l(k,t);
 valLD(l,j,t,'sim1')        = LD.l(l,j,t);
 valLDC(j,t,'sim1')         = LDC.l(j,t);
 valLS(l,t,'sim1')          = LS.l(l,t);
 valMRGN(i,t,'sim1')        = MRGN.l(i,t);
 valP(j,i,t,'sim1')         = P.l(j,i,t);
 valPC(i,t,'sim1')          = PC.l(i,t);
 valPCI(j,t,'sim1')         = PCI.l(j,t);
 valPD(i,t,'sim1')          = PD.l(i,t);
 valPE(i,t,'sim1')          = PE.l(i,t);
 valPE_FOB(i,t,'sim1')      = PE_FOB.l(i,t);
 valPIXCON(t,'sim1')        = PIXCON.l(t);
 valPIXGDP(t,'sim1')        = PIXGDP.l(t);
 valPIXGVT(t,'sim1')        = PIXGVT.l(t);
 valPIXINV_PRI(t,'sim1')    = PIXINV_PRI.l(t);
 valPIXINV_PUB(t,'sim1')    = PIXINV_PUB.l(t);
 valPK_PRI(t,'sim1')        = PK_PRI.l(t);
 valPK_PUB(t,'sim1')        = PK_PUB.l(t);
 valPL(i,t,'sim1')          = PL.l(i,t);
 valPM(i,t,'sim1')          = PM.l(i,t);
 valPP(j,t,'sim1')          = PP.l(j,t);
 valPT(j,t,'sim1')          = PT.l(j,t);
 valPVA(j,t,'sim1')         = PVA.l(j,t);
 valPWM(i,t,'sim1')         = PWM.l(i,t);
 valPWX(i,t,'sim1')         = PWX.l(i,t);
 valQ(i,t,'sim1')           = Q.l(i,t);
 valR(k,j,t,'sim1')         = R.l(k,j,t);
 valRC(j,t,'sim1')          = RC.l(j,t);
 valRTI(k,j,t,'sim1')       = RTI.l(k,j,t);
 valSF(f,t,'sim1')          = SF.l(f,t);
 valSG(t,'sim1')            = SG.l(t);
 valSH(h,t,'sim1')          = SH.l(h,t);
 valsh0(h,t,'sim1')         = sh0.l(h,t);
 valsh1(h,t,'sim1')         = sh1.l(h,t);
 valSROW(t,'sim1')          = SROW.l(t);
 valTDF(f,t,'sim1')         = TDF.l(f,t);
 valTDFT(t,'sim1')          = TDFT.l(t);
 valTDH(h,t,'sim1')         = TDH.l(h,t);
 valTDHT(t,'sim1')          = TDHT.l(t);
 valTIC(i,t,'sim1')         = TIC.l(i,t);
 valTICT(t,'sim1')          = TICT.l(t);
 valTIK(k,j,t,'sim1')       = TIK.l(k,j,t);
 valTIKT(t,'sim1')          = TIKT.l(t);
 valTIM(i,t,'sim1')         = TIM.l(i,t);
 valTIMT(t,'sim1')          = TIMT.l(t);
 valTIP(j,t,'sim1')         = TIP.l(j,t);
 valTIPT(t,'sim1')          = TIPT.l(t);
 valTIW(l,j,t,'sim1')       = TIW.l(l,j,t);
 valTIWT(t,'sim1')          = TIWT.l(t);
 valTIX(i,t,'sim1')         = TIX.l(i,t);
 valTIXT(t,'sim1')          = TIXT.l(t);
 valTPRCTS(t,'sim1')        = TPRCTS.l(t);
 valTPRODN(t,'sim1')        = TPRODN.l(t);
 valTR(ag,agj,t,'sim1')     = TR.l(ag,agj,t);
 valtr0(h,t,'sim1')         = tr0.l(h,t);
 valtr1(h,t,'sim1')         = tr1.l(h,t);
 valttdf0(f,t,'sim1')       = ttdf0.l(f,t);
 valttdf1(f,t,'sim1')       = ttdf1.l(f,t);
 valttdh0(h,t,'sim1')       = ttdh0.l(h,t);
 valttdh1(h,t,'sim1')       = ttdh1.l(h,t);
 valttic(i,t,'sim1')        = ttic.l(i,t);
 valttik(k,j,t,'sim1')      = ttik.l(k,j,t);
 valttim(i,t,'sim1')        = ttim.l(i,t);
 valttip(j,t,'sim1')        = ttip.l(j,t);
 valttiw(l,j,t,'sim1')      = ttiw.l(l,j,t);
 valttix(i,t,'sim1')        = ttix.l(i,t);
 valU(k,j,t,'sim1')         = U.l(k,j,t);
 valVA(j,t,'sim1')          = VA.l(j,t);
 valVSTK(i,t,'sim1')        = VSTK.l(i,t);
 valW(l,t,'sim1')           = W.l(l,t);
 valWC(j,t,'sim1')          = WC.l(j,t);
 valWTI(l,j,t,'sim1')       = WTI.l(l,j,t);
 valXS(j,i,t,'sim1')        = XS.l(j,i,t);
 valXST(j,t,'sim1')         = XST.l(j,t);
 valYDF(f,t,'sim1')         = YDF.l(f,t);
 valYDH(h,t,'sim1')         = YDH.l(h,t);
 valYF(f,t,'sim1')          = YF.l(f,t);
 valYFK(f,t,'sim1')         = YFK.l(f,t);
 valYFTR(f,t,'sim1')        = YFTR.l(f,t);
 valYG(t,'sim1')            = YG.l(t);
 valYGK(t,'sim1')           = YGK.l(t);
 valYGTR(t,'sim1')          = YGTR.l(t);
 valYH(h,t,'sim1')          = YH.l(h,t);
 valYHK(h,t,'sim1')         = YHK.l(h,t);
 valYHL(h,t,'sim1')         = YHL.l(h,t);
 valYHTR(h,t,'sim1')        = YHTR.l(h,t);
 valYROW(t,'sim1')          = YROW.l(t);
 valPIXCON_C(t1,'sim1')     = PIXCON.l(t1);
 valPIXGDP_C(t1,'sim1')     = PIXGDP.l(t1);
 valPIXINV_PRI_C(t1,'sim1') = PIXINV_PRI.l(t1);
 valPIXINV_PUB_C(t1,'sim1') = PIXINV_PUB.l(t1);
loop[t$(ORD(t) gt 1),
 valPIXCON_C(t,'sim1')      = valPIXCON_C(t-1,'sim1')*SUM[i,PC.l(i,t)
                              *SUM[h,C.l(i,h,t-1)]]
                              /SUM[i,PC.l(i,t-1)*SUM[h,C.l(i,h,t-1)]];
 valPIXGDP_C(t,'sim1')      = valPIXGDP_C(t-1,'sim1')*
               {SUM[j,{(PVA.l(j,t)*VA.l(j,t)+TIP.l(j,t))/VA.l(j,t)}*VA.l(j,t-1)]
               /SUM[j,{(PVA.l(j,t-1)*VA.l(j,t-1)+TIP.l(j,t-1))/VA.l(j,t-1)}*VA.l(j,t-1)]
               *SUM[j,{(PVA.l(j,t)*VA.l(j,t)+TIP.l(j,t))/VA.l(j,t)}*VA.l(j,t)]
               /SUM[j,{(PVA.l(j,t-1)*VA.l(j,t-1)+TIP.l(j,t-1))/VA.l(j,t-1)}*VA.l(j,t)]
                          }**0.5;
 valPIXINV_PRI_C(t,'sim1')  = valPIXINV_PRI_C(t-1,'sim1')*PROD[i$gamma_INVPRI(i),
                          (PC.l(i,t)/PC.l(i,t-1))**gamma_INVPRI(i)];
 valPIXINV_PUB_C(t,'sim1')  = valPIXINV_PUB_C(t-1,'sim1')*PROD[i$gamma_INVPUB(i),
                           (PC.l(i,t)/PC.l(i,t-1))**gamma_INVPUB(i)];
];


 valC(i,h,t,'var')$valC(i,h,t,'bau')                 =  (valC(i,h,t,'sim1')/valC(i,h,t,'bau')-1)*100;
 valCAB(t,'var')$valCAB(t,'bau')                     =  (valCAB(t,'sim1')/valCAB(t,'bau')-1)*100;
 valCG(i,t,'var')$valCG(i,t,'bau')                   =  (valCG(i,t,'sim1')/valCG(i,t,'bau')-1)*100;
 valCI(j,t,'var')$valCI(j,t,'bau')                   =  (valCI(j,t,'sim1')/valCI(j,t,'bau')-1)*100;
 valCMIN(i,h,t,'var')$valCMIN(i,h,t,'bau')           =  (valCMIN(i,h,t,'sim1')/valCMIN(i,h,t,'bau')-1)*100;
 valCTH(h,t,'var')$valCTH(h,t,'bau')                 =  (valCTH(h,t,'sim1')/valCTH(h,t,'bau')-1)*100;
 valCTH_REAL(h,t,'var')$valCTH_REAL(h,t,'bau')       =  (valCTH_REAL(h,t,'sim1')/valCTH_REAL(h,t,'bau')-1)*100;
 valDD(i,t,'var')$valDD(i,t,'bau')                   =  (valDD(i,t,'sim1')/valDD(i,t,'bau')-1)*100;
 valDI(i,j,t,'var')$valDI(i,j,t,'bau')               =  (valDI(i,j,t,'sim1')/valDI(i,j,t,'bau')-1)*100;
 valDIT(i,t,'var')$valDIT(i,t,'bau')                 =  (valDIT(i,t,'sim1')/valDIT(i,t,'bau')-1)*100;
 valDS(j,i,t,'var')$valDS(j,i,t,'bau')               =  (valDS(j,i,t,'sim1')/valDS(j,i,t,'bau')-1)*100;
 vale(t,'var')$vale(t,'bau')                         =  (vale(t,'sim1')/vale(t,'bau')-1)*100;
 valEX(j,i,t,'var')$valEX(j,i,t,'bau')               =  (valEX(j,i,t,'sim1')/valEX(j,i,t,'bau')-1)*100;
 valEXD(i,t,'var')$valEXD(i,t,'bau')                 =  (valEXD(i,t,'sim1')/valEXD(i,t,'bau')-1)*100;
 valG(t,'var')$valG(t,'bau')                         =  (valG(t,'sim1')/valG(t,'bau')-1)*100;
 valG_REAL(t,'var')$valG_REAL(t,'bau')               =  (valG_REAL(t,'sim1')/valG_REAL(t,'bau')-1)*100;
 valGDP_BP(t,'var')$valGDP_BP(t,'bau')               =  (valGDP_BP(t,'sim1')/valGDP_BP(t,'bau')-1)*100;
 valGDP_BP_REAL(t,'var')$valGDP_BP_REAL(t,'bau')     =  (valGDP_BP_REAL(t,'sim1')/valGDP_BP_REAL(t,'bau')-1)*100;
 valGDP_FD(t,'var')$valGDP_FD(t,'bau')               =  (valGDP_FD(t,'sim1')/valGDP_FD(t,'bau')-1)*100;
 valGDP_IB(t,'var')$valGDP_IB(t,'bau')               =  (valGDP_IB(t,'sim1')/valGDP_IB(t,'bau')-1)*100;
 valGDP_MP(t,'var')$valGDP_MP(t,'bau')               =  (valGDP_MP(t,'sim1')/valGDP_MP(t,'bau')-1)*100;
 valGDP_MP_REAL(t,'var')$valGDP_MP_REAL(t,'bau')     =  (valGDP_MP_REAL(t,'sim1')/valGDP_MP_REAL(t,'bau')-1)*100;
 valGFCF(t,'var')$valGFCF(t,'bau')                   =  (valGFCF(t,'sim1')/valGFCF(t,'bau')-1)*100;
 valGFCF_PRI_REAL(t,'var')$valGFCF_PRI_REAL(t,'bau') =  (valGFCF_PRI_REAL(t,'sim1')/valGFCF_PRI_REAL(t,'bau')-1)*100;
 valGFCF_PUB_REAL(t,'var')$valGFCF_PUB_REAL(t,'bau') =  (valGFCF_PUB_REAL(t,'sim1')/valGFCF_PUB_REAL(t,'bau')-1)*100;
 valIM(i,t,'var')$valIM(i,t,'bau')                   =  (valIM(i,t,'sim1')/valIM(i,t,'bau')-1)*100;
 valIND(k,j,t,'var')$valIND(k,j,t,'bau')             =  (valIND(k,j,t,'sim1')/valIND(k,j,t,'bau')-1)*100;
 valINV(i,t,'var')$valINV(i,t,'bau')                 =  (valINV(i,t,'sim1')/valINV(i,t,'bau')-1)*100;
 valINV_PRI(i,t,'var')$valINV_PRI(i,t,'bau')         =  (valINV_PRI(i,t,'sim1')/valINV_PRI(i,t,'bau')-1)*100;
 valINV_PUB(i,t,'var')$valINV_PUB(i,t,'bau')         =  (valINV_PUB(i,t,'sim1')/valINV_PUB(i,t,'bau')-1)*100;
 valIR(t,'var')$valIR(t,'bau')                       =  (valIR(t,'sim1')/valIR(t,'bau')-1)*100;
 valIT(t,'var')$valIT(t,'bau')                       =  (valIT(t,'sim1')/valIT(t,'bau')-1)*100;
 valIT_PRI(t,'var')$valIT_PRI(t,'bau')               =  (valIT_PRI(t,'sim1')/valIT_PRI(t,'bau')-1)*100;
 valIT_PUB(t,'var')$valIT_PUB(t,'bau')               =  (valIT_PUB(t,'sim1')/valIT_PUB(t,'bau')-1)*100;
 valKD(k,j,t,'var')$valKD(k,j,t,'bau')               =  (valKD(k,j,t,'sim1')/valKD(k,j,t,'bau')-1)*100;
 valKDC(j,t,'var')$valKDC(j,t,'bau')                 =  (valKDC(j,t,'sim1')/valKDC(j,t,'bau')-1)*100;
 valKS(k,t,'var')$valKS(k,t,'bau')                   =  (valKS(k,t,'sim1')/valKS(k,t,'bau')-1)*100;
 valLD(l,j,t,'var')$valLD(l,j,t,'bau')               =  (valLD(l,j,t,'sim1')/valLD(l,j,t,'bau')-1)*100;
 valLDC(j,t,'var')$valLDC(j,t,'bau')                 =  (valLDC(j,t,'sim1')/valLDC(j,t,'bau')-1)*100;
 valLS(l,t,'var')$valLS(l,t,'bau')                   =  (valLS(l,t,'sim1')/valLS(l,t,'bau')-1)*100;
 valMRGN(i,t,'var')$valMRGN(i,t,'bau')               =  (valMRGN(i,t,'sim1')/valMRGN(i,t,'bau')-1)*100;
 valP(j,i,t,'var')$valP(j,i,t,'bau')                 =  (valP(j,i,t,'sim1')/valP(j,i,t,'bau')-1)*100;
 valPC(i,t,'var')$valPC(i,t,'bau')                   =  (valPC(i,t,'sim1')/valPC(i,t,'bau')-1)*100;
 valPCI(j,t,'var')$valPCI(j,t,'bau')                 =  (valPCI(j,t,'sim1')/valPCI(j,t,'bau')-1)*100;
 valPD(i,t,'var')$valPD(i,t,'bau')                   =  (valPD(i,t,'sim1')/valPD(i,t,'bau')-1)*100;
 valPE(i,t,'var')$valPE(i,t,'bau')                   =  (valPE(i,t,'sim1')/valPE(i,t,'bau')-1)*100;
 valPE_FOB(i,t,'var')$valPE_FOB(i,t,'bau')           =  (valPE_FOB(i,t,'sim1')/valPE_FOB(i,t,'bau')-1)*100;
 valPIXCON(t,'var')$valPIXCON(t,'bau')               =  (valPIXCON(t,'sim1')/valPIXCON(t,'bau')-1)*100;
 valPIXGDP(t,'var')$valPIXGDP(t,'bau')               =  (valPIXGDP(t,'sim1')/valPIXGDP(t,'bau')-1)*100;
 valPIXGVT(t,'var')$valPIXGVT(t,'bau')               =  (valPIXGVT(t,'sim1')/valPIXGVT(t,'bau')-1)*100;
 valPIXINV_PRI(t,'var')$valPIXINV_PRI(t,'bau')       =  (valPIXINV_PRI(t,'sim1')/valPIXINV_PRI(t,'bau')-1)*100;
 valPIXINV_PUB(t,'var')$valPIXINV_PUB(t,'bau')       =  (valPIXINV_PUB(t,'sim1')/valPIXINV_PUB(t,'bau')-1)*100;
 valPK_PRI(t,'var')$valPK_PRI(t,'bau')               =  (valPK_PRI(t,'sim1')/valPK_PRI(t,'bau')-1)*100;
 valPK_PUB(t,'var')$valPK_PUB(t,'bau')               =  (valPK_PUB(t,'sim1')/valPK_PUB(t,'bau')-1)*100;
 valPL(i,t,'var')$valPL(i,t,'bau')                   =  (valPL(i,t,'sim1')/valPL(i,t,'bau')-1)*100;
 valPM(i,t,'var')$valPM(i,t,'bau')                   =  (valPM(i,t,'sim1')/valPM(i,t,'bau')-1)*100;
 valPP(j,t,'var')$valPP(j,t,'bau')                   =  (valPP(j,t,'sim1')/valPP(j,t,'bau')-1)*100;
 valPT(j,t,'var')$valPT(j,t,'bau')                   =  (valPT(j,t,'sim1')/valPT(j,t,'bau')-1)*100;
 valPVA(j,t,'var')$valPVA(j,t,'bau')                 =  (valPVA(j,t,'sim1')/valPVA(j,t,'bau')-1)*100;
 valPWM(i,t,'var')$valPWM(i,t,'bau')                 =  (valPWM(i,t,'sim1')/valPWM(i,t,'bau')-1)*100;
 valPWX(i,t,'var')$valPWX(i,t,'bau')                 =  (valPWX(i,t,'sim1')/valPWX(i,t,'bau')-1)*100;
 valQ(i,t,'var')$valQ(i,t,'bau')                     =  (valQ(i,t,'sim1')/valQ(i,t,'bau')-1)*100;
 valR(k,j,t,'var')$valR(k,j,t,'bau')                 =  (valR(k,j,t,'sim1')/valR(k,j,t,'bau')-1)*100;
 valRC(j,t,'var')$valRC(j,t,'bau')                   =  (valRC(j,t,'sim1')/valRC(j,t,'bau')-1)*100;
 valRTI(k,j,t,'var')$valRTI(k,j,t,'bau')             =  (valRTI(k,j,t,'sim1')/valRTI(k,j,t,'bau')-1)*100;
 valSF(f,t,'var')$valSF(f,t,'bau')                   =  (valSF(f,t,'sim1')/valSF(f,t,'bau')-1)*100;
 valSG(t,'var')$valSG(t,'bau')                       =  (valSG(t,'sim1')/valSG(t,'bau')-1)*100;
 valSH(h,t,'var')$valSH(h,t,'bau')                   =  (valSH(h,t,'sim1')/valSH(h,t,'bau')-1)*100;
 valsh0(h,t,'var')$valsh0(h,t,'bau')                 =  (valsh0(h,t,'sim1')/valsh0(h,t,'bau')-1)*100;
 valsh1(h,t,'var')$valsh1(h,t,'bau')                 =  (valsh1(h,t,'sim1')/valsh1(h,t,'bau')-1)*100;
 valSROW(t,'var')$valSROW(t,'bau')                   =  (valSROW(t,'sim1')/valSROW(t,'bau')-1)*100;
 valTDF(f,t,'var')$valTDF(f,t,'bau')                 =  (valTDF(f,t,'sim1')/valTDF(f,t,'bau')-1)*100;
 valTDFT(t,'var')$valTDFT(t,'bau')                   =  (valTDFT(t,'sim1')/valTDFT(t,'bau')-1)*100;
 valTDH(h,t,'var')$valTDH(h,t,'bau')                 =  (valTDH(h,t,'sim1')/valTDH(h,t,'bau')-1)*100;
 valTDHT(t,'var')$valTDHT(t,'bau')                   =  (valTDHT(t,'sim1')/valTDHT(t,'bau')-1)*100;
 valTIC(i,t,'var')$valTIC(i,t,'bau')                 =  (valTIC(i,t,'sim1')/valTIC(i,t,'bau')-1)*100;
 valTICT(t,'var')$valTICT(t,'bau')                   =  (valTICT(t,'sim1')/valTICT(t,'bau')-1)*100;
 valTIK(k,j,t,'var')$valTIK(k,j,t,'bau')             =  (valTIK(k,j,t,'sim1')/valTIK(k,j,t,'bau')-1)*100;
 valTIKT(t,'var')$valTIKT(t,'bau')                   =  (valTIKT(t,'sim1')/valTIKT(t,'bau')-1)*100;
 valTIM(i,t,'var')$valTIM(i,t,'bau')                 =  (valTIM(i,t,'sim1')/valTIM(i,t,'bau')-1)*100;
 valTIMT(t,'var')$valTIMT(t,'bau')                   =  (valTIMT(t,'sim1')/valTIMT(t,'bau')-1)*100;
 valTIP(j,t,'var')$valTIP(j,t,'bau')                 =  (valTIP(j,t,'sim1')/valTIP(j,t,'bau')-1)*100;
 valTIPT(t,'var')$valTIPT(t,'bau')                   =  (valTIPT(t,'sim1')/valTIPT(t,'bau')-1)*100;
 valTIW(l,j,t,'var')$valTIW(l,j,t,'bau')             =  (valTIW(l,j,t,'sim1')/valTIW(l,j,t,'bau')-1)*100;
 valTIWT(t,'var')$valTIWT(t,'bau')                   =  (valTIWT(t,'sim1')/valTIWT(t,'bau')-1)*100;
 valTIX(i,t,'var')$valTIX(i,t,'bau')                 =  (valTIX(i,t,'sim1')/valTIX(i,t,'bau')-1)*100;
 valTIXT(t,'var')$valTIXT(t,'bau')                   =  (valTIXT(t,'sim1')/valTIXT(t,'bau')-1)*100;
 valTPRCTS(t,'var')$valTPRCTS(t,'bau')               =  (valTPRCTS(t,'sim1')/valTPRCTS(t,'bau')-1)*100;
 valTPRODN(t,'var')$valTPRODN(t,'bau')               =  (valTPRODN(t,'sim1')/valTPRODN(t,'bau')-1)*100;
 valTR(ag,agj,t,'var')$valTR(ag,agj,t,'bau')         =  (valTR(ag,agj,t,'sim1')/valTR(ag,agj,t,'bau')-1)*100;
 valtr0(h,t,'var')$valtr0(h,t,'bau')                 =  (valtr0(h,t,'sim1')/valtr0(h,t,'bau')-1)*100;
 valtr1(h,t,'var')$valtr1(h,t,'bau')                 =  (valtr1(h,t,'sim1')/valtr1(h,t,'bau')-1)*100;
 valttdf0(f,t,'var')$valttdf0(f,t,'bau')             =  (valttdf0(f,t,'sim1')/valttdf0(f,t,'bau')-1)*100;
 valttdf1(f,t,'var')$valttdf1(f,t,'bau')             =  (valttdf1(f,t,'sim1')/valttdf1(f,t,'bau')-1)*100;
 valttdh0(h,t,'var')$valttdh0(h,t,'bau')             =  (valttdh0(h,t,'sim1')/valttdh0(h,t,'bau')-1)*100;
 valttdh1(h,t,'var')$valttdh1(h,t,'bau')             =  (valttdh1(h,t,'sim1')/valttdh1(h,t,'bau')-1)*100;
 valttic(i,t,'var')$valttic(i,t,'bau')               =  (valttic(i,t,'sim1')/valttic(i,t,'bau')-1)*100;
 valttik(k,j,t,'var')$valttik(k,j,t,'bau')           =  (valttik(k,j,t,'sim1')/valttik(k,j,t,'bau')-1)*100;
 valttim(i,t,'var')$valttim(i,t,'bau')               =  (valttim(i,t,'sim1')/valttim(i,t,'bau')-1)*100;
 valttip(j,t,'var')$valttip(j,t,'bau')               =  (valttip(j,t,'sim1')/valttip(j,t,'bau')-1)*100;
 valttiw(l,j,t,'var')$valttiw(l,j,t,'bau')           =  (valttiw(l,j,t,'sim1')/valttiw(l,j,t,'bau')-1)*100;
 valttix(i,t,'var')$valttix(i,t,'bau')               =  (valttix(i,t,'sim1')/valttix(i,t,'bau')-1)*100;
 valU(k,j,t,'var')$valU(k,j,t,'bau')                 =  (valU(k,j,t,'sim1')/valU(k,j,t,'bau')-1)*100;
 valVA(j,t,'var')$valVA(j,t,'bau')                   =  (valVA(j,t,'sim1')/valVA(j,t,'bau')-1)*100;
 valVSTK(i,t,'var')$valVSTK(i,t,'bau')               =  (valVSTK(i,t,'sim1')/valVSTK(i,t,'bau')-1)*100;
 valW(l,t,'var')$valW(l,t,'bau')                     =  (valW(l,t,'sim1')/valW(l,t,'bau')-1)*100;
 valWC(j,t,'var')$valWC(j,t,'bau')                   =  (valWC(j,t,'sim1')/valWC(j,t,'bau')-1)*100;
 valWTI(l,j,t,'var')$valWTI(l,j,t,'bau')             =  (valWTI(l,j,t,'sim1')/valWTI(l,j,t,'bau')-1)*100;
 valXS(j,i,t,'var')$valXS(j,i,t,'bau')               =  (valXS(j,i,t,'sim1')/valXS(j,i,t,'bau')-1)*100;
 valXST(j,t,'var')$valXST(j,t,'bau')                 =  (valXST(j,t,'sim1')/valXST(j,t,'bau')-1)*100;
 valYDF(f,t,'var')$valYDF(f,t,'bau')                 =  (valYDF(f,t,'sim1')/valYDF(f,t,'bau')-1)*100;
 valYDH(h,t,'var')$valYDH(h,t,'bau')                 =  (valYDH(h,t,'sim1')/valYDH(h,t,'bau')-1)*100;
 valYF(f,t,'var')$valYF(f,t,'bau')                   =  (valYF(f,t,'sim1')/valYF(f,t,'bau')-1)*100;
 valYFK(f,t,'var')$valYFK(f,t,'bau')                 =  (valYFK(f,t,'sim1')/valYFK(f,t,'bau')-1)*100;
 valYFTR(f,t,'var')$valYFTR(f,t,'bau')               =  (valYFTR(f,t,'sim1')/valYFTR(f,t,'bau')-1)*100;
 valYG(t,'var')$valYG(t,'bau')                       =  (valYG(t,'sim1')/valYG(t,'bau')-1)*100;
 valYGK(t,'var')$valYGK(t,'bau')                     =  (valYGK(t,'sim1')/valYGK(t,'bau')-1)*100;
 valYGTR(t,'var')$valYGTR(t,'bau')                   =  (valYGTR(t,'sim1')/valYGTR(t,'bau')-1)*100;
 valYH(h,t,'var')$valYH(h,t,'bau')                   =  (valYH(h,t,'sim1')/valYH(h,t,'bau')-1)*100;
 valYHK(h,t,'var')$valYHK(h,t,'bau')                 =  (valYHK(h,t,'sim1')/valYHK(h,t,'bau')-1)*100;
 valYHL(h,t,'var')$valYHL(h,t,'bau')                 =  (valYHL(h,t,'sim1')/valYHL(h,t,'bau')-1)*100;
 valYHTR(h,t,'var')$valYHTR(h,t,'bau')               =  (valYHTR(h,t,'sim1')/valYHTR(h,t,'bau')-1)*100;
 valYROW(t,'var')$valYROW(t,'bau')                   =  (valYROW(t,'sim1')/valYROW(t,'bau')-1)*100;
 valPIXCON_C(t1,'var')$valPIXCON_C(t1,'bau')         =  (valPIXCON_C(t1,'sim1')/valPIXCON_C(t1,'bau')-1)*100;
 valPIXGDP_C(t1,'var')$valPIXGDP_C(t1,'bau')         =  (valPIXGDP_C(t1,'sim1')/valPIXGDP_C(t1,'bau')-1)*100;
 valPIXINV_PRI_C(t1,'var')$valPIXINV_PRI_C(t1,'bau') =  (valPIXINV_PRI_C(t1,'sim1')/valPIXINV_PRI_C(t1,'bau')-1)*100;
 valPIXINV_PUB_C(t1,'var')$valPIXINV_PUB_C(t1,'bau') =  (valPIXINV_PUB_C(t1,'sim1')/valPIXINV_PUB_C(t1,'bau')-1)*100;
 valPIXCON_C(t,'var')$valPIXCON_C(t,'bau')           =  (valPIXCON_C(t,'sim1')/valPIXCON_C(t,'bau')-1)*100;
 valPIXGDP_C(t,'var')$valPIXGDP_C(t,'bau')           =  (valPIXGDP_C(t,'sim1')/valPIXGDP_C(t,'bau')-1)*100;
 valPIXINV_PRI_C(t,'var')$valPIXINV_PRI_C(t,'bau')   =  (valPIXINV_PRI_C(t,'sim1')/valPIXINV_PRI_C(t,'bau')-1)*100;
 valPIXINV_PUB_C(t,'var')$valPIXINV_PUB_C(t,'bau')   =  (valPIXINV_PUB_C(t,'sim1')/valPIXINV_PUB_C(t,'bau')-1)*100;



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

