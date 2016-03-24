# SVD_TO_D
converts cmsis to d code.
The Idea is that it takes alot of effort tho convert documentation for microcontrollers into code for use in projects. It uses almost the same framework that https://github.com/JinShil/stm32f42_discovery_demo does.

build with
```
dub
```

It works like this:
```
svd_to_d_reg file.svd > file.d
```
