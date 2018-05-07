return Def.ActorFrame{
	LoadActor("../ScreenLogo background"),
	
	LoadActor("frame")..{ OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;faderight,0.1;fadeleft,0.1;cropright,1.1;cropleft,-0.1;linear,1;cropright,-0.1) },
	LoadActor("flare")..{ OnCommand=cmd(y,SCREEN_CENTER_Y-165;x,SCREEN_LEFT-64;rotationz,0;linear,1;x,SCREEN_RIGHT+64;rotationz,360;) },
	LoadActor("flare")..{ OnCommand=cmd(y,SCREEN_CENTER_Y+165;x,SCREEN_LEFT-64;rotationz,0;linear,1;x,SCREEN_RIGHT+64;rotationz,360;) },
	LoadActor("../ScreenWithMenuElements underlay"),
}
-- [Layer2]
-- File=frame
-- OnCommand=x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomToWidth,SCREEN_WIDTH;faderight,0.1;fadeleft,0.1;cropright,1.1;cropleft,-0.1;linear,1;cropright,-0.1

-- [Layer3]
-- File=flare
-- InitCommand=
-- #blend,add
-- OnCommand=y,SCREEN_CENTER_Y-176;x,SCREEN_LEFT-64;RotationZ,0;Linear,1;x,SCREEN_RIGHT+64;RotationZ,+360;

-- [Layer4]
-- File=flare
-- InitCommand=
-- #blend,add
-- OnCommand=y,SCREEN_CENTER_Y+176;x,SCREEN_LEFT-64;RotationZ,0;Linear,1;x,SCREEN_RIGHT+64;RotationZ,-360

-- [Layer5]
-- File=../ScreenWithMenuElements underlay
