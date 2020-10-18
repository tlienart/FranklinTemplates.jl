# Franklin Templates

Templates for [Franklin](https://github.com/tlienart/Franklin.jl), the static-site generator in Julia.

Most of these templates are adapted from existing, popular templates with minor modifications to accommodate Franklin's content.

**NOTE**: these templates should be seen as _starting points_, they are far from perfect.
PRs to help improve them will be very welcome, thanks!
Most importantly they are designed to be simple to adjust to your needs.

## List of templates

Get an idea for which template you like using [this preview](https://tlienart.github.io/FranklinTemplates.jl/).
The grid below keeps track of their name, license, the kind of navbar they have and whether they require Javascript.

| Name | Source | License | Navbar | JS  |
| ---- | ------ | ------- | ----- | --- |
| `"sandbox"`  | N/A    | MIT     | N/A | No |
| `"sandbox-extended"`  | N/A    | MIT     | N/A | No |
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

## Fixing/Adding a template

The package now contains a few utils to make it easier to add / fix templates.

1. clone a fork of this package wherever you usually do things, typically `~/.julia/dev/`
1. checkout the package in development mode with `] dev FranklinTemplates`
1. `cd` to a sensible workspace and do one of
    1. `using FranklinTemplates; newsite("newTemplate")` to start working on `newTemplate` more or less from scratch,
    1. `using FranklinTemplates; newsite("newTemplate", template="jemdoc")` to start working on `newTemplate` using some other template as starting point,
    1. `using FranklinTemplates; modify("jemdoc")` to quickly start working on an existing template in order to fix it.
1. change things, fix things, etc.
1. bring your changes into your fork with `addtemplate("path/to/your/work")`
    1. if the template doesn't exist, it will just add the folder removing things that are duplicate from `templates/common/`.
    1. if the template exists, it will just adjust what needs to be adjusted.

Now if it was just a bunch of fixes to an existing template, you can just push those changes to your fork and open a PR.

If it's a new template that you're working on, you can also do that but there's a few extra things you need to do:

1. in `FranklinTemplates/src/FranklinTemplates.jl` add the name of your template in the list
1. in `FranklinTemplates/docs/make.jl` add the name of your template with a description in the list
1. in `FranklinTemplates/docs/thumb` add a screenshot of your template in `png` format with **exactly** an 850x850 dimension
1. in `FranklinTemplates/docs/index_head.html` add a CSS block following the other examples

Thanks!!

## Misc

* Current version of KaTeX: 0.12.0
* Current version of highlight: v10.3.1 (with `css`, `C`, `C++`, `yaml`, `bash`, `ini,TOML`, `markdown`, `html,xml`, `r`, `julia`, `julia-repl`, `plaintext`, `python` and the minified `github` theme).
* Current version of Plotly (used in `sandbox-extended`): 1.57

## Notes:

This package contains a copy of the relevant KaTeX files and highlight.js files;
- the KaTeX files are basically provided "as is", completely unmodified; you could download your own version of the files from the [original repo](https://github.com/KaTeX/KaTeX) and replace the files in `_libs/katex`,
- the Highlight.js files are _essentially_ provided "as is" for a set of languages, there is a small modification in the `highlight.pack.js` file to highlight julia shell and pkg prompt (see next section). You can also download your own version of files from the [original source](https://highlightjs.org) where you might want to
    - specify languages you want to highlight if other than the default list above
    - specify the "style" (we use github but you could use another sheet)

**Note**: in Franklin's `optimize` pass, by default the **full library** `highlight.js` is called to pre-render highlighting; this bypasses the `highlight.pack.js` file and, in particular, supports highlighting for **all** languages. In other words, the `highlight.pack.js` file is relevant only when you preview your site locally with `serve()` or if you don't intend to apply the prerendering step.

### Maintenance

- if update `highlight.pack.js`, look for `julia>`, replace (so that ‚`pkg>` and `shell>` are recognised)

```js
hljs.registerLanguage("julia-repl",function(e){return{c:[{cN:"meta",b:/^julia>/,relevance:10,starts:{e:/^(?![ ]{6})/,sL:"julia"},aliases:["jldoctest"]}]}});
```

with

```js
hljs.registerLanguage("julia-repl",function(e){return{c:[{cN:"meta",b:/^julia>/,relevance:10,starts:{e:/^(?![ ]{6})/,sL:"julia"}},{cN:"metas",b:/^shell>/,relevance:10,starts:{e:/^(?![ ]{6})/,sL:"bash"}},{cN:"metap",b:/^\(.*\)\spkg>/,relevance:10,starts:{e:/^(?![ ]{6})/,sL:"julia"}}]}});
```
