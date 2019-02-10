

check_bus = function(interval = interval_time) {
  current_table <- call_times(my_bus_stop) %>% filter(Time == "Due") %>%
    select(Service, To)
  if (nrow(current_table) > 0) {
    current_table$Time <- format(Sys.time(), '%H:%M')
    current_table$Date <- format(Sys.time(), '%d-%m')
  }

  if (exists("due_record") == FALSE) {
    # First time
    print("First go. Making dataframe")
    due_record <- current_table %>%
      distinct()
    assign("due_record", due_record, envir = .GlobalEnv)
  }
  else{
    # Normal operation
    if (nrow(current_table) == 0) {
      #print("No buses due!")
    }
    else{
      print("There's a bus coming!")
      due_record <- bind_rows(due_record, current_table) %>%
        distinct()
      assign("due_record", due_record, envir = .GlobalEnv)
    }
  }
  print(paste("Still running    time:", format(Sys.time(), '%H:%M:%S')))
  later::later(check_bus, interval)
}

check_bus()
rm(check_bus)
rm(due_record)
