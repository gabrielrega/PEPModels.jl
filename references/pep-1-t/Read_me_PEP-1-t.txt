PEP-1-t, version 2.1, July 2013

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

It contains all the necessary programs to run the PEP-1-t standard 
single-country, recursive dynamic CGE model, together with the relevant 
documentation.

When you unzip the downloaded file, il will create 4 folders:
- user_guide
- presentation
- debugator
- GAMS_code

================================================================================
---PEP-1-t Model documentation--------------------------------------------------
================================================================================

Folder "user_guide":
- PEP-1-t_v2.1.pdf: this is the detailed description of the model:
   Bernard DECALUWÉ, André LEMELIN, Véronique ROBICHAUD and Hélène MAISONNAVE (2013),
   PEP-1-t. The PEP standard single-country, recursive dynamic CGE model 
   (Version 2.1), Partnership for Economic Policy (PEP) Research Network, 
   Université Laval, Québec.

- PEP 1-t User Guide.pdf: this Guide is more directly focused on applying the
  model, and in particular on how to configure a country SAM. Be advised, however,
  that the Guide was elaborated on the basis of a previous version of PEP-1-t.

   Véronique ROBICHAUD, André LEMELIN, Hélène MAISONNAVE and Bernard DECALUWÉ (2012), 
   PEP-1-t. A User Guide, Partnership for Economic Policy (PEP) Research Network, 
   Université Laval, Québec and IFPRI-AGRODEP.

--------------------------------------------------------------------------------
Folder "presentation":
This folder contains presentations of version 1.0 of the PEP-1-t model.
While the presentations are not perfectly up-to-date, we believe that they are 
nonetheless useful as an initiation to PEP-1-t.
- PEP 1-t.ppsx:
   A slide-show presentation of the model by Véronique ROBICHAUD,
   André LEMELIN, Hélène MAISONNAVE and Bernard DECALUWÉ (2012), elaborated 
   thanks to a joint effort by IFPRI and PEP in the context of AGRODEP, with
   financial support from AGRODEP.

- PEP 1-t.pdf:
   A pdf document which reproduces the slides in PEP 1-t.ppsx, together with
   presentation notes

--------------------------------------------------------------------------------
Folder "debugator": empty
 The "Debugator" is found in the PEP-1-1 package. It can also be downloaded 
 separately from the model home page. 
   https://www.pep-net.org/pep-standard-cge-models

================================================================================
---Files to run the PEP-1-t model-----------------------------------------------
================================================================================

Folder "GAMS_code"

- PEP_1-t-b_v2_1.gms: is the model GAMS code in which the model is solved 
  recursively, one period at a time.

- RESULTS PEP 1-t-b BAU.gms: this program is called by PEP_1-t-b_v2_1.gms

- RESULTS PEP 1-t-b SIM1.GMS: this program is called by PEP_1-t-b_v2_1.gms

- PEP_1-t_v2_1.gms: is the model GAMS code in which the model is solved 
  simultaneously for all periods.

- RESULTS PEP 1-t BAU.GMS: this program is called by PEP_1-t_v2_1.gms

- RESULTS PEP 1-t SIM1.GMS: this program is called by PEP_1-t_v2_1.gms

- VAL_PAR.xls is an Excel file of model parameters.

- SAM-V2_0.xls is an Excel file containing the social accounting matrix (SAM) of
  a fictitious country, to illustrate how the model works.

--------------------------------------------------------------------------------
For further details, please refer to the comments in the GAMS programs and to 
the included model documentation 

The PEP modeling team
