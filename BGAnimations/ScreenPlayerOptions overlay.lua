return Def.ActorFrame{

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end;

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text=THEME:GetString("ScreenPlayerOptions","HeaderText"),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
		end;
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},

		LoadActor( THEME:GetPathG("ScreenWithMenuElements Items/stage",""..StageIndexBySegment()) )..{
		OnCommand=function(self)
			self:x(40):y(34):addx(-SCREEN_WIDTH):sleep(0.2):decelerate(0.6):addx(SCREEN_WIDTH)
		end;
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},

	},

	LoadActor( THEME:GetPathG("","_name p1") )..{
		OnCommand=function(self)
			self:player(PLAYER_1):x(SCREEN_CENTER_X+(372-320)):y(81):addx(SCREEN_WIDTH*3/4):sleep(0.1):decelerate(0.3):addx(-SCREEN_WIDTH*3/4)
		end;
		OffCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end;
	},

	LoadActor( THEME:GetPathG("","_name p2") )..{
		OnCommand=function(self)
			self:player(PLAYER_2):x(SCREEN_CENTER_X+(540-320)):y(81):addx(SCREEN_WIDTH*3/4):sleep(0.2):decelerate(0.3):addx(-SCREEN_WIDTH*3/4)
		end;
		OffCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end;
	},

	Def.HelpDisplay {
		File="_eurostile normal",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+203):zoom(0.7):diffuseblink()
		end;
		InitCommand=function(self)
			local s = THEME:GetString("ScreenPlayerOptions","HelpText") .. "::".. THEME:GetString("ScreenPlayerOptions","SelectAvailableHelpTextAppend")
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated(s);
		end;
		OffCommand=function(self)
			self:linear(0.5):zoomy(0)
		end;
		},


}