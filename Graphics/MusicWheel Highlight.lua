return Def.ActorFrame{
	InitCommand=cmd(fov,58;ztest,1;addx,-420;sleep,0.4;linear,0.5;addx,420);
	LoadActor("WheelItems/Wheel highlight")..{ OnCommand=cmd(x,-30;zoomx,1.2;rotationy,0;diffuseshift;effectcolor2,1,1,1,0.7;effectcolor1,1,1,1,0.3;effectperiod,1.0;effectoffset,0.2;effectclock,"beat";ztest,1) },
}