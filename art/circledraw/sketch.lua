function _init()
  cls()
  x = 64
  y = 64

  xstep = 0.1
  ystep = 0.1
  col = 1
end

function _update()
  x += xstep
  y += ystep

  if (x > 128) x-=128
  if (x < 0) x+= 128
  if (y > 128) y -= 128
  if (y < 0) y += 128

  if (btn(➡️)) xstep += 0.1
  if (btn(⬅️)) xstep -= 0.1
  if (btn(⬇️)) ystep += 0.1
  if (btn(⬆️)) ystep -= 0.1

  col = 16 * (x + y) / 256
end

function _draw()
  circ(x, y, abs(xstep)+abs(ystep), col)
end

function changespeed()
end