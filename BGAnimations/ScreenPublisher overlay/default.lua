local t = Def.ActorFrame{
    Def.Quad{
        InitCommand=function(self)
            self:FullScreen():diffusealpha(1)
        end
    },
    Def.Sprite{
        Texture="redoctane.png",
        InitCommand=function(self)
            self:Center()
        end
    },
    Def.Quad{
        InitCommand=function(self)
            self:FullScreen():diffusealpha(1):sleep(0.5):linear(0.5):diffusealpha(0)
        end
    },
}

return t