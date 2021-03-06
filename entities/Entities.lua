if Entities == nil then
Entities = {
	active = true,
	world = nil,
	entityList = {}, -- background by default
    foreground = {},
}
end

function Entities:enter(world)
	self:clear()
	self.world = world
end

-- adds entity to background by default
function Entities:add(entity)
	table.insert(self.entityList, entity)
end

-- add foreground object
function Entities:addFore(entity)
    table.insert(self.foreground,entity)
end

function Entities:addMany(entities)
	for k, entity in pairs(entities) do
		table.insert(self.entityList,entity)
	end
end

function Entities:remove(entity)
	for i, e in ipairs(self.entityList) do
		if e == entity then
			table.remove(self.entityList,i)
			return
		end
	end
end

function Entities:removeAt(index)
	table.remove(self.entityList,index)
end

function Entities:clear()
	self.world = nil
	self.entityList = {}
end

function Entities:draw()
    self.camera:attach()
	for i, e in ipairs(self.entityList) do
		e:draw(i)
	end
    for i, e in ipairs(self.foreground) do
        e:draw(i)
    end
    self.camera:detach()
end

function Entities:update(dt)
	for i, e in ipairs(self.entityList) do
		e:update(dt,i)
	end
end

return Entities

