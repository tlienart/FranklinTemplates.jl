# This file was generated, do not modify it. # hide
#hideall
function linescatter1()
    trace1 = scatter(;x=1:4, y=[10, 15, 13, 17], mode="markers")
    trace2 = scatter(;x=2:5, y=[16, 5, 11, 9], mode="lines")
    trace3 = scatter(;x=1:4, y=[12, 9, 15, 12], mode="lines+markers")
    plot([trace1, trace2, trace3])
end
function batman()
    σ(x) = @. √(1-x^2)
    el(x) = @. 3*σ(x/7)
    s(x) = @. 4.2 - 0.5*x - 2.0*σ(0.5*x-0.5)
    b(x) = @. σ(abs(2-x)-1) - x^2/11 + 0.5x - 3
    c(x) = [1.7, 1.7, 2.6, 0.9]

    p(i, f; kwargs...) = scatter(; x=[-i; 0.0; i], y=[f(i); NaN; f(i)],
                                  marker_color="black", showlegend=false,
                                  kwargs...)
    traces = vcat(p(3:0.1:7, el;         name="wings 1"),
                  p(4:0.1:7, t->-el(t);  name="wings 2"),
                  p(1:0.1:3, s;          name="Shoulders"),
                  p(0:0.1:4, b;          name="Bottom"),
                  p([0, 0.5, 0.8, 1], c; name="head"))

    plot(traces, Layout(title="Batman"))
end