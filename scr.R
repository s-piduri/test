#####
#developed to extract relevant infor for Deans during JoAnn's absence to imitate her enrollment report
library(tidyverse)
library(janitor)
library(readxl)
library(scales)
library(openxlsx)

# read file ---------------------------------------------------------------

headcnt_trnd_raw <- read_excel(path = "data/2022-01-28student_enrlmnt_district.xlsx", sheet = 7, range = "A4:Q7")
seatcnt_trnd_raw <- read_excel(path = "data/2022-01-28student_enrlmnt_district.xlsx", sheet = 7, range = "A14:Q17")


# pivot and join data ------------------------------------------------------------

headcnt_trnd <- headcnt_trnd_raw %>% 
  rename(term_id = "Student Count") %>% 
  pivot_longer(cols = !term_id, names_to = "week", values_to = 'hdcnt')

seatcnt_trnd <- seatcnt_trnd_raw %>% 
  rename(term_id = "Seat Count") %>% 
  pivot_longer(cols = !term_id, names_to = "week", values_to = 'seatcnt')

trnd_data <- headcnt_trnd %>% 
  left_join(seatcnt_trnd, by = c("term_id", "week")) %>% 