using JuDocTemplates, JuDoc

build = joinpath(@__DIR__, "build")

isdir(build) || mkdir(build)

function fixdir(τ::String)
    # 1. remove src folder (not needed anymore)
    rm(joinpath(τ, "src"), recursive=true)
    # 2. fix links in index.html etc
    html_files = String[]
    for (root, _, files) ∈ walkdir(τ)
        for file ∈ files
            endswith(file, ".html") || continue
            fp   = joinpath(root, file)
            html = read(fp, String)
            html = replace(html, "href=\"/" => "href=\"/templates/$τ/")
            html = replace(html, "src=\"/" => "src=\"/templates/$τ/")
            write(fp, html)
        end
    end
    return
end

# make a template folder with a subfolder for each template
# compile each template with a fullpass of judoc
begin
    # first clean up the directory to avoid clashes etc
    begin
        cd(build)
        isdir("templates") && rm("templates", recursive=true)
        cd("..")
    end
    # make the template folder
    templates = mkpath(joinpath(build, "templates"))
    cd(templates)
    for τ ∈ JuDocTemplates.LIST_OF_TEMPLATES
        newsite(τ; template=τ, changedir=true, verbose=false)
        optimize(minify=(τ!="vela")) # see issue #7
        cd("..")
        fixdir(τ)
    end
end

# build the index page
begin
    html = IOBuffer()
    write(html, read(joinpath(@__DIR__, "index_head.html"), String))

    # One card per template
    for τ ∈ JuDocTemplates.LIST_OF_TEMPLATES
        c = """
            <a href="/templates/$τ/index.html" target="_blank" rel="noopener noreferrer">
            <div class="card">
              <div class="descr">
                <h2>$τ</h2>
              </div>
              <div class="code">
                <pre><font color="green" style="font-weight:bold">julia></font> <font color="royalblue">newsite</font>(<font color="darkred">"MySite"</font>; template=<font color="darkred">"$τ"</font>)</pre>
              </div>
            </div>
            </a>
            """
        write(html, c)
    end
    write(html, read(joinpath(@__DIR__, "index_foot.html"), String))
    write(joinpath(build, "index.html"), take!(html))
end
