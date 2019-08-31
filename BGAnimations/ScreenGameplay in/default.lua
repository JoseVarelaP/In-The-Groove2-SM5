local t = Def.ActorFrame{}
	
if not GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame{
		Def.Sprite{
		Condition=not ThemePrefs.Get("ITG1"),
		Texture=THEME:GetPathG( "StageAndCourses/ScreenGameplay","stage ".. ToEnumShortString(GAMESTATE:GetCurrentStage()) ),
		OnCommand=function(self)
			if GAMESTATE:GetCurrentStage() == "Stage_Final" then
				self:Load( THEME:GetPathG("StageAndCourses/ScreenGameplay stage","final") )
			end
			self:Center():draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.25):y(SCREEN_BOTTOM-40)
		end;
		OffCommand=function(self)
			self:accelerate(0.8):addy(150)
		end;
		},

		LoadActor( THEME:GetPathB("","_frame 3x1"), {"name entry",100} )..{
			Condition=ThemePrefs.Get("ITG1") and not GAMESTATE:IsDemonstration();
			OnCommand=function(self)
				self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-40):addy(300):sleep(1.2):decelerate(0.3):addy(-300)
			end;
		};
		LoadActor( THEME:GetPathG( "","StageAndCourses/ITG1" ) )..{
			Condition=ThemePrefs.Get("ITG1") and not GAMESTATE:IsDemonstration(),
			OnCommand=function(self)
				self:Center():draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.22):y(SCREEN_BOTTOM-40)
			end;
		};
};
end

return t;
