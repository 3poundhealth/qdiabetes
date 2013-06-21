/* 
 * Copyright 2012 ClinRisk Ltd.
 * 
 * This file is part of QDiabetes-2013 (http://qdiabetes.org, http://svn.clinrisk.co.uk/opensource/qdiabetes).
 * 
 * QDiabetes-2013 is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * QDiabetes-2013 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with QDiabetes-2013.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * The initial version of this file, to be found at http://svn.clinrisk.co.uk/opensource/qdiabetes, faithfully implements QDiabetes-2013.
 * We have released this code under the GNU Lesser General Public License to enable others to implement the algorithm faithfully.
 * However, the nature of the GNU Lesser General Public License is such that we cannot prevent, for example, someone altering the coefficients.
 * We stress, therefore, that it is the responsibility of the end user to check that the source that they receive produces the same results as the original code posted at http://svn.clinrisk.co.uk/opensource/qdiabetes.
 * Inaccurate implementations of risk scores can lead to wrong patients being given the wrong treatment.
 * 
 * This file has been auto-generated.
 * XML source: Q68_qdiabetes_2013_1_1.xml
 * STATA dta time stamp: 15 Feb 2013 11:36
 * Header file create date: Fri 15 Feb 2013 11:40:42 GMT
 */

double type2_male(
int age,int b_corticosteroids,int b_cvd,int b_treatedhyp,double bmi,int ethrisk,int fh_diab,int smoke_cat,int surv,double town,int *error,char *errorBuf,int errorBufSize,int debug
);
