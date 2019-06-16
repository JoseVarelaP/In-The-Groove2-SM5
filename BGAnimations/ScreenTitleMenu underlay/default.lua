return Def.ActorFrame{
	LoadActor("../ScreenLogo background"),
	
	
	LoadActor("frame")..{
		 OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomtowidth(SCREEN_WIDTH):faderight(0.1):fadeleft(0.1):cropright(1.1):cropleft(-0.1):linear(1):cropright(-0.1)
		end
	},
	
	LoadActor("flare")..{
		 OnCommand=function(self)
			self:y(SCREEN_CENTER_Y-165):x(SCREEN_LEFT-64):rotationz(0):linear(1):x(SCREEN_RIGHT+64):rotationz(360)
		end
	},
	
	LoadActor("flare")..{
		 OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+165):x(SCREEN_LEFT-64):rotationz(0):linear(1):x(SCREEN_RIGHT+64):rotationz(360)
		end
	},

	LoadActor("../ScreenWithMenuElements underlay"),
}