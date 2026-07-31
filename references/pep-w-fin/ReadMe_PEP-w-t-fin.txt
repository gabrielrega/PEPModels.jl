PEP-w-t-fin, version 4.1, November 2014

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
*                         Andre Lemelin, Veronique Robichaud and               *
*                         Bernard Decaluwe.                                    *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

This zip file has been downloaded from:
www.pep-net.org/pep-standard-cge-models

It contains the model documentation and all the files necessary to run the
PEP-w-t-fin standard multi-region recursive dynamic world CGE model with
bilateral international financial assets, together with the relevant documentation.

When you unzip the downloaded file, it will create 2 folders, the second one
containing two subfolders:
- user_guide
- GAMS_code
  - 25-18
  - 14-4

================================================================================
---PEP-w-t-fin Model documentation----------------------------------------------
================================================================================

Folder "user_guide":

PEP-w-t-fin_v4.1.pdf: This is the basic model documentation, containing a detailed 
  description of the model.

   André LEMELIN, Véronique ROBICHAUD and Bernard DECALUWÉ (2014),
   PEP-w-t-fin: the PEP standard multi-region, recursive dynamic world CGE model
   with bilateral international financial assets (Version 4.1), Partnership for
   Economic Policy (PEP) Research Network, Université Laval, Québec.

- How to create input files for DATA_AGG-Rev.pdf: 
  This document explains how users can construct their own model database from 
  the GTAP8 database, if they want to use a different aggregation from 
  DATA_AGG-2007.gdx in the "GAMS_code" folder.

   Véronique ROBICHAUD (2015), How to create input files for DATA_AGG, 
   Partnership for Economic Policy (PEP) Research Network, 
   Université Laval, Québec.

================================================================================
---Files to run the PEP-w-t-fin model-------------------------------------------
================================================================================
 This file briefly describes the different program and data files used
 in the PEP w-t-fin model. A complete description of the model is given in the
 pdf documentation files contained in this package.

Folder "GAMS_code":
 Subfolder "14-4"
================================================================================
---14-region, 4-commodity aggregation-------------------------------------------
--------------------------------------------------------------------------------

 For the pedagogical version of PEP w-t-fin, which uses a 14-region, 4-commodity
 aggregation, all the data required are available for download. In other
 words, the user does not need to have a GTAP licence. We thank the Global
 Trade Analysis Project (GTAP: www.gtap.agecon.purdue.edu) for granting us
 permission to distribute this aggregation.

 Here is the file structure of this version along with the steps to follow in
 order to use the model:
--------------------------------------------------------------------------------
1- BUILD THE DATABASE
 **  This step can be skiped as the database is already available online.     **
 **  However, we thought it would be useful to describe how the database was  **
 **  generated.                                                               **

Program file:
 -> DATA_AGG-2007.gms

Input files:
 -> basedata2007.gdx .........GTAP Data (not included)
 -> Parameters2007.gdx .......GTAP parameters (not included)
 -> Projection.gms ...........FBQF projections

Output file:
 => DATA_AGG-2007.gdx ........GTAP data in the 14-4 aggregation

--------------------------------------------------------------------------------
2- CREATE THE DATA FOR THE REFERENCE SCENARIO

Program file:
 -> PEP-w-t-fin_v4.1_CAL_B_line.gms

Input files:
 -> DATA_AGG-2007.gdx ........GTAP data in the 14-4 aggregation
 -> VAL_PAR.xls ..............Values for other parameters in the 14-4 aggregation
 -> Fin_Flow-2007.gms.........Data on financial flows from IMF BOP data base
 -> FinBilatStock-2007.gms....Bilateral data estimated from balanced IMF IFS data
 -> B_line.gdx ...............Baseline values from PEP w-t for A_VA, sh0 and sh1
 -> INIT.gms..................Initialization of variables

Output files:
 => B_line-fin.gdx ...........Baseline values (A_VA, sh0, sh1, G, G_REAL, IND)
 => B_line_values.gdx ........Baseline values for all variables

--------------------------------------------------------------------------------
3- RUN THE MODEL

Main program file:
 -> PEP-w-t-fin_v4.1.gms

Input files:
 -> DATA_AGG-2007.gdx ........GTAP data in the 14-4 aggregation
 -> VAL_PAR.xls ..............Values for other parameters
 -> Fin_Flow-2007.gms.........Data on financial flows from IMF BOP data base
 -> FinBilatStock-2007.gms....Bilateral data estimated from balanced IMF IFS data
 -> BAU_SOLVE.gms ............Solves the model without shock
    -> B_line_fin.gdx ........Base line values (A_VA, sh0, sh1, G, G_REAL, IND)
    -> INIT_B_line.gms........Initialization of variables
       -> B_line_values.gdx ..Baseline values for all variables
    -> BAU_RESULTS.gms .......Stores the values of variables without shock
 -> SIM_SOLVE.gms
    -> SIM_RESULTS.GMS .......Stores the values of variables after shock
    -> XLS_RESULTS.GMS .......Creates output files of results (GDX and XLS)

Output files:
 => results_PEP-w-t-fin_ALL.gdx ..All results in GDX
 => results_PEP-w-t-fin_MAIN.gdx .Only the main results in GDX
 => results_PEP-w-t_ALL.xlsx .....All results in XLSX
 => results_PEP-w-t-fin_MAIN.xls .Only the main results in XLS
 => Parameters.gdx ...............Values of all parameters in GDX
 => Parameters.xls ...............Values of all parameters in XLS

Folder "GAMS_code":
 Subfolder "25-18"
================================================================================
---25-region, 18-commodity aggregation -----------------------------------------
--------------------------------------------------------------------------------
 Using the 25-region, 18-commodity aggregation requires that the user has a GTAP
 licence. In other words, in order to use this aggregation, the user must
 create the database using the GTAP data.
 Here is the file structure of this version along with the steps to follow in
 order to use the model:

--------------------------------------------------------------------------------
1- BUILD THE DATABASE

Program file:
 -> DATA_AGG-2007-25-18.gms

Input files:
 -> basedata2007.gdx .........GTAP Data (not included)
 -> Parameters2007.gdx .......GTAP parameters (not included)
 -> Projection.gms ...........FBQF projections

Output file:
 => DATA_AGG-2007-25-18.gdx ..GTAP data in the 25-18 aggregation

--------------------------------------------------------------------------------
2- CREATE THE DATA FOR THE REFERENCE SCENARIO

Program file:
 -> PEP-w-t-fin_v4.1_CAL_B_line-25-18.gms

Input files:
 -> DATA_AGG-2007-25-18.gdx ...GTAP data in the 25-18 aggregation
 -> VAL_PAR-25-18.xls .........Values for other parameters in the 25-18 aggregation
 -> Fin_Flow-2007-25.gms.......Data on financial flows from IMF BOP data base
 -> FinBilatStock-2007-25.gms..Bilateral data estimated from balanced IMF IFS data
 -> B_line-25-18.gdx ..........Baseline values from PEP w-t for A_VA, sh0 and sh1
 -> INIT.gms...................Initialization of variables

Output files:
 => B_line-fin-25-18.gdx ......Baseline values (A_VA, sh0, sh1, G, G_REAL, IND)
 => B_line_values-25-18.gdx ...Baseline values for all variables

--------------------------------------------------------------------------------
3- RUN THE MODEL

Main program file:
 -> PEP-w-t-fin-25-18_v4.1.gms

Input files:
 -> DATA_AGG-2007-25-18.gdx ........GTAP data in the 25-18 aggregation
 -> VAL_PAR-25-18.xls ..............Values for other parameters
 -> Fin_Flow-2007-25.gms............Data on financial flows from IMF BOP data base
 -> FinBilatStock-2007-25.gms.......Bilateral data estimated from balanced IMF IFS data
 -> BAU_SOLVE-25-18.gms ............Solves the model without shock
    -> B_line_fin-25-18.gdx ........Base line values (A_VA, sh0, sh1, G, G_REAL, IND)
    -> INIT_B_line-25-18.gms........Initialization of variables
       -> B_line_values-25-18.gdx ..Baseline values for all variables
    -> BAU_RESULTS-25-18.gms .......Stores the values of variables without shock
 -> SIM_SOLVE-25-18.gms
    -> SIM_RESULTS-25-18.GMS .......Stores the values of variables after shock
    -> XLS_RESULTS-25-18.GMS .......Creates output files of results (GDX and XLS)

Output files:
 => results_PEP-w-t-fin_ALL.gdx ....All results in GDX
 => results_PEP-w-t-fin_MAIN.gdx ...Only the main results in GDX
 => results_PEP-w-t_ALL.xlsx .......All results in XLSX
 => results_PEP-w-t-fin_MAIN.xls ...Only the main results in XLS
 => Parameters.gdx .................Values of all parameters in GDX
 => Parameters.xls .................Values of all parameters in XLS
