# {dash2} rewrite of the app from https://dashr.plotly.com/pattern-matching-callbacks

library(dash2)
library(dashCoreComponents)

app <- dash_app()
app %>%
  set_layout(
    button("Add Filter", id = "add-filter"),
    div(id="dropdown-container"),
    div(id="dropdown-container-output")
  ) %>%
  add_callback(
    "dropdown-container",
    input(id = "add-filter", property = "n_clicks", name = "filter_click"),
    state(id = "dropdown-container", property = "children", name = "dropdown_content"),
    function(input) {
      new_dropdown = dccDropdown(
        id=list(
          "index" = input$filter_click,
          "type" = "filter-dropdown"
        ),
        options = lapply(c("NYC", "MTL", "LA", "TOKYO"), function(x){
          list("label" = x, "value" = x)
        })
      )
      children <- input$dropdown_content
      children[[input$filter_click + 1]] <- new_dropdown
      return(children)
    }
  ) %>%
  add_callback(
    "dropdown-container-output",
    input(id=list("index" = ALL, "type" = "filter-dropdown"), property = "value", name = "mydropdown"),
    function(input) {
      test <- input$mydropdown
      return(div(
        lapply(seq_along(test), function(x){
          return(div(sprintf("Dropdown %s = %s", x, test[[x]])))
        })
      ))
    }
  ) %>%
  run_app()
