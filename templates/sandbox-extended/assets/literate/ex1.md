<!--This file was generated, do not modify it.-->
## Literate example

Whatever is in comment can be Franklin-markdown, so for instance you can
write maths in much the same way:

$$ \exp(i\tau) = 1 $$

This is Euler's identity following the [$\tau$ day manifesto](https://tauday.com/tau-manifesto).

Code:

````julia:ex1
a = 5
a^2
````

Any valid code basically:

````julia:ex2
v = ["Thom", "Martha", "Smith", "John"]
f = first.(v)
````

So the workflow is to just write a standard Literate document using
Franklin markdown in the comments and normal code.
You can also hide lines:

````julia:ex3
using Random # hide
Random.seed!(1) # hide
randn()
````

Or hide everything (note that for the line to be taken as comment for the
code block there should be no whitespace between the `#` and the `h`).

````julia:ex4
#hideall
using LinearAlgebra
a = dot(randn(5), randn(5))
````

It still shows the result though since `showall = true`! If you want to
suppress it, just use a `;` on the last line:

````julia:ex5
#hideall
using LinearAlgebra
a = dot(randn(5), randn(5));
````

That's basically it.

````julia:ex6
println("done!")
````

