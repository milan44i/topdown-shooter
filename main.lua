function love.load()
  sprites = {}
  sprites.background = love.graphics.newImage("sprites/background.png")
  sprites.player = love.graphics.newImage("sprites/player.png")
  sprites.zombie = love.graphics.newImage("sprites/zombie.png")
  sprites.bullet = love.graphics.newImage("sprites/bullet.png")

  player = {}
  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight() / 2
  player.speed = 250

  zombies = {}
  bullets = {}
end

function love.update(dt)
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end
  
  -- Keep player within screen boundaries
  player.x = math.max(0, math.min(player.x, love.graphics.getWidth()))
  player.y = math.max(0, math.min(player.y, love.graphics.getHeight()))

  for _, zombie in ipairs(zombies) do
    local angle = zombiePlayerAngle(zombie)
    zombie.x = zombie.x + math.cos(angle) * zombie.speed * dt
    zombie.y = zombie.y + math.sin(angle) * zombie.speed * dt

    -- Keep zombie within screen boundaries
    zombie.x = math.max(0, math.min(zombie.x, love.graphics.getWidth()))
    zombie.y = math.max(0, math.min(zombie.y, love.graphics.getHeight()))

    if distance(player.x, player.y, zombie.x, zombie.y) < 30 then
      for i, z in ipairs(zombies) do
        zombies[i] = nil
      end
    end
  end

  for i = #bullets, 1, -1 do
    local bullet = bullets[i]
    bullet.x = bullet.x + math.cos(bullet.angle) * bullet.speed * dt
    bullet.y = bullet.y + math.sin(bullet.angle) * bullet.speed * dt

    if bullet.x < 0 or bullet.x > love.graphics.getWidth() or bullet.y < 0 or bullet.y > love.graphics.getHeight() then
      table.remove(bullets, i)
    end

    for j = #zombies, 1, -1 do
      local zombie = zombies[j]
      if distance(bullet.x, bullet.y, zombie.x, zombie.y) < 20 then
        table.remove(zombies, j)
        table.remove(bullets, i)
        break
      end
    end
  end
end

function love.draw()
    love.graphics.draw(sprites.background, 0, 0)
    love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), 1, 1, sprites.player:getWidth() / 2, sprites.player:getHeight() / 2)

    for _, zombie in ipairs(zombies) do
        love.graphics.draw(sprites.zombie, zombie.x, zombie.y, zombiePlayerAngle(zombie), 1, 1, sprites.zombie:getWidth() / 2, sprites.zombie:getHeight() / 2)
    end

    for _, bullet in ipairs(bullets) do
        love.graphics.draw(sprites.bullet, bullet.x, bullet.y, bullet.angle, 0.5, 0.5, sprites.bullet:getWidth() / 2, sprites.bullet:getHeight() / 2)
    end
end

function love.keypressed(key)
  if key == "space" then
    spawnZombie()
  end
end

function love.mousepressed(x, y, button)
  if button == 1 then
    spawnBullet()
  end
end

function playerMouseAngle()
  local mouseX, mouseY = love.mouse.getPosition()
  local angle = math.atan2(mouseY - player.y, mouseX - player.x)
  return angle
end

function zombiePlayerAngle(zombie)
  local angle = math.atan2(player.y - zombie.y, player.x - zombie.x)
  return angle
end

function spawnZombie()
  local zombie = {}
  zombie.x = math.random(0, love.graphics.getWidth())
  zombie.y = math.random(0, love.graphics.getHeight())
  zombie.speed = math.random(100, 200)
  table.insert(zombies, zombie)
end

function spawnBullet()
  local bullet = {}
  bullet.x = player.x
  bullet.y = player.y
  bullet.angle = playerMouseAngle()
  bullet.speed = 500
  table.insert(bullets, bullet)
end

function distance(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end