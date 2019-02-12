return Def.ActorFrame{
	LoadActor("../_moveon")..{
	StartTransitioningCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):linear(0.2):diffusealpha(0)
	end;
	},
}