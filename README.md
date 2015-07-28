htmlgen
====

```rb
html =
tag("html")
  .tag("div")
    .id("test")
    .class("hi")
    .text("hello world")
  .fin
  
puts html
```
