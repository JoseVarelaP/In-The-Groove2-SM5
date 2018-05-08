return Def.ActorFrame{
	LoadActor( "ScreenWithMenuElements underlay" ),

	LoadActor( THEME:GetPathG("","_options system page") )..{
	InitCommand=cmd(Center;addy,18);
	OnCommand=cmd(addx,-SCREEN_WIDTH;decelerate,0.3;addx,SCREEN_WIDTH);
	OffCommand=cmd(accelerate,0.3;addx,SCREEN_WIDTH);
	},

	LoadActor("ScreenOptions overlay/ScreenOptions frame")..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;addy,18);
	OnCommand=cmd(addx,-SCREEN_WIDTH;decelerate,0.3;addx,SCREEN_WIDTH);
	OffCommand=cmd(accelerate,0.3;addx,SCREEN_WIDTH);
	},
}