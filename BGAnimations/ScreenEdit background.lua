return Def.ActorFrame{
	LoadActor("_shared background no streaks")..{
		OnCommand=function(self)
			self:rotationz(90)
			:zoomx(1.2)
			:zoomy( WideScale(1,1.3) )
			:x(SCREEN_CENTER_X)
			:y(SCREEN_CENTER_Y)
			:SetUpdateRate(0.1)
		end
	},

	
	Def.Quad{
		 OnCommand=function(self)
			self:FullScreen():diffuse(0,0,0,0.2):Center()
		end
	}
}