local x = Def.ActorFrame{
	LoadActor("_menu out")..{
		OnCommand=function(s)
			if ThemePrefs.Get("ITG1") then s:xy(GetTitleSafeH(0.9),GetTitleSafeV(0.8)) else s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y) end
			s:diffusealpha(0):linear(0.3):diffusealpha(1)
		end;
	}
};

x[#x+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(1); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};

return x;