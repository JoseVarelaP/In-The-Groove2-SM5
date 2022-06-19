return Def.ActorFrame{

	LoadModule("HeaderText.lua")(Var "LoadingScreen"),

	Def.HelpDisplay {
		File="_eurostile normal",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+203):zoom(0.7):diffuseblink():zoomy(0):sleep(0.3):linear(0.5):zoomy(0.7)
		end,
		InitCommand=function(self)
			local s = THEME:GetString("ScreenOptionsServiceChild","HelpText")
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated(s)
		end,
		OffCommand=function(self)
			self:linear(0.5):zoomy(0)
			SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
		end,
		CancelMessageCommand=function(self)
			self:linear(0.5):zoomy(0)
		end
	}
}