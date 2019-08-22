local t = Def.ActorFrame{}
t[#t+1] = LoadActor("../_shared background normal");
t[#t+1] = Def.ActorFrame{ OnCommand=function(s) s:fov(70) end;
    LoadActor( THEME:GetPathG("_memory","card/card.txt") )..{
        OnCommand=function(s)
            s:xy( SCREEN_CENTER_X+10, SCREEN_CENTER_Y+130 ):zoom(1.1):spin():effectmagnitude(60,0,0)
        end;
    };
};

t[#t+1] = Def.Sprite{
    Texture="../_red streak",
    OnCommand=function(s)
        s:zoom(0.5):xy( SCREEN_CENTER_X, SCREEN_CENTER_Y-80 ):fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3)
        :linear(1):cropleft(-0.3):zoom(2.5):linear(9):zoom(1.2)
    end;
    OffCommand=function(s) s:stoptweening():linear(0.5):cropright(1.3):zoom(0.5) end;
}

t[#t+1] = Def.Sprite{
    Texture="usememory",
    OnCommand=function(s)
        s:zoom(0.5):xy( SCREEN_CENTER_X+70, SCREEN_CENTER_Y-80 ):addx(SCREEN_WIDTH*1.5):zoom(0.9):diffusealpha(0):sleep(2):decelerate(0.5):
        diffusealpha(1):addx(-SCREEN_WIDTH*1.5):linear(3):zoom(0.8):linear(0.25):diffusealpha(0)
    end;
    OffCommand=function(s) s:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end;
}

t[#t+1] = Def.Sprite{
    Texture="moreinfo",
    OnCommand=function(s)
        s:zoom(0.5):xy( SCREEN_CENTER_X+70, SCREEN_CENTER_Y-80 ):zoom(0.9):diffusealpha(0):sleep(5.50):linear(0.25):
        diffusealpha(1):linear(3.25):zoom(0.8):accelerate(0.5):diffusealpha(0):addx(-SCREEN_WIDTH)
    end;
    OffCommand=function(s) s:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end;
}

t[#t+1] = Def.Sprite{
    Texture="usb icon",
    OnCommand=function(s)
        s:glow(Color.White):xy( SCREEN_WIDTH*2, SCREEN_CENTER_Y-80 ):sleep(1):decelerate(0.5):x(SCREEN_CENTER_X-220):glowshift():effectclock("bgm"):effectoffset(1):effectperiod(2)
        :sleep(7.5):accelerate(0.5):addx(-SCREEN_WIDTH)
    end;
    OffCommand=function(s) s:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end;
}

t[#t+1] = Def.Sprite{ 
    Texture="usb glow",
    OnCommand=function(s)
        s:diffusealpha(0):xy(SCREEN_CENTER_X-220,SCREEN_CENTER_Y-80):sleep(1.5):diffusealpha(1):linear(0.8):zoomx(3):zoomy(2):diffusealpha(0)
    end;
    OffCommand=function(s) s:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end;
}

t[#t+1] = LoadActor("../ScreenAttract overlay");

return t;
--[[
[BGAnimation]
LengthSeconds=10

[Layer50]
File=../ScreenAttract overlay
]]