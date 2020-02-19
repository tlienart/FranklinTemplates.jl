@def hasmdpad = true
@def hasplotly = true
@def reeval = true <!-- seems necessary -->

# Franklin + mpad

* [home](/)

## *mdpad* example with Hyperscript.jl inputs and Mithril outputs

This is an example [mdpad](https://mdpad.netlify.com) page.
The inputs and outputs are generated using the [mdpad-mithril](https://github.com/tshort/mdpad-js/blob/master/src/mdpad-mithril.js) helper functions.
These helper functions rely on [Mithril](https://mithril.js.org/) and Bootstrap.

```julia:inputs
#hideall
using Hyperscript
@tags div label input select option

function minput(;
      title = "",
      mdpad = "",
      type = "number",
      step = 1,
      min = 0,
      value = 0,
    )
    return div.formGroup(
             label."control-label"(title),
             input."form-control"(mdpad=mdpad, type=type, step=step, min=min, value=value))
end

function mselect(;
      title = "",
      mdpad = "",
      options = "",
      selected = "",
    )
    options = (option(x, selected = x == selected) for x in options)
    return div."form-group"(
             label."control-label"(title),
             select."form-control"(mdpad=mdpad, options...))
end
print("~~~")
print(
    div.row(
        div."col-md-6"(
            minput(title="Number A", mdpad="A", value=3.3),
            mselect(title="Fruit", mdpad="fruit", options=["apple", "banana", "orange"]),
)))
print("~~~")
```

\textoutput{inputs}

## Results

Here are some results. As the inputs above change, the outputs should adjust accordingly.
The plot is done with [Plotly-js](https://plot.ly/javascript/).

<!-- anchor for plotly -->
~~~
<div id="output"></div>
~~~

<!-- simple styling (you could load bootstrap...) -->
~~~
<style>
.control-label { padding-right: 10px;}
</style>
~~~


~~~
<script>
var tbl = {
    fruit: ["orange", "apple", "banana", "apple"],
    k: [10, 20, 50, 99],
}

function mdpad_update() {
    tbl["k * A"] = tbl.k.map((x) => mdpad.A * x);
    var colors = tbl.fruit.map((x) => x == mdpad.fruit ? "green" : "purple");   
    m.render(document.getElementById("output"), m("div",
      mdatatable(tbl, {theadclass: "thead-dark"}),
      m("p", "The first ", m("em", mdpad.fruit),
        " in the table has k == ", m("b", tbl.k[tbl.fruit.indexOf(mdpad.fruit)]), "."),
      mplotly([{x: tbl.fruit, y: tbl["k * A"], type:"bar", marker: {color: colors}}]),
    ));
}

</script>
~~~
