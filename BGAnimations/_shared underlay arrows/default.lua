return Def.ActorFrame{
	LoadActor("arrow")..{
	InitCommand=cmd(x,SCREEN_LEFT+64;y,SCREEN_CENTER_Y);
	OnCommand=cmd(addx,-200;decelerate,0.5;addx,200);
	MenuLeftP1MessageCommand=cmd(playcommand, "Blink");
	MenuLeftP2MessageCommand=cmd(playcommand, "Blink");
	BlinkCommand=cmd(finishtweening;zoom,1.2;glow,1,1,1,1;linear,0.2;glow,1,1,1,0;zoom,1);
	MadeChoiceP1MessageCommand=cmd(playcommand,GoOff);
	MadeChoiceP2MessageCommand=cmd(playcommand,GoOff);
	GoOffCommand=cmd(accelerate,0.5;addx,-200);
	},
	LoadActor("arrow")..{
	InitCommand=cmd(x,SCREEN_RIGHT-64;y,SCREEN_CENTER_Y;rotationz,180);
	OnCommand=cmd(addx,-200;decelerate,0.5;addx,200);
	MenuRightP1MessageCommand=cmd(playcommand, "Blink");
	MenuRightP2MessageCommand=cmd(playcommand, "Blink");
	BlinkCommand=cmd(finishtweening;zoom,1.2;glow,1,1,1,1;linear,0.2;glow,1,1,1,0;zoom,1);
	MadeChoiceP1MessageCommand=cmd(playcommand,GoOff);
	MadeChoiceP2MessageCommand=cmd(playcommand,GoOff);
	GoOffCommand=cmd(accelerate,0.5;addx,200);
	},
}