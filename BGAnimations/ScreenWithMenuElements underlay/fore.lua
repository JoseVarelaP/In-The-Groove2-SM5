return Def.ActorFrame{
	InitCommand=function(self)
		self:y(SCREEN_BOTTOM-34)
	end;
	
	Def.Sprite{
	Condition=not ThemePrefs.Get("ITG1"),
	Texture="streak",
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):zoomtowidth(SCREEN_WIDTH):cropleft(-0.2):cropright(-0.2)
	end;
	DoOnCommand=function(self)
		self:diffusealpha(1):cropright(1.2):cropleft(-0.2):linear(1):cropright(-0.2)
	end;
	DoOffCommand=function(self)
		self:linear(0.5):diffusealpha(0)
	end;
	},

	LoadActor( THEME:GetPathB("","_frame 3x1") , {"footer",WideScale(520,680)})..{
		Condition=ThemePrefs.Get("ITG1"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X,0)
		end;
	},

	Def.Sprite{
	Texture="flare",
	Condition=not ThemePrefs.Get("ITG1"),
	InitCommand=function(self)
		self:x(SCREEN_LEFT-128)
	end;
	DoOnCommand=function(self)
		self:x(SCREEN_LEFT-128):rotationz(0):linear(1):x(SCREEN_RIGHT+128):rotationz(360)
	end;
	},
}
