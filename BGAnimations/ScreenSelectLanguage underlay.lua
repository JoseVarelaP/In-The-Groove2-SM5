return Def.ActorFrame{
    Def.Quad{
        OnCommand=function(s)
            s:diffuse(Color.Black):stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
        end;
    }
}