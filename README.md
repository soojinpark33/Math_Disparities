# Math_Disparities

Tyler Womack<sup>1</sup>, Gregory Palardy<sup>1</sup>, and Soojin Park<sup>1</sup>

<sup>1</sup> School of Education, University of California, Riverside  

## Overview
Mathematics literacy is crucial in many STEM fields, yet Black and Hispanic students are less likely to achieve high math proficiency. While previous literature investigated potential mediators to mitigate racial or gendered disparities in mathematics literacy, few studies addressed the correct causal interpretation of the results obtained. Guided by intersectionality theory and causal decomposition analysis, we examined the degree to which disparities in mathematics literacy (a) exist at the intersection of race and gender and (b) can be reduced by hypothetical interventions that equalize school socioeconomic status (SES) or opportunity to learn (OTL) across groups. We found large race/ethnic differences in math literacy favoring Asians and whites and much smaller gender differences generally favoring males, except Black females score higher than Black males. We also found that equalizing school SES may reduce disparities for Black and Hispanic males and females; equalizing OTL may reduce disparities for Black and Hispanic males as well as Asian males and females; compared to white males. Our findings implicate that targeted intervention is required to reduce disparities in math literacy depending on specific race-gender groups.

Here, we provide `R` codes to reproduce our data analysis. 

## DATA

* `dat1.xls` 
  
  We used data from the Program for International Student Assessment (PISA) study of 2012. The original data can be downloaded from the OECD portal by clicking [here](https://www.oecd.org/pisa/data/).
  
## Rcode

* `illustration_pisa.R`
  
  This `R` file replicates Table 2 and Figures 2 and 3 of our study. We used the [causal.decomp](https://cran.r-project.org/web/packages/causal.decomp/index.html) R package. 
