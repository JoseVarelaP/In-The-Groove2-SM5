local style = ThemePrefs.Get("ITG1") and "small blue" or "small red"
local t = Def.ActorFrame{}
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {style,320});
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {"small green",312})..{
    GainFocusMessageCommand=function(self) self:visible(true) end;
    LoseFocusMessageCommand=function(self) self:visible(false) end;
};
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {"small glow",292})..{
    GainFocusMessageCommand=function(self) self:visible(true):diffuseshift():effectcolor1( color("1,1,1,0") ) end;
    LoseFocusMessageCommand=function(self) self:visible(false) end;
};
t[#t+1] = Def.BitmapText{
    Font="Common Normal",
    OnCommand=function(s)
        s:zoom(0.6)
        s:settext( THEME:GetString("NativeLanguages", string.sub(s:GetParent():GetName(), 13 ) ) )
    end;
    GainFocusMessageCommand=function(s) s:diffuse( color("1,1,1,1") ) end;
    LoseFocusMessageCommand=function(s) s:diffuse( color("0.5,0.5,0.5,1") ) end;
};
return t;