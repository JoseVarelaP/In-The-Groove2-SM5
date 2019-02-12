return Def.ActorFrame{
	LoadActor( "ScreenWithMenuElements underlay" ),

	LoadActor( THEME:GetPathG("","_options system page") )..{
	InitCommand=function(self)
		self:Center():addy(18)
	end;
	OnCommand=function(self)
		self:x(-SCREEN_WIDTH):decelerate(0.3):x(SCREEN_CENTER_X)
	end;
	OffCommand=function(self)
		self:accelerate(0.3):addx(SCREEN_WIDTH)
	end;
	},

	LoadActor("ScreenOptions overlay/ScreenOptions frame")..{
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):addy(18)
	end;
	OnCommand=function(self)
		self:x(-SCREEN_WIDTH):decelerate(0.3):x(SCREEN_CENTER_X)
	end;
	OffCommand=function(self)
		self:accelerate(0.3):addx(SCREEN_WIDTH)
	end;
	},
}