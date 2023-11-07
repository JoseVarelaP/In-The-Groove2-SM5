return Def.ActorFrame{
	Def.Sprite{
		Texture="flash",
		OnCommand=function(self)
			self:blend("add"):spin():effectmagnitude(0,0,100)
		end
	},
	Def.Sprite{
		Texture="flash",
		OnCommand=function(self)
			self:blend("add"):spin():effectmagnitude(0,0,-100)
		end
	},
}