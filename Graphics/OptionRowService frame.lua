local t = Def.ActorFrame{}
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {"small 2red",320});
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {"small green",312})..{
    GainFocusMessageCommand=function(self) self:visible(true) end;
    LoseFocusMessageCommand=function(self) self:visible(false) end;
};
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {"small glow",292})..{
    GainFocusMessageCommand=function(self) self:visible(true):diffuseshift():effectcolor1( color("1,1,1,0") ) end;
    LoseFocusMessageCommand=function(self) self:visible(false) end;
};
return t;