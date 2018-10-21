function _init()
  cls()
  x = 0
  y = 0
end

function _update()
end

function _draw()
  drawleaf()
end

function drawleaf()
  for k = 1,1000 do
    x,y = f(x,y)
    pset(10*x+64,128-12*y,3)
  end
end

function f(x,y)
  r = rnd(1)
  if r <= 0.01 then
    return 0, 0.16*y
  elseif r <= 0.08 then
    return 0.2*x-0.26*y, 0.23*x+0.22*y+1.6
  elseif r <= 0.15 then
    return -0.15*x +0.28*y, 0.26*x+0.24*y+0.44
  else
    return 0.85*x +0.04*y, -0.04*x+0.85*y+1.6
  end
end
