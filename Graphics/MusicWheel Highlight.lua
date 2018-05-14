return Def.ActorFrame{
	InitCommand=cmd(fov,58;ztest,1;addx,-500;sleep,0.4;linear,0.45;addx,500);
	--OffCommand=cmd(linear,0.5;addx,-420);
	LoadActor("WheelItems/Wheel highlight")..{ OnCommand=cmd(x,-80;zoomx,1.2;rotationz,0.5;rotationy,-5;diffuseshift;effectcolor2,1,1,1,0.7;effectcolor1,1,1,1,0.3;effectperiod,1.0;effectoffset,0.2;effectclock,"beat";ztest,1) },
}