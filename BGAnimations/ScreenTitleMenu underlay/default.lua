local style = ThemePrefs.Get("ITG1") and "_flare" or "flare"
return Def.ActorFrame{
	LoadActor("../ScreenLogo background"),


	Def.Sprite{
		Texture="frame",
		 OnCommand=function(self)
			self:Center():zoomtowidth(SCREEN_WIDTH):faderight(0.1):fadeleft(0.1):cropright(1.1):cropleft(-0.1):linear(1):cropright(-0.1)
			GAMESTATE:Env()["WorkoutMode"] = nil
		end;
		CodeMessageCommand=function(s,param)
			Unlock( param.Name )
		end;
	},
	
	Def.Sprite{
		Texture=style,
		 OnCommand=function(self)
			self:xy(SCREEN_LEFT-64,SCREEN_CENTER_Y-165):rotationz(0):linear(1):x(SCREEN_RIGHT+64):rotationz(360)
		end
	},
	
	Def.Sprite{
		Texture=style,
		 OnCommand=function(self)
			self:xy(SCREEN_LEFT-64,SCREEN_CENTER_Y+165):rotationz(0):linear(1):x(SCREEN_RIGHT+64):rotationz(360)
		end
	},

	Def.BitmapText{
		Condition=PREFSMAN:GetPreference("UseUnlockSystem"),
		Font="Common Normal",
		OnCommand=function(s)
			local unlocked = 0
			for i=1,15 do
				local Code = UNLOCKMAN:GetUnlockEntry( i-1 )
				if Code and not Code:IsLocked() then
					unlocked = unlocked + 1
				end
			end

			s:settext( string.format( THEME:GetString("ScreenUnlock","%d/%d unlocked"), unlocked, 15 ) )
			:halign(1):xy(SCREEN_RIGHT-30,SCREEN_CENTER_Y+130):zoom(0.6):diffusealpha(0.5)
		end;
	};

	Def.HelpDisplay {
		File="_eurostile normal",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+203):zoom(0.7):diffuseblink():maxwidth(SCREEN_WIDTH/0.8)
		end;
		InitCommand=function(self)
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated( THEME:GetString("ScreenTitleMenu","HelpText") );
			for i=1,15 do
				if PREFSMAN:GetPreference("UseUnlockSystem") then
					local Code = UNLOCKMAN:GetUnlockEntry( i-1 )
					if Code and Code:IsLocked() then
						UNLOCKMAN:LockEntryID( tostring(i) )
					end
				end
			end
		end;
		OffCommand=function(self)
			self:linear(0.5):zoomy(0)
			SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
		end;
	},

	LoadActor("../ScreenWithMenuElements underlay"),
	LoadActor("PercentComplete","StepsType_Dance_Single")..{ OnCommand=function(self) self:xy(SCREEN_RIGHT-90,SCREEN_TOP+30):zoom(0.9) end; };
	LoadActor("PercentComplete","StepsType_Dance_Double")..{ OnCommand=function(self) self:xy(SCREEN_RIGHT-90,SCREEN_TOP+50):zoom(0.9) end; };
}