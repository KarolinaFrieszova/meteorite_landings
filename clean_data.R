library(tidyverse)
library(janitor)
library(assertr)

# Read in data 

meteorite_landings <- read_csv("raw_data/meteorite_landings.csv")

# Clean Data

meteorites <- clean_names(meteorite_landings)

meteorites <- meteorites %>% 
  separate(geo_location, c("latitude", "longitude"), sep = ",") %>% 
  mutate(latitude = str_remove_all(latitude, "^\\("),
         longitude = str_remove_all(longitude, "\\)$"),
         latitude = as.numeric(latitude),
         longitude = as.numeric(longitude),
         latitude = coalesce(latitude, 0, na.rm = TRUE),
         longitude = coalesce(longitude, 0, na.rm = TRUE)) %>% 
  filter(mass_g > 1000) %>% 
  drop() %>% 
  arrange(year)

# Verify that we have valid latitudes and longitudes

meteorites %>% 
  verify(latitude >= -90 & latitude <= 90) %>% 
  verify(longitude >= -180 & longitude <= 180) 

# Verify the data is as we expect

stopifnot(names(meteorites) %in% 
            c("id", "name", "mass_g", "year", "fall", "latitude", "longitude"))

# Save clean dataset

write_csv(meteorites, "clean_data/meteorites.csv")
