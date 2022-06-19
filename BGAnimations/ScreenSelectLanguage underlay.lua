return Def.ActorFrame{
    Def.Quad{
        OnCommand=function(self)
            self:diffuse(Color.Black):stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
        end
    }
}