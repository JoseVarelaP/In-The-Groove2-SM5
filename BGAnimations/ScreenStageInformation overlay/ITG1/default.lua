local t = Def.ActorFrame{}

if not GAMESTATE:IsEventMode() then
	t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("StageAndCourses/ITG1/_stage","all"),
		OnCommand=function(s) s:x(-44):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(1):cropleft(0):cropright(0) end; 
	};
	t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("StageAndCourses/ITG1/_stage",""..StageIndexBySegment()),
		OnCommand=function(s) s:x(184):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):sleep(0.7):linear(0.5):cropleft(0):cropright(0) end; 
	};
else
	t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("StageAndCourses/ITG1/_stage","event"),
		OnCommand=function(s) s:cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(1):cropleft(0):cropright(0) end; 
	};
end

t[#t+1] = Def.Sprite{
	Texture=GAMESTATE:IsEventMode() and "_stage event" or "_stage all",
	OnCommand=function(s)
		s:x(GAMESTATE:IsEventMode() and 0 or -44):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):linear(1):cropleft(1):cropright(-0.3)
	end;
};

t[#t+1] = Def.Sprite{
	Condition=not GAMESTATE:IsEventMode(),
	Texture="_stage ".. StageIndexBySegment(),
	OnCommand=function(s)
		s:x(186):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):sleep(0.7):linear(0.5):cropleft(1):cropright(-0.3)
	end;
};

return t;