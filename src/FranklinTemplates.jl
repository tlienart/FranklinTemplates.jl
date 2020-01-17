module FranklinTemplates

export newsite

const FRANKLIN_PATH     = splitdir(pathof(FranklinTemplates))[1]
const TEMPL_PATH        = joinpath(FRANKLIN_PATH, "templates")
const LIST_OF_TEMPLATES = ("sandbox", "basic", "jemdoc", "just-the-docs",
                           "hyde", "hypertext", "lanyon", "minimal-mistakes",
                           "pure-sm", "tufte", "vela")

"""
    newsite(topdir; template="basic", cd=true)

Generate a new folder (an error is thrown if it already exists) that contains the skeleton of a
website that can be processed by Franklin. The user can specify a `template`
out of the list of available templates.

* `template="basic"`: name of the template to use,
* `cd=true`:          whether to change the current directory to the newly
                      created folder or not.
* `verbose=true`:     whether to display information or not.

### Example

```julia
newsite("MyNewWebsite", template="pure-sm")
```
"""
function newsite(topdir::String="TestWebsite";
                 template::String="basic",
                 changedir::Bool=true,
                 verbose::Bool=true)

    template = lowercase(template)
    template ∈ LIST_OF_TEMPLATES || throw(ArgumentError("Template $template doesn't exist."))

    # create the top-directory
    topdir = mkdir(topdir)

    # create the sub-directories
    for foldername ∈ ("libs", "assets", "src")
        subdir = joinpath(topdir, foldername)
        # common/foldername
        cp(joinpath(TEMPL_PATH, "common", foldername), subdir)
        # template/foldername
        template_subdir = joinpath(TEMPL_PATH, template, foldername)
        isdir(template_subdir) && mergefolders(template_subdir, subdir)
    end

    # Pkg.jl does something odd with file permissions, restoring to 644
    # otherwise there may be files that are read-only which is annoying
    for (root, _, files) ∈ walkdir(topdir)
        for file in files
            chmod(joinpath(root, file), 0o644)
        end
    end

    # check if the template has a pre-specified index.html, if so make the index.md from
    # common/ into pages/franklin.md
    if isfile(joinpath(topdir, "src", "index.html"))
        mv(joinpath(topdir, "src", "index.md"), joinpath(topdir, "src", "pages", "franklin.md"))
    end

    # move to the directory if relevant
    changedir && cd(topdir)

    # display information as adequate
    verbose && begin
        print("✓ Website folder generated at \"$(topdir)\"")
        println(ifelse(changedir, " (now the current directory)." , "."))
        println("→ Use serve() from Franklin to see the website in your browser.")
    end

    return nothing
end

#
# utils
#

"""
    mergefolders(src, dst)

Internal function to looks at what's inside `src/` and put it in `dst/`. If
there are paths that match, the files are merged. It is assumed that files will
not clash, if they clash files in `dst` are replaced.
See also [`newsite`](@ref).
"""
function mergefolders(src, dst)
    for (root, _, files) ∈ walkdir(src)
        for file ∈ files
            newpath = replace(root, Regex("^$(escape_string(src))")=>"$dst")
            isdir(newpath) || mkpath(newpath)
            newpathfile = joinpath(newpath, file)
            cp(joinpath(root, file), newpathfile; force=true)
        end
    end
end

end # module
