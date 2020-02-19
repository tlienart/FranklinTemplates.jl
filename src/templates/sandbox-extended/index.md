@def title = "Franklin Sandbox"
@def hasmath = true
@def hascode = true


# Franklin extended sandbox

This is meant as a collection of simple examples of how you can use Franklin with other Julia libraries. It's assumed you're already familiar with the syntax (otherwise, please try the `sandbox` template).

* [literate](/literate/)
* [plotly](/plotly/)
* [hyperscript](/hyperscript/)
* [pyplot](/pyplot/)
* [mdpad](/mdpad/)

## KaTeX numbering on/off

Have a look at `.no-number` in the CSS.

This is numbered
$$ 1+1 = 2 $$

This isn't

@@no-number
$$ 2+2 = 4 $$
and
$$ 3+3 = 7-1 $$
@@

Numbered again
$$ 7 + 1 = 8 $$
