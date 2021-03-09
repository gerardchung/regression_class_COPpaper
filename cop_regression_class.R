# Reactable table for Dissertation P2 Descriptive table 
#########################################################
#########################################################   
# Compare on child-level, caregiver-level, family/case/community-level between NSCAW 1 and 2

rm(list=ls())
library(readxl)
library(reactable)
library(htmltools)
library(hrbrthemes)
library(tidyverse)
library(janitor)

# Load dataset
#############
#combined_child <- read_xlsx("results/plots_tables/descriptives_tables/descriptive_predictors_nscaw_formattable.xlsx",
#                           sheet = "cop")

combined_child <- read_xlsx("descriptive_predictors_nscaw_formattable.xlsx",
                            sheet = "cop")

# Create ID 
##############
combined_child <- combined_child %>% mutate(id = row_number())

## Change vars to numeric
############################
#combined_child$percent_nscaw1 <- as.numeric(combined_child$percent_nscaw1)
#combined_child$percent_nscaw2 <- as.numeric(combined_child$percent_nscaw2)
#combined_child$N_nscaw1 <- as.numeric(combined_child$N_nscaw1)
#combined_child$N_nscaw2 <- as.numeric(combined_child$N_nscaw2)
#combined_child$Mean_nscaw2 <- as.numeric(combined_child$Mean_nscaw2)
#combined_child$SD_nscaw2 <- as.numeric(combined_child$SD_nscaw2)

# Reaarrange vars
######################
combined_child <- combined_child %>% relocate(id, 
                                             variables,
                                             percent_nscaw1, N_nscaw1,
                                             Mean_nscaw1, SD_nscaw1)


# Format the variables
######################
combined_child$percent_nscaw1 <- round(combined_child$percent_nscaw1, digits = 2) 
#combined_child$percent_nscaw2 <- round(combined_child$percent_nscaw2, digits = 0)
    # keep this numeric with missing as NA so that later I can express the is.na 
    # as "-" in reactable codes
table(combined_child$percent_nscaw1, exclude = F)


# Basic Reactable table
#########################
reactable(combined_child,
          defaultSortOrder = 'asc',
          defaultSorted = 'id',
          showSortIcon = FALSE,
          compact = TRUE,
          pagination = FALSE)

#library(hrbrthemes) # for font_es


# Function to create the bar_chart 
######################################
bar_chart <- function(label, width = "100%", height = "16px", fill = "lightblue", background = NULL) {
    bar <- div(style = list(background = fill, width = width, height = height))
    chart <- div(style = list(flexGrow = 1, marginLeft = "8px", background = background), bar)
    div(style = list(display = "flex", alignItems = "center"), label, chart)
}


# Table with problems of bars displayed for numerical vars - SOLVED
##################################################################

reactable(combined_child,
          defaultSortOrder = 'asc',
          defaultSorted = 'id',
          showSortIcon = FALSE,
          compact = TRUE,
          pagination = FALSE,
          highlight = T,
          ###
          defaultColDef = colDef(
              ### define header styling
              headerStyle = list(
                  textAlign = "left",
                  fontSize = "14px",
                  lineHeight = "14px",
                  textTransform = "uppercase",
                  color = "#0c0c0c",
                  fontWeight = "500",
                  borderBottom = "2px solid #e9edf0",
                  paddingBottom = "3px",
                  verticalAlign = "bottom",
                  fontFamily = "Menlo"
              ),
              ### define default column styling
              style = list(
                  fontFamily = "Menlo", # "Menlo";
                  whiteSpace = "pre", #  this whitespace is useful to have alignment for the percentage values
                  fontSize = "12px",
                  verticalAlign = "center",
                  align = "left"
              )
          ),
          columns = list(
              id         = colDef(show = F),
              variables = colDef(name = "Variables", align = "left", minWidth = 250),
              N_nscaw1 = colDef(name = "N", align = "center", minWidth = 70),
              percent_nscaw1 =  colDef(na = "NA", name = "%", align = "left",  minWidth = 100,
                                      # solution to solve the missing values
                                       cell = function(value) {
                                           width <- if (!is.na(value) ) {
                                               paste0(value  * 100, "%") 
                                           } else if (is.na(value)) 
                                               return("-")
                                           value <- format(value*100, width = 2, justify = "right") 
                                           # this together with whitespace abv helps alignmt of % values
                                           bar_chart(value, width = width, fill = "#F15A3F", background = "#e1e1e1" ) #lightblue
                                       }),
              Mean_nscaw1 = colDef(na = "-", (name = "Mean"), minWidth = 50),
              SD_nscaw1 = colDef(na = "-", (name = "SD"), minWidth = 50)
          )
)


# Reactable Table with problems of bars displayed for numerical vars (SOLVED ABOVE)
###############################################################################
reactable(combined_child,
          defaultSortOrder = 'asc',
          defaultSorted = 'id',
          showSortIcon = FALSE,
          compact = TRUE,
          pagination = FALSE,
          highlight = T,
          ###
          defaultColDef = colDef(
              ### define header styling
              headerStyle = list(
                  textAlign = "left",
                  fontSize = "14px",
                  lineHeight = "14px",
                  textTransform = "uppercase",
                  color = "#0c0c0c",
                  fontWeight = "500",
                  borderBottom = "2px solid #e9edf0",
                  paddingBottom = "3px",
                  verticalAlign = "bottom",
                  fontFamily = "Menlo"
              ),
              ### define default column styling
              style = list(
                  fontFamily = "Menlo", whiteSpace = "pre", # this whitespace is useful to have alignment for the percentage values
                  fontSize = "12px",
                  verticalAlign = "center",
                  align = "left"
              )
          ),
          columns = list(
              id         = colDef(show = F),
              variables = colDef(name = "Child-level", align = "left", minWidth = 250),
              N_nscaw1 = colDef(name = "NSCAW 1", align = "center", minWidth = 70),
              percent_nscaw1 =  colDef(na = "NA", name = "%", align = "left",  minWidth = 150,
                                       cell = function(value) {
                                           width <- paste0(value, "%")
                                           value <- format(value, width = 2, justify = "left") # this together with whitespace abv helps alignmt of % values
                                           bar_chart(value, width = width, fill = "#F15A3F", background = "#e1e1e1" ) #lightblue
                                       }),
              N_nscaw2 = colDef(name = "NSCAW 2", align = "center",  minWidth = 70),
              percent_nscaw2 =  colDef(name = "%", align = "left", minWidth = 150,
                                       cell = function(value) {
                                           width <- paste0(value, "%") 
                                           value <- format(value, width = 2, justify = "left") 
                                           bar_chart(value, width = width, fill = "#3F5661", background = "#e1e1e1" ) #orange
                                       }),
              Mean_nscaw1 = colDef(na = "-", (name = "Mean"), minWidth = 50),
              SD_nscaw1 = colDef(na = "-", (name = "SD"), minWidth = 50),
              Mean_nscaw2 = colDef(na = "-", (name = "Mean"), minWidth = 50),
              SD_nscaw2 = colDef(na = "-", (name = "SD"), minWidth = 50)            
          )
)

