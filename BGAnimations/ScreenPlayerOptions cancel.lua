return Def.ActorFrame{
	Def.Actor{
	StartTransitioningCommand=function(self)
		self:sleep(1)
		MESSAGEMAN:Broadcast("Cancel")
	end;
	},

	LoadActor( THEME:GetPathS("","_screen cancel") )..{
		StartTransitioningCommand=function(self)
			self:play()
		end;
	},
}
