local style = ThemePrefs.Get("ITG1") and "small blue" or "small red"
local itemcount = 0
local t = Def.ActorFrame{
    BeginCommand=function(s)
        itemcount = itemcount + 1
        s:GetChild("CounterText"):settext( itemcount )
        if itemcount > 0 then
            s:addx(-SCREEN_WIDTH):sleep(0.04*itemcount):bounceend(0.3):addx(SCREEN_WIDTH)
        end
    end;
    CancelMessageCommand=function(s) s:queuecommand("Off") end;
    OffCommand=function(s)
        itemcount = 0
        s:hurrytweening(0.2):queuecommand("TweenOff")
    end;
    TweenOffCommand=function(s)
        itemcount = itemcount + 1
        if itemcount > 0 then
            s:sleep(0.04*itemcount):bouncebegin(0.3):addx(SCREEN_WIDTH)
        end
    end;
}
t[#t+1] = Def.BitmapText{
    Name="CounterText", Font="Common Normal",
    OnCommand=function(s) s:visible(false) end;
    GainFocusMessageCommand=function(s)
        GAMESTATE:Env()["CurrentServiceItem"] = tonumber(s:GetText())
    end;
};
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