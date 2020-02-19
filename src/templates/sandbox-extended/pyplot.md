@def hascode = true

# Franklin + PyPlot

Using Franklin with PyPlot is pretty straightforward but it's always nice to have a few examples especially for the paths.

**NOTE**: if you have lots of plots on a  page, it may happen that you see a warning like:

```
RuntimeWarning: More than 20 figures have been opened. Figures created through
the pyplot interface (`matplotlib.pyplot.figure`) are retained until explicitly
closed and may consume too much memory. (To control this warning, see the
rcParam `figure.max_open_warning`).
```

In such a case, consider killing the server, calling `using PyPlot; PyPlot.close_figs()` and restarting the server (you don't need to do this, but it will make the error go away and possibly avoid slowdown.).

```julia:ini
#hideall
using PyPlot
```

## Examples

### Sincs

```julia:pyplot1
#hideall
using PyPlot
figure(figsize=(8, 6))
x = range(-2, 2, length=500)
for α in 1:5
    plot(x, sinc.(α .* x))
end
savefig(joinpath(@OUTPUT, "sinc.svg")) # hide
```

\fig{sinc}

### Koch

[Original script](https://matplotlib.org/3.1.1/gallery/lines_bars_and_markers/fill.html#sphx-glr-gallery-lines-bars-and-markers-fill-py)

```julia:koch
#hideall
function koch(order, scale=10)
    if iszero(order)
        angles = @. ([0, 120, 240] + 90) * pi/180
        return @. scale / sqrt(3) * exp(angles * 1im)
    end
    ZR = 0.5 - 0.5im * sqrt(3)/3
    p1 = koch(order - 1)
    p2 = [p1[2:end]..., p1[1]]
    dp = p2 .- p1

    new_points = zeros(ComplexF64, length(p1) * 4)
    new_points[1:4:end] .= p1
    new_points[2:4:end] .= @. p1 + dp / 3
    new_points[3:4:end] .= @. p1 + dp * ZR
    new_points[4:4:end] .= @. p1 + dp / 3 * 2
    return new_points
end

function koch_plot(order, scale=10)
    points = koch(order, scale)
    x, y = real.(points), imag.(points)
    figure(figsize=(8,8))
    axis("equal")
    fill(x, y)
end

koch_plot(5)

savefig(joinpath(@OUTPUT, "koch.svg")) # hide
```

\fig{koch}

### Scatterplot + histogram

[Original file](https://matplotlib.org/3.1.1/gallery/lines_bars_and_markers/scatter_hist.html#sphx-glr-gallery-lines-bars-and-markers-scatter-hist-py)

```julia:sc-histo
#hideall
using Random
Random.seed!(5521)

x = randn(1_000)
y = randn(1_000)

left, width = 0.1, 0.65
bottom, height = 0.1, 0.65
spacing = 0.005

rect_scatter = [left, bottom, width, height]
rect_histx = [left, bottom + height + spacing, width, 0.2]
rect_histy = [left + width + spacing, bottom, 0.2, height]

figure(figsize=(8,8))

ax_scatter = plt.axes(rect_scatter)
ax_scatter.tick_params(direction="in", top=true, right=true)
ax_histx = plt.axes(rect_histx)
ax_histx.tick_params(direction="in", labelbottom=false)
ax_histy = plt.axes(rect_histy)
ax_histy.tick_params(direction="in", labelleft=false)

ax_scatter.scatter(x, y)

binwidth = 0.25
lim = ceil(maximum(abs.(vcat(x, y))) / binwidth) * binwidth
ax_scatter.set_xlim((-lim, lim))
ax_scatter.set_ylim((-lim, lim))

bins = -lim:binwidth:(lim + binwidth)

ax_histx.hist(x, bins=bins)
ax_histy.hist(y, bins=bins, orientation="horizontal")

ax_histx.set_xlim(ax_scatter.get_xlim())
ax_histy.set_ylim(ax_scatter.get_ylim())

savefig(joinpath(@OUTPUT, "schist.svg")) # hide
```

\fig{schist.svg}
