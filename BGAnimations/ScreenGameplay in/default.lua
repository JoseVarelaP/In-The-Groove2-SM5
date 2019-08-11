local t = Def.ActorFrame{}
	
if not GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame{
		LoadActor("ScreenGameplay stage ".. ToEnumShortString(GAMESTATE:GetCurrentStage()) )..{
		OnCommand=function(self)
			if GAMESTATE:GetCurrentStage() == "Stage_Final" then
				self:Load( THEME:GetPathB("ScreenGameplay in/ScreenGameplay stage","final") )
			end
			self:Center():draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.25):y(SCREEN_BOTTOM-40)
		end;
		OffCommand=function(self)
			self:accelerate(0.8):addy(150)
		end;
		},
};
end

if GAMESTATE:IsCourseMode() then
local StageNum = 0
t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:Center():animate(0):draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.25):y(SCREEN_BOTTOM-40) end;
		OffCommand=function(self) self:accelerate(0.8):addy(150) end;
		LoadActor("ScreenGameplay course song "..StageNum+1)..{
		OnCommand=function(self) self:animate(0) end;
		CurrentSongChangedMessageCommand=function(self)
			StageNum = StageNum + 1
			self:Load( THEME:GetPathB("ScreenGameplay in/ScreenGameplay course","song "..StageNum) )
		end,
		},
	};
end

return t;
