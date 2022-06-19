local style = ThemePrefs.Get("ITG1") and "small blue" or "small red"
local LangName = Var("GameCommand"):GetName()
return Def.ActorFrame{
    LoadActor( THEME:GetPathB("","_frame 3x1") , {style,320}),
    LoadActor( THEME:GetPathB("","_frame 3x1") , {"small green",312})..{
        GainFocusMessageCommand=function(self) self:visible(true) end,
        LoseFocusMessageCommand=function(self) self:visible(false) end
    },
    LoadActor( THEME:GetPathB("","_frame 3x1") , {"small glow",292})..{
        GainFocusMessageCommand=function(self) self:visible(true):diffuseshift():effectcolor1( color("1,1,1,0") ) end,
        LoseFocusMessageCommand=function(self) self:visible(false) end
    },
    Def.BitmapText{
        Font="Common Normal",
        OnCommand=function(self)
            self:zoom(0.6):settext( THEME:GetString("NativeLanguages", LangName ) )
        end,
        GainFocusMessageCommand=function(self) self:diffuse( color("1,1,1,1") ) end,
        LoseFocusMessageCommand=function(self) self:diffuse( color("0.5,0.5,0.5,1") ) end
    }
}