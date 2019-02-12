return Def.ActorFrame{
	LoadActor("../ScreenWithMenuElements underlay/back"),
	LoadActor("../_shared underlay arrows"),

	Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+80):y(SCREEN_CENTER_Y+60):z(-100):zoom(1.3)
	end;

		LoadActor("char")..{
			OnCommand=function(self)
				self:ztest(1):glow(1,1,1,0):diffusealpha(0):linear(0.3):glow(1,1,1,1):sleep(0.001):diffusealpha(1):linear(0.3):glow(1,1,1,0)
			end;
			OffCommand=function(self)
				self:linear(0.3):diffusealpha(0)
			end;
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
