


library(tidycensus)
library(tidyverse)

#load your census key census_api_key("6eff16100e6184b9bf0604e510aeba4abcdefghij,install = TRUE,overwrite = TRUE)

# The Census Dept surveys the entire nation every 10 years but in between they do estimates 
#called THE AMERICAN COMMUNITY SURVEY or ACS.  The ACS comes in 1yr,3yr,5yr versions.
#All communities get a 5yr ACS but only communities of 200,000 + get 1yr.

#That was the WHEN next we will look at the WHERE.

#From smallest to largest:cencus block, cencus block groups, 
#censuc tracts.
#These are nested.
#The smaller the unit the greater the MOE (maargin of error)

#Census blocks have 0 to several hundred.
#Block groups have 600 to 3,000 people.
#Block groups dont cross county or state boundaries.
#Block Group is the smallest unit for which the cencus publishes.

#Census Tracts deliniated by locals,1500 to 8000. Each county has at least one,i.e,
#Tracts dont cross county boundaries.  Aspire to be homogenous re 
#economics.  Tract boundaries are rarely changed to make before after comparrison meaningfull.


# A search with TidyCensus  of  the 10 year census is done like this:
#States_Population<- get_decennial (geography= "state", year=2010, variable= "P001001")
# Besides "state" and "nation" , on can alsp search block, groupd block, zcta, (which is not identical
# zip code but the Census bureau tells me is very close) and county.
# But now lets run that search

States_Population<- get_decennial (geography= "state", year=2010, variable= "P001001")
dim(States_Population)

#There are a LOT of variables.  3,346 to be prec
decenial_census_variables<- load_variables(2010, "sf1", cache = TRUE)
dim(decenial_census_variables)

County_Population<- get_decennial (geography= "county", year=2010, variable= "P001001")
dim(County_Population)
#Rather amazing  In under 100 key strokes one now has the population of every coounty in the US.

#But what if you are only interested in single state?

NY_Counties_Pop<- get_decennial(geography = "county", year = 2010, state = "NY",
                             variables = "P001001")
dim(NY_Counties_Pop)

#But all of this is from the 2010 census.  For more recent data ,albeiet a estimate rather than
# a survey one can use the American Community Survey (ACS).

# First let us look at the what variables of the ACS.
ACS5_variables_2017<- load_variables(2017,"acs5",cache = TRUE)
dim(ACS5_variables_2017)

# So how does one find the variable one is looking for ?
View(ACS5_variables_2017)
# In the top right corner of the ACS_Variables_2017 is a search box.
# This is a trial by error with the emphais on the error, tilting towards exasperation at times.
# Enter MARRIED.
# B06008_002 is "Estimate!!Total!!Never married". I was surprised that this was a criteria.
#But then again there are 25,000+ variables.
# Beneath that are the subsets of "Estimate!!Total!!Never married" are "Estimate!!Total!!Now married except separated"
# (B06008_003) and many others.
#If we run the next line it will tell us how many people have never been married in each 
#congressional district.  If one is not sure why this would be usefull think instead of the wonder of 
#its spoecificity and assume no matter what democgraich deatil one might wish for it is in
# the census (somewhere).

B12002C_009
# Latino , Sex by Age B01001I_001
Never_Married_2017<- get_acs(geography = "congressional district", variables = "B12002C_009",
            year = 2017, state = "NY", geometry = FALSE)

#Suppose you wanted to know how many LAtinos live in each congressional district in NYS?
Latino_NYS_CongressionalDist_Pop<- get_acs(geography = "congressional district", variables = "B01001I_001",
                              year = 2017, state = "NY", geometry = FALSE)

#But we can also just as easliy drill down ansd find the age distribution for that same population.
# But here we change the technique a bit.
# First we drop the suffix from the variable name. "B01001I" instead of  "B01001I_001".  This 
#  coupled with exchanging "Variables = " for "table= "calls up not the specific file
#  but the entire group.  Lastly specify "output= "wide" " to make each age group acolumn.
Latino_NYS_ConDist_Age_Dist<- get_acs(geography = "congressional district",state = "NY",
                                   table="B01001I", output = "wide",survey = "acs5")
View(Latino_NYS_ConDist_Age_Dist)

# The output is just what one would hope for.
#Each row is the congressional district and each column is the age bracket.
# To decod teh age brackets return to the ACS5 object, enter Latino, and scroll down
#until one gets to B010001I
# B01001I_002 is total male population.
#  B01001I_003Estimate!!Total!!Male!!Under 5 years
#  B01001I_004Estimate!!Total!!Male!!5 to 9 years

#And so on .  How marvelously specif is this?

#############
Latino_Ages_2017_NY<- get_acs(geography = "congressional district", variables = "B01001I_002",
                             year = 2017, state = "NY", geometry = FALSE)
dim(Latino_Ages_2017_US)


Latino_Ages_2017_NY_wide<- get_acs(geography = "congressional district",state = "NY",
                             table="B01001I", output = "wide",survey = "acs5")
View(Latino_Ages_2017_NY_wide)
