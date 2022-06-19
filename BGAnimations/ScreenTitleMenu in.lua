return Def.ActorFrame{
	Def.Sound{
		File="_logo.ogg",
		OnCommand=function(self)
			self:play()
		end
	},
	
	Def.Quad{
		OnCommand=function(self)
			self:FullScreen():linear(0.3):diffusealpha(0)
		end
	}
}