# JuDoc Templates

Templates for [JuDoc](https://github.com/tlienart/JuDoc.jl), the static-site generator in Julia.

Most of these templates are adapted from existing, popular templates with minor modifications to accommodate JuDoc's content.

**NOTE**: these templates should be seen as starting points, they are far from perfect. PRs to help improve them will be very welcome.

| Name | Source | License | Navbar | JS  |
| ---- | ------ | ------- | ----- | --- |
| `"sandbox"`  | N/A    | MIT     | N/A | No |
| `"basic"`  | N/A    | MIT     | Top | No |
| `"jemdoc"` | [jemdoc](https://github.com/jem/jemdoc) | N/A | Side | No |
| `"hypertext"` | [grav theme hypertext](https://github.com/artofthesmart/hypertext) | [MIT](https://github.com/artofthesmart/hypertext/blob/master/LICENSE) | Top | No |
| `"pure-sm"` | [pure css](https://purecss.io/layouts/side-menu/) | [Yahoo BSD](https://github.com/pure-css/pure-site/blob/master/LICENSE.md) | Side | No |
| `"vela"` | [grav theme vela](https://github.com/danzinger/grav-theme-vela) | [MIT](https://github.com/danzinger/grav-theme-vela/blob/develop/LICENSE) | Side (collapsable) | Yes |
| `"tufte"` | [Tufte CSS](https://github.com/edwardtufte/tufte-css), and a bit of [Lawler.io](https://github.com/Eiriksmal/lawler-dot-io) for the menu | [both](https://github.com/edwardtufte/tufte-css/blob/gh-pages/LICENSE)  [MIT](https://github.com/Eiriksmal/lawler-dot-io/blob/main/license.md) | Side | No |
| `"hyde"` | [Hyde](https://github.com/poole/hyde) | [MIT](https://github.com/poole/hyde/blob/master/LICENSE.md) | Side | No |
| `"lanyon"` | [Lanyon](https://github.com/poole/lanyon) | [MIT](https://github.com/poole/lanyon/blob/master/LICENSE.md) | Side (collapsable) | No |
| `"just-the-docs"` | [Just the docs](https://github.com/pmarsceill/just-the-docs) | [MIT](https://github.com/pmarsceill/just-the-docs/blob/master/LICENSE.txt) | Side/Top | No |
| `"minimal-mistakes"` | [Minimal mistakes](https://github.com/mmistakes/minimal-mistakes) | [MIT](https://github.com/mmistakes/minimal-mistakes/blob/master/LICENSE) | Side/Top | No |

## Misc

* Current version of KaTeX: 0.11.1
* Current version of highlight: v9.17.1 (with `css`, `python`, `yaml`, `bash`, `ini,TOML`, `markdown`, `html,xml`, `r`, `julia`, `julia-repl`, `plaintext` and the minified `github` theme).

## Notes:

- if update `highlight.pack.js`, look for `julia>`, replace (so that pkg and shell are recognised)

```
hljs.registerLanguage("julia-repl",function(e){return{c:[{cN:"meta",b:/^julia>/,relevance:10,starts:{e:/^(?![ ]{6})/,sL:"julia"},aliases:["jldoctest"]}]}});
```

by

```
hljs.registerLanguage("julia-repl",function(e){return{c:[{cN:"meta",b:/^julia>/,relevance:10,starts:{e:/^(?![ ]{6})/,sL:"julia"}},{cN:"metas",b:/^shell>/,relevance:10,starts:{e:/^(?![ ]{6})/,sL:"bash"}},{cN:"metap",b:b:/^\(.*\)\spkg>/,relevance:10,starts:{e:/^(?![ ]{6})/,sL:"julia"}}]}});
```
