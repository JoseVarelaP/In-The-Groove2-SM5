return Def.ActorFrame{
	LoadActor("../ScreenWithMenuElements underlay"),
	
	Def.Quad{
	InitCommand=cmd(diffuse,0,0,0,1);
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;FullScreen;diffusealpha,0;accelerate,0.5;diffusealpha,1;sleep,2	);
	},

		Def.ActorFrame{
		Condition=not GAMESTATE:IsCourseMode();

			LoadActor("../ScreenGameplay in/ScreenGameplay stage ".. ToEnumShortString(GAMESTATE:GetCurrentStage()) )..{
				OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;cropright,1.3;linear,1;cropright,-0.3);
			},

			LoadActor("_white ScreenGameplay stage ".. ToEnumShortString(GAMESTATE:GetCurrentStage()) )..{
				OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.05;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;linear,1;cropleft,1;cropright,-0.3);
			},

			LoadActor("../_song credit display")..{
				OnCommand=cmd(diffusealpha,0;linear,0.3;diffusealpha,1);
			},

		},

		Def.ActorFrame{
			Condition=GAMESTATE:IsCourseMode();
			
			LoadActor("../ScreenGameplay in/ScreenGameplay course song 1")..{
				OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;cropright,1.3;linear,1;cropright,-0.3);
			},

			LoadActor("_white ScreenGameplay course song 1")..{
				OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.05;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;linear,1;cropleft,1;cropright,-0.3);
			},

		},
}

-- 		<ActorFrame Condition="not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/Training1/')" ><children>
-- 			<Actor
-- 				File="@THEME:GetPath(EC_GRAPHICS,'','_tutorial welcome')"
-- 				OnCommand="x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-112;diffusealpha,0;zoom,4;sleep,0.0;linear,0.3;diffusealpha,1;zoom,1"
-- 			/>
-- 		</children></ActorFrame>
-- 		<ActorFrame Condition="GAMESTATE:IsCourseMode()" ><children>
-- 			<Actor
-- 				File="../../Graphics/ScreenGameplay course song 1"
-- 				OnCommand="x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;cropright,1.3;linear,1;cropright,-0.3"
-- 			/>
-- 			<Actor
-- 				File="../../Graphics/_white ScreenGameplay course song 1"
-- 				OnCommand="x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.05;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;linear,1;cropleft,+1;cropright,-0.3"
-- 			/>
-- 		</children></ActorFrame>
-- 	</children>
-- </ActorFrame>
