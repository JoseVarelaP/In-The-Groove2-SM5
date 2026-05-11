local style = IsITG1Mode() and "_ITG1moveon" or "_moveon"
return Def.ActorFrame{
	LoadActor("../"..style)..{
	StartTransitioningCommand=function(s)
		if IsITG1Mode() then s:xy(GetTitleSafeH(0.9),GetTitleSafeV(0.8)) else s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y) end
		s:linear(0.2):diffusealpha(0)
	end;
	},
}