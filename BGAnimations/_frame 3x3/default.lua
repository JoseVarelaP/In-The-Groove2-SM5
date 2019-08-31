local t = Def.ActorFrame{}
local Args=...
local File,Width,Height,MarginFix=Args[1],Args[2],Args[3],Args[4]

t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(0):pause():horizalign(right):xy(-Width/2,-Height) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(1):pause():zoomtowidth(Width):y(-Height) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(2):pause():horizalign(left):xy(Width/2,-Height) end; };

t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(3):pause():zoomtoheight(Height*(MarginFix or 1.73)):horizalign(right):x(-Width/2) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(4):pause():zoomtoheight(Height*(MarginFix or 1.73)):zoomtowidth(Width) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(5):pause():zoomtoheight(Height*(MarginFix or 1.73)):horizalign(left):x(Width/2) end; };

t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(6):pause():horizalign(right):xy(-Width/2,Height) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(7):pause():zoomtowidth(Width):y(Height) end; };
t[#t+1] = LoadActor( THEME:GetPathB("","_frame files 3x3/"..File) )..{ InitCommand=function(self) self:setstate(8):pause():horizalign(left):xy(Width/2,Height) end; };

return t;