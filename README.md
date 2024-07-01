# nvim

Useful default vim things I didn't know about:

:ls = list buffers
:pwd = print working directory

Normal mode:
; = repeat last f, F, t, or T
, = repeat last f, F, t, or T in opposite direction
g~ = Toggle case
gu = lower case
gU = upper case
gv = reselect last visual selection
`. = Location of last change
`^ = Location of last insertion

Insert mode:
<C-w> = delete word
<C-u> = delete back to start of line
<C-r>{register} = paste from register
<C-r>= = insert expression register (calculator)

Insert normal mode:
<C-o> = go to normal mode for one command

Visual mode:
o = move to other end of selection

Windows:
:on[ly] = <C-w>o = close all other windows

Saving in nvim with root:
:w !sudo te

---

As a general rule, we could say that the `d{motion}` command tends to work
well with `aw`,`as`, and `ap`, whereas the `c{motion}`command works better with`iw` and similar.
