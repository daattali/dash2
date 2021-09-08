library(dash2)

dash_app() %>%
  set_layout(
    dashCoreComponents::dccInput(id = "text", "sample"),
    div("CAPS: ", span(id = "out1")),
    div("small: ", span(id = "out2"))
  ) %>%
  add_callback(
    list(
      "out1",
      output("out2", "children")
    ),
    "text",
    list(),
    function(input) {
      list(
        toupper(input$text),
        tolower(input$text)
      )
    }
  ) %>%
  run_app()

