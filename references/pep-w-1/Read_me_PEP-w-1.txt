PEP-w-1, version 4.0, December 2013

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

This zip file has been downloaded from:
www.pep-net.org/pep-standard-cge-models

It contains all the necessary programs to run the PEP-w-1 standard multi-region 
single-period world CGE model, together with the relevant documentation.

When you unzip the downloaded file, it will create 2 folders:
- user_guide
- GAMS_code

================================================================================
---PEP-w-1 Model documentation--------------------------------------------------
================================================================================

Folder "user_guide":
- PEP-w-1 v4.0.pdf: Model documentation
   André LEMELIN, Véronique ROBICHAUD, Bernard DECALUWÉ and Hélène MAISONNAVE (2013),
   PEP-w-1. The PEP standard multi-region, single-period world CGE model 
   (Version 4.0), Partnership for Economic Policy (PEP) Research Network, 
   Université Laval, Québec.

- How to create input files for DATA_AGG-Rev.pdf: 
  This document explains how users can construct their own model database from 
  the GTAP8 database, if they want to use a different aggregation from 
  DATA_AGG-2007.gdx in the "GAMS_code" folder.

   Véronique ROBICHAUD (2015), How to create input files for DATA_AGG, 
   Partnership for Economic Policy (PEP) Research Network, 
   Université Laval, Québec.

================================================================================
---Files to run the PEP-w-1 model-----------------------------------------------
================================================================================

Folder "GAMS_code"

- PEP-w-1_v4.0.gms is the model GAMS code.

- VAL_PAR.xls is an Excel file of model parameters.

- DATA_AGG-2007.gdx is a file containing our 14 region, 4 industry 
  aggregation of the GTAP 8.1 data base. We thank the Global Trade Analysis 
  Project (GTAP: www.gtap.agecon.purdue.edu) for granting us permission to 
  distribute this aggregation.

- RESULTS PEP w-1.gms is called by the main program to produce results files.

- DATA_AGG-2007.gms is NOT necessary to run the model. It may be useful to 
  users who own a GTAP licence and want to create their own aggregation.

--------------------------------------------------------------------------------
For further details, please refer to the comments in the GAMS programs and to 
the included model documentation PEP-w-1 v4.0.pdf.

The PEP modeling team