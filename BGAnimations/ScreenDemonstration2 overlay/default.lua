return Def.ActorFrame{
	LoadActor("../ScreenGameplay overlay/demonstration gradient")..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT):diffusealpha(0.8)
		end;
	},

	Def.BitmapText{
	Font="_tutorial",
	Text="Color Arrows\nscroll from\nlow to high.",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):y(SCREEN_CENTER_Y):addx(SCREEN_WIDTH/2):zoom(0.8):sleep(5):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0)
	end;
	},

	LoadActor("focus square")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4.2):y(SCREEN_CENTER_Y+60):zoomx(1.0):zoomy(1.05):diffuseblink():effectperiod(0.5):diffusealpha(0):sleep(6):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
	end;
	},

	Def.BitmapText{
	Font="_tutorial",
	Text="Step when a\nColor Arrow\noverlaps the\nTarget Arrows\nat the top.",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):y(SCREEN_CENTER_Y):addx(SCREEN_WIDTH/2):zoom(0.8):sleep(11):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0)
	end;
	},

	LoadActor("focus rect")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4.2):y(SCREEN_CENTER_Y-124):zoomx(1.0):zoomy(0.8):diffuseblink():effectperiod(0.5):diffusealpha(0):sleep(12):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
	end;
	},

	Def.BitmapText{
	Font="_tutorial",
	Text="The\nTraffic Light\nhelps you\nunderstand\nthe timing.",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):y(SCREEN_CENTER_Y):addx(SCREEN_WIDTH/2):zoom(0.8):sleep(17):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0)
	end;
	},

	LoadActor("focus rect")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-30):zoomx(1.0):zoomy(1):rotationz(90):diffuseblink():effectperiod(0.5):diffusealpha(0):sleep(18):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
	end;
	},

	Def.BitmapText{
	Font="_tutorial",
	Text="The direction\nof the arrow\nsays which\nPanel\nto step on.",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):y(SCREEN_CENTER_Y):addx(SCREEN_WIDTH/2):zoom(0.8):sleep(23):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0)
	end;
	},

	Def.BitmapText{
	Font="_tutorial",
	Text="For arrows\nfacing Left,\nstep on the\nLeft Panel.\n\n\n\n",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):y(SCREEN_CENTER_Y):addx(SCREEN_WIDTH/2):zoom(0.8):sleep(29):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0)
	end;
	},

	LoadActor("arrow")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4-60):y(SCREEN_CENTER_Y+80):rotationz(0):glowblink():effectperiod(0.5):diffusealpha(0):sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
	end;
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+210):y(SCREEN_CENTER_Y+80):zoom(0.8):rotationx(-20):fov(45)
		end;
		LoadActor("../ScreenGameplay underlay/platform")..{
		OnCommand=function(self)
			self:y(7):diffuse(0.6,0.6,0.6,0.8):diffusealpha(0):sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
		end;
		},

		LoadActor("../ScreenGameplay underlay/panelglow")..{
		OnCommand=function(self)
			self:x(-45):blend("BlendMode_Add"):diffuseblink():effectperiod(0.5):diffusealpha(0):sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
		end;
		},
	},

	Def.BitmapText{
	Font="_tutorial",
	Text="For arrows\nfacing Up,\nstep on the\nUp Panel.\n\n\n\n",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):y(SCREEN_CENTER_Y):addx(SCREEN_WIDTH/2):zoom(0.8):sleep(35):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0)
	end;
	},

	LoadActor("arrow")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4-60):y(SCREEN_CENTER_Y+80):rotationz(90):glowblink():effectperiod(0.5):diffusealpha(0):sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
	end;
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+210):y(SCREEN_CENTER_Y+80):zoom(0.8):rotationx(-20):fov(45)
		end;
		LoadActor("../ScreenGameplay underlay/platform")..{
		OnCommand=function(self)
			self:y(7):diffuse(0.6,0.6,0.6,0.8):diffusealpha(0):sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
		end;
		},

		LoadActor("../ScreenGameplay underlay/panelglow")..{
		OnCommand=function(self)
			self:y(-45):blend("BlendMode_Add"):diffuseblink():effectperiod(0.5):diffusealpha(0):sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
		end;
		},
	},

	Def.Quad{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT):diffuse(0,0,0,1):sleep(3.5):linear(0.5):diffusealpha(0)
	end;
	},

	LoadActor("instructions")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):cropright(1.3):linear(1):cropright(-0.3):sleep(2):decelerate(0.5):zoom(0.7):y(SCREEN_TOP+40)
	end;
	},

	LoadActor("white instructions")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoom(1.05):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(1):cropleft(1):cropright(-0.3)
	end;
	},

	LoadActor("../ScreenAttract overlay"),

}