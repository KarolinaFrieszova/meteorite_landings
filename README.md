# Meteorite landings
Cleaning and analysing data from NASA on meteorites that have been found up to the year 2013

# Stracture of project
R project with two pieces of code:
1. A clean_data.R file that cleans some data on meteorites.
2. A plots.Rmd file that takes the cleaned data and performs some analysis.

# The dataset contains following variables
- id: a unique identifier for the meteorite
- name: the meteorite's name
- mass_g: the mass of the meteorite in grams
- fall: fell - for meteorite that has been seen falling
        found - meteorite's fall was not observed 
- year: the year the meteorite fell, or the year it was found (depending on the value of fell)
- latitude: the latitude of the meteorite's landing
- longitude: the longitude of the meteorite's landing

# The clean_data.R file
- reads data and changes the names of variables to follow naming standards
- splits column into 'GeoLocation' latitude and longitude, changes type to numeric
- replaces any missing values in latitude and longitude with zeros
- removes meteorites less than 1000g in weight from the data
- orders the data by the year of discovery
- assertive programming included to ensure that names of variables as we expect & latitude and longitude observations have valid values
- saves cleaned data into clean_data folder

# The plots.Rmd file
- reads clean data in
- finds names and years of ten largest meteorites found
- finds the average mass of meteorites that were recorded falling, vs. those which were just found
- finds the number of meteorites in each year, for every year since 2000
