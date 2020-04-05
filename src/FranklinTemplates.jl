module FranklinTemplates

export newsite, addtemplate, modify

const FRANKLIN_PATH     = dirname(pathof(FranklinTemplates))
const TEMPL_PATH        = joinpath(FRANKLIN_PATH, "templates")
const LIST_OF_TEMPLATES = (
    "sandbox",
    "sandbox-extended",
    "basic",
    "jemdoc",
    "just-the-docs",
    "hyde",
    "hypertext",
    "lanyon",
    "minimal-mistakes",
    "pure-sm",
    "tufte",
    "vela")

include("utils.jl")

end # module
