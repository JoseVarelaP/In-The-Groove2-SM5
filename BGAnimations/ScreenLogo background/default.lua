local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame{
	Condition=not ThemePrefs.Get("ITG1"),
	Def.Sprite{
		Texture="978_JumpBack.mpg",
		OnCommand=function(self)
			self:rate(2):diffusealpha(0.7):stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
			PROFILEMAN:GetMachineProfile():SetLastUsedHighScoreName(""):SetDisplayName("")
		end;
	},

	Def.Sprite{
		Texture="roxor",
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+90,SCREEN_TOP+30):diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1)
		end;
	},

		Def.ActorFrame{
			OnCommand=function(self)
				self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+10)
			end;

				Def.Sprite{
					Texture="2",
					OnCommand=function(self)
						self:xy(190,10):zoomx(0):glow(1,1,1,1):sleep(0.8):zoomy(3):bounceend(.3):zoom(1):glow(1,1,1,0)
					end;
				},
				Def.Sprite{
					Texture="in",
					OnCommand=function(self)
						self:xy(-240,-70):zoom(0):sleep(0.1):bounceend(0.4):zoom(1)
					end;
				},
				Def.Sprite{
					Texture="the",
					OnCommand=function(self)
						self:xy(-106,-70):zoom(0):sleep(0.1):bounceend(0.4):zoom(1)
					end;
				},
				Def.Sprite{
					Texture="groove",
					OnCommand=function(self)
						self:xy(-50,26):zoom(0):sleep(0.1):bounceend(0.4):zoom(1)
					end;
				},
				Def.Sprite{
					Texture="trademark",
					OnCommand=function(self)
						self:xy(176,-24):diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):diffuse(color("#000000"))
					end;
				},
		},

	Def.BitmapText{
	Font="_eurostile normal",
	Condition="SelectButtonAvailable()",
	Text="&xa9; 2005 Andamiro Co., Ltd.",
	OnCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-31):zoom(0.5):shadowlength(2):diffusealpha(0.8)
	end;
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Condition="SelectButtonAvailable()",
	Text="&xa9; 2005 Roxor Games, Inc.",
	OnCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-17):zoom(0.5):shadowlength(2):diffusealpha(0.8)
	end;
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Condition="SelectButtonAvailable()",
	Text="r5",
	OnCommand=function(self)
		self:xy(SCREEN_CENTER_X+94,SCREEN_BOTTOM-17):zoom(0.5):shadowlength(2):horizalign(left):diffusealpha(0.8)
	end;
	},

	Def.Quad{
	OnCommand=function(self)
		self:stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffuse(color("#FFFFFF")):diffusealpha(0):sleep(0.1):accelerate(0.5):diffusealpha(1):sleep(0.2):decelerate(0.5):diffusealpha(0)
	end
	}

}

t[#t+1] = LoadActor("ITG1")..{Condition=ThemePrefs.Get("ITG1")};

return t;