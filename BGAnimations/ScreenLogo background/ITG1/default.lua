local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffuse(Color.Black)
	end
};

t[#t+1] = Def.Sprite{ Texture="nexuswave.mpg", OnCommand=function(s) s:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(0.6):blend(Blend.Add) end; };
t[#t+1] = Def.Sprite{ Texture="bgoverlay", OnCommand=function(s) s:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(0.3333) end; };

t[#t+1] = Def.Sprite{
    Texture="shine1",
    OnCommand=function(s) s:halign(0):vertalign(0):blend(Blend.Add):diffuseshift():effectperiod(2):effectcolor2(color("1,1,1,0.5")) end; 
};

t[#t+1] = Def.Sprite{
    Texture="shine3",
    OnCommand=function(s) s:halign(1):vertalign(0):x(SCREEN_RIGHT):blend(Blend.Add):diffuseshift():effectperiod(3):effectcolor2(color("1,1,1,0.5")) end; 
};

t[#t+1] = Def.ActorFrame{
	OnCommand=function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+10) end;
	Def.Sprite{ Texture="in", OnCommand=function(s) s:xy(-240+30,-70+10):zoom(0):sleep(0.1):bounceend(0.4):zoom(1):sleep(0):zoom(0) end; };
	Def.Sprite{ Texture="the", OnCommand=function(s) s:xy(-106+30,-70+10):zoom(0):sleep(0.1):bounceend(0.4):zoom(1):sleep(0):zoom(0) end; };
	Def.Sprite{ Texture="groove", OnCommand=function(s) s:xy(-50+30,26+10):zoom(0):sleep(0.1):bounceend(0.4):zoom(1):sleep(0):zoom(0) end; };

	Def.Sprite{ Texture="overlay", OnCommand=function(s) s:xy(0,0):zoom(0):sleep(0.5):zoom(1) end; };
};

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0):sleep(0.2):linear(0.3):diffusealpha(1):sleep(0.05):linear(0.3):diffusealpha(0)
	end
};

return t;