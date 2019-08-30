return Def.ActorFrame{

	LoadActor("ScreenWithMenuElements underlay"),

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end;

		Def.BitmapText{
		Font=_eurostileColorPick(),
		Text=string.upper(THEME:GetString("ScreenTestInput","HeaderText")),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
		end;
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},

	},

	Def.DeviceList {
		Font="Common Normal",
		InitCommand=function(self)
			self:x(SCREEN_LEFT+20):y(SCREEN_TOP+80):zoom(0.8):halign(0)
		end;
	};

	Def.InputList {
		Font="Common Normal",
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X-280):y(SCREEN_CENTER_Y):zoom(1):halign(0):vertspacing(8):zoom(0.6)
		end;
	};

}