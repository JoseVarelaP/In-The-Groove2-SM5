return Def.ActorFrame{
	LoadActor("../ScreenWithMenuElements underlay/back"),
	LoadActor("../_shared underlay arrows"),

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_CENTER_X+80;y,SCREEN_CENTER_Y+60;z,-100;zoom,1.3);

		LoadActor("char")..{
			OnCommand=cmd(ztest,1;glow,1,1,1,0;diffusealpha,0;linear,0.3;glow,1,1,1,1;sleep,0.001;diffusealpha,1;linear,0.3;glow,1,1,1,0);
			OffCommand=cmd(linear,0.3;diffusealpha,0);
		},
	},

	LoadActor("../ScreenWithMenuElements underlay/fore"),
}
-- <ActorFrame><children>
-- 	<Layer
-- 		Class="AutoActor" 
-- 		File="../ScreenWithMenuElements underlay/back"
-- 	/>
-- 	<Layer
-- 		Class="AutoActor" 
-- 		File="../_shared underlay arrows"
-- 	/>
-- 	<Layer Class="ActorFrame" InitCommand="x,SCREEN_CENTER_X+80;y,SCREEN_CENTER_Y+60;z,-100;zoom,1.3"><children>
-- 		<ActorFrame><children>
-- 			<AutoActor 
-- 				File="char" 
-- 				OnCommand="zbuffer,1;glow,1,1,1,0;diffusealpha,0;linear,0.3;glow,1,1,1,1;sleep,0.001;diffusealpha,1;linear,0.3;glow,1,1,1,0" 
-- 				OffCommand="linear,0.3;diffusealpha,0"
-- 			/>
-- 		</children></ActorFrame>
-- 	</children></Layer>
-- 	<Layer
-- 		Class="AutoActor" 
-- 		File="../ScreenWithMenuElements underlay/fore"
-- 	/>
-- </children></ActorFrame>
