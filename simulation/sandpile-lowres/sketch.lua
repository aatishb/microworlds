table = {}
col = {[0]=0, [1]=9, [2]=3, [3]=2, [4]=1}

function _init()
  cls()

  for x=0,32 do
    for y=0,32 do
      table[x..","..y]=0
    end
  end
end

function _update60()
  if btn(➡️) then
    table[16 ..","..16] += 1
  end
  for x=0,32 do
    for y=0,32 do

      c = table[x..","..y]

      if c>4 then
        table[x..","..y] -= 4
        table[x+1 ..","..y] += 1
        table[x-1 ..","..y] += 1
        table[x..","..y+1] += 1
        table[x..","..y-1] += 1
      end
    end
  end
end

function _draw()
  for x=0,32 do
    for y=0,32 do
      rectfill(4*x,
                4*y,
                4*x+2,
                4*y+2,
                col[table[x..","..y]])
    end
  end

  print("press ➡️ to add a grain of sand",
              0,120,5)
end
