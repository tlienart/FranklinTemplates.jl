"""
    newsite(topdir; template="basic", cd=true)

Generate a new folder (an error is thrown if it already exists) that contains
the skeleton of a website that can be processed by Franklin. The user can
specify a `template` out of the list of available templates.
If `topdir` is specified as `"."` then the current directory is used.

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
                 template::String="basic", changedir::Bool=true,
                 verbose::Bool=true)

    template = lowercase(template)
    template ∈ LIST_OF_TEMPLATES ||
        throw(ArgumentError("Template $template doesn't exist."))

    # create the top-directory
    if topdir == "."
        topdir    = pwd()
        changedir = true
    else
        topdir = mkdir(topdir)
    end

    common_dir   = joinpath(TEMPL_PATH, "common")
    template_dir = joinpath(TEMPL_PATH, template)

    mergefolders(common_dir,   topdir)
    mergefolders(template_dir, topdir)

    # for sandbox, remove aux pages menu1,menu2,menu3
    if template in ("sandbox", "sandbox-extended")
        for i in 1:3
            rm(joinpath(topdir, "menu$i.md"))
        end
    end

    # For 'added' packages, Pkg.jl makes some files read-only, so here we
    # restore to 644 to guarantee that they are r/w
    for (root, _, files) ∈ walkdir(topdir)
        for file in files
            chmod(joinpath(root, file), 0o644)
        end
    end

    # check if the template has a pre-specified index.html, if so rename
    # index.md to avoid confusion
    if isfile(joinpath(topdir, "index.html"))
        mv(joinpath(topdir, "index.md"), joinpath(topdir, "franklin.md"))
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

"""
    modify(template_name)

Convenience function to quickly instantiate a directory with a given template
once satisfied with the changes, they can be added to the repo by doing
`addtemplate(path)`. 
"""
function modify(name)
    @assert name in LIST_OF_TEMPLATES "unknown template"
    newsite(name, template=name)
    return nothing
end

"""
    addtemplate(path)

Assuming you're working with FranklinTemplates on development mode (i.e.
`] dev FranklinTemplates` this function takes a path where you would have
worked on a template and incorporates it into FranklinTemplates, putting files
at the right place; this makes iterations and PRs easier.

Note: if you use this without FranklinTemplates on dev mode, bad things will
likely occur.
"""
function addtemplate(path::String)
    path = abspath(path)
    @assert isdir(path) "'$path' does not seem to be a valid directory."

    # check whether it looks like a sensible dir
    rd = readdir(path)
    if !all(p->p in rd, ("_css", "_layout", "_libs"))
        error("The directory $path does not contain a `_css`, `_layout` and " *
              "a `_libs` folder and so will be ignored.")
    end

    # Add the folder at the right place in FranklinTemplates
    #
    # does it exist?
    d, tname = splitdir(path)
    isempty(tname) && (tname = splitdir(d)[2]) # it ended with separator

    dest = joinpath(TEMPL_PATH, tname, "")
    common = joinpath(TEMPL_PATH, "common", "")

    if tname ∉ readdir(TEMPL_PATH)
        cp(path, dest)
    else
        # it exists already --> merge the folders
        mergefolders(path, dest)
    end

    # postprocess
    if isdir(joinpath(dest, "__site"))
        rm(joinpath(dest, "__site"), recursive=true, force=true)
    end
    # remove duplicates
    deduplicate(common, dest)
    return nothing
end

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

"""
    deduplicate(src, dest)

Consider the files provided by `src` and remove all identical files from `dest`
to avoid duplication.
"""
function deduplicate(src, dest)
    # Post processs by removing files which are already provided by src
    dest = joinpath(dest, "") # ensure it has a separator at the end
    for (root, _, files) in walkdir(dest)
        for file in files
            fpath = joinpath(root, file)
            rpath = replace(fpath, dest => "")
            cpath = joinpath(src, rpath)
            isfile(cpath) || continue
            if filecmp(fpath, cpath)
                rm(fpath)
            end
        end
    end
    # there may be empty folders (these would be ignored by GitHub anyway)
    emptydirs = []
    for (root, dirs, _) in walkdir(dest)
        for dir in dirs
            dpath = joinpath(root, dir)
            if isdir(dpath) && isempty(readdir(dpath))
                push!(emptydirs, dpath)
            end
        end
    end
    for dpath in emptydirs
        try; rm(dpath, recursive=true); catch; end
    end
    return nothing
end

"""
    filecmp(path1, path2)

Take 2 absolute paths and check if the files are different (return false if
different and true otherwise).
This code was suggested by Steven J. Johnson on discourse:
https://discourse.julialang.org/t/how-to-obtain-the-result-of-a-diff-between-2-files-in-a-loop/23784/4
"""
function filecmp(path1::AbstractString, path2::AbstractString)
    stat1, stat2 = stat(path1), stat(path2)
    if !(isfile(stat1) && isfile(stat2)) || filesize(stat1) != filesize(stat2)
        return false
    end
    stat1 == stat2 && return true # same file
    open(path1, "r") do file1
        open(path2, "r") do file2
            buf1 = Vector{UInt8}(undef, 32768)
            buf2 = similar(buf1)
            while !eof(file1) && !eof(file2)
                n1 = readbytes!(file1, buf1)
                n2 = readbytes!(file2, buf2)
                n1 != n2 && return false
                0 != Base._memcmp(buf1, buf2, n1) && return false
            end
            return eof(file1) == eof(file2)
        end
    end
end
