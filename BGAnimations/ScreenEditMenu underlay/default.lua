return Def.ActorFrame{
	LoadActor("../ScreenWithMenuElements underlay"),
	
	LoadActor("main")..{
		 OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-32)
		end
	},
	
	LoadActor("explanation")..{
		 OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+138)
		end
	},
}