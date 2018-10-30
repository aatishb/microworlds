function _init()
  for x=0,128 do
    for y=0,128 do
      c = rnd(3)
      pset(x,y,c%3+8)
    end
  end
end

function _update60()
  for i=1,2000 do
    local x=rnd(128)
    local y=rnd(128)
    local c = pget(x,y)
    circ(x,y,1,c)
  end
end

