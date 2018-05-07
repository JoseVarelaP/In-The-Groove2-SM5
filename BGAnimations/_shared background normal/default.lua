return Def.ActorFrame{
	LoadActor("../_shared background no streaks")..{OnCommand=cmd(Center) },

	Def.ActorFrame{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;wag;effectmagnitude,10,0,0;effectperiod,8);
		Def.ActorFrame{
			OnCommand=cmd(wag;effectmagnitude,0,5,0;effectperiod,12);
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,-200;z,-100;customtexturerect,0.6,0,0.65,1;texcoordvelocity,0.16,0;diffuse,color("#DA7979");diffusealpha,0.1) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,-160;z,-200;customtexturerect,0.9,0,0.95,1;texcoordvelocity,0.14,0;diffuse,color("#DA7979");diffusealpha,0.1) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,-120;z,-300;customtexturerect,0.2,0,0.25,1;texcoordvelocity,0.12,0;diffuse,color("#DA7979");diffusealpha,0.2) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,-80;z,-400;customtexturerect,0.5,0,0.55,1;texcoordvelocity,0.10,0;diffuse,color("#DA7979");diffusealpha,0.2) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,-40;z,-500;customtexturerect,0.5,0,0.55,1;texcoordvelocity,0.08,0;diffuse,color("#DA7979");diffusealpha,0.3) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,0;z,-600;customtexturerect,0.8,0,0.85,1;texcoordvelocity,0.07,0;diffuse,color("#DA7979");diffusealpha,0.3) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,40;z,-500;customtexturerect,0.9,0,0.95,1;texcoordvelocity,0.09,0;diffuse,color("#DA7979");diffusealpha,0.3) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,80;z,-400;customtexturerect,0.2,0,0.25,1;texcoordvelocity,0.11,0;diffuse,color("#DA7979");diffusealpha,0.2) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,120;z,-300;customtexturerect,0.2,0,0.25,1;texcoordvelocity,0.13,0;diffuse,color("#DA7979");diffusealpha,0.2) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,160;z,-200;customtexturerect,0.5,0,0.55,1;texcoordvelocity,0.15,0;diffuse,color("#DA7979");diffusealpha,0.1) },
			Def.Sprite{ Texture="streak", OnCommand=cmd(zoom,1.5;y,200;z,-100;customtexturerect,0.8,0,0.85,1;texcoordvelocity,0.17,0;diffuse,color("#DA7979");diffusealpha,0.1) },
		},
	},

	Def.ActorFrame{
	OnCommand=cmd(fov,45;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;rotationz,-30;rotationx,-30;rotationy,-15);
        		LoadActor("arrow.txt")..{ OnCommand=cmd(diffusealpha,0.12;zoom,2;wag;effectmagnitude,0,0,5;effectperiod,5); },
	},

	-- clear the zbuffer so that screens can draw without having to clear it
	Def.Quad{
	OnCommand=cmd(clearzbuffer,1;zoom,0)
	},
}
-- 		<Layer Type="ActorFrame" FOV="45" OnCommand="x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;rotationz,-30;rotationx,-30;rotationy,-15"><children>
-- 			<Layer
-- 				Type="AutoActor"
-- 				File="arrow.txt"
-- 				OnCommand="diffusealpha,0.12;zoom,2;wag;EffectMagnitude,0,0,5;EffectPeriod,5"
-- 			/>
-- 		</children></Layer>
-- 		<!-- clear the zbuffer so that screens can draw without having to clear it -->
-- 		<Layer
-- 			Type="Quad"
-- 			OnCommand="clearzbuffer,1;zoom,0"
-- 		/>		
-- 	</children>
-- </ActorFrame>
