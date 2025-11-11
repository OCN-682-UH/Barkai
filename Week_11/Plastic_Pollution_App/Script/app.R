# =====================================================
# Plastic Pollution App
# Author: Leah Barkai
# Date: November 11, 2025
# =====================================================

# ---- Load libraries ----
library(shiny)          # builds web apps
library(tidyverse)      # main data manipulation + visualization packages
library(janitor)        # cleans column names
library(DT)             # creates interactive data tables in Shiny
library(rnaturalearth)  # provides world map data for plotting
library(rnaturalearthdata) # supports rnaturalearth (extra map data)
library(sf)             # handles spatial (map) data
library(plotly)         # makes ggplot maps interactive
library(scales)         # adds formatting helpers 

# =====================================================
# Load Data
# =====================================================

# Load TidyTuesday dataset for 2021-01-26
PlasticData <- tidytuesdayR::tt_load('2021-01-26')

# =====================================================
# Clean Data
# =====================================================

# Convert plastics data into a tibble
plastic_table <- as_tibble(PlasticData$plastics)

# Clean and prepare dataset
plastic_clean <- plastic_table %>%
  clean_names() %>%                         # Clean column names
  mutate(
    country = str_trim(country),            # Remove extra spaces in country names
    year = as.integer(year)) %>%            # Convert year column to numeric
  rename(total_plastic_kg = grand_total) %>%# Rename column
  select(country, total_plastic_kg, year) %>% # Keep relevant columns
  filter(!is.na(country) & !is.na(total_plastic_kg) & total_plastic_kg != 0) %>% # Remove missing or zero values
  distinct() %>%                            # Keep unique rows only
  mutate(
    country = str_squish(country),          # Remove double spaces within names
    country_lower = str_to_lower(country) ) %>% # Create lowercase version for cleaning
  filter(country_lower != "empty", country_lower != "") %>% # Remove invalid country entries
  mutate(
    country = case_when(                    # Standardize country name spellings
      country_lower == "ecuador" ~ "Ecuador",
      country_lower %in% c(
        "cote d_ivoire", "cote d'ivoire", "cote d’ivoire",
        "côte d’ivoire", "côte d'ivoire", "cote_d_ivoire",
        "cotedivoire", "cote d ivoire", "cote_d'ivoire"
      ) ~ "Côte d'Ivoire",
      str_detect(country_lower, "taiwan") ~ "Taiwan",
      str_detect(country_lower, "united kingdom") ~ "United Kingdom",
      str_detect(country_lower, "united states") ~ "United States",
      TRUE ~ str_to_title(country)          # Capitalize remaining country names
    )
  ) %>%
  filter(country != "Hong Kong") %>%        # Exclude Hong Kong
  select(-country_lower)                    # Drop helper column

# Summarize total plastic by country and year
plastic_table_summary <- plastic_clean %>%
  group_by(country, year) %>%               # Group data by country and year
  summarize(total_plastic_kg = sum(total_plastic_kg), .groups = "drop") %>% # Sum plastic totals
  arrange(country, year)                    # Sort alphabetically and by year

# Pivot data wide for easier viewing
plastic_summary_wide <- plastic_table_summary %>%
  pivot_wider(
    names_from = year,                      # Use 'year' as new column names
    values_from = total_plastic_kg,         # Fill columns with plastic values
    values_fill = 0                         # Replace missing values with 0
  ) %>%
  mutate(Total_All_Years = rowSums(across(-country))) %>% # Add total column across all years
  rename(Country = country)                 # Capitalize column name for display

# =====================================================
# App Code
# =====================================================
ui <- fluidPage(
  
  titlePanel("Plastic Pollution Visualization App 🌍"),  # App title
  tabsetPanel(                                           # Create tabs for views
    # --- TAB 1: Data Table ---
    tabPanel("Table View",
             br(),
             p("This interactive table shows total plastic collected in kg per country and year from the TidyTuesday dataset (2021-01-26)."),
             DTOutput("plastic_table")),                  # Output interactive data table
    
    # --- TAB 2: World Map ---
    tabPanel("World Map",
             br(),
             p("Map visualization of total plastic collected in kg by country."),
             plotlyOutput("plastic_map", height = "600px")))) # Output interactive map

# =====================================================
# Server
# =====================================================
server <- function(input, output, session) {
  # Render interactive DataTable ----
  output$plastic_table <- renderDT({
    datatable(
      plastic_summary_wide,                # Use summarized dataset
      rownames = FALSE,                    # Hide row numbers
      options = list(
        pageLength = 10,                   # Show 10 rows per page
        autoWidth = TRUE,                  # Adjust column width automatically
        scrollX = TRUE,                    # Allow horizontal scrolling
        searching = TRUE,                  # Enable search bar
        ordering = TRUE),                  # Enable sorting
      caption = htmltools::tags$caption(   # Add custom caption above the table
        style = 'caption-side: top; text-align: center; font-weight: bold;',
        'Plastic Collected in kg per Country and Year'))})
  
  # Render interactive Map ----
  output$plastic_map <- renderPlotly({
    world <- ne_countries(scale = "medium", returnclass = "sf") # Load world map geometry
    
    world_plastic <- world %>%
      left_join(plastic_summary_wide, by = c("name" = "Country")) # Join with plastic data
    
    # Create base ggplot world map
    p <- ggplot(world_plastic) +
      geom_sf(aes(
        fill = Total_All_Years,            # Color by total plastic amount
        text = paste0(name, ": ", comma(Total_All_Years)) # Tooltip info
      ), color = "black") +
      scale_fill_viridis_c(option = "plasma", na.value = "grey90") + # Color scale
      theme_minimal() +
      labs(fill = "Plastic Amount (Kg)")   # Legend label
    
    # Convert ggplot to interactive Plotly plot
    ggplotly(p, tooltip = "text") %>%
      layout(
        annotations = list(                # Add title and source note to plot
          list(x = 0.485, y = 1.03, xref = "paper", yref = "paper",
               text = "<b>Total Plastic Collected in kg by Country (2019–2020)</b>",
               showarrow = FALSE,
               xanchor = "center", yanchor = "bottom",
               font = list(size = 18)),
          list(x = 0.485, y = 0.99, xref = "paper", yref = "paper",
               text = "<i>Data source: TidyTuesday 2021-01-26</i>",
               showarrow = FALSE,
               xanchor = "center", yanchor = "top",
               font = list(size = 13, color = "gray30"))
        ),
        margin = list(t = 110, b = 40, l = 40, r = 40))})}  # Add spacing

# =====================================================
# RUN THE APP
# =====================================================
shinyApp(ui = ui, server = server)         # Launch the app
