return Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+24;addy,-100;sleep,0.5;queuecommand, "TweenOn");
	OffCommand=cmd(sleep,1;queuecommand, "TweenOff");
	ShowGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOn");
	HideGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOff");
	TweenOnCommand=cmd(decelerate,0.8;addy,100);
	TweenOffCommand=cmd(accelerate,0.8;addy,-100);

		Def.SongMeterDisplay{
        InitCommand=cmd(SetStreamWidth,SCREEN_WIDTH/1.58);
        Stream=LoadActor("meter stream")..{InitCommand=cmd(diffusealpha,1)};
        Tip=LoadActor("tip")..{
            OnCommand=cmd(diffuseshift;effectcolor1,1,1,1,0.6;effectcolor2,1,1,1,1.0);
        },
    },

    -- History Time
    
    -- I've made this trickery with the original meter frame texture back in 2016, when I was messing around with
    -- ITGPC and suddenly got the realization of how could I make the meter frame stretch to fit, without distoring it.
    -- I kept the code I did for this, and now it is used for Widescreen SM setups.
    																						-- Jose_Varela

    	LoadActor("meter frame")..{ OnCommand=cmd(zoomtowidth,SCREEN_WIDTH/2;cropleft,0.5;x,SCREEN_WIDTH/11.5); },
    	LoadActor("meter frame")..{ OnCommand=cmd(zoomtowidth,SCREEN_WIDTH/2;cropright,0.5;x,SCREEN_WIDTH/-11.5); },
    	LoadActor("meter frame")..{ OnCommand=cmd(zoomtowidth,SCREEN_WIDTH/2;cropright,0.326;cropleft,0.326;x,0); },
}
