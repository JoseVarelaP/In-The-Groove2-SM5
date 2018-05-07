return Def.ActorFrame{
	LoadActor("978_JumpBack.mpg")..{
		OnCommand=cmd(rate,2;diffusealpha,0.7;FullScreen);
	},

	LoadActor("roxor")..{
		OnCommand=cmd(x,SCREEN_LEFT+90;y,SCREEN_TOP+30;diffusealpha,0;sleep,0.5;linear,0.5;diffusealpha,1);
	},

		Def.ActorFrame{
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+10);

				LoadActor("2")..{
					OnCommand=cmd(x,190;y,10;zoomx,0;glow,1,1,1,1;sleep,0.8;zoomy,3;bounceend,.3;zoom,1;glow,1,1,1,0);
				},
				LoadActor("in")..{
					OnCommand=cmd(x,-240;y,-70;zoom,0;sleep,0.1;bounceend,0.4;zoom,1);
				},
				LoadActor("the")..{
					OnCommand=cmd(x,-106;y,-70;zoom,0;sleep,0.1;bounceend,0.4;zoom,1);
				},
				LoadActor("groove")..{
					OnCommand=cmd(x,-50;y,26;zoom,0;sleep,0.1;bounceend,0.4;zoom,1);
				},
				LoadActor("trademark")..{
					OnCommand=cmd(x,176;y,-24;diffusealpha,0;sleep,0.5;linear,0.5;diffusealpha,1;diffuse,color("#000000"));
				},
		},

	Def.BitmapText{
	Font="_eurostile normal",
	Condition="SelectButtonAvailable()",
	Text="&xa9; 2005 Andamiro Co., Ltd.",
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-31;zoom,0.5;shadowlength,2;diffusealpha,0.8);
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Condition="SelectButtonAvailable()",
	Text="&xa9; 2005 Roxor Games, Inc.",
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-17;zoom,0.5;shadowlength,2;diffusealpha,0.8);
	},

	Def.BitmapText{
	Font="_eurostile normal",
	Condition="SelectButtonAvailable()",
	Text="r5",
	OnCommand=cmd(x,SCREEN_CENTER_X+94;y,SCREEN_BOTTOM-17;zoom,0.5;shadowlength,2;horizalign,left;diffusealpha,0.8);
	},

	Def.Quad{
	OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color("#FFFFFF");diffusealpha,0;sleep,0.1;accelerate,0.5;diffusealpha,1;sleep,0.2;decelerate,0.5;diffusealpha,0)
	}

}										
-- 	<Layer
-- 		Class="Quad"
-- 		OnCommand="stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,#FFFFFF;diffusealpha,0;sleep,0.1;accelerate,0.5;diffusealpha,1;sleep,0.2;decelerate,0.5;diffusealpha,0"
-- 	/>
-- </children></ActorFrame>