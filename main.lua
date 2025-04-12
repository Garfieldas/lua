local player = {}
local ball = {}
local edges = {}
local hand = {}
local playerSpeed

function love.load()
    love.window.setTitle("Mew")

    background = love.graphics.newImage("images/backgrounds/bg.png")
    Pawn = love.graphics.newImage("images/pawn.png")
    ballImage = love.graphics.newImage("images/ball.png")

    song = love.audio.newSource("music/theme.mp3", "stream")
    song:setVolume(0.5)
    song:setLooping(true)
    song:play()

    sfx = love.audio.newSource("music/effect.mp3", "static")

    local imageWidth = Pawn:getWidth()
    local imageHeight = Pawn:getHeight()

    player = { x = 309, y = 364,
    width = imageWidth, height = imageHeight,
    image = Pawn}

    edges = {right = 690, left = 10,
            top = 10, bottom = 570}

    ball = { x = 350, y = 300,
            vx = 200, vy = 200,
            radius = 25, image = ballImage}


    hand = { top = 364, bottom = 454}

    playerSpeed = 300

end

function playSfx()
    sfx:setVolume(1)
    sfx:play()
end

function love.update(dt)

    if love.keyboard.isDown("right") and player.x < edges.right then
        player.x = player.x + playerSpeed * dt
    end

    if love.keyboard.isDown("left") and player.x > edges.left then
        player.x = player.x - playerSpeed * dt
    end 

    if love.keyboard.isDown("up") and player.y > hand.top then
        player.y = player.y - playerSpeed * dt
    end

    if love.keyboard.isDown("down") and player.y < hand.bottom then
        player.y = player.y + playerSpeed * dt
    end 

    MoveBall(dt)

end

function MoveBall(dt)

    ball.x = ball.x + ball.vx * dt
    ball.y = ball.y + ball.vy * dt

    if ball.x + ball.radius > edges.right then
        ball.x = edges.right - ball.radius
        ball.vx = -ball.vx
        playSfx()
    elseif ball.x - ball.radius < edges.left then
        ball.x = edges.left + ball.radius
        ball.vx = -ball.vx
        playSfx()
    end

    if ball.y + ball.radius > edges.bottom then
        ball.y = edges.bottom - ball.radius
        ball.vy = -ball.vy
        playSfx()
    elseif ball.y - ball.radius < edges.top then
        ball.y = edges.top + ball.radius
        ball.vy = -ball.vy
        playSfx()
    end


    local ballBox = {
        x = ball.x - ball.radius,
        y = ball.y - ball.radius,
        w = ball.radius * 2,
        h = ball.radius * 2
    }

    if CheckCollision(player.x, player.y, player.width, player.height,
                      ballBox.x, ballBox.y, ballBox.w, ballBox.h) then

        ball.vy = -ball.vy
        ball.y = player.y - ball.radius
        ball.vy = ball.vy * 1.05
        playSfx()
    end
end

function CheckCollision(ax, ay, aw, ah, bx, by, bw, bh)
    return ax < bx + bw and
           ax + aw > bx and
           ay < by + bh and
           ay + ah > by
end

function love.draw()

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    backgroundX = screenWidth / background:getWidth()
    backgroundY = screenHeight / background:getHeight()

    love.graphics.draw(background, 0, 0, 0, backgroundX, backgroundY)

    love.graphics.draw(player.image, player.x, player.y,
    0, 0.4, 0.4)

    local scaleX = (ball.radius * 2) / ball.image:getWidth()
    local scaleY = (ball.radius * 2) / ball.image:getHeight()  

    love.graphics.draw(ball.image, ball.x - ball.radius, ball.y - ball.radius,
    0, scaleX, scaleY)

    love.graphics.print("X: " .. player.x .. " Y: " .. player.y)

end

