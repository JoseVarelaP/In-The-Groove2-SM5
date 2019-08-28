local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
    Texture="bgoverlay",
    OnCommand=function(s) s:diffusealpha(0.3):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM) end;
};

t[#t+1] = Def.Sprite{
    Texture="nexuswave.mpg",
    OnCommand=function(s) s:diffusealpha(0.6):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):blend(Blend.Add) end;
};

t[#t+1] = Def.Sprite{
    Texture="shine1",
    OnCommand=function(s) s:halign(0):vertalign(0):blend(Blend.Add):diffuseshift():effectperiod(2):effectcolor2(color("1,1,1,0.5")) end; 
};

t[#t+1] = Def.Sprite{
    Texture="shine3",
    OnCommand=function(s) s:halign(1):vertalign(0):x(SCREEN_RIGHT):blend(Blend.Add):diffuseshift():effectperiod(3):effectcolor2(color("1,1,1,0.5")) end; 
};

return t;
