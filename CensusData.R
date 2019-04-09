


library(tidycensus)
library(tidyverse)

#load your census key census_api_key("6eff16100e6184b9bf0604e510aeba4abcdefghij,install = TRUE,overwrite = TRUE)

# The Census Dept surveys the entire nation every 10 years but in between they do estimates 
#called THE AMERICAN COMMUNITY SURVEY or ACS.  Teh ACS comes in 1yr,3yr,5yr versions.
#All communities get a 5yr ACS but only communities of 200,000 + get 1yr.

#That was the WHEN next we will look at the WHERE.

#From smallest to largest:cencus block, cencus block groups, 
#censuc tracts.
#These are nested.
#The s maller the unit the greater the MOE (maargin of error)
#Census blocks have 0 to several hundred.

#Block groups have 600 to 3,000 people.
#Block groups dont cross county or state boundaries.
#Block Group is the smallest unit for which the cencus publoishes.

#Census Tracts deliniated by locals,1500 to 8000. Each county has at least one,i.e,
#Tracts dont cross county boundaries?  Aspire to be homogenous re 
#economics.  Tract boundaries are rarely chsnged 
#to make before after comparrison meaningfull.