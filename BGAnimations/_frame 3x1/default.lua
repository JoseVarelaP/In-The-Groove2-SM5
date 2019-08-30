local t = Def.ActorFrame{}
local Args=...
local File,Width,Mask=Args[1],Args[2],Args[3]

t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x1/"..File) )..{ InitCommand=function(self) self:setstate(0):pause():horizalign(right):x(-Width/2):zwrite(Mask or 0):blend(Mask and "BlendMode_NoEffect" or Blend.Normal) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x1/"..File) )..{ InitCommand=function(self) self:setstate(1):pause():zoomtowidth(Width):zwrite(Mask or 0):blend(Mask and "BlendMode_NoEffect" or Blend.Normal) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x1/"..File) )..{ InitCommand=function(self) self:setstate(2):pause():horizalign(left):x(Width/2):zwrite(Mask or 0):blend(Mask and "BlendMode_NoEffect" or Blend.Normal) end; };

return t;