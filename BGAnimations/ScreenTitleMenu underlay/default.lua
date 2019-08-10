return Def.ActorFrame{
	LoadActor("../ScreenLogo background"),
	
	
	Def.Sprite{
		Texture="frame",
		 OnCommand=function(self)
			self:Center():zoomtowidth(SCREEN_WIDTH):faderight(0.1):fadeleft(0.1):cropright(1.1):cropleft(-0.1):linear(1):cropright(-0.1)
		end
	},
	
	Def.Sprite{
		Texture="flare",
		 OnCommand=function(self)
			self:xy(SCREEN_LEFT-64,SCREEN_CENTER_Y-165):rotationz(0):linear(1):x(SCREEN_RIGHT+64):rotationz(360)
		end
	},
	
	Def.Sprite{
		Texture="flare",
		 OnCommand=function(self)
			self:xy(SCREEN_LEFT-64,SCREEN_CENTER_Y+165):rotationz(0):linear(1):x(SCREEN_RIGHT+64):rotationz(360)
		end
	},

	LoadActor("../ScreenWithMenuElements underlay"),
	LoadActor("PercentComplete","StepsType_Dance_Single")..{ OnCommand=function(self) self:xy(SCREEN_RIGHT-90,SCREEN_TOP+30):zoom(0.9) end; };
	LoadActor("PercentComplete","StepsType_Dance_Double")..{ OnCommand=function(self) self:xy(SCREEN_RIGHT-90,SCREEN_TOP+50):zoom(0.9) end; };
}