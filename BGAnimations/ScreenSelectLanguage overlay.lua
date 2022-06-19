return Def.ActorFrame{
    Def.Quad{
        OnCommand=function(self)
            self:diffuse(Color.Black):stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):linear(1.5):diffusealpha(0)
        end,
        OffCommand=function(self)
            self:linear(1.5):diffusealpha(1)
            SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
        end
    },
}