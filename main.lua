require"collission"--importamos una libreria

function love.load( ... )
    --[[esta funcion se ejecuta al iniciar el juego, es donde se hacen las configuraciones iniciales]]
    math.randomseed(os.time())

    player = {}

    player.x = 50
    player.y =300
    player.w = 30
    player.h = 30

    coins = {}
    score = 0

    sounds = {}
    sounds.coin = love.audio.newSource("assets/sounds/coin.ogg", "static") --cargamos el sonido
    sounds.coin:setVolume(1)

    
    font = love.graphics.newFont("assets/font/clacon2.ttf", 20) --cargamos la fuente

    --[[cargamos el fondo]]
    images = {}
    images.background = love.graphics.newImage("assets/images/background.png")
    images.coin = love.graphics.newImage("assets/images/coin.png")
    images.player = love.graphics.newImage("assets/images/player.png")
end

--[[esta funcion se actualiza en cada frame, por lo que es ideal para realizar
    movimientos, animaciones, etc.
]]

function love.update(dt)
    if love.keyboard.isDown("d") then
        player.x = player.x + (200 * dt)
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - (200 * dt)
    end
    if love.keyboard.isDown("w") then
        player.y = player.y - (200 * dt)
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + (200 * dt)
    end

    for i=#coins, 1, -1 do 
        local coin = coins[i]
        if AABB(player.x,player.y,player.w,player.h, coin.x,coin.y,coin.w,coin.h) then
            table.remove(coins, i )
            sounds.coin:play()
            score = score + 1
        end
    end
     if math.random(0,100) < 0.01 then
        local coin = {}
        coin.w = 10
        coin.h = 10
        coin.x = math.random(0, 800 - coin.w)
        coin.y = math.random(0, 600 - coin.h)
        table.insert(coins, coin)
     end
end

--[[esta funcion se ejecuta cada vez que se dibuja, por lo que es ideal para dibujar
    en pantalla.
]]

function love.draw()
    --[[dibujamos el fondo]]
    for x=0, love.graphics.getWidth(), images.background:getWidth() do
        for y=0, love.graphics.getHeight(), images.background:getHeight() do
            love.graphics.draw(images.background, x, y)
        end
    end

    love.graphics.draw(images.background, 0, 0)

    love.graphics.draw(images.player,player.x,player.y) 
    for i=1, #coins, 1 do 
        local coin = coins[i]
        love.graphics.draw(images.coin,coin.x,coin.y)   
    end

    love.graphics.setFont(font)
    love.graphics.print("SCORE: " .. score, 10, 10)
    
end