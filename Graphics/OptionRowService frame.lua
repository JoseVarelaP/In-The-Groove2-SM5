local style = ThemePrefs.Get("ITG1") and "small blue" or "small red"
local t = Def.ActorFrame{
    BeginCommand=function(self)
        self.index = self:GetParent():GetParent().iIndex
        self:GetChild("CounterText").val = self.index
        self:addx(-SCREEN_WIDTH):sleep(0.04*self.index):bounceend(0.3):addx(SCREEN_WIDTH)
    end;
    CancelMessageCommand=function(s) s:queuecommand("Off") end;
    OffCommand=function(s)
        s:hurrytweening(0.2):queuecommand("TweenOff")
    end;
    TweenOffCommand=function(self)
        -- Get the current cursor position to create the wave effect.
        local cursorPos = SCREENMAN:GetTopScreen():GetCurrentRowIndex( GAMESTATE:GetMasterPlayerNumber() )

        -- With the position made, the wave effect begins with the selection starting first,
        -- and then going away.
        local calc = math.abs( cursorPos - self.index )

        self:sleep(0.04*calc):bouncebegin(0.3):addx(SCREEN_WIDTH)
    end;
}
t[#t+1] = Def.Actor{
    Name="CounterText",
    GainFocusMessageCommand=function(s)
        GAMESTATE:Env()["CurrentServiceItem"] = tonumber(s.val)
    end
}
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
        local optrow = s:GetParent():GetParent():GetParent()
        s:settext( THEME:GetString("OptionTitles",optrow:GetName()) )
    end;
    GainFocusMessageCommand=function(s) s:diffuse( color("1,1,1,1") ) end;
    LoseFocusMessageCommand=function(s) s:diffuse( color("0.5,0.5,0.5,1") ) end;
};
return t;