local style = ThemePrefs.Get("ITG1") and "_" or ""
return Def.ActorFrame{

	LoadActor( "ScreenWithMenuElements underlay" ),

	LoadActor("ScreenOptions overlay/".. style .."options frame")..{
		InitCommand=function(self)
			self:Center():addy(18)
		end,
		OnCommand=function(self)
			self:addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end
	},

	LoadActor( THEME:GetPathG("","MapController Mask") )..{
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+40):zwrite(true):z(1):blend("BlendMode_NoEffect")
		end
	},

	LoadModule("HeaderText.lua")(Var "LoadingScreen"),

	Def.BitmapText{
		Font=_eurostileColorPick(),
		Text="Player 1 Controls",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X-160,SCREEN_CENTER_Y-160):zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
		end;
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},

	Def.BitmapText{
		Font=_eurostileColorPick(),
		Text="Player 2 Controls",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X+160,SCREEN_CENTER_Y-160):zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
		end;
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},
		
}