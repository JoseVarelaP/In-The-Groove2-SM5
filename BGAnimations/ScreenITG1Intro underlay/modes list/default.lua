local t = Def.ActorFrame{ FOV=45 }

local scroll = Def.ActorScroller {
	SecondsPerItem = 0.5,
	NumItemsToDraw = 15,
	-- This is the equivalent of grain, so the higher level, the smoother the path.
	Subdivisions = 3,
	TransformFunction = function( self, offset, itemIndex, numItems)
		local degrees = offset*28.2
		local radians = degrees/180*math.pi
		self:x( math.cos(radians)*300 )
		self:y( math.sin(radians)*300 )
		:zoom(1.5)
		:rotationz(degrees)
	end,
	OnCommand=function(self)
		self:scrollwithpadding(5,5)
	end
}

-- Generate each song entry
local names = {
	"Tutorial",
	"Dance",
	"Battle",
	"Marathon",
	"Fitness"
}
for i,v in ipairs(names) do
	scroll[#scroll+1] = Def.ActorFrame{
		Def.Sprite{ Texture=ToLower(v) },
		Def.BitmapText{
			Font="_eurostile normal",
			Text=THEME:GetString("ScreenIntro",v),
			OnCommand=function(self)
				self:zoom(0.5):shadowlength(2)
			end
		},
	}
end

t[#t+1] = scroll

return t