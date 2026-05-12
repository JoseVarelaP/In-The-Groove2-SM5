return Def.ActorFrame{
    Def.Model{
        Meshes="box cans.txt",
        Materials="box cans.txt",
        Bones="box cans.txt",
    },

    Def.Model{
        Meshes="box lights.txt",
        Materials="box lights.txt",
        Bones="box lights.txt",
        InitCommand=function(self)
            self:z(-1):effectclock("beat"):playcommand("CrossedBeat1")
        end,
        CrossedBeat1MessageCommand=function(self)
            self:diffuseshift():effecttiming(0.2,0,1.8,0):effectoffset(-0.7)
            :effectcolor1(color("#303030")):effectcolor2(color("#3AA0D2"))
        end,
        CrossedBeat14MessageCommand=function(self)
            self:diffuse(Color.White):linear(0.3):queuecommand("StopEffect")
            :linear(0.2):diffuse(color("#303030"))
            :sleep(0.2):linear(0.2):diffuse(color("#FFFFFF"))
            :linear(0.2):diffuse(color("#303030"))
        end,
        CrossedBeat18MessageCommand=function(self)
            self:diffuseshift():effecttiming(0.2,0,1.8,0):effectoffset(-0.7)
            :effectcolor1(color("#303030")):effectcolor2(color("#3AD26C"))
        end,
        CrossedBeat54MessageCommand=function(self)
            self:diffuseshift():effecttiming(0.2,0,3.8,0):effectoffset(-0.7)
            :effectcolor1(color("#303030")):effectcolor2(color("#8D5AD2"))
        end,
        CrossedBeat71MessageCommand=function(self)
            self:playcommand("CrossedBeat1")
        end,
        StopEffectCommand=function(self) self:stopeffect() end
    },

    Def.Model{
        Meshes="box flares.txt",
        Materials="box flares.txt",
        Bones="box flares.txt",
        InitCommand=function(self)
            self:zbuffer(0):blend("BlendMode_Add"):effectclock("beat"):playcommand("CrossedBeat1")
        end,
        CrossedBeat1MessageCommand=function(self)
            self:diffuseshift():effecttiming(0.2,0,1.8,0):effectoffset(-0.7)
            :effectcolor1(color("#000000")):effectcolor2(color("#3AA0D2"))
        end,
        CrossedBeat14MessageCommand=function(self)
            self:diffuse(Color.White):linear(0.3):queuecommand("StopEffect")
            :linear(0.2):diffuse(color("#000000"))
            :sleep(0.2):linear(0.2):diffuse(color("#FFFFFF"))
            :linear(0.2):diffuse(color("#000000"))
        end,
        CrossedBeat18MessageCommand=function(self)
            self:diffuseshift():effecttiming(0.2,0,1.8,0):effectoffset(-0.7)
            :effectcolor1(color("#000000")):effectcolor2(color("#3AD26C"))
        end,
        CrossedBeat54MessageCommand=function(self)
            self:diffuseshift():effecttiming(0.2,0,3.8,0):effectoffset(-0.7)
            :effectcolor1(color("#000000")):effectcolor2(color("#8D5AD2"))
        end,
        CrossedBeat71MessageCommand=function(self)
            self:playcommand("CrossedBeat1")
        end,
        StopEffectCommand=function(self) self:stopeffect() end
    },
}