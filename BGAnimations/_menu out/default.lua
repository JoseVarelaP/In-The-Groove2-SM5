local style = ThemePrefs.Get("ITG1") and "_ITG1moveon" or "_moveon"
return Def.ActorFrame{
	LoadActor("../"..style)..{
	StartTransitioningCommand=function(s)
		if ThemePrefs.Get("ITG1") then s:xy(GetTitleSafeH(0.9),GetTitleSafeV(0.8)) else s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y) end
		s:diffusealpha(0):sleep(0.2):linear(0.1):diffusealpha(1):sleep(0.2)
	end;
	},
}