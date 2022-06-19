return Def.ActorFrame{
	Def.Actor{
		StartTransitioningCommand=function(self)
			self:sleep(1)
			MESSAGEMAN:Broadcast("Cancel")
		end
	},

	Def.Sound{
		File=THEME:GetPathS("","_screen cancel"),
		StartTransitioningCommand=function(self)
			self:play()
		end
	}
}
