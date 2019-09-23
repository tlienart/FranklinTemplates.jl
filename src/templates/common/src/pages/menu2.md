@def title = "More goodies"
@def hascode = true

# More goodies

## More markdown support

The Julia Markdown parser in Julia's stdlib is not exactly complete and JuDoc strives to bring useful extensions that are either defined in standard specs such as Common Mark or that just seem like useful extensions.

* indirect references for instance [like so]

[like so]: http://existentialcomics.com/

or also for images

![][some image]

some people find that useful as it allows referring multiply to the same link for instance.

[some image]: https://upload.wikimedia.org/wikipedia/commons/9/90/Krul.svg

* un-qualified code blocks and indented code blocks are allowed and are julia by default

    a = 1
    b = a+1

or

```
a = 1
b = a+1
```

you can specify the default language with `@def lang = "julia"`.
If you actually want a "plain" code block, qualify it as `plaintext` like

```plaintext
so this is plain-text stuff.
```

## A bit more highlighting

Extension of highlighting for `pkg` an `shell` mode in Julia:

```julia-repl
(v1.4) pkg> add JuDoc
shell> blah
julia> 1+1
(Sandbox) pkg> resolve
```

you can tune the colouring etc via the

* `hljs-meta` (for `julia>`)
* `hljs-metas` (for `shell>`)
* `hljs-metap` (for `...pkg>`)
