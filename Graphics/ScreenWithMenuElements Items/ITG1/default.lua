local t = Def.ActorFrame{}
local reverseindex = ...
if not GAMESTATE:IsEventMode() then
	if GAMESTATE:GetCurrentStage() == "Stage_Final" then
		t[#t+1] = Def.Sprite{ Texture="_stage final", OnCommand=function(s) s:xy(0,4) end; };
	else
		t[#t+1] = Def.Sprite{ Texture="_stage all", OnCommand=function(s) s:xy(0,4) end; };
		t[#t+1] = Def.Sprite{ Texture="_stage "..StageIndexBySegment(reverseindex), OnCommand=function(s) s:x(64) end; };
	end
else
	t[#t+1] = Def.Sprite{ Texture="_stage event", OnCommand=function(s) end; };
end

return t;