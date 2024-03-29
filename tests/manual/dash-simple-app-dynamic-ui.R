library(dash2)
library(dashCoreComponents)

app <- dash_app("test app")
app %>% set_layout(function() {div(
  h1('Hello Dash'),
  "Dash: A web application framework for R.",
  br(),
  "Time: ", as.character(Sys.time()),
  dccGraph(
    figure=list(
      data=list(
        list(
          x=list(1, 2, 3),
          y=list(4, 1, 2),
          type='bar',
          name='SF'
        ),
        list(
          x=list(1, 2, 3),
          y=list(2, 4, 5),
          type='bar',
          name='Montr\U{00E9}al'
        )
      ),
      layout = list(title='Dash Data Visualization')
    )
  ))
})
app %>% run_app()
