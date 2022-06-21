local ModeMenuAvailable = THEME:GetMetric("ScreenSelectMusic","ModeMenuAvailable")
local itgstylemargin = ThemePrefs.Get("ITG1") and -1 or 0
local t=Def.ActorFrame{}
t[#t+1] = Def.ActorFrame{

	-- Load Sound Containers.

	Def.Sprite{
		Texture=THEME:GetPathG("ScreenSelectMusic wheel","mask"),
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X-385):y(SCREEN_CENTER_Y-10):zoom(1.1):zoomy(1.2):zwrite(true):z(1):blend("BlendMode_NoEffect")
			for player in ivalues(PlayerNumber) do
				if GAMESTATE:Env()["WorkoutMode"] then
					if GAMESTATE:IsPlayerEnabled(player) then
						-- FailSetting
						GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):FailSetting(3)
					end
				end
			end
		end
	},

	Def.Sprite{
		Texture=THEME:GetPathG("ScreenSelectMusic wheel","mask"),
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X-385):y(SCREEN_CENTER_Y-12):croptop(0.5):zwrite(true):z(1):blend("BlendMode_NoEffect")
		end
	},

	Def.Sprite{
		Texture=THEME:GetPathG("ScreenSelectMusic wheel inner","mask"),
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X+80):y(SCREEN_CENTER_Y-10):zoom(1.1):zoomy(1.28):zwrite(true):z(1):blend("BlendMode_NoEffect"):croptop(0.34)
		end
	},

	Def.ActorFrame{
		OnCommand=function(s) s:fov(45) end,
		Def.Quad{
			InitCommand=function(s)
				s:zoomto(30,10):x(SCREEN_CENTER_X-36):y(SCREEN_CENTER_Y-66):rotationy(-20):zwrite(true):z(1):blend("BlendMode_NoEffect"):croptop(0.34)
			end
		}
	},

	Def.ActorProxy{
		BeginCommand=function(self)
			local banner = SCREENMAN:GetTopScreen():GetChild('MusicWheel')
			self:SetTarget(banner)
		end
	},

	LoadActor( THEME:GetPathG('ScreenSelectMusic','banner frame' ) )..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X-320+444):y(SCREEN_CENTER_Y-240+222)
		end
	},

	Def.ActorFrame{
		OnCommand=function(self) self:xy(35,38) end,

		Def.BitmapText{
			Font=_eurostileColorPick(),
			Text=GAMESTATE:IsCourseMode() and THEME:GetString("ScreenSelectMusicCourse","HeaderText") or Screen.String("HeaderText"),
			InitCommand=function(self)
				self:shadowlength(4):x(self:GetWidth()/2):skewx( ThemePrefs.Get("ITG1") and 0 or -0.16)
			end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
			end,
			OffCommand=function(self) self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end,
			CancelMessageCommand=function(self) if GAMESTATE:Env()["WorkoutMode"] then self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end end
		},

		Def.Sprite{
			Texture=THEME:GetPathG("ScreenWithMenuElements Items/stage",""..StageIndexBySegment()),
			Condition=not GAMESTATE:IsCourseMode() and not ThemePrefs.Get("ITG1"),
			OnCommand=function(self)
				self:xy(40,34):addx(-SCREEN_WIDTH):sleep(0.2):decelerate(0.6):addx(SCREEN_WIDTH)
			end,
			OffCommand=function(self) self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end,
			CancelMessageCommand=function(self) if GAMESTATE:Env()["WorkoutMode"] then self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end end
		},

		LoadActor( THEME:GetPathG("ScreenWithMenuElements","Items/ITG1") )..{
			Condition=not GAMESTATE:IsCourseMode() and ThemePrefs.Get("ITG1"),
			OnCommand=function(self)
				self:x(SCREEN_RIGHT-140):addx(SCREEN_WIDTH):sleep(0.2):decelerate(0.6):addx(-SCREEN_WIDTH)
			end,
			OffCommand=function(self) self:accelerate(.5):addx(SCREEN_WIDTH) end,
			CancelMessageCommand=function(self) if GAMESTATE:Env()["WorkoutMode"] then self:accelerate(.5):addx(SCREEN_WIDTH) end end
		}
	},

	Def.HelpDisplay {
		File="_eurostile normal",
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+203+itgstylemargin):zoom(0.75):diffuseblink()
		end,
		InitCommand=function(self)
			local s = THEME:GetString("ScreenSelectMusic","HelpTextNormal") .. "::" ..
				THEME:GetString("ScreenSelectMusic","DifficultyChangingAvailableHelpTextAppend") .. "::" ..
				THEME:GetString("ScreenSelectMusic","SelectButtonAvailableHelpTextAppend")
			if GAMESTATE:Env()["WorkoutMode"] then
				s = s .. "::"..THEME:GetString("ScreenSelectMusic","WorkoutHelpTextAppend")
			end
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated(s)
		end,
		SetHelpTextCommand=function(self, params)
			self:SetTipsColonSeparated( params.Text )
		end,
		SelectMenuOpenedMessageCommand=function(self)
			self:stoptweening():decelerate(0.2):zoomy(0)
		end,
		SelectMenuClosedMessageCommand=function(self)
			self:stoptweening():bouncebegin(0.2):zoomy(0.75)
		end,
		OffCommand=function(self) self:linear(0.5):zoomy(0) end,
		CancelMessageCommand=function(self)
			if GAMESTATE:Env()["WorkoutMode"] then
				self:linear(0.5):zoomy(0)
			end
		end
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:y( SCREEN_BOTTOM-17-18+itgstylemargin )
		end,
		SelectMenuOpenedMessageCommand=function(self)
			SOUND:PlayOnce( THEME:GetPathS("ScreenSelectMusic select","down") )
		end,

		Def.ActorFrame{
			OnCommand=function(self)
				if ModeMenuAvailable then self:x(SCREEN_CENTER_X-225) else self:x(SCREEN_CENTER_X-125) end
			end,

			Def.BitmapText{
				Font="Common Normal",
				Text="&MENULEFT;",
				OnCommand=function(self)
					self:x(-5):horizalign(right):zoomx(0.5):zoomy(0.7):diffusealpha(0)
				end,
				SelectMenuOpenedMessageCommand=function(self)
					self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7)
				end,
				SelectMenuClosedMessageCommand=function(self)
					self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5)
				end
			},

			Def.BitmapText{
				Font="Common Normal",
				Text="Easier",
				OnCommand=function(self)
					self:x(0):horizalign(left):zoomx(0.5):zoomy(0.7):diffusealpha(0):diffuseramp():effectperiod(1):effectoffset(0.20):effectclock("bgm"):effectcolor1(color("#FFFFFF")):effectcolor2(color("#20D020"))
				end,
				SelectMenuOpenedMessageCommand=function(self)
					self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7)
				end,
				SelectMenuClosedMessageCommand=function(self)
					self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5)
				end
			}
		},

		Def.ActorFrame{
			OnCommand=function(self)
				local xpos = ModeMenuAvailable and 225 or 125
				self:x( SCREEN_CENTER_X + xpos )
			end,
			Def.BitmapText{
				Font="Common Normal",
				Text="&MENURIGHT;",
				OnCommand=function(self)
					self:x(15):zoomx(0.5):zoomy(0.7):diffusealpha(0)
				end,
				SelectMenuOpenedMessageCommand=function(self)
					self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7)
				end,
				SelectMenuClosedMessageCommand=function(self)
					self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5)
				end
			},
	
			Def.BitmapText{
				Font="Common Normal",
				Text="Harder",
				OnCommand=function(self)
					self:horizalign(right):zoomx(0.5):zoomy(0.7):diffusealpha(0):diffuseramp():effectperiod(1):effectoffset(0.20):effectclock("bgm"):effectcolor1(color("#FFFFFF")):effectcolor2(color("#E06060"))
				end,
				SelectMenuOpenedMessageCommand=function(self)
					self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7)
				end,
				SelectMenuClosedMessageCommand=function(self)
					self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5)
				end
			}
		},

		Def.BitmapText{
			Condition=ModeMenuAvailable,
			Font="Common Normal",
			Text="&START; Change Sort",
			OnCommand=function(self)
				self:x(SCREEN_CENTER_X):zoomx(0.5):zoomy(0.7):diffusealpha(0)
			end,
			SelectMenuOpenedMessageCommand=function(self)
				self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7)
			end,
			SelectMenuClosedMessageCommand=function(self)
				self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5)
			end,
			ShowPressStartForOptionsCommand=function(self)
				SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start") or THEME:GetPathS("_ITGCommon","start") )
			end,
			ShowEnteringOptionsCommand=function(self)
				SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start") or THEME:GetPathS("_ITGCommon","start") )
			end
		}
	},

	Def.Sprite{
		Condition=not ThemePrefs.Get("ITG1"),
		Texture=THEME:GetPathG("ScreenSelectMusic","Options Message"),
		InitCommand=function(self)
			self:Center():pause():diffusealpha(0)
		end,
		ShowPressStartForOptionsCommand=function(self)
			self:diffusealpha(1):faderight(.3):fadeleft(.3):cropleft(-0.3):cropright(1.3):linear(0.3):cropright(-0.3):sleep(1.2):linear(0.3):cropleft(1.3)
		end,
		ShowEnteringOptionsCommand=function(self)
			self:stoptweening():setstate(1):sleep(0.6):linear(0.3):cropleft(1.3)
		end,
		HidePressStartForOptionsCommandCommand=function(self)
			self:linear(0.3):cropleft(1.3)
		end,
	},

	Def.ActorFrame{
		InitCommand=function(self)
			self:Center():diffusealpha(0):zoom(0.9)
		end,
		ShowPressStartForOptionsCommand=function(self)
			self:diffusealpha(1):zoomx(0.1):zoomy(3):bounceend(0.3):zoom(0.9)
		end,
		Def.BitmapText{
			Condition=ThemePrefs.Get("ITG1"),
			Font="_big blue glow",
			Text=THEME:GetString("ScreenSelectMusic","OptionsMessage"),
			ShowPressStartForOptionsCommand=function(self)
				self:sleep(1.5):linear(0.3):cropleft(1.3)
			end,
			ShowEnteringOptionsCommand=function(self)
				self:settext( THEME:GetString("ScreenSelectMusic","EnteringOptions") )
				self:stoptweening():sleep(0.6):linear(0.3):cropleft(1.3)
			end,
			HidePressStartForOptionsCommandCommand=function(self)
				self:linear(0.3):cropleft(1.3)
			end
		}
	}
}

for player in ivalues(PlayerNumber) do
	t[#t+1] = LoadActor( THEME:GetPathG('ScreenSelectMusic','PaneDisplay'), player )..{
		Condition=GAMESTATE:IsHumanPlayer(player),
		OnCommand=function(self)
			self:x( GAMESTATE:GetCurrentStyle():GetStyleType() == "StyleType_OnePlayerTwoSides" and SCREEN_CENTER_X or (player == PLAYER_1 and SCREEN_CENTER_X-155 or SCREEN_CENTER_X+155) )
			:y(SCREEN_BOTTOM-95):zoomy(0):sleep(0.5):linear(0.3):zoomy(1)
		end,
		OffCommand=function(self) self:linear(0.3):zoomy(0) end,
		CancelMessageCommand=function(self) if GAMESTATE:Env()["WorkoutMode"] then self:linear(0.3):zoomy(0) end end
	}
end

return t