return Def.ActorFrame{
	
	Def.ActorFrame{
	Condition=not GAMESTATE:IsCourseMode();
		LoadActor("ScreenGameplay stage ".. ToEnumShortString(GAMESTATE:GetCurrentStage()) )..{
		OnCommand=function(self)
			self:Center():draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.25):y(SCREEN_BOTTOM-40)
		end;
		OffCommand=function(self)
			self:accelerate(0.8):addy(150)
		end;
		},
	},

	Def.ActorFrame{
	Condition=GAMESTATE:IsCourseMode();
		LoadActor("CourseStages 1x5")..{
		OnCommand=function(self)
			self:Center():animate(0):draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.25):y(SCREEN_BOTTOM-40)
		end;
		OffCommand=function(self)
			self:accelerate(0.8):addy(150)
		end;
		CurrentSongChangedMessageCommand=function(self)
			self:setstate( GAMESTATE:GetCourseSongIndex() )
			self:linear(0.3)
			self:Center()
			self:zoom(1)
		end,
		},
	},

}
