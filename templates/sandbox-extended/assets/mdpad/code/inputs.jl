# This file was generated, do not modify it. # hide
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