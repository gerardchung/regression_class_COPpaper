	  

		
************************
************************
**********  COP  *******	
************************
************************


/* 

* AIM OF THIS PAPER
* =================
It analyzes for COP paper 2  (regression class)


*/ 


* START
* =====
clear all
capture log close

macro drop _all 
version 14.2
set linesize 80
set more off 



****************************************************************************************

clear all 
cd "/Users/gerardchung/Google Drive/longitudinal_datasets_USA/cop/p2_fatherdep_cop/data_p2_cop/an_data_cop/"

use an_p2_depression_cop.dta , clear

*********************************
* Regression diagnostics here
**********************************
	* Your reg diagnostics here

* Drop the outlier!!
drop if id == 133 // data point with outlier, high lev and high cooksd -> see diagnostic way below down

***************************
* 1) Standardized variables
***************************

* --> CREATE STANDARDIZED OUTCOME AND EFFICACY
	// CPRclose_m1 
	sum CPRclose_m1
	return list
	generate close_ctr = (CPRclose_m1 - r(mean))/r(sd) 

	// CPRconflict_m1 
	sum CPRconflict_m1
	return list
	generate conflict_ctr = (CPRconflict_m1 - r(mean))/r(sd) 
	
	// CESD1
	sum CESD1
	return list
	// generate cesd_ctr = (CESD1 - r(mean))/r(sd) 
	generate cesd_ctr = (CESD1 - 16)/r(sd)  // standardized around score 16 which is the cut off for cesd

	
	// fpe_1mr 
	sum fpe_1mr
	return list
	generate efficacy_ctr = (fpe_1mr - r(mean))/r(sd) 

	
***************************
* 2) Multiple Imputation
***************************

	
mi set mlong
mi register imputed   close_ctr 	conflict_ctr 	efficacy_ctr 	cesd_ctr  	fatherage  	childage1	cgender1  	race_r    reside1  educ1    income1r marstat1
	mi misstable summarize  close_ctr 	conflict_ctr 	efficacy_ctr 	cesd_ctr  	fatherage  	childage1	cgender1  	race_r    reside1  educ1    income1r marstat1
	mi misstable patterns   close_ctr 	conflict_ctr 	efficacy_ctr 	cesd_ctr  	fatherage  	childage1   cgender1  	race_r    reside1  educ1    income1r marstat1

mcartest close_ctr 	conflict_ctr 	efficacy_ctr 	cesd_ctr  	fatherage  	childage1		cgender1  	race_r reside1  educ1    income1r marstat1
mi impute chained (logit) childage1 cgender1 race_r reside1  (regress)   close_ctr 	conflict_ctr 	efficacy_ctr 	cesd_ctr fatherage (mlogit) educ1  income1r marstat1 , ///
			add(30) rseed (53421) force savetrace(trace1,replace) augment


	* save "/Users/gerardchung/Google Drive/longitudinal_datasets_USA/cop/p2_fatherdep_cop/paper_moderation_regressionclass_gerard/dataset/imputed_reg_class.dta", replace

use "/Users/gerardchung/Google Drive/longitudinal_datasets_USA/cop/p2_fatherdep_cop/paper_moderation_regressionclass_gerard/dataset/imputed_reg_class.dta", clear 			
		
	
	
	* save "/Users/gerardchung/Google Drive/longitudinal_datasets_USA/cop/p2_fatherdep_cop/paper_moderation_regressionclass_gerard/dataset/imputed_reg_class_include133.dta", replace

	* use "/Users/gerardchung/Google Drive/longitudinal_datasets_USA/cop/p2_fatherdep_cop/paper_moderation_regressionclass_gerard/dataset/imputed_reg_class_include133.dta", clear 			

 
	
* Outcome models 

	*********************************************************
	* Main effects model (HYPOTHESIS 1 AND 2)
		* Closeness = Depression + PSE + sociodemographics 
		* Conflicts = Depression + PSE + sociodemographics 
	*********************************************************

	
	// After imputation, do we use usual .regress command? No! because this is a dataset with 30 imputed sets	
	regress close_ctr    c.cesd_ctr c.efficacy_ctr    /// 
						 c.fatherage i.race_r i.reside1 i.educ1 ///
						 i.income1r i.marstat1	i.childage1 i.cgender1 ///
							, vce(robust) 	

	regress conflict_ctr c.cesd_ctr c.efficacy_ctr   /// 
						 c.fatherage i.race_r i.reside1 i.educ1 ///
						 i.income1r i.marstat1	i.childage1 i.cgender1 ///
							, vce(robust) 
	
	
	// Use STATA multiple imputation command
	mi estimate: regress close_ctr  c.cesd_ctr c.efficacy_ctr  ///  Key predictors
						 c.fatherage i.race_r i.reside1 i.educ1 /// covariates
						 i.income1r i.marstat1	i.childage1 i.cgender1 /// covariates
							, vce(robust) 
							
    mi estimate: regress conflict_ctr  c.cesd_ctr c.efficacy_ctr  ///
						 c.fatherage i.race_r i.reside1 i.educ1 ///
						 i.income1r i.marstat1	i.childage1 i.cgender1 ///
							, vce(robust) 
							
		// Show results table for main effect model in excel
			// demonstrate how to copy and paste from STATA output to Excel
			
	
	// how about getting standardized betas? 
	mibeta close_ctr 	 c.cesd_ctr c.efficacy_ctr	 c.fatherage i.race_r i.reside1 i.educ1 i.income1r i.marstat1	 i.childage1 i.cgender1  , vce(robust) 
	mibeta conflict_ctr  c.cesd_ctr c.efficacy_ctr	 c.fatherage i.race_r i.reside1 i.educ1 i.income1r i.marstat1	 i.childage1 i.cgender1  , vce(robust) 


	
	*********************************************************
	* Interactional model (HYPOTHESIS 3)
		* Closeness = Depression X PSE + main effects + sociodemographics 
		* Conflicts = Depression + PSE + main effects + sociodemographics 
	*********************************************************

		***********************
		** Outcome 1: Closeness
		***********************
		mi estimate: regress close_ctr 	c.cesd_ctr c.efficacy_ctr	///  /* main effect */
		                     c.cesd_ctr#c.efficacy_ctr     ///			/* Interaction effect */   
									c.fatherage i.race_r i.reside1 i.educ1 ///
									i.income1r i.marstat1 i.childage1   ///
									, vce(robust) 

			// graphs
			 * margins , at( cesd_ctr=(-1(1)1) efficacy_ctr=(-1(1)1) ) 
					// cannot use margins because this is an imputed dataset
			
			mimrgns, 	at( cesd_ctr=(-1(1)1) efficacy_ctr=(-1(1)1) ) vsquish   cmdmargins
						// https://www.stata.com/meeting/germany16/slides/de16_klein.pdf
						// cesd_ctr=(-1(1)1) means plot cesd_ctr at three values 
						// at increments of +1: -1, 0, 1

			marginsplot, recast(line) noci ///
				title("") /// 
				xtitle(Depression standardized , size(medsmall)) ///
				ytitle(Closeness standardized, size(medsmall)) ///
				ylabel(-2.0(.2)0, labsize(small)) ///
				xlabel(, labsize(small)) ///
				scheme(s1mono) ///
				legend(row(3) order(1 "Low self-efficacy" 2 "Average self-efficacy" 3 "High self-efficacy")) /// 
				plot1opts(lpattern("__")) plot2opts(lpattern("l")) plot3opts(lpattern("--")) 

		
			// What are the slopes for each of the three lines?  
			mi estimate: regress close_ctr 	 	c.cesd_ctr c.efficacy_ctr	c.cesd_ctr#c.efficacy_ctr     c.fatherage i.race_r i.reside1 i.educ1 i.income1r i.marstat1	 i.childage1 i.cgender1  , vce(robust) 
			mimrgns , 	at(  efficacy_ctr=(-1(1)1) ) dydx(cesd_ctr) vsquish   cmdmargins	
				
		***********************
		** Outcome 2: Conflict
		***********************
		mi estimate: regress conflict_ctr 	c.cesd_ctr c.efficacy_ctr	///
							 c.cesd_ctr#c.efficacy_ctr     ///
									c.fatherage	 i.childage1 i.cgender1   ///
									i.race_r i.reside1 i.educ1 i.income1r ///
									i.marstat1  , vce(robust) 
				
			// graphs	
			mimrgns,  at(  cesd_ctr=(-1(1)1) efficacy_ctr=(-1(1)1) ) vsquish   cmdmargins
					

			marginsplot, recast(line) noci ///
				title("") /// 
				xtitle(Depression standardized , size(medsmall)) ///
				ytitle(Conflict standardized, size(medsmall)) ///
				ylabel(-.6(.2)1.8, labsize(small)) ///
				xlabel(, labsize(small)) ///
				scheme(s1mono) ///
				legend(row(3) order(1 "Low self-efficacy" 2 "Average self-efficacy" 3 "High self-efficacy")) /// 
				plot1opts(lpattern("__")) plot2opts(lpattern("l")) plot3opts(lpattern("--"))
				
				
			// What are the slopes for each of the three lines?  
			mi estimate: regress conflict_ctr 	c.cesd_ctr c.efficacy_ctr	c.cesd_ctr#c.efficacy_ctr     c.fatherage	 i.childage1 i.cgender1   i.race_r i.reside1 i.educ1 i.income1r i.marstat1  , vce(robust) 
			mimrgns , 	at(  efficacy_ctr=(-1(1)1) ) dydx(cesd_ctr) vsquish   cmdmargins
			
				// demonstrate how to add slopes numbers to the graph
				// Remind that when graph editor is in use, you cannot run commands in do-file




* Try coefplot package 
* ====================
		* You can use it with usual regress command as well as mi estimate:

* Coefplot
// findit coefplot
// http://repec.sowi.unibe.ch/stata/coefplot/getting-started.html

* Plot 1 - look at the regression coefficients for Closeness outomce
mi estimate: regress close_ctr 	c.cesd_ctr c.efficacy_ctr	///  /* main effect */
		                     c.cesd_ctr#c.efficacy_ctr     ///			/* Interaction effect */   
									c.fatherage i.race_r i.reside1 i.educ1 ///
									i.income1r i.marstat1 i.childage1   ///
									, vce(robust) 
coefplot, drop(_cons) xline(0)
 
* Compare the regression coefficients for Closeness & Conflict outomce
mi estimate: regress close_ctr 	c.cesd_ctr c.efficacy_ctr	///  /* main effect */
		                     c.cesd_ctr#c.efficacy_ctr     ///			/* Interaction effect */   
									c.fatherage i.race_r i.reside1 i.educ1 ///
									i.income1r i.marstat1 i.childage1   ///
									, vce(robust) 

									
estimates store outcome1


mi estimate: regress conflict_ctr 	c.cesd_ctr c.efficacy_ctr	///  /* main effect */
		                     c.cesd_ctr#c.efficacy_ctr     ///			/* Interaction effect */   
									c.fatherage i.race_r i.reside1 i.educ1 ///
									i.income1r i.marstat1 i.childage1   ///
									, vce(robust) 

estimates store outcome2

coefplot outcome1 outcome2, ///
				keep(cesd_ctr efficacy_ctr c.cesd_ctr#c.efficacy_ctr)  ///
				drop(_cons) ///
				xline(0) 

				

 clear all
			
				
	

