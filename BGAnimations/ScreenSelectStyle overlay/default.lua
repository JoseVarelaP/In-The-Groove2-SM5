return Def.ActorFrame{

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end;

		Def.BitmapText{
		Font=_eurostileColorPick(),
		Text="SELECT A STYLE",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):bounceend(.3):zoom(1)
		end;
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},

	},

	LoadActor("explanation frame")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+82):y(SCREEN_CENTER_Y+134):diffusealpha(0):linear(0.5):diffusealpha(1)
	end;
	MadeChoiceP1MessageCommand=function(self)
		self:playcommand("GoOff")
	end;
	MadeChoiceP2MessageCommand=function(self)
		self:playcommand("GoOff")
	end;
	GoOffCommand=function(self)
		self:linear(0.5):diffusealpha(0)
	end;
	},
}