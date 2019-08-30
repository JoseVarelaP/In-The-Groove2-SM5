local t = Def.ActorFrame{}
t[#t+1] = Def.ActorFrame{

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end;

		Def.BitmapText{
		Font=_eurostileColorPick(),
		Text=THEME:GetString("ScreenPlayerOptions","HeaderText"),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
		end;
		CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
		OffCommand=function(s)
			s:playcommand("TweenOff")
			SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
		end;
		TweenOffCommand=function(self)
			self:stoptweening():accelerate(.3):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},

		Def.Sprite{
			Texture=THEME:GetPathG("ScreenWithMenuElements Items/stage",""..StageIndexBySegment()),
			Condition=not GAMESTATE:IsCourseMode() and not ThemePrefs.Get("ITG1"),
			OnCommand=function(self)
				self:x(40):y(34):addx(-SCREEN_WIDTH):sleep(0.2):decelerate(0.6):addx(SCREEN_WIDTH)
			end;
			OffCommand=function(self) self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end;
			CancelMessageCommand=function(self) if GAMESTATE:Env()["WorkoutMode"] then self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end end;
		},
	
		LoadActor( THEME:GetPathG("ScreenWithMenuElements","Items/ITG1") )..{
			Condition=not GAMESTATE:IsCourseMode() and ThemePrefs.Get("ITG1"),
			OnCommand=function(self)
				self:xy(SCREEN_RIGHT-140,0):addx(SCREEN_WIDTH):sleep(0.2):decelerate(0.6):addx(-SCREEN_WIDTH)
			end;
			OffCommand=function(self) self:accelerate(.3):addx(SCREEN_WIDTH) end;
		};

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
		CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
		OffCommand=function(s) s:playcommand("TweenOff") end;
		TweenOffCommand=function(self) self:linear(0.5):zoomy(0) end;
	},

	LoadActor("_menu out")..{
		OnCommand=function(s)
			s:Center():diffusealpha(0)
		end;
		CancelMessageCommand=function(s) s:sleep(0.3):linear(0.3):diffusealpha(1) end;
	}


}

for player in ivalues(PlayerNumber) do
	t[#t+1] = LoadActor( THEME:GetPathG("","_name frame"), player )..{
		OnCommand=function(self)
			local margin = player == PLAYER_1 and 372 or 540
			self:player(player):x(SCREEN_CENTER_X+(margin-320)):y(81):addx(SCREEN_WIDTH*3/4):sleep(0.1):decelerate(0.3):addx(-SCREEN_WIDTH*3/4)
		end;
		CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
		OffCommand=function(s) s:playcommand("TweenOff") end;
		TweenOffCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end;
	};
end

return t;