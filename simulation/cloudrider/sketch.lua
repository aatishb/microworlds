function _init()
  map(0,0)
  x = 64
  y = 64
end

function _update60()
  if (btn(⬅️)) x-=1
  if (btn(➡️)) x+=1
  if (btn(⬆️)) y-=1
  if (btn(⬇️)) y+=1

  circfill(x,y,3,7)

  for i = 0,2000 do
    local x = rnd(128)
    local y = rnd(128)
    c = pget(x,y)
    circfill(x,y,1,c)
  end
end
