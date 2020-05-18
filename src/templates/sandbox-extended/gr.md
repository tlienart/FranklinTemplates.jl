@def hascode = true

# Franklin + GR

## Examples

### animation

* This example is taken from [GR.jl/examples/anim.ipynb](https://github.com/jheinen/GR.jl/blob/master/examples/anim.ipynb).

```julia:gr
using GR

GR.inline("mov")
x = collect(0:0.01:2*pi)
for i = 1:100
    GR.plot(x, sin.(x .+ i / 10.0), size=(400,300))
end

s = GR.show()
println("~~~$(s.s)~~~") # hide
```

\textoutput{gr}

