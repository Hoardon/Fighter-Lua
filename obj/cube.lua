
local cube = {}
cube.__index = cube

setmetatable(cube, {
		__call = function (cls, ...)
			    return cls.new(...)
			 end,
	     })

function cube.new(name)
   local self = setmetatable({}, cube)
   --self.value = init
   self.name = name
   self.x = 100
   self.y = 100
   self.destx = 0
   self.desty = 0
   self.speed = 100
   self.xmax = 0
   self.ymax = 0
   self.sizex = 100
   self.sizey = 100
   self.r = 255
   self.g = 255
   self.b = 255
   self.scalex = 1
   self.scaley = 1
   self.up = 5
   self.face = 0
   self.savex = self.scalex
   self.savey = self.scaley
   return self
end

function cube.setFace(self, img)
   self.face = love.graphics.newImage(img)
end

function cube.getFace(self)
   return self.face
end

function cube.Init(self, r, g, b)
   self.speed = 400
   self.xmax = 0
   self.ymax = 0
   self.sizex = 60
   self.sizey = 60
   self.r = r
   self.g = g
   self.b = b
end

function cube.setMax(self, x, y)
   self.xmax = x
   self.ymax = y
end

function cube.getXMax(self)
   return self.xmax
end

function cube.getYMax(self)
   return self.ymax
end

function cube.upScale(self)



   if self.scalex < 10  then
      self.scalex = self.scalex + 1
   end
   if self.scaley < 10  then
      self.scaley = self.scaley + 1
   end

end

function cube.correction(self, X, Y, moovex, moovey)

--   print(" -->1 *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** " .. X .. " " .. Y )


   if moovex > X and X > 0 then
      moovex = X
   end

   if moovex > X * -1 and X < 0 then
      moovex = X * -1
   end

   return moovex

end

function cube.correction2(self, X, Y, moovex, moovey)

--   print(" -->2 *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** " .. X .. " " .. Y )


   if moovey > Y and Y > 0 then
      moovey = Y
   end

   if moovey > Y * -1 and Y < 0 then
      moovey = Y * -1
   end

   return moovey

end

function cube.travel(self, dt, time)

   print("################################# START ##################################################")
   X = self.destx - self.x
   Y = self.desty - self.y 

--   print("Self.Scale --> " .. self.scale)
--   scale = 10

--   print(" *===============> " .. self.scalex .. " " .. self.scaley .. "\n")

--   self.scalex = 10
--   self.scaley = 10

   print("--> " ..  X/Y)
  -- print(" ===============> " .. X .. "/" .. Y .. " ** ")
--   print(" *===============> " .. self.scalex .. " " .. self.scaley .. "\n")
  -- print(" ===============> " .. self.destx .. " " .. self.desty)
  -- print(" ===============> " .. self.x .. " " .. self.y)

   g = 0

   tmp1 = self.x
   tmp2 = self.y

   moovex = self.scalex
   moovey = self.scaley

   moovex = self:correction(X, Y, moovex, moovey)
   moovey = self:correction2(X, Y, moovex, moovey)

 --  print( " --------------------> " .. moovex .. "-" .. moovex .. " - " .. X .. "-" .. Y)
   print( " --------------------> Pos. Actuelle = " .. self.x .. " - " .. self.y .. "  Destination = " .. self.destx .. " - " .. self.desty .. "   Deplacement =  " .. moovex .. " - " .. moovey)

   if X/Y > 0.1 and X/Y < 2 and X >= 0 and Y > 0 then
      g = 1
      self.x = self.x + moovex
      self.y = self.y + moovey
      print("\n************************************\n" .. "-------------------------------------------------  *  ----------" .. "\n************************************\n")
   elseif X/Y > 0.1 and X/Y < 2 and X < 0 and Y < 0 then
      g = 1
      self.x = self.x - moovex
      self.y = self.y - moovey
      print("\n************************************\n" .. "-------------------------------------------------  **  ----------" .. "\n************************************\n")
   elseif X/Y  < -0.1 and X/Y > -2 and X >= 0 and Y < 0 then
      g = 1
      self.x = self.x + moovex
      self.y = self.y - moovey
      print("\n************************************\n" .. "-------------------------------------------------  ***  ----------" .. "\n************************************\n")
   elseif X/Y < -0.1 and X/Y > -2 and X < 0 and Y > 0 then
      g = 1
      self.x = self.x - moovex
      self.y = self.y + moovey
      print("\n************************************\n" .. "-------------------------------------------------  ****  ----------" .. "\n************************************\n")
   elseif Y == 0 then
      self.y = self.y + moovey
      if X > 0 then
	 g = 1
	 self.x = self.x + moovex
	    print("\n************************************\n" .. "11\n".. moovex .. " / " .. moovey .. "\n************************************\n")
      end
      if X < 0 then
	 g = 1
	 self.x = self.x - moovex
	    print("\n************************************\n" .. "12\n".. moovex .. " / " .. moovey .. "\n************************************\n")
      end
   elseif X >= 0 then
      if Y > 0 then
	 if X >= Y then
	    g = 1 
	    self.x = self.x + moovex
	    print("\n************************************\n" .. "1\n".. moovex .. " / " .. moovey .. "\n************************************\n")
	 end
	 if Y > X then
	    g = 1
	    self.y = self.y + moovey
	    print("\n************************************\n" .. "2\n".. moovex .. " / " .. moovey .. "\n************************************\n")
	 end
      end
      if Y < 0 then
	 y = Y * -1
	 if X >= y then
	    g = 1
	    self.x = self.x + moovex
	    print("\n************************************\n" .. "3\n" .. moovex .. " / " .. moovey .. "\n************************************\n")
	 end
	 if y > X then
	    g = 1
	    self.y = self.y - moovey
	    print("\n************************************\n" .. "4\n".. moovex .. " / " .. moovey .. "\n************************************\n")
	 end
      end
   elseif X < 0 then
      _x = X * -1
      if Y > 0 then
	 if _x >= Y then
	    g = 1
	    self.x = self.x - moovex
	    print("\n************************************\n" .. "5\n".. moovex .. " / " .. moovey .. "\n************************************\n")
	 end
	 if Y > _x then
	    g = 1
	    self.y = self.y + moovey
	    print("\n************************************\n" .. "6\n".. moovex .. " / " .. moovey .. "\n************************************\n") 
	 end
      end
      if Y < 0 then
	 _y = Y * -1
	 if _x >= _y then
	    g = 1
	    self.x = self.x - moovex
	    print("\n************************************\n" .. "7\n".. moovex .. " / " .. moovey .. "\n************************************\n")
	 end
	 if _y > _x then
	    g = 1
	    self.y = self.y - moovey
	    print("\n************************************\n" .. "8\n".. moovex .. " / " .. moovey .. "\n************************************\n")
	 end
      end
   elseif X == Y and X >= 0 then
      g = 1
      self.x = self.x + moovex
      self.y = self.y + moovey
      print("\n************************************\n" .. "9\n".. moovex .. " / " .. moovey .. "\n************************************\n")
   elseif X == Y and X < 0 then
      g = 1
      self.x = self.x - moovex
      self.y = self.y - moovey
      print("\n************************************\n" .. "10\n".. moovex .. " / " .. moovey .. "\n************************************\n")
   end

   print( " --------------------> Pos. Actuelle = " .. self.x .. " - " .. self.y .. "  Destination = " .. self.destx .. " - " .. self.desty .. "   Deplacement =  " .. moovex .. " - " .. moovey)

   print("G = " .. g .. "<-------")
   if g == 0 then
      print("PROBLEME !!")
   end

--   print(" END ===========> " .. self.scale[Dx - tmp1 .. "  " .. self.y - tmp2 )

--   self.x = math.floor(self.x)
--   self.y = math.floor(self.y)
   --print(X .. " -- " .. Y)

   --print("BASE: " .. self.x .. " - / - " .. self.y .. " *** DEST: " .. self.destx .. " - / - " .. self.desty)
   print("################################# END! ##################################################")

end

function cube.setDestX(self, x)
   self.destx = x
end

function cube.setDestY(self, y)
   self.desty = y
end

function cube.getDestX(self)
   return self.destx
end

function cube.getDestY(self)
   return self.desty
end

function cube.setSpeed(self, speed)
   self.speed = speed
end

function cube.setPos(self, x, y)
   self.x = x
   self.y = y
end

function cube.setColor(self, r, g, b)
   self.r = r
   self.g = g
   self.b = b
end

function cube.setName(self, name)
   self.name = name
end

function cube.getSpeed(self)
   return self.speed
end

function cube.getPosX(self)
   return self.x
end

function cube.getPosY(self)
   return self.y
end

function cube.getSizeX(self)
   return self.sizex
end

function cube.getSizeY(self)
   return self.sizey
end

function cube.getColorR(self)
   return self.r
end

function cube.getColorG(self)
   return self.g
end

function cube.getColorB(self)
   return self.b
end

function cube.setSize(self, x, y)
   self.sizex = x
   self.sizey = y
end

function cube.increase(self, nb)
   print("taille cube augmente")
end

function cube.borneCube(self)
   if self.x + self.sizex >= self.xmax then
      self.x = self.xmax - self.sizex
   end
   if self.y + self.sizey >= self.ymax then
      self.y = self.ymax - self.sizey
   end
   if self.x <= 0 then
      self.x = 0
   end
   if self.y <= 0 then
      self.y = 0
   end
end

function cube.moveCube(self, dt, up, down, right, left)
   if love.keyboard.isDown(up) then
      self.y = self.y - self.speed * dt
--      print("on deplace UP")
   end   
   if love.keyboard.isDown(down) then
      self.y = self.y + self.speed * dt
--      print("on deplace DOWN")   
   end   
   if love.keyboard.isDown(right) then
      self.x = self.x + self.speed * dt
--      print("on deplace RIGHT")   
   end   
   if love.keyboard.isDown(left) then
      self.x = self.x - self.speed * dt
--      print("on deplace LEFT")   
   end

   --print(self.x .. "/" .. self.y)

end

function cube.speedCube(self)
   if love.keyboard.isDown("kp+") then
      if self.speed <= 198 then
	 --self.speed = self.speed + 2
	 self:setSpeed(self.speed + 2)
	 self:sizeCube('+', 0)
      end
   elseif love.keyboard.isDown("kp-") then
      if self.speed >= 42 then
	 --self.speed = self.speed - 2
	 self:setSpeed(self.speed - 2)
	 self:sizeCube('-', 0)
      end
   end
end

function cube.sizeCube(self, mod, nb)
   if nb == 0 then
      if mod == '+' then
	 self.sizex = self.sizex - 1
	 self.sizey = self.sizey - 1
      else
	 self.sizex = self.sizex + 1
	 self.sizey = self.sizey + 1
      end
   end
   if nb ~= 0 then
      if mod == '+' then
	 self.sizex = self.sizex - nb
	 self.sizey = self.sizey - nb
      else
	 self.sizex = self.sizex + nb
	 self.sizey = self.sizey + nb
      end
   end
end

--player = cube:new("player")

return cube