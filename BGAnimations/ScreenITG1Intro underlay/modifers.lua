local t = Def.ActorFrame{FOV=45}

local modlist = {
	{"Drunk", "Split" },
	{"Dizzy", "Boomerang" },
	{"Mini", "Alternate" },
	{"Flip", "Wide" },
	{"Tornado", "Big" },
	{"Tipsy", "Quick" },
	{"Planted", "Skippy" },
	{"Twister", "Echo" },
	{"Cel", "Stomp" },
	{"Metal", "SuperShuffle" },
	{"Bumpy", "Centered" },
	{"Beat", "Cross" }
}

local Left = Def.ActorScroller{
	SecondsPerItem = 0.3,
	NumItemsToDraw = 7,
	TransformFunction=function( self, offset, itemIndex, numItems)
		self:rotationy(offset*20):y(offset*100)
	end,
	InitCommand=function(self)
		self:x(-100):scrollwithpadding(4,16)
	end
}

local Right = Def.ActorScroller{
	SecondsPerItem = 0.3,
	NumItemsToDraw = 7,
	TransformFunction=function( self, offset, itemIndex, numItems)
		self:rotationy(offset*20):y(offset*100)
	end,
	InitCommand=function(self)
		self:x(100):scrollwithpadding(4,16)
	end
}

for i,v in ipairs( modlist ) do
	Left[#Left+1] = Def.ActorFrame{
		Def.Sprite{ Texture="_modifier frame" },
		Def.BitmapText{ Font="_eurostile normal", Text=THEME:GetString("OptionNames",v[1]) },
	}

	Right[#Right+1] = Def.ActorFrame{
		Def.Sprite{ Texture="_modifier frame" },
		Def.BitmapText{ Font="_eurostile normal", Text=THEME:GetString("OptionNames",v[2]) },
	}
end

t[#t+1] = Left
t[#t+1] = Right

return t