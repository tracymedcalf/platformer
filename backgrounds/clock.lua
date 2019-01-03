local Entity = require 'entities.Entity'
local background = Entity()
background.red = 1
background.hourAngle = 0
background.minuteAngle = 0

function parametricX(circleCenterX,radius,angle)
    return circleCenterX + radius * math.cos(angle)
end

function parametricY(circleCenterY,radius,angle)
    return circleCenterY + radius * math.sin(angle)
end

function background:draw()
    love.graphics.setBackgroundColor(self.red,self.red-.4,0)
    self.red = self.red - .005
    love.graphics.circle('line',200,150,100)
    love.graphics.line(200,150,parametricX(200,70,self.hourAngle),parametricY(150,70,self.hourAngle))
    love.graphics.line(200,150,parametricX(200,85,self.minuteAngle),parametricY(150,85,self.minuteAngle))
    self.hourAngle = self.hourAngle + .00833
    self.minuteAngle = self.minuteAngle + .05
end 

return background
