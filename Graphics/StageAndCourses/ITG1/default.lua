local t = Def.ActorFrame{}

if not GAMESTATE:IsEventMode() then
	t[#t+1] = Def.Sprite{ Texture="_stage all", OnCommand=function(s)
		s:x(-44)
		if GAMESTATE:GetCurrentStage() == "Stage_Final" then
			s:x(0):Load( THEME:GetPathG("StageAndCourses/ITG1/_stage","final" ) )
		end
	end; };
	t[#t+1] = Def.Sprite{ Texture="_stage "..StageIndexBySegment(), OnCommand=function(s)
		s:x(184)
		if GAMESTATE:GetCurrentStage() == "Stage_Final" then s:visible(false) end
	end; };
else
	t[#t+1] = Def.Sprite{ Texture="_stage event", OnCommand=function(s) end; };
end

return t;