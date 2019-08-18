return Def.ActorFrame{
	LoadActor( "ScreenWithMenuElements underlay" )..{
		OnCommand=function(s)
			s:diffusealpha(0):linear(0.5):diffusealpha(1)
		end;
		OffCommand=function(s)
			s:linear(0.5):diffusealpha(0)
		end;
		CancelMessageCommand=function(s)
			s:linear(0.5):diffusealpha(0)
		end
	};

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
	CancelMessageCommand=function(self)
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
	CancelMessageCommand=function(self)
		self:accelerate(0.3):addx(SCREEN_WIDTH)
	end;
	},
}