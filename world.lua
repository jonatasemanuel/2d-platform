World = {}

function World:load()
	self.world = love.physics.newWorld(0, 9.81 * 64, true)
	-- self.world = love.physics.newWorld(0, 9.81 * 1000, true)

	local floor = {}
	floor.body = love.physics.newBody(self.world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 17)
	floor.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 1)
	floor.fixture = love.physics.newFixture(floor.body, floor.shape)

	self.world:setCallbacks(beginContact, endContact)
end

-- function World:floor()
-- 	local floor = {}
-- 	floor.body = love.physics.newBody(World, love.graphics.getWidth() / 2, love.graphics.getHeight())
-- 	floor.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 1)
-- 	floor.fixture = love.physics.newFixture(floor.body, floor.shape)
-- end

function World:update(dt)
	self.world:update(dt)
end
