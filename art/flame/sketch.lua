-- flame test
-- aatish bhatia

fire={[10]=9,[9]=8,[8]=4,[4]=2,[2]=1,[1]=0,[0]=0}

function _init()
  map(0,0,0,0)
end

function _draw()

for i=0,2999 do
 local x,y=rnd(128),rnd(128)
 local c=pget(x,y)
 c=fire[c]
 circ(x,y,1,c)
end

end

