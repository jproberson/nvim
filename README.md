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
:w !sudo tee
