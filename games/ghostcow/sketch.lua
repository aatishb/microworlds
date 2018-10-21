function _init()
  cls()
  music(0)
  x = 64
  y = 64
end

function _update()

  if (btn(⬅️)) x-=1
  if (btn(➡️)) x+=1
  if (btn(⬇️)) y+=1
  if (btn(⬆️)) y-=1

  if (x > 128) x-=128
  if (x < 0) x+=128
  if (y > 128) y-=128
  if (y < 0) y+=128

end

function _draw()
  cls()
  map(0,0)
  spr(1,x,y)
end
