local t = Def.ActorFrame{}

if GAMESTATE:IsCourseMode() then

	t[#t+1] = Def.Sprite{
		Texture="_stage all",
		OnCommand=function(self)
			self:x(-44)
		end
	}

	t[#t+1] = Def.Sprite{
		Name="Number",
		Texture="_stage 1",
		OnCommand=function(self)
			self:x(184)
			if GAMESTATE:GetCurrentStage() == "Stage_Final" then
				self:visible(false)
			end
		end
	}

	return t
end

if not GAMESTATE:IsEventMode() then
	t[#t+1] = Def.Sprite{ Texture="_stage all", OnCommand=function(self)
		self:x(-44)
		if GAMESTATE:GetCurrentStage() == "Stage_Final" then
			self:x(0):Load( THEME:GetPathG("StageAndCourses/ITG1/_stage","final" ) )
		end
	end; };
	t[#t+1] = Def.Sprite{ Name="Number", Texture="_stage "..StageIndexBySegment(), OnCommand=function(s)
		s:x(184)
		if GAMESTATE:GetCurrentStage() == "Stage_Final" then s:visible(false) end
	end; };
else
	t[#t+1] = Def.Sprite{ Texture="_stage event", OnCommand=function(s) end; };
end

return t;