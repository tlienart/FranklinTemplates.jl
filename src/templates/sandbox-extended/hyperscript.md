@def hascode = true

# Franklin + Hyperscript

* [back home](/)

If you like using [Hyperscript.jl](https://github.com/yurivish/Hyperscript.jl) and would like to use it to include raw HTML, it's pretty easy, you just need to ensure that the resulting HTML is plugged in between `~~~`.

```julia:ini
#hideall
using Hyperscript
```

## Examples

### Basic

First example:

```julia:ex1
#hideall
h = m("div", class="entry",
      m("h4", "An Important Announcement"))
println("~~~$h~~~")
```
\textoutput{ex1}

pretty easy...

### Useful trick

You could just define a function to plug things in `~~~`:

```julia:fun
#hideall
html(s) = println("~~~$s~~~")
```

which is then easy to use:

```julia:ex2
#hideall
@tags p
@tags_noescape style

s1 = Style(css("p", fontWeight="bold", color="red"))
style(styles(s1)) |> html
s1(p("hello"))    |> html
```
\textoutput{ex2}
