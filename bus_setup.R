library(rjstat)
library(rvest)
library(dplyr)
library(later)

bus_url <- "http://rtpi.ie/Text/WebDisplay.aspx?stopRef="

interval_time <- 10

# 46a oconnell street 6059
# pearse street 346
my_bus_stop <- "346"
supervalue_stop <- "4616"

call_times <- function(stop_number){
  paste0(bus_url,stop_number) %>%
    read_html() %>%
    html_node("table") %>%
    html_table() %>% data.frame()
}

times1 <- call_times(my_bus_stop)