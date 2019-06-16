local t = Def.ActorFrame{}
local Args=...
local File,Width=Args[1],Args[2]

t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x1/"..File) )..{ InitCommand=function(self) self:setstate(0):pause():horizalign(right):x(-Width/2) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x1/"..File) )..{ InitCommand=function(self) self:setstate(1):pause():zoomtowidth(Width) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x1/"..File) )..{ InitCommand=function(self) self:setstate(2):pause():horizalign(left):x(Width/2) end; };

return t;