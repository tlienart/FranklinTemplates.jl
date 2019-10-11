# aggressively set all perms for folders in `src/` to `755`
# and perms for files to 644.

for (root, dirs, files) ∈ walkdir(joinpath(@__DIR__, "src"))
    for d in dirs
        run(`chmod 755 $(joinpath(root, d))`)
    end
    for file in files
        run(`chmod 644 $(joinpath(root, file))`)
    end
end
