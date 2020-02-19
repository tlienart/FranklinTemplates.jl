# This file was generated, do not modify it. # hide
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