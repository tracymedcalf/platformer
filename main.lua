Gamestate = require 'hump.gamestate'

local mainMenu = require 'gamestates.mainMenu'
local gameLevel4 = require 'gamestates.gameLevel4'
--local Level = require 'gamestates.Level'
local pause = require 'gamestates.pause'

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(gameLevel4)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end
