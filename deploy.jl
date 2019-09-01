include(joinpath("docs", "make.jl"))

cd(@__DIR__)

# fix all links to prepend them with `JuDocTemplates.jl/`
for (root, _, files) ∈ walkdir(joinpath(@__DIR__, "docs", "build"))
    for file ∈ files
        endswith(file, ".html") || continue
        path = joinpath(root, file)
        html = read(path, String)
        html = replace(html, "href=\"/" => "href=\"/JuDocTemplates.jl/")
        html = replace(html, "src=\"/" => "src=\"/JuDocTemplates.jl/")
        write(path, html)
    end
end

const JS_GHP = """
    var ghpages = require('gh-pages');
    ghpages.publish('docs/build', function(err) {});
    """
run(`node -e $JS_GHP`)
