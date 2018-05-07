return Def.ActorFrame{
	LoadActor("_moveon")..{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	Def.Actor{
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(1); end
		self:queuecommand("Load")
	end,
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end,
	},
}