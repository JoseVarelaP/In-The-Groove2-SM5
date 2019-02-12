return Def.ActorFrame{
	LoadActor("_shared background no streaks")..{
	OnCommand=function(self)
	self:rotationz(90);
	self:zoomx(1.2);
	self:zoomy( WideScale(1,1.3) );
	self:x(SCREEN_CENTER_X);
	self:y(SCREEN_CENTER_Y);
	self:SetUpdateRate(0.1);
	end,
	},

	
	Def.Quad{
		 OnCommand=function(self)
			self:FullScreen():diffuse(0,0,0,0.2):Center()
		end
	},
}