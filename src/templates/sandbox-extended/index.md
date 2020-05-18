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
* [gr](/gr/)

## KaTeX numbering on/off

~~~
<style>
.no-number .katex-display::after {
  counter-increment: nothing;
  content: "";
}
</style>
~~~

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
