# JuDoc Templates

Templates for [JuDoc](https://github.com/tlienart/JuDoc.jl), the static-site generator in Julia.

Most of these templates are adapted from existing, popular templates with minor modifications to accommodate JuDoc's content.

| Name | Source | License | Navbar | JS  |
| ---- | ------ | ------- | ----- | --- |
| `"sandbox"`  | N/A    | MIT     | N/A | No |
| `"basic"`  | N/A    | MIT     | Top | No |
| `"hypertext"` | [grav theme hypertext](https://github.com/artofthesmart/hypertext) | [MIT](https://github.com/artofthesmart/hypertext/blob/master/LICENSE) | Top | No |
| `"pure-sm"` | [pure css](https://purecss.io/layouts/side-menu/) | [Yahoo BSD](https://github.com/pure-css/pure-site/blob/master/LICENSE.md) | Side | No |
| `"vela"` | [grav theme vela](https://github.com/danzinger/grav-theme-vela) | [MIT](https://github.com/danzinger/grav-theme-vela/blob/develop/LICENSE) | Side (collapsable) | Yes |
| `"tufte"` | [Tufte CSS](https://github.com/edwardtufte/tufte-css), and a bit of [Lawler.io](https://github.com/Eiriksmal/lawler-dot-io) for the menu | [both](https://github.com/edwardtufte/tufte-css/blob/gh-pages/LICENSE)  [MIT](https://github.com/Eiriksmal/lawler-dot-io/blob/main/license.md) | Side | No |
| `"hyde"` | [Hyde](https://github.com/poole/hyde) | [MIT](https://github.com/poole/hyde/blob/master/LICENSE.md) | Side | No |
| `"lanyon"` | [Lanyon](https://github.com/poole/lanyon) | [MIT](https://github.com/poole/lanyon/blob/master/LICENSE.md) | Side (collapsable) | No |

## Misc

* Current version of KaTeX: 0.11
* Current version of highlight: v9.15.10 (with `css`, `python`, `yaml`, `bash`, `ini,TOML`, `markdown`, `html,xml`, `r`, `julia`, `julia-repl` and the minified `github` theme).

## Notes:

- if update `highlight.pack.js`, look for `julia>`, replace (so that pkg and shell are recognised)

```
return{c:[{cN:"meta",b:/^julia>/,r:10,starts:{e:/^(?![ ]{6})/,sL:"julia"},aliases:["jldoctest"]}]}
```

by

```
return{c:[{cN:"meta",b:/^julia>/,r:10,starts:{e:/^(?![ ]{6})/,sL:"julia"}},{cN:"metas",b:/^shell>/,r:10,starts:{e:/^(?![ ]{6})/,sL:"bash"}},{cN:"metap",b:/^\(.*\)\spkg>/,r:10,starts:{e:/^(?![ ]{6})/,sL:"julia"}}]}
```
