function _init()
  map(0,0)
end

function _update60()
  for i = 0,1000 do
    local x = rnd(128)
    local y = rnd(128)
    c = pget(x,y)
    circfill(x,y,1,c)
  end
end