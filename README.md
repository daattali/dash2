# dash2 - Wrapper for Plotly's {dash}

This package requires an installation of the dev version of {dash}:

```
remotes::install_github("plotly/dashR", "dev")
```

## Example of old vs new syntax

Using old {dash}:

```
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

app <- Dash$new(meta_tags = list(list(name = 'description', content = 'My App')))

app$layout(
  htmlDiv(
    list(
      htmlH1('Hello Dash'),
      htmlDiv(children = list("Dash: ", "A web application framework for R.")),
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
      )
    )
  )
)

app$title("My app")

app$run_server(port = 8060)
```

Using new {dash2}:

```
library(dash2)

app <- dash_app("My app")

app %>% set_layout(
  h1('Hello Dash'),
  div("Dash: ", "A web application framework for R."),
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
  )
)

app %>%
  add_meta(list(name = 'description', content = 'My App')) %>%
  run_app(port = 8060)
```

To add stylesheets/javascript, call `app %>% add_stylesheet()` or `app %>% add_script()` with either a single URL or a list of URLs. These functions can be called multiple times, each time new scripts will be added to the app.

Note that a browser session will automatically be launched.

All HTML tags are available with the `html` list. Any tag can take an arbitrary number of parameters; named parameters become attributes, and non-named parameters become children. For example, to create `<div title="foo">bar</div>`, use `html$div(title = "foo", "bar")`. Some common HTML tags are upgraded to functions for convenience, for example you can use `div()` or `h1()` instead of `html$div()` or `html$h1()`.
