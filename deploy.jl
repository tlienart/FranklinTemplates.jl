include(joinpath("docs", "make.jl"))

cd(@__DIR__)

# fix all links to prepend them with `FranklinTemplates.jl/`
for (root, _, files) ∈ walkdir(joinpath(@__DIR__, "docs", "build"))
    for file ∈ files
        endswith(file, ".html") || continue
        path  = joinpath(root, file)
        htmls = read(path, String)
        htmls = replace(htmls, "href=\"/" => "href=\"/FranklinTemplates.jl/")
        htmls = replace(htmls, "src=\"/" => "src=\"/FranklinTemplates.jl/")
        write(path, htmls)
    end
end

using NodeJS

const JS_GHP = """
    var ghpages = require('gh-pages');
    ghpages.publish('docs/build', function(err) {});
    """
run(`$(NodeJS.nodejs_cmd()) -e $JS_GHP`)
