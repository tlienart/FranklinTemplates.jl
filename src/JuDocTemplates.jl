module JuDocTemplates

export newsite

const JUDOC_PATH = splitdir(pathof(JuDocTemplates))[1] # .../JuDocTemplates/src
const TEMPL_PATH = joinpath(JUDOC_PATH, "templates")
const LIST_OF_TEMPLATES = ("sandbox", "basic", "pure-sm", "vela", "hypertext",
                           "tufte", "hyde", "lanyon", "jemdoc")

"""
    newsite(topdir; template="basic", cd=true)

Generate a new folder (an error is thrown if it already exists) that contains the skeleton of a
website that can be processed by JuDoc. The user can specify a `template` out of the list of
available templates.

* `template="basic"` specify the name of the desired template,
* `cd=true` specify whether to change the current directory to the newly created folder or not.
* `verbose=true` specify whether to display information or not.

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
    
    # on windows, make sure everything is read-write in the generated dir
    Sys.iswindows() && chmod(topdir, 0o777; recursive=true)

    # move to the directory if relevant
    changedir && cd(topdir)

    # display information as adequate
    verbose && begin
        print("✓ Website folder generated at \"$(topdir)\"")
        println(ifelse(changedir, " (now the current directory)." , "."))
        println("→ Use serve() from JuDoc to see the website in your browser.")
    end

    return nothing
end

#
# utils
#

"""
    mergefolders(src, dst)

Internal function to looks at what's inside `src/` and put it in `dst/`. If there are paths that
match, the files are merged. It is assumed that files will not clash, if they clash files in `dst`
are replaced. See also [`newsite`](@ref).
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
