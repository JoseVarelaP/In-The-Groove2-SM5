local t = Def.ActorFrame{ FOV=45 }

local scroll = Def.ActorScroller {
	SecondsPerItem = 0.3,
	NumItemsToDraw = 8,
	-- This is the equivalent of grain, so the higher level,
	-- the smoother the path.
	Subdivisions = 3,
	TransformFunction = function( self, offset, itemIndex, numItems)
		self:x( offset*offset*20 )
		self:y( 86 * offset )
	end,
	OnCommand=function(self)
		self:scrollwithpadding(5,5)
	end
}

-- Generate each song entry
for i = 1,8 do
	scroll[#scroll+1] = Def.ActorFrame{
		Def.Sprite{
			Texture="../_item mask",
			OnCommand=function(self)
				self:zwrite(true):blend("noeffect")
			end
		},
		Def.Sprite{
			Texture="coursebanner"..i,
			OnCommand=function(self)
				self:zoomto(270,64):ztest(1)
			end
		},
		Def.Sprite{ Texture="../_item frame" }
	}
end

t[#t+1] = scroll

return t