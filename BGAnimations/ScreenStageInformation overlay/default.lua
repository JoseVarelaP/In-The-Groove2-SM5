return Def.ActorFrame{
	LoadActor("../ScreenWithMenuElements underlay"),
	
	Def.Quad{
	InitCommand=function(self)
		self:diffuse(0,0,0,1)
	end;
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):FullScreen():diffusealpha(0):accelerate(0.5):diffusealpha(1):sleep(2)
	end;
	},

		Def.ActorFrame{
		Condition=not GAMESTATE:IsCourseMode();

			LoadActor("../ScreenGameplay in/ScreenGameplay stage ".. ToEnumShortString(GAMESTATE:GetCurrentStage()) )..{
				OnCommand=function(self)
					self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):cropright(1.3):linear(1):cropright(-0.3)
				end;
			},

			LoadActor("_white ScreenGameplay stage ".. ToEnumShortString(GAMESTATE:GetCurrentStage()) )..{
				OnCommand=function(self)
					self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoom(1.05):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(1):cropleft(1):cropright(-0.3)
				end;
			},

			LoadActor("../_song credit display")..{
				OnCommand=function(self)
					self:diffusealpha(0):linear(0.3):diffusealpha(1)
				end;
			},

		},

		Def.ActorFrame{
			Condition=GAMESTATE:IsCourseMode();
			
			LoadActor("../ScreenGameplay in/ScreenGameplay course song 1")..{
				OnCommand=function(self)
					self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):cropright(1.3):linear(1):cropright(-0.3)
				end;
			},

			LoadActor("_white ScreenGameplay course song 1")..{
				OnCommand=function(self)
					self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoom(1.05):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(1):cropleft(1):cropright(-0.3)
				end;
			},

		},
}
