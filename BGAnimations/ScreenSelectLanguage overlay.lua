return Def.ActorFrame{
    Def.Quad{
        OnCommand=function(s)
            s:diffuse(Color.Black):stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):linear(1.5):diffusealpha(0)
        end;
        OffCommand=function(s)
            s:linear(1.5):diffusealpha(1)
            SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
        end;
    }
}