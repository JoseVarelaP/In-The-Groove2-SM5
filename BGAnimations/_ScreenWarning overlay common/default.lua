local style = ThemePrefs.Get("ITG1") and "ITG1/" or ""
return Def.ActorFrame{
	LoadActor(ThemePrefs.Get("ITG1") and "ITG1/streak" or "../_red streak")..{
		OnCommand=function(self)
			self:zoom(0.5):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-80):fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):linear(1):cropleft(-0.3):zoom(2.5):linear(9):zoom(1.2)
		end;
		OffCommand=function(self)
			self:stoptweening():linear(0.5):cropright(1.3):zoom(0.5)
		end;
	},

	LoadActor(style.."extreme motions")..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-80):addx(SCREEN_WIDTH*1.5):zoom(0.90):diffusealpha(0):sleep(2.0):decelerate(0.5):x(SCREEN_CENTER_X+40):diffusealpha(1):linear(3):zoom(0.8):linear(0.25):diffusealpha(0)
		end;
		OffCommand=function(self)
			self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5)
		end;
	},

	LoadActor(style.."be careful")..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+40):y(SCREEN_CENTER_Y-80):zoom(0.9):diffusealpha(0):sleep(5.50):linear(0.25):diffusealpha(1):linear(3.25):zoom(0.8):accelerate(0.5):addx(-SCREEN_WIDTH)
		end;
		OffCommand=function(self)
			self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5)
		end;
	},

	LoadActor(style.."exclamation normal")..{
		OnCommand=function(self)
			self:glow(1,1,1,1):x(SCREEN_WIDTH + 100):y(SCREEN_CENTER_Y-80):sleep(1.0):decelerate(0.5):x(SCREEN_CENTER_X+(80-320)):glowshift():effectclock("bgm"):effectoffset(1):effectperiod(2):sleep(7.5):accelerate(0.5):addx(-SCREEN_WIDTH)
		end;
		OffCommand=function(self)
			self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5)
		end;
	},

	LoadActor("exclamation pulse")..{
		OnCommand=function(self)
			self:diffusealpha(0):x(SCREEN_CENTER_X-240):y(SCREEN_CENTER_Y-80):sleep(1.5):diffusealpha(1):linear(0.8):zoomx(3):zoomy(2):diffusealpha(0)
		end;
		OffCommand=function(self)
			self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5)
		end;
	},
}
