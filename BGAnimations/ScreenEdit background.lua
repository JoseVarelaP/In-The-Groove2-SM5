return Def.ActorFrame{
	LoadActor("_shared background no streaks")..{
	OnCommand=function(self)
	self:rotationz(90);
	self:zoomx(1.2);
	if IsUsingWideScreen then
		self:zoomy(1.2);
	end
	self:x(SCREEN_CENTER_X);
	self:y(SCREEN_CENTER_Y);
	self:SetUpdateRate(0.1);
	end,
	},

	Def.Quad{ OnCommand=cmd(FullScreen;diffuse,0,0,0,0.2;Center); },
}