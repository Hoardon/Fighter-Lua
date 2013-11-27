
target = require "obj/cube"
player = require "obj/cube"

function love.load()
   print("Start !")
   
   wall = love.graphics.newImage("img/bataille.jpg")

   target = target:new("target")

   player = player:new("player")

   target:setFace("img/warrior2.jpeg")

   player:setFace("img/guerrier-player.jpg")

   player:Init(200, 100, 0)

   ennemy = love.graphics.newImage("img/warrior2.jpeg")
   ally = love.graphics.newImage("img/guerrier-player.jpg")

   math.randomseed(os.time())
   target:setMax(love.graphics.getWidth(), love.graphics.getHeight())
   target:setSize(ennemy:getHeight(), ennemy:getWidth())
   player:setMax(love.graphics.getWidth(), love.graphics.getHeight())
   target:setSize(ally:getHeight(), ally:getWidth())

   game = {
      time = love.timer.getTime()
   }

   target:setDestX(0)
   target:setDestY(0)

   npos = 0

   side = 0
   level = 4

end

function love.update(dt)

   side = side + 1

   timer = love.timer.getTime() - love.timer.getTime() % 1
   if timer ~= game.time and timer % 1 == 0 then 
      game.time = timer
      if timer % 10 == 0 and timer ~= 0 then
	 target:upScale()
	 level = level - 1
	 print(timer % 10)
      end
      if 60 - game.time == 0 then
	 love.event.quit()
      end

   end 


   if target:getPosX() == target:getDestX() and target:getPosY() == target:getDestY() then
      changeDest()
   else
      target:travel(dt, game.time)
   end
   
   player:moveCube(dt, "z", "s", "d", "q")
   
   target:borneCube()
   player:borneCube()
   
   target:speedCube()
   
end

function changeDest()
   target:setDestX(20 * math.floor(math.random(target:getXMax() - target:getSizeX()) / 20))
   target:setDestY(20 * math.floor(math.random(target:getYMax() - target:getSizeY()) / 20))
end

function love.draw()

   love.graphics.setColor(255, 255, 255);
   love.graphics.draw(wall)

   love.graphics.draw(love.graphics.newImage("img/warrior2.jpeg"), target:getPosX(), target:getPosY())
   love.graphics.draw(love.graphics.newImage("img/guerrier-player.jpg"), player:getPosX(), player:getPosY())

--   love.graphics.setColor(target:getColorR(), target:getColorG(), target:getColorB())
--   love.graphics.rectangle("fill", target:getPosX(), target:getPosY(), target:getSizeX(), target:getSizeY())

--   love.graphics.setColor(player:getColorR(), player:getColorG(), player:getColorB())
--   love.graphics.rectangle("fill", player:getPosX(), player:getPosY(), player:getSizeX(), player:getSizeY())

   love.graphics.setColor(255, 40, 20);
   love.graphics.print("Cube speed : " .. target:getSpeed(), 20, 20, 0, 2, 2)

   love.graphics.print("Time left : " .. 60 - game.time, 20, 50, 0, 2, 2)

   love.graphics.print("Score : " .. 0, 20, 80, 0, 2, 2)

   --   love.graphics.setColor(255, 0, 255)
   --   love.graphics.rectangle("fill", cube.x + 150, cube.y, cube.sizex, cube.sizey)
end

function love.mousepressed(x, y, unicode)
   print(" **  -CLICK-  ** " .. unicode)
end

function love.mousereleased(x, y, unicode)
   print(" ** -UNCLICK- ** " .. unicode)
end

function love.keypressed(k)

   --   love.graphics.setColor(255, 0, 255);
   --   love.graphics.print( "Cube speed " .. target:getSpeed(), 20, 20)
   --   love.graphics.setColor(255, 255, 255);

   if k == "escape" then
      love.event.quit()
   end

end