require("world")

Player = {}

function Player:load(world)
	self.world:setCallbacks(beginContact, endContact)
end

function Player:new(world)
	local self = self or {}
	self.x = 50
	self.y = love.graphics.getWidth() / 2
	self.width = 16
	self.height = 32
	self.speed = 500
	self.jumpCount = 0
	self.isGrounded = false

	self.world = world

	self.physics = {}
	self.physics.world = world
	self.physics.body = love.physics.newBody(self.physics.world, self.x, self.y, "dynamic")
	self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
	self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape, 1)
	self.physics.fixture:setRestitution(0.2)

	self.physics.body:setGravityScale(10)

	self.draw = function()
		love.graphics.rectangle("fill", self.physics.body:getX(), self.physics.body:getY(), self.width, self.height)
	end

	return self
end

function Player:update(dt)
	Player:move(dt)

	-- if love.keyboard.isDown("w") or love.keyboard.isDown("space") then
	-- 	self:jump()
	-- end
	function love.keypressed(key)
		if key == "w" or key == "space" then
			self:jump()
		end
	end
end

function Player:move(dt)
	local vx, vy = 0, 0

	-- Move the physics body by applying velocity
	if love.keyboard.isDown("a") then
		vx = vx - self.speed
	end
	if love.keyboard.isDown("s") then
		vy = vy + self.speed
	end
	if love.keyboard.isDown("d") then
		vx = vx + self.speed
	end

	-- Update the physics body's velocity
	self.physics.body:setLinearVelocity(vx, vy)
end

function Player:jump()
	if self.jumpCount < 2 then
		self.physics.body:applyLinearImpulse(0, -3000)
		self.jumpCount = self.jumpCount + 1
		print(self.jumpCount)
	end

	-- local _, vy = self.physics.body:getLinearVelocity()
	--
	-- -- checking if the player is on the ground
	-- if vy == 0 then
	-- 	self.physics.body:applyLinearImpulse(0, -220)
	-- end
end

function beginContact(a, b, coll)
	print("collision detected")
	if a == Player.physics.fixture or b == Player.physics.fixture then
		Player:resetJump()
	end
end

function endContact(a, b, coll)
	-- print("end")
	-- if a == Player.physics.fixture or b == Player.physics.fixture then
	-- 	Player.isGrounded = false
	-- end
end

function Player:resetJump()
	print("resetjump")
	self.jumpCount = 0
	self.isGrounded = true
end

function Player:draw()
	love.graphics.polygon("fill", self.physics.body:getWorldPoints(self.physics.shape:getPoints()))
end
