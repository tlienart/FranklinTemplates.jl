# This file was generated, do not modify it. # hide
#hideall
@tags p
@tags_noescape style

s1 = Style(css("p", fontWeight="bold", color="red"))
style(styles(s1)) |> html
s1(p("hello"))    |> html