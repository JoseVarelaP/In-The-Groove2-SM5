return Def.ActorFrame{
	LoadActor("../ScreenWithMenuElements underlay"),
	LoadActor("main")..{ OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-32); },
	LoadActor("explanation")..{ OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+138); },
}