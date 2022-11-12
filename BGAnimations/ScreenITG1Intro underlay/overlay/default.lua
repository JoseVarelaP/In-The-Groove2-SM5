local t = Def.ActorFrame{FOV=45}

local featureNames = {
	{70, THEME:GetString("ScreenIntro","New Songs"), -270, -120, "down", 3, "right", 0.5, halign = 0},
	{550, THEME:GetString("ScreenIntro","New Dances"), 270, -120, "left", 3.5, "down", 4.5, halign = 1},
	{5, THEME:GetString("ScreenIntro","Game Modes"), 270, 120, "up", 2.5, "left", 8.8, halign = 1},
	{15, THEME:GetString("ScreenIntro","New Courses"), -270, 120, "right", 3, "left", 12.3, halign = 0},
	{50, THEME:GetString("ScreenIntro","Modifiers"), -270, -120, "down", 3.5, "right", 16.5, halign = 0},
	{THEME:GetString("ScreenIntro","New"), THEME:GetString("ScreenIntro","Features"), 270, -120, "left", 3.5, "right", 21.5, halign = 1},
}

for i,v in ipairs(featureNames) do
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			self:xy(v[3],v[4])
			:diffusealpha(0)
		end,
		OnCommand=function(self)
			-- Tween a bit before the original position
			if v[5] == "right" then self:x( v[3] + 40 ) end
			if v[5] == "left" then self:x( v[3] - 40 ) end
			if v[5] == "up" then self:y( v[4] - 40 ) end
			if v[5] == "down" then self:y( v[4] + 40 ) end
			self:sleep(v[8]):linear(0.5):diffusealpha(1)
			-- And now restore it back.
			self:xy(v[3],v[4])
			:sleep(v[6])
			:linear(0.5):diffusealpha(0)
			if v[7] == "right" then self:x( v[3] + 40 ) end
			if v[7] == "down" then self:y( v[4] + 40 ) end
			if v[7] == "left" then self:x( v[3] - 40 ) end
		end,
		Def.BitmapText{
			Font="_big blue glow",
			Text=v[1],
			InitCommand=function(self)
				self:align(v.halign,0):zoom(1.3):y(-40)
			end
		},
		Def.BitmapText{
			Font="_big blue glow",
			Text=v[2],
			InitCommand=function(self)
				self:align(v.halign,0):y(25):zoom(0.8)
			end
		}
	}
end

t[#t+1] = Def.Sprite{
	Texture="overlay edge",
	InitCommand=function(self)
		self:valign(0):y(-SCREEN_HEIGHT*.5-35):texcoordvelocity(0.025,0)
		:zoomx(2)
		:customtexturerect(0,0,2,1)
		:diffusealpha(0.5)
	end
}

t[#t+1] = Def.Sprite{
	Texture="overlay edge",
	InitCommand=function(self)
		self:valign(0):rotationz(180):y(SCREEN_HEIGHT*.5+35):texcoordvelocity(0.025,0)
		:zoomx(2)
		:customtexturerect(0,0,2,1)
		:diffusealpha(0.5)
	end
}

t[#t+1] = Def.Sprite{
	Texture="in the groove",
	InitCommand=function(self)
		local xtimes = (SCREEN_WIDTH/self:GetWidth()) + 1
		self:y(-SCREEN_HEIGHT*.5+15):texcoordvelocity(-0.05,0)
		:zoomx(xtimes)
		:customtexturerect(0,0,xtimes,1)
	end
}

t[#t+1] = Def.Sprite{
	Texture="in the groove",
	InitCommand=function(self)
		local xtimes = (SCREEN_WIDTH/self:GetWidth()) + 1
		self:y(SCREEN_HEIGHT*.5-15):texcoordvelocity(0.05,0)
		:zoomx(xtimes)
		:customtexturerect(0,0,xtimes,1)
	end
}

return t