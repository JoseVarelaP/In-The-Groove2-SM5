local t = Def.ActorFrame{}
	
if not GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame{
		Def.Sprite{
		Texture=THEME:GetPathG( "StageAndCourses/ScreenGameplay","stage ".. ToEnumShortString(GAMESTATE:GetCurrentStage()) ),
		OnCommand=function(self)
			if GAMESTATE:GetCurrentStage() == "Stage_Final" then
				self:Load( THEME:GetPathB("StageAndCourses/ScreenGameplay stage","final") )
			end
			self:Center():draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.25):y(SCREEN_BOTTOM-40)
		end;
		OffCommand=function(self)
			self:accelerate(0.8):addy(150)
		end;
		},
};
end

return t;
