pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

local frame
local flames
local drop
local score

function _init()
  frame = 0
  flames = {}
  score = 0

  for i=1,6 do
    makerandomflame()
  end

  music(0)
end

function _update()
  drop:move()
  drop:constrain()
end

function _draw()
  cls(1)

  for flame in all(flames) do
    flame:draw()
    flame:collide(drop)
  end

  drop:draw()

  print("score:", 2, 123,7)
  print(score, 27, 123,7)

  frame += 1
end



function makeflame(x, y)
  local flame = {
    x = x,
    y = y,
    width = 5,
    height = 8,
    visible = true,
    animation = {1,2,3,4,5,4,3,2,1},
    offset = flr(rnd(5)),
    draw = function(self)
      if self.visible then
        spr(self.animation[flr(0.6*frame + self.offset)%#self.animation + 1], self.x, self.y)
      end
      --rect(self.x,self.y,self.x+self.width,self.y+self.height)
    end,
    collide = function(self, drop)
      if distsq(self.x,self.y,drop.x,drop.y) < 20 then
        if self.visible then
          score += 1
          self.visible = false
          sfx(2)
          if (score > 2) then
            makeflame(rnd(128 - self.width),rnd(128 - self.height))
          end
        end
      end
    end
  }

  add(flames, flame)
end

function makerandomflame()

  local x = rnd(128 - 5)
  local y = rnd(128 - 8)

  while distsq(x,y,drop.x,drop.y) < 20 do
    x = rnd(128 - 5)
    y = rnd(128 - 8)
  end

  makeflame(x,y)

end

drop = {
  x = 64,
  y = 64,
  width = 8,
  height = 7,
  sprite = 0;
  draw = function(self)
    spr(flr(0.5*self.sprite)%5 + 7, self.x, self.y)
    --rect(self.x,self.y,self.x+self.width,self.y+self.height)
  end,
  move = function(self)
    if (btn(⬅️)) then
      self.x -= 1
      self.sprite -= 1
    end
    if (btn(➡️)) then
      self.x += 1
      self.sprite += 1
    end
    if (btn(⬇️)) self.y+=1
    if (btn(⬆️)) self.y-=1
  end,
  constrain = function(self)
    if (self.x > 128 - self.width) self.x = 128 - self.width
    if (self.x < 0) self.x = 0
    if (self.y > 128 - self.height) self.y = 128 - self.height
    if (self.y < 0) self.y = 0
  end
}

function distsq(ax,ay,bx,by)
  local deltax = mid(-100, ax - bx, 100)
  local deltay = mid(-100, ay - by, 100)
  return deltax*deltax + deltay*deltay
end

__gfx__
00000000000800000080000000080000000800000000800000cc000000cccc0000cccc0000cccc0000cccc0000cccc0000cccc00000000000000000000000000
0000000000880000008800000088800000088000000880000cccc0000cccccc00cccccc00cccccc00cccccc00cccccc00cccccc0000000000000000000000000
007007000888800008888000088880000088800000888800c6cccc00ccccccccccc66cccccc66cccccc66ccccccccccccccccccc000000000000000000000000
0007700008988000889888000889880008898800088a8800c66ccc00cc6ccccccc66cccccc6cc6cccccc66ccccccc6cccccccccc000000000000000000000000
000770008899880088998800889a8800089a9800888a9800cc66cc00cc66cccccc6cccccccccccccccccc6cccccc66cccc6cc6cc000000000000000000000000
00700700089a8800089a800008aa880008aa980008aa98000cccc0000cc66cc00cccccc00cccccc00cccccc00cc66cc00cc66cc0000000000000000000000000
000000000888800008a880000888800008888000088880000000000000cccc0000cccc0000cccc0000cccc0000cccc0000cccc00000000000000000000000000
00000000008800000088000000880000008800000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000a00000d7220d7220d7220d7220f7220f7220f7220f72212722127221272212722147221472214722147221672216722167221672214722147221472214722127221272212722127220f7220f7220f7220f722
00050000176101d6101f610226102261022610206101c61018610146100e6100c6100c6100d6100f61012610166101a610146001460016600196001c60021600246002460024600266002560023600206001d600
000200000101003030040500507006060060500704008040090300b0300c0200d0200e0200e0100e0100f01010010110101880000000000000000000000000000000000000000000000000000000000000000000
__music__
03 00404344

