# This file was generated, do not modify it. # hide
#hideall
function make_ax(title, tickangle)
    attr(title=title, titlefont_size=20, tickangle=tickangle,
        tickfont_size=15, tickcolor="rgba(0, 0, 0, 0)", ticklen=5,
        showline=true, showgrid=true)
end

raw_data = [
    Dict(:journalist=>75, :developer=>:25, :designer=>0, :label=>"point 1"),
    Dict(:journalist=>70, :developer=>:10, :designer=>20, :label=>"point 2"),
    Dict(:journalist=>75, :developer=>:20, :designer=>5, :label=>"point 3"),
    Dict(:journalist=>5, :developer=>:60, :designer=>35, :label=>"point 4"),
    Dict(:journalist=>10, :developer=>:80, :designer=>10, :label=>"point 5"),
    Dict(:journalist=>10, :developer=>:90, :designer=>0, :label=>"point 6"),
    Dict(:journalist=>20, :developer=>:70, :designer=>10, :label=>"point 7"),
    Dict(:journalist=>10, :developer=>:20, :designer=>70, :label=>"point 8"),
    Dict(:journalist=>15, :developer=>:5, :designer=>80, :label=>"point 9"),
    Dict(:journalist=>10, :developer=>:10, :designer=>80, :label=>"point 10"),
    Dict(:journalist=>20, :developer=>:10, :designer=>70, :label=>"point 11")
]

t = scatterternary(
    mode="markers",
    a=[d[:journalist] for d in raw_data],
    b=[d[:developer] for d in raw_data],
    c=[d[:designer] for d in raw_data],
    text=[d[:label] for d in raw_data],
    marker=attr(symbol=100, color="#DB7365", size=14, line_width=2)
)
layout = Layout(
    ternary=attr(
        sum=100,
        aaxis=make_ax("Journalist", 0),
        baxis=make_ax("Developer", 45),
        caxis=make_ax("Designer", -45),
        bgcolor="#fff1e0",
    ), annotations=attr(
        showarrow=false,
        text="Replica of Tom Pearson's block",
        x=1.0, y=1.3, font_size=15
    ),
    paper_bgcolor="#fff1e0"
)
plt = plot(t, layout)

fdplotly(json(plt))