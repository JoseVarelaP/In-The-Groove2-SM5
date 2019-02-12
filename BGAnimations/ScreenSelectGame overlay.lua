return Def.ActorFrame{

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end;

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text=string.upper(THEME:GetString("ScreenSelectGame","HeaderText")),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
		end;
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},

	},


}