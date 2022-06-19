local frame = ThemePrefs.Get("ITG1") and "_options" or "options"
return Def.ActorFrame{
	LoadActor( "ScreenWithMenuElements underlay" ),

	LoadActor( THEME:GetPathG("","_options system page") )..{
		InitCommand=function(self)
			self:Center():addy(18)
		end,
		OnCommand=function(self)
			self:x(-SCREEN_WIDTH):decelerate(0.3):x(SCREEN_CENTER_X)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end,
		CancelMessageCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end
	},

	LoadActor("ScreenOptions overlay/".. frame .." frame")..{
		InitCommand=function(self)
			self:Center():addy(18)
		end,
		OnCommand=function(self)
			self:x(-SCREEN_WIDTH):decelerate(0.3):x(SCREEN_CENTER_X)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end,
		CancelMessageCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end
	}
}