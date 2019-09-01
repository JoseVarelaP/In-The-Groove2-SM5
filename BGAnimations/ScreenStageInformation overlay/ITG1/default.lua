local t = Def.ActorFrame{}

if not GAMESTATE:IsEventMode() then
	if GAMESTATE:GetCurrentStage() == "Stage_Final" then
		t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("StageAndCourses/ITG1/_stage","final"),
			OnCommand=function(s) s:x(0):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(0.6):cropleft(0):cropright(0) end; 
		};
	else
		t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("StageAndCourses/ITG1/_stage","all"),
			OnCommand=function(s) s:x(-44):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(0.6):cropleft(0):cropright(0) end; 
		};
		t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("StageAndCourses/ITG1/_stage",""..StageIndexBySegment()),
			OnCommand=function(s) s:x(184):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):sleep(0.35):linear(0.3):cropleft(0):cropright(0) end; 
		};
	end
else
	t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("StageAndCourses/ITG1/_stage","event"),
		OnCommand=function(s) s:cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(0.6):cropleft(0):cropright(0) end; 
	};
end

t[#t+1] = Def.Sprite{
	Texture=GAMESTATE:IsEventMode() and "_stage event" or ( not GAMESTATE:GetCurrentStage() == "Stage_Final" and "_stage final" or "_stage all"),
	OnCommand=function(s)
		s:x((GAMESTATE:IsEventMode() or GAMESTATE:GetCurrentStage() == "Stage_Final") and 0 or -44):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(0.6):cropleft(1):cropright(-0.3)
	end;
};

t[#t+1] = Def.Sprite{
	Condition=not GAMESTATE:IsEventMode() and not GAMESTATE:GetCurrentStage() == "Stage_Final",
	Texture="_stage ".. StageIndexBySegment(),
	OnCommand=function(s)
		s:x(186):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):sleep(0.7):linear(0.5):cropleft(1):cropright(-0.3)
	end;
};

t[#t+1] = Def.Sprite{
	Condition=not GAMESTATE:IsEventMode() and not GAMESTATE:GetCurrentStage() == "Stage_Final",
	Texture="_stage ".. StageIndexBySegment(),
	OnCommand=function(s)
		s:x(186):diffusealpha(0):sleep(0.6):diffusealpha(1):linear(0.25):zoom(1.6):diffusealpha(0)
	end;
};

return t;