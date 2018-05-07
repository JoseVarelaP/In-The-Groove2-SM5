return Def.ActorFrame{
	LoadActor("roxor logo")..{
	OnCommand=cmd(Center;FullScreen;zoomtoheight,SCREEN_WIDTH/4*3);
	},
}