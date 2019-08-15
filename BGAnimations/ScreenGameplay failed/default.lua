return Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self)
			self:FullScreen():diffuse(Color.Black):diffusealpha(0):linear(1.5):diffusealpha(1)
		end;
	},

	Def.Sound{
		File="bleh",
		StartTransitioningCommand=function(self)
			self:play()
		end;
	},

	Def.Sprite{
		Texture="pandemonium skull";
		Condition=GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/Pandemonium');
		OnCommand=function(self)
			self:Center():zoom(3.6):rotationz(-30):diffusealpha(0):sleep(3):linear(1):diffusealpha(1):zoom(3.2):linear(2):zoom(2.4):linear(1):diffusealpha(0):zoom(2)
		end;
	},

	Def.Sprite{
		Texture="../_red streak";
		OnCommand=function(self)
			self:Center()
			:zoom(3.2):rotationz(-30):fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):linear(1):cropleft(-0.3):zoom(2.8):linear(2):zoom(2.0):linear(1):cropright(1.3):zoom(1.6)
		end;
	},

	Def.Sprite{
		Texture="life";
		OnCommand=function(self)
			self:rotationz(-30):x(SCREEN_CENTER_X-42):y(SCREEN_CENTER_Y-32):addx(SCREEN_WIDTH*1.3):addy(-SCREEN_HEIGHT):decelerate(0.5):addx(-SCREEN_WIDTH*1.3):addy(SCREEN_HEIGHT):sleep(2):accelerate(0.5):addx(-SCREEN_WIDTH*1.3):addy(SCREEN_HEIGHT)
		end;
	},
	Def.Sprite{
		Texture="depleted";
		OnCommand=function(self)
			self:rotationz(-30):x(SCREEN_CENTER_X+42):y(SCREEN_CENTER_Y+32):addx(-SCREEN_WIDTH*1.3):addy(SCREEN_HEIGHT):decelerate(0.5):addx(SCREEN_WIDTH*1.3):addy(-SCREEN_HEIGHT):sleep(2):accelerate(0.5):addx(SCREEN_WIDTH*1.3):addy(-SCREEN_HEIGHT)
		end;
	},
	Def.Sprite{
		Texture="../_blue streak";
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoom(3.6):rotationz(-30):fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):sleep(2.5):linear(1):cropleft(-0.3):zoom(3.2):linear(3):zoom(2.0):linear(1):cropright(1.3):zoom(1.6)
		end;
	},
	Def.Sprite{
		Texture="round";
		OnCommand=function(self)
			self:rotationz(-30):x(SCREEN_CENTER_X-90):y(SCREEN_CENTER_Y):addx(SCREEN_WIDTH*1.3):addy(-SCREEN_HEIGHT):sleep(2.5):decelerate(0.5):addx(-SCREEN_WIDTH*1.3):addy(SCREEN_HEIGHT):sleep(3):accelerate(0.5):addx(-SCREEN_WIDTH*1.3):addy(SCREEN_HEIGHT)
		end;
	},
	Def.Sprite{
		Texture="failed";
		OnCommand=function(self)
			self:rotationz(-30):x(SCREEN_CENTER_X+100):y(SCREEN_CENTER_Y):addx(-SCREEN_WIDTH*1.3):addy(SCREEN_HEIGHT):sleep(2.5):decelerate(0.5):addx(SCREEN_WIDTH*1.3):addy(-SCREEN_HEIGHT):sleep(3):accelerate(0.5):addx(SCREEN_WIDTH*1.3):addy(-SCREEN_HEIGHT)
		end;
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:visible( GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 2/VerTex^2') )
			self:rotationz(-30):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):sleep(6):accelerate(0.5):addx(SCREEN_WIDTH*1.3):addy(-SCREEN_HEIGHT)
		end;
		Def.Sprite{
			Texture="2";
			OnCommand=function(self)
				self:x(290):y(10):zoomy(2):zoomx(0):diffusealpha(0):sleep(3.5):decelerate(1):accelerate(.2):diffusealpha(1):zoom(1)
			end;
		};
	};
}