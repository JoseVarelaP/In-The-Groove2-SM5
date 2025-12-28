local t = Def.ActorFrame{}
t[#t+1] = LoadActor("ScreenWithMenuElements underlay/back")..{
    OffCommand=function(self)
        self:accelerate(0.5):diffusealpha(0)
    end
}
t[#t+1] = LoadActor("ScreenWithMenuElements underlay/fore")..{
    OffCommand=function(self)
        self:accelerate(0.5):diffusealpha(0)
    end
}
t[#t+1] = LoadModule("HeaderText.lua")(Var "LoadingScreen")
return t