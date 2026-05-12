return Def.ActorFrame{
    FOV=72,
    OnCommand=function(self)
        self:Center():z(300):spin():effectmagnitude(0,20,0)
    end,

    Def.Model{
        Meshes="ball.txt",
        Materials="ball.txt",
        Bones="ball.txt",
        OnCommand=function(self)
            self:diffuse(color("#FF6E24")):diffusealpha(0.4):zbuffer(0):zoom(3):cullmode("CullMode_None")
        end
    },

    Def.Sprite{
        Texture="grid diffuse",
        OnCommand=function(self)
            self:y(60):rotationx(90):zoom(0.7)
        end
    },

    Def.Sprite{
        Texture="grid flare",
        OnCommand=function(self)
            self:y(59.5):diffuseshift():effectcolor1(Color.White):effectcolor2(Color.Black)
            :blend("BlendMode_Add"):rotationx(90):zoom(0.7)
        end
    },
}