local style = ThemePrefs.Get("ITG1") and "small blue" or "small red"
local t = Def.ActorFrame{}
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {style,320});
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {"small green",312})..{
    GainFocusMessageCommand=function(self) self:visible(true) end;
    LoseFocusMessageCommand=function(self) self:visible(false) end;
};
t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {"small glow",292})..{
    GainFocusMessageCommand=function(self) self:visible(true):spin():diffuseshift():effectcolor1( color("1,1,1,0") ) end;
    LoseFocusMessageCommand=function(self) self:visible(false) end;
};

t[#t+1] = Def.Actor{
    GainFocusMessageCommand=function(s)
        local optrow = s:GetParent():GetParent():GetParent()
        -- s:GetChoiceInRowWithFocus( GAMESTATE:GetMasterPlayerNumber() )
        if optrow:GetName() ~= "Create New Profile" then
            MESSAGEMAN:Broadcast("ProfileSelected",{Name=optrow:GetName()})
        else
            MESSAGEMAN:Broadcast("ProfileSelected",{Name=nil})
        end
    end;
    CancelMessageCommand=function(s)
        local optrow = s:GetParent():GetParent():GetParent()
        if optrow then
            optrow:accelerate(0.3):addx(-SCREEN_WIDTH)
        end
    end;
}
return t;