@def hascode = true
@def showall = true <!-- useful to show the output of every cell! -->

# Franklin + Literate

* [back home](/)

You can write tutorials using [Literate.jl](https://github.com/fredrikekre/Literate.jl) and simply plug them in Franklin where they will be (re)evaluated and the output of code blocks shown assuming you've written `@def showall = true` on the page.
Here's an example:

\literate{/_literate/ex1.jl} <!--_ input the literate source-->
