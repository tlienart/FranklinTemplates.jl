"""
    initfolders(topdir, template)

Internal function to copy over the `common/[libs|src|assets]` folders to the
`topdir/[libs|src|assets]`. It also merges the content of `template/[libs|src|assets]` if the
template defines those folders. Folders cannot clash (see documentation).
See also [`newsite`](@ref).

**NOTE**: in `common/libs`, the highlight lib has a few standard languages (R, Julia, Python, ...).
If you want highlighting for other languages, you will need to replace the library.
"""
function initfolders(topdir::String, template::String)
    for foldername ∈ ("libs", "assets", "src")
        subdir = mkdir(joinpath(topdir, foldername))
        # common/foldername
        cp(joinpath(TEMPL_PATH, "common", foldername), subdir)
        # template/foldername
        template_subdir = joinpath(TEMPL_PATH, template, foldername)
        isdir(template_subdir) && mergefolders(template_subdir, subdir)
    end
    return nothing
end

"""
    initsrc(topdir, template)

Internal function to copy over the `common/src/` folder from a given template to the website folder.
See [`newsite`](@ref).
"""
function initsrc(topdir::String, template::String)
    src = mkdir(joinpath(topdir, "src"))
    cp(joinpath(TEMPL_PATH, template, "_css"),             joinpath(src, "_css"))
    cp(joinpath(TEMPL_PATH, template, "_html_parts"),      joinpath(src, "_html_parts"))
    cp(joinpath(TEMPL_PATH, "common", "src", "pages"),     joinpath(src, "pages"))
    cp(joinpath(TEMPL_PATH, "common", "src", "config.md"), joinpath(src, "config.md"))
    cp(joinpath(TEMPL_PATH, "common", "src", "index.md"),  joinpath(src, "index.md"))
end

"""
    initassets(topdir, template)

Internal function to copy over the `assets/` folder from a given template to the website folder.
See [`newsite`](@ref).
"""
function initassets(topdir::String, template::String)
    assets = mkdir(joinpath(topdir, "assets"))
    cp(joinpath(TEMPL_PATH, "common", "assets", "infra"),   joinpath(assets, "infra"))
    cp(joinpath(TEMPL_PATH, "common", "assets", "scripts"), joinpath(assets, "scripts"))

    tassets = joinpath(TEMPL_PATH, template, "assets")
    if isdir(tassets)
        mergefolders(tassets, assets)
    end
end
