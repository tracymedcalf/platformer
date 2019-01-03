local Entity = require 'entities.Entity'
local background = Entity()
background.red = 1

function background:draw()
    love.graphics.setBackgroundColor(self.red,self.red-.4,0)
    self.red = self.red - .005
    love.graphics.circle('line',100,100,20)
end 

return background
