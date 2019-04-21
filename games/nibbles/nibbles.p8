pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

local frame
local fruits
local snake
local score
local gameover

function _init()
  cls(1)

  gameover = false
  frame = 0
  fruits = {}
  score = 0
  music(1)

  snake:init()
  makerandomfruit()

end

function _update()
  if not gameover then
    snake:move()
    for fruit in all(fruits) do
      snake:collide(fruit)
    end
  end
end

function _draw()
  if not gameover then
    cls(1)

    for fruit in all(fruits) do
      fruit:draw()
    end

    snake:draw()

    print("score:", 2, 123,7)
    print(score, 27, 123,7)

    frame += 1
  end
end

function makefruit(x, y)
  local fruit = {
    x = flr(x/1)*1,
    y = flr(y/1)*1,
    draw = function(self)
      --spr(1, self.x, self.y)
      --rect(self.x,self.y,self.x+1,self.y+1, 10)
      circfill(self.x, self.y, 2, 10)
    end
  }

  add(fruits, fruit)
end

function makerandomfruit()

  local pt = makepoint(rnd(128),rnd(128))

  while snake:contains(pt) do
    pt = makepoint(rnd(128),rnd(128))
  end

  makefruit(pt.x,pt.y)

end

function makepoint(x,y)
  return {x=x, y=y}
end

snake = {
  x = 64,
  y = 64,
  size = 1,
  speed = 1,
  length = 15,
  body = {},
  direction = ➡️,
  draw = function(self)
    for pt in all(self.body) do
      circfill(pt.x, pt.y, self.size, 8)
      --rectfill(pt.x, pt.y, pt.x + self.size, pt.y + self.size, 8)
    end
  end,
  init = function(self)
    add(body,makepoint(self.x,self.y))
  end,
  move = function(self)

    if (btn(⬅️) and self.direction != ➡️) self.direction = ⬅️
    if (btn(➡️) and self.direction != ⬅️) self.direction = ➡️
    if (btn(⬇️) and self.direction != ⬆️) self.direction = ⬇️
    if (btn(⬆️) and self.direction != ⬇️) self.direction = ⬆️

    local oldx = self.x
    local oldy = self.y

    if (self.direction == ⬅️) self.x -= flr(self.size * self.speed)
    if (self.direction == ➡️) self.x += flr(self.size * self.speed)
    if (self.direction == ⬇️) self.y += flr(self.size * self.speed)
    if (self.direction == ⬆️) self.y -= flr(self.size * self.speed)

    if self.x != oldx then
      while self.x != oldx do
        if (self.direction == ⬅️) oldx -= 1
        if (self.direction == ➡️) oldx += 1

        local newpt = makepoint(oldx, self.y)
        if (self:contains(newpt)) then
          gameover = true
        else
          add(self.body, newpt)
        end
      end
    end

    if self.y != oldy then
      while self.y != oldy do
        if (self.direction == ⬇️) oldy += 1
        if (self.direction == ⬆️) oldy -= 1

        local newpt = makepoint(self.x, oldy)
        if (self:contains(newpt)) then
          gameover = true
        else
          add(self.body, newpt)
        end
      end
    end

    if gameover == true then
      print('game over', 40, 64)
    else
      for i = 1, #self.body - self.length do
        del(self.body, self.body[i])
      end
    end

  end,

  contains = function(self, pt)
    return containspoint(self.body, pt)
  end,
  collide = function(self, fruit)
    if (distsq(self.x,self.y,fruit.x,fruit.y) < 12) then
      score += 1
      self.length += 10
      self.speed += 0.1
      sfx(4)

      del(fruits, fruit)
      makerandomfruit()
    end
  end
}

function containspoint(list, val)
  local found = false

  for v in all(list) do
    if (v.x == val.x and v.y == val.y) found = true
  end

  return found
end

function snaptogrid(pos, size)
  return flr(pos/size)*size
end

function distsq(ax,ay,bx,by)
  local deltax = mid(-100, ax - bx, 100)
  local deltay = mid(-100, ay - by, 100)
  return deltax*deltax + deltay*deltay
end

__gfx__
00000000000000000043300000000000000800000000800000cc000000cccc0000cccc0000cccc0000cccc0000cccc0000cccc00000000000000000000000000
00000000000000a0004000000099000000088000000880000cccc0000cccccc00cccccc00cccccc00cccccc00cccccc00cccccc0000000000000000000000000
0070070000000aa008888000099990000088800000888800c6cccc00ccccccccccc66cccccc66cccccc66ccccccccccccccccccc000000000000000000000000
000770000000aaa0888888009999990008898800088a8800c66ccc00cc6ccccccc66cccccc6cc6cccccc66ccccccc6cccccccccc000000000000000000000000
00077000000aaa008888880099999900089a9800888a9800cc66cc00cc66cccccc6cccccccccccccccccc6cccccc66cccc6cc6cc000000000000000000000000
007007000aaaa000088888000999990008aa980008aa98000cccc0000cc66cc00cccccc00cccccc00cccccc00cc66cc00cc66cc0000000000000000000000000
00000000aaaa0000008880000099990008888000088880000000000000cccc0000cccc0000cccc0000cccc0000cccc0000cccc00000000000000000000000000
00000000000000000000000000099000008800000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a00001211011110101100e1100e1100d1100d1100d1100e11010110131101611017110181101811017110161101411012110111100f1100e1100d1100d1100d1100e1100e1101011010110121101311014110
00050000090500c0501005016050190501c0502005027050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00000f5600f5500f5400f5300f5200f5100f5000f5000f5000f5000750008500085700856008550085400853006520095001f500165001150010500105001050010500125601255012540125301252012510
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 00000000
03 03050000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
