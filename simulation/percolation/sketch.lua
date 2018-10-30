oil = {}
porosity = 0.66

function _init()
  map(0,0)
  row = 0

  for x = 0,128 do
    if (x%2 == 0) then
      oil[x] = 1
      pset(x,row,0)
    else
      oil[x] = 0
    end
  end

end

function _update()
  row += 1
  prevoil = oil

  for x = 0,64 do

    x0 = 2*x + (row+1)%2

    if(prevoil[x0]==1) then

      oil[x0] = 0

      if rnd(1) < porosity then
        oil[x0-1] = 1
      else
        oil[x0-1] = 0
      end

      if rnd(1) < porosity then
        oil[x0+1] = 1
      else
        oil[x0+1] = 0
      end

    end
  end

end

function _draw()

  for x = 0,128 do
    if (oil[x] == 1) pset(x,row,0)
  end

end