function GetRandomSongNames( num )
	local s = "";
	for i = 1,num do
		local song = SONGMAN:GetRandomSong();
		if song then s = s .. song:GetDisplayFullTitle() .. "\n" end
	end
	return s
end

function GetRandomCourseNames( num )
	local s = "";
	for i = 1,num do
		local course = SONGMAN:GetRandomCourse();
		if course then s = s .. course:GetDisplayFullTitle() .. "\n" end
	end
	return s
end

function GetModifierNames( num )
	local mods = {
		"x1","x1.5","x2","x2.5","x3","x4","x5","x6","x8","c300","c450",
		"Incoming","Overhead","Space","Hallway","Distant",
		"Standard","Reverse","Split","Alternate","Cross","Centered",
		"Accel","Decel","Wave","Expand","Boomerang","Bumpy",
		"Dizzy","Drift","Mini","Flip","Invert","Tornado","Float","Beat",
		"Fade&nbsp;In","Fade&nbsp;Out","Blink","Invisible","Beat","Bumpy",
		"Mirror","Left","Right","Random","Blender",
		"No&nbsp;Jumps","No&nbsp;Holds","No&nbsp;Rolls","No&nbsp;Hands","No&nbsp;Quads","No&nbsp;Mines",
		"Simple","Stream","Wide","Quick","Skippy","Echo","Stomp",
		"Planted","Floored","Twister","Add&nbsp;Mines","No&nbsp;Stretch&nbsp;Jumps",
		"Hide&nbsp;Targets","Hide&nbsp;Judgment","Hide&nbsp;Background",
		"Metal","Cel","Flat","Robot","Vivid"
	}
	mods = tableshuffle( mods )
	local s = "";
	for i = 1,math.min(num,table.getn(mods)) do
		s = s .. mods[i] .. "\n"
	end
	return s
end

function GetStepChartFacts()
	local s = "";
	s = s .. "In The Groove:\n"
	s = s .. "  71 single easy\n"
	s = s .. "  71 single medium\n"
	s = s .. "  71 single hard\n"
	s = s .. "  52 single expert\n"
	s = s .. "  71 double easy\n"
	s = s .. "  71 double medium\n"
	s = s .. "  71 double hard\n"
	s = s .. "  59 double expert\n"
	s = s .. "In The Groove 2:\n"
	s = s .. "  61 single novice\n"
	s = s .. "  61 single easy\n"
	s = s .. "  61 single medium\n"
	s = s .. "  61 single hard\n"
	s = s .. "  49 single expert\n"
	s = s .. "  61 double easy\n"
	s = s .. "  61 double medium\n"
	s = s .. "  61 double hard\n"
	s = s .. "  52 double expert"
	return s
end

return Def.ActorFrame{
	Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,0,0,0,1);
	},

	LoadActor("rave")..{ OnCommand=cmd(FullScreen;zoomtoheight,SCREEN_WIDTH/4*3*1.1;sleep,30;diffusealpha,0) },

	Def.ActorFrame{
	OnCommand=cmd(Center;rotationz,180;linear,1;rotationz,0);
		LoadActor("ring")..{
		OnCommand=cmd(shadowlength,4;zoom,3;diffusealpha,0;linear,1;zoomx,1.1;zoomy,-1.1;diffusealpha,1;linear,2;zoomx,1.0;zoomy,-1.0;linear,0.3;diffusealpha,0);
		},
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Text="Roxor Games presents",
	OnCommand=cmd(Center;shadowlength,4;diffusealpha,0;sleep,0.5;linear,0.5;diffusealpha,1;sleep,2;linear,0.5;diffusealpha,0);
	},

	Def.Quad{
	OnCommand=cmd(x,SCREEN_RIGHT+SCREEN_WIDTH/2;y,SCREEN_TOP+110;zoomtowidth,SCREEN_WIDTH;zoomtoheight,60;diffuse,1,1,1,0.5;sleep,3;bounceend,0.5;fadeleft,0.3;faderight,0.3;x,0;linear,3;addx,100;accelerate,0.5;addx,-SCREEN_WIDTH);
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Text="In The Groove 2",
	OnCommand=cmd(x,SCREEN_LEFT+200;y,SCREEN_TOP+110;skewx,-0.2;shadowlength,4;diffusealpha,0;sleep,3.5;linear,0.3;diffusealpha,1;sleep,3;linear,0.3;diffusealpha,0);
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-0;y,SCREEN_CENTER_Y;sleep,3.5;linear,4;addx,30);
		LoadActor("2")..{
			OnCommand=cmd(horizalign,right;skewx,-0.05;diffusealpha,0;sleep,3;linear,0.5;diffusealpha,0.5;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.Quad{
	OnCommand=cmd(x,SCREEN_RIGHT+SCREEN_WIDTH/2;y,SCREEN_TOP+110;zoomtowidth,SCREEN_WIDTH;zoomtoheight,60;diffuse,1,1,1,0.5;sleep,11;bounceend,0.5;fadeleft,0.3;faderight,0.3;x,0;linear,3;addx,100;accelerate,0.5;addx,-SCREEN_WIDTH);
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Text="135 songs",
	OnCommand=cmd(x,SCREEN_LEFT+200;y,SCREEN_TOP+110;skewx,-0.2;shadowlength,4;diffusealpha,0;sleep,11.5;linear,0.3;diffusealpha,1;sleep,3;linear,0.3;diffusealpha,0);
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-0;y,SCREEN_CENTER_Y+50;sleep,11;linear,4;addx,30);
		LoadActor("135")..{
			OnCommand=cmd(horizalign,right;skewx,-0.05;diffusealpha,0;sleep,11;linear,0.5;diffusealpha,0.5;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-270;y,SCREEN_BOTTOM-200;sleep,11;linear,4;y,SCREEN_TOP+200);
		Def.BitmapText{
		Font="_eurostile normal",
		Text=GetRandomSongNames(23),
			OnCommand=cmd(horizalign,left;zoom,0.8;diffusealpha,0;sleep,11;linear,0.5;diffusealpha,0.3;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.Quad{
	OnCommand=cmd(x,SCREEN_RIGHT+SCREEN_WIDTH/2;y,SCREEN_TOP+110;zoomtowidth,SCREEN_WIDTH;zoomtoheight,60;diffuse,1,1,1,0.5;sleep,15;bounceend,0.5;fadeleft,0.3;faderight,0.3;x,0;linear,3;addx,100;accelerate,0.5;addx,-SCREEN_WIDTH);
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Text="1,000 step charts",
		OnCommand=cmd(x,SCREEN_LEFT+200;y,SCREEN_TOP+110;skewx,-0.2;shadowlength,4;diffusealpha,0;sleep,15.5;linear,0.3;diffusealpha,1;sleep,3;linear,0.3;diffusealpha,0);
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-0;y,SCREEN_CENTER_Y+50;sleep,15;linear,4;addx,30);
		LoadActor("1000")..{
			OnCommand=cmd(horizalign,right;skewx,-0.05;diffusealpha,0;sleep,15;linear,0.5;diffusealpha,0.5;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-270;y,SCREEN_BOTTOM-200;sleep,15;linear,4;y,SCREEN_TOP+200);
		Def.BitmapText{
			Font="_eurostile normal",
			Text=GetStepChartFacts(),
			OnCommand=cmd(horizalign,left;zoom,0.8;diffusealpha,0;sleep,15;linear,0.5;diffusealpha,0.3;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.Quad{
	OnCommand=cmd(x,SCREEN_RIGHT+SCREEN_WIDTH/2;y,SCREEN_TOP+110;zoomtowidth,SCREEN_WIDTH;zoomtoheight,60;diffuse,1,1,1,0.5;sleep,19;bounceend,0.5;fadeleft,0.3;faderight,0.3;x,0;linear,3;addx,100;accelerate,0.5;addx,-SCREEN_WIDTH);
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Text="45 courses",
		OnCommand=cmd(x,SCREEN_LEFT+200;y,SCREEN_TOP+110;skewx,-0.2;shadowlength,4;diffusealpha,0;sleep,19.5;linear,0.3;diffusealpha,1;sleep,3;linear,0.3;diffusealpha,0);
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-0;y,SCREEN_CENTER_Y+50;sleep,19;linear,4;addx,30);
		LoadActor("45")..{
			OnCommand=cmd(horizalign,right;skewx,-0.05;diffusealpha,0;sleep,19;linear,0.5;diffusealpha,0.5;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-250;y,SCREEN_BOTTOM-200;sleep,19;linear,4;y,SCREEN_TOP+200);
		Def.BitmapText{
			Font="_eurostile normal",
			Text=GetRandomCourseNames(23),
			OnCommand=cmd(horizalign,left;zoom,0.8;diffusealpha,0;sleep,19;linear,0.5;diffusealpha,0.3;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.Quad{
	OnCommand=cmd(x,SCREEN_RIGHT+SCREEN_WIDTH/2;y,SCREEN_TOP+110;zoomtowidth,SCREEN_WIDTH;zoomtoheight,60;diffuse,1,1,1,0.5;sleep,23;bounceend,0.5;fadeleft,0.3;faderight,0.3;x,0;linear,3;addx,100;accelerate,0.5;addx,-SCREEN_WIDTH);
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Text="50 modifiers",
		OnCommand=cmd(x,SCREEN_LEFT+200;y,SCREEN_TOP+110;skewx,-0.2;shadowlength,4;diffusealpha,0;sleep,23.5;linear,0.3;diffusealpha,1;sleep,3;linear,0.3;diffusealpha,0);
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-0;y,SCREEN_CENTER_Y+50;sleep,23;linear,4;addx,30);
		LoadActor("50")..{
			OnCommand=cmd(horizalign,right;skewx,-0.05;diffusealpha,0;sleep,23;linear,0.5;diffusealpha,0.5;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_RIGHT-250;y,SCREEN_BOTTOM-200;sleep,23;linear,4;y,SCREEN_TOP+200);
		Def.BitmapText{
			Font="_eurostile normal",
			Text=GetModifierNames(23),
			OnCommand=cmd(horizalign,left;zoom,0.8;diffusealpha,0;sleep,23;linear,0.5;diffusealpha,0.3;linear,3;linear,0.5;diffusealpha,0.0);
		},
	},

	Def.Quad{
	OnCommand=cmd(vertalign,top;x,SCREEN_CENTER_X;y,SCREEN_TOP;zoomtowidth,SCREEN_WIDTH;zoomtoheight,(SCREEN_HEIGHT-SCREEN_WIDTH/4*3*0.705)/2;diffuse,0,0,0,1);
	},
	Def.Quad{
	OnCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;zoomtowidth,SCREEN_WIDTH;zoomtoheight,(SCREEN_HEIGHT-SCREEN_WIDTH/4*3*0.705)/2;diffuse,0,0,0,1);
	},
	Def.Quad{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;diffusealpha,0;hibernate,29.5;linear,0.5;diffusealpha,1;linear,0.5;diffusealpha,0);
	},
}	

