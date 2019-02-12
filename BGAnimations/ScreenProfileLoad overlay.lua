local x = Def.ActorFrame{
	LoadActor("_moveon")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y)
	end;
	};
};

x[#x+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(1); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};

return x;