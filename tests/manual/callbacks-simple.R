library(dash2)

dash_app() %>%
  set_layout(
    dashCoreComponents::dccInput(id = "text", "sample"),
    div("CAPS: ", span(id = "out1")),
    div("small: ", span(id = "out2"))
  ) %>%
  add_callback(
    list(
      output("out1", "children"),
      output("out2", "children")
    ),
    input("text", "value"),
    function(text) {
      list(
        toupper(text),
        tolower(text)
      )
    }
  ) %>%
  run_app()

