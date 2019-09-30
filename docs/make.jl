using JuDocTemplates, JuDoc

descr = Dict{String,String}(
    "sandbox"   => """
                   <span class="th-name">sandbox</span>
                   <p>Simplest one-page layout, meant for practicing or testing JuDoc syntax.</p>
                   """,
    "basic"     => """
                   <span class="th-name">basic</span>
                   <p>Barebone responsive theme with a top navigation bar, no extra javascript and a simple stylesheet.</p>
                   """,
    "jemdoc"    => """
                   <span class="th-name">jemdoc</span>
                   <p>Simple theme with a side navigation bar, no extra javascript and a simple stylesheet. (Adapted from the original Jemdoc theme.)</p>
                   """,
    "hyde"      => """
                   <span class="th-name">hyde</span>
                   <p>A neat two-column responsive theme with a side navigation bar, no extra javascript and a simple stylesheet. (Adapted from the Jekyll theme.)</p>
                   """,
    "hypertext" => """
                   <span class="th-name">hypertext</span>
                   <p>Barebone responsive theme with a simple top navigation bar, no extra javascript and a simple stylesheet. (Adapted from the Grav theme.)</p>
                   """,
    "lanyon"    => """
                   <span class="th-name">lanyon</span>
                   <p>A neat single-column theme with a sliding menu-bar, no extra javascript and a simple stylesheet. (Adapted from the Jekyll theme.)</p>
                   """,
    "pure-sm"   => """
                   <span class="th-name">pure-sm</span>
                   <p>Single-column theme with a sliding menu-bar, a simple stylesheet and some javascript for the menu bar. (Adapted from the Pure CSS theme.)</p>
                   """,
    "tufte"     => """
                   <span class="th-name">tufte</span>
                   <p>A neat single-column theme adapted from tufte.css with a focus on clarity and nice typesetting, no extra javascript and a sophisticated stylesheet.</p>
                   """,
    "vela"      => """
                   <span class="th-name">vela</span>
                   <p>A single-column theme with a sliding menu-bar, a simple stylesheet and extra javascript for the menu-bar. (Adapted from the Grav theme.)</p>
                   """,
    )


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
        println("🍏  template: $τ")
        newsite(τ; template=τ, changedir=true, verbose=false)
        optimize(minify=(τ!="vela")) # see issue #7
        cd("..")
        fixdir(τ)
    end
    # copy over the thumb folder
    cp(joinpath(dirname(build), "thumb"), joinpath(build, "thumb"), force=true)
end

# build the index page
begin
    html = IOBuffer()
    write(html, read(joinpath(@__DIR__, "index_head.html"), String))

    # One card per template
    for τ ∈ JuDocTemplates.LIST_OF_TEMPLATES
        c = """
            <a href="/templates/$τ/index.html" target="_blank" rel="noopener noreferrer" title="$τ">
            <div class="card" id="$τ">
              <div class="descr">
              $(descr[τ])
              </div>
            </div>
            </a>
            """
        write(html, c)
    end
    write(html, read(joinpath(@__DIR__, "index_foot.html"), String))
    write(joinpath(build, "index.html"), take!(html))
end
