cloud = {[7] = 1 ,[12]=0, [1]=7, [0]=12}

function _init()
  map(0,0)
end

function _update60()

  for i = 0,500 do
    local x = rnd(128)
    local y = rnd(128)
    diffusion(x,y)
  end

  for i = 0,1000 do
    local x = rnd(128)
    local y = rnd(128)
    local c = pget(x,y)
    circ(x,y,1,c)
  end

end

function diffusion(x,y)

  local c = cloud[pget(x,y)]
  local x0 = x-1
  local x1 = x+1

  if (x0 < 0) x0=127
  if (x1 > 127) x1=0

  local d = cloud[pget(x0,y)]
  + cloud[pget(x1,y)]
  - 2 * c

  if d > 0 then
    pset(x,y,cloud[1])
  end

end
c