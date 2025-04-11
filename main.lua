function love.load()
    x = 100
    y = 100
    width = 100
    height = 20

    maxX = 650
    maxY = 50

    minX = 50
    minY = 450

    ballX = 350
    ballY = 300
    ballW = 15
    ballH = 15

    speed = 200
    direction = "up"

end

function MoveBallUp(dt)
    ballY = ballY + (speed * dt)
    return ballY
end

function MoveBallDown(dt)
    ballY = ballY - (speed * dt)
    return ballY
end

function love.update(dt)
    if love.keyboard.isDown("right") then
        if x < maxX then
            x = x + 5
        end
    end

    if love.keyboard.isDown("left") then
        if x > minX then
            x = x - 5
        end
    end

    if love.keyboard.isDown("up") then
        if y > maxY then 
            y = y - 5
        end
    end

    if love.keyboard.isDown("down") then
        if y < minY then
            y = y + 5
        end
    end

    if direction == "up" then
        ballY = MoveBallUp(dt)
        if ballY >= minY then
            direction = "down"
        end
    elseif direction == "down" then
        ballY = MoveBallDown(dt)
        if ballY <= maxY then
            direction = "up"
        end
    end    

end

function love.draw()
    love.graphics.rectangle("line", x, y, width, height)
    love.graphics.print("X: " .. x .. " Y: " .. y)

    love.graphics.circle("fill", ballX, ballY, ballW, ballH)
end

