local t = Def.ActorFrame{}

if not GAMESTATE:IsEventMode() then
	t[#t+1] = Def.Sprite{ Texture="_stage all", OnCommand=function(s) s:xy(0,4) end; };
	t[#t+1] = Def.Sprite{ Texture="_stage "..StageIndexBySegment(), OnCommand=function(s) s:x(64) end; };
else
	t[#t+1] = Def.Sprite{ Texture="_stage event", OnCommand=function(s) end; };
end

return t;