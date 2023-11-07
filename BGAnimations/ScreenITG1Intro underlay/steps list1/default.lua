local t = Def.ActorFrame{FOV=45}

local scroll = Def.ActorScroller {
	SecondsPerItem = 2,
	NumItemsToDraw = 7,
	-- This is the equivalent of grain, so the higher level,
	-- the smoother the path.
	Subdivisions = 3,
	TransformFunction = function( self, offset, itemIndex, numItems)
		self:y( offset*80 )
		self:z( offset*40 )
	end,
	OnCommand=function(self)
		self:scrollwithpadding(1,1)
	end
}

local charts = {
	"Easy",
	"Medium",
	"Hard",
	"Expert"
}

for i, v in ipairs(charts) do
	scroll[#scroll+1] = Def.ActorFrame{
		Def.BitmapText{
			Font="_eurostile outline",
			Text=THEME:GetString("ScreenIntro",v),
			OnCommand=function(self)
				local chartn = v == "Expert" and "Challenge" or v
				self:y( 20 * (i-1) )
				:diffuse( DifficultyColor("Difficulty_"..chartn) )

				-- Fade in...
				:diffusealpha(0):sleep(0.4*i)
				:linear(0.5):diffusealpha(1)
				-- Now Fade out
				:sleep(2):linear(0.5)
				:diffusealpha(0)
			end
		}
	}
end

t[#t+1] = scroll

return t