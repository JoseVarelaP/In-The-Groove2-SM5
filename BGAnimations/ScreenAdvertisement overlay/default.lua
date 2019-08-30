local t = Def.ActorFrame{
	OnCommand=function(s) s:fov(45) end;
};

t[#t+1] = Def.ActorFrame{
	OnCommand=function(s) s:xy(SCREEN_CENTER_X+10,SCREEN_CENTER_Y):rotationy(-10) end;

	Def.Sprite{ Texture="streak", OnCommand=function(s)
		s:zoom(0.5):fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):linear(1):cropleft(-0.3):zoom(3):linear(11):zoom(2.8)
	end; };

	Def.ActorFrame{
		InitCommand=function(s) s:xy(WideScale(90,160),-52) end;

		Def.ActorFrame{
			InitCommand=function(s) s:xy(60,-2):zoom(0.8):addx(600):sleep(0.5):decelerate(0.5):addx(-600) end;
			Def.Sprite{ Texture="in", OnCommand=function(s) s:xy(-240,-70):shadowlength(2) end; };
			Def.Sprite{ Texture="the", OnCommand=function(s) s:xy(-106,-70):shadowlength(2) end; };
			Def.Sprite{ Texture="groove", OnCommand=function(s) s:xy(-50,26):shadowlength(2) end; };
			Def.Sprite{ Texture="trademark", OnCommand=function(s) s:xy(176,-24):diffuse(Color.Black) end; };
			Def.BitmapText{ Font="_eurostile normal", Text="for PlayStation® 2", OnCommand=function(s) s:halign(1):xy(170,110):shadowlength(2):zoom(1.4) end; };
			Def.BitmapText{ Font="_eurostile normal", Text="In Stores Now", OnCommand=function(s) s:halign(1):xy(170,150):shadowlength(2):zoom(1.4) end; };
			Def.BitmapText{ Font="_big red glow", Text="www.inthegroove.com", OnCommand=function(s) s:xy(-48,200):shadowlength(2) end; };
		}
	};
};

t[#t+1] = Def.Model{
	Meshes="case.txt",
	Bones="case.txt",
	Materials="case.txt",
	OnCommand=function(s)
		s:xy(SCREEN_CENTER_X-180,SCREEN_CENTER_Y):rotationy(-60):zoom(3):spin():effectmagnitude(0,40,0)
	end;
};

t[#t+1] = LoadActor("../ScreenAttract overlay");

return t;