function _init()
  cls()
  x = rnd(1)
  y = rnd(1)
  c = 1
  for k = 1,20 do getpoint() end
end

function _update()
end

function _draw()
  for k = 1,20 do
    getpoint()
    pset(128*x,128*y,8)
  end
end

function getpoint()
  x,y = f(x,y)
end

function f(x,y)
  r = rnd(1)
  if r <= 0.33 then
    return x/2, y/2
  elseif r <= 0.66 then
    return (x+1)/2, y/2
  else
    return x/2, (y+1)/2
  end
end
