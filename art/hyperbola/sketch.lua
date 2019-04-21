function _init()
  t = 0
  a = 20
end

function _update()
  t += 0.1
  a = 100 * (1.17 + sin(t/30))
end

function _draw()

  for x=0,128 do
    for y=0,128 do
      c = (x-64)*(y-64)/a + t
      c = c % 4 + 12
      pset(x,y,c)
    end
  end

  --print(a,0,0,0)

end
