return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(Color.Black):FullScreen()
		end,
		OnCommand=function(self)
			self:cropleft(1):fadeleft(.5):linear(0.5):cropleft(-0.5):sleep(0.5)
		end
	},

	Def.Sound{
		File=THEME:GetPathS("","_screen cancel"),
		StartTransitioningCommand=function(self)
			self:play()
		end
	}
}
