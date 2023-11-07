return Def.ActorFrame{
	Def.Sprite{
		Texture="flare",
		OnCommand=function(self)
			self:blend("add")
			:diffusealpha(0.4)
			:zoom(1.6)
		end
	},

	Def.Sprite{
		Texture="burn",
		OnCommand=function(self)
			self:blend("add")
			:linear(0.8)
			:rotationz(90)
			:diffusealpha(0)
			:zoom(1.2)
		end
	},

	Def.Sprite{
		Texture="burn",
		OnCommand=function(self)
			self:blend("add")
			:sleep(1.8)
			:linear(0.8)
			:rotationz(-90)
			:diffusealpha(0)
			:zoom(1.2)
		end
	},

	Def.Sprite{
		Texture="electricity",
		OnCommand=function(self)
			self:blend("add")
			:zoomtowidth(SCREEN_WIDTH)
			:texcoordvelocity(1,0)
			:diffusealpha(0.25)
		end
	},

	Def.Sprite{
		Texture="electricity",
		OnCommand=function(self)
			self:blend("add")
			:zoomtowidth(SCREEN_WIDTH)
			:texcoordvelocity(-1,0)
			:diffusealpha(0.25)
		end
	}
}