# packages ---------------------------------------------------------------

library(targets)
library(tarchetypes)
library(tigris)
options(tigris_use_cache = TRUE)
library(dataRetrieval)
library(sf)
library(conflicted)
conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")
library(tidyverse)
library(quarto)
