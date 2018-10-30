function _init()
  cls()
end

function _update60()
  pset(64,64,pget(64,64)+1)
  for x=0,128 do
    for y=0,128 do
      local c = pget(x,y)
      if (c>4) then
        pset(x,y,c-4)
        pset(x-1,y,pget(x-1,y)+1)
        pset(x+1,y,pget(x+1,y)+1)
        pset(x,y-1,pget(x,y-1)+1)
        pset(x,y+1,pget(x,y+1)+1)
      end
    end
  end
end

