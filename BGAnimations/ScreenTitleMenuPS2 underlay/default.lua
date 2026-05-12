local style = IsITG1Mode() and "_flare" or "flare"
local num = IsITG1Mode() and "" or " 2"
local isDedicab = ThemePrefs.Get("DedicabToggle") or false
local enteredMenu = false

local function WaitForStartButton(event)
	if event.GameButton == "Start" then
		enteredMenu = true
		MESSAGEMAN:Broadcast("EnteredMenu")
		for pn in ivalues(PlayerNumber) do
			SCREENMAN:set_input_redirected(pn, false)
		end
	end
end

return Def.ActorFrame{
	OnCommand=function(self)
		for pn in ivalues(PlayerNumber) do
			SCREENMAN:set_input_redirected(pn, true)
		end
		SCREENMAN:GetTopScreen():AddInputCallback(WaitForStartButton)
	end,
	CancelCommand=function(self)
		for pn in ivalues(PlayerNumber) do
			SCREENMAN:set_input_redirected(pn, false)
		end
	end,
	EnteredMenuMessageCommand=function(self)
		self:GetChild("Enter"):play()
		SCREENMAN:GetTopScreen():RemoveInputCallback(WaitForStartButton)
	end,
	CodeMessageCommand=function(self,param)
		if not enteredMenu then return end
		if param.Name == "GoodEnding" and not GAMESTATE:Env()['ForceGoodEnding'] then
			GAMESTATE:Env()['ForceGoodEnding'] = "1"
			SOUND:PlayOnce( THEME:GetPathS("ScreenTitleMenu","ForceGoodEnding") )
		end
	end,
	-- LoadActor("../ScreenLogo background"),

	Def.Sound{
		Name="Enter",
		File=THEME:GetPathS("","PS2-Next")
	},

	Def.Sprite{
		Texture=THEME:GetPathB("ScreenLogo","background/978_JumpBack.mpg"),
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
		end;
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+10)
		end;
		EnteredMenuMessageCommand=function(self)
			self:decelerate(0.5):addx(-SCREEN_WIDTH)
		end,

		Def.Sprite{
			Texture=THEME:GetPathB("ScreenLogo","background/2"),
			OnCommand=function(self)
				self:xy(190,10):zoomx(0):glow(1,1,1,1):sleep(0.8):zoomy(3):bounceend(.3):zoom(1):glow(1,1,1,0)
			end;
		},
		Def.Sprite{
			Texture=THEME:GetPathB("ScreenLogo","background/in"),
			OnCommand=function(self)
				self:xy(-240,-70):zoom(0):sleep(0.1):bounceend(0.4):zoom(1)
			end;
		},
		Def.Sprite{
			Texture=THEME:GetPathB("ScreenLogo","background/the"),
			OnCommand=function(self)
				self:xy(-106,-70):zoom(0):sleep(0.1):bounceend(0.4):zoom(1)
			end;
		},
		Def.Sprite{
			Texture=THEME:GetPathB("ScreenLogo","background/groove"),
			OnCommand=function(self)
				self:xy(-50,26):zoom(0):sleep(0.1):bounceend(0.4):zoom(1)
			end;
		},
		Def.Sprite{
			Texture=THEME:GetPathB("ScreenLogo","background/trademark"),
			OnCommand=function(self)
				self:xy(176,-24):diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):diffuse(color("#000000"))
			end;
		},

		Def.BitmapText{
			Font="_eurostile outline",
			Text="???",
			OnCommand=function(self)
				self:y(160):shadowlength(2):diffusealpha(0):sleep(1):queuecommand("PressStart")
			end,
			PressStartCommand=function(self)
				self:settext('PRESS &START;')
				:diffusealpha(1)
				:diffuseblink()
				:effectcolor1(1,1,1,0)
				:effectcolor2(1,1,1,1)
			end,
		},
	},

	Def.ActorFrame{
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y)
		end,
		OnCommand=function(self)
			self:addx(SCREEN_WIDTH)
		end,
		EnteredMenuMessageCommand=function(self)
			self:decelerate(0.5):addx(-SCREEN_WIDTH)
		end,

		Def.Sprite{
			Texture="middle",
			OnCommand=function(self)
				self:zoomx(1.1):zoomy(1.01):diffusealpha(0):linear(0.9):diffusealpha(1)
			end
		},

		Def.Sprite{
			Texture="streak_diffuse",
			OnCommand=function(self)
				self:y(101):zoomto(200,64):diffuse(color("#FFCC00")):fadeleft(0.3):faderight(0.3)
			end
		},

		Def.Sprite{
			Texture="streak_add",
			OnCommand=function(self)
				self:y(101):zoomto(200,64):fadeleft(0.3):faderight(0.3)
			end
		}
	},

	Def.BitmapText{
		Condition=PREFSMAN:GetPreference("UseUnlockSystem"),
		Font="Common Normal",
		OnCommand=function(self)
			local unlocked = 0
			for i=1,UNLOCKMAN:GetNumUnlocks() do
				local Code = UNLOCKMAN:GetUnlockEntry( i-1 )
				if Code and not Code:IsLocked() then
					unlocked = unlocked + 1
				end
			end

			self:settext( string.format( THEME:GetString("ScreenUnlock","%d/%d unlocked"), unlocked, UNLOCKMAN:GetNumUnlocks() ) )
			:halign(1):xy(SCREEN_RIGHT-30,SCREEN_CENTER_Y+106):zoom(0.6):diffusealpha(0.5)
			:addx(SCREEN_WIDTH)

			-- There can be a special case where a user changes to the theme, while the unlock preference is on.
			-- Because of how UNLOCKMAN is initialized only on startup, it can only perform the locks if the theme is
			-- part of the loading process at startup. For this, we need to inform the user that they need to restart.
			if UNLOCKMAN:GetNumUnlocks() == 0 then
				self:settext("Please restart your game for unlocks to work!")
				:wrapwidthpixels(400)
			end
		end;
		EnteredMenuMessageCommand=function(self)
			self:decelerate(0.5):addx(-SCREEN_WIDTH)
		end,
	};
	
	LoadActor("../ScreenWithMenuElements underlay")..{
		OnCommand=function(self)
			-- self:hibernate(10000)
		end,
		EnteredMenuMessageCommand=function(self)
			self:finishtweening()
			self:playcommand("DoOn"):playcommand("DoLarge")
		end
	},

	Def.HelpDisplay {
		File="_eurostile normal",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+200):y(SCREEN_CENTER_Y+180):zoom(0.7):diffuseblink():maxwidth(SCREEN_WIDTH/0.8)
			:diffusealpha(0)
		end;
		InitCommand=function(self)
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated( THEME:GetString("ScreenTitleMenu","HelpText") );
			for i=1,UNLOCKMAN:GetNumUnlocks() do
				if PREFSMAN:GetPreference("UseUnlockSystem") then
					local Code = UNLOCKMAN:GetUnlockEntry( i-1 )
					if Code and Code:IsLocked() then
						UNLOCKMAN:LockEntryID( tostring(i) )
					end
				end
			end
		end;
		EnteredMenuMessageCommand=function(self)
			self:sleep(0.5):diffusealpha(1)
		end,
		OffCommand=function(self)
			self:linear(0.5):zoomy(0)
			SOUND:PlayOnce( IsITG1Mode() and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
		end;
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end;
		Def.BitmapText{
			Font=_eurostileColorPick(),
			Text="MAIN MENU",
			InitCommand=function(self) self:shadowlength(2); self:x(self:GetWidth()/2) self:skewx( IsITG1Mode() and 0 or -0.16):zoomx(0) end,
			EnteredMenuMessageCommand=function(self)
				self:zoomx(0):zoomy(6):bounceend(.3):zoomy(1.3):zoomx(0.8)
			end,
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end,
		},
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_RIGHT-90,SCREEN_CENTER_Y+130):zoom(0.9)
			:addx(SCREEN_WIDTH)
		end;
		EnteredMenuMessageCommand=function(self)
			self:decelerate(0.5):addx(-SCREEN_WIDTH)
		end,
		LoadActor("../_frame 3x1", {"product bar",120})..{
			OnCommand=function(s)
				s:diffuse(color("#3DA1FF"))
				if SONGMAN:DoesSongGroupExist("In The Groove 2") then
					s:diffuse( color("#FE2424") )
				end
			end;
		};
		Def.BitmapText{ Font="_eurostile normal", Text=THEME:GetString("Product","Base") .. num;
			OnCommand=function(s)
				s:zoom(0.6):y(-2):shadowlength(2):maxwidth(200)
				if SONGMAN:DoesSongGroupExist("In The Groove 2") then
					s:settext( THEME:GetString("Product","PackA") )
				end
			end;
		};
	};
}