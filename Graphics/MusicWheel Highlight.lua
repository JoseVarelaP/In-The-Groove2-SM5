return Def.ActorFrame{
	InitCommand=function(self)
		self:fov(58):ztest(1):addx(-500):sleep(0.4):linear(0.45):addx(500)
	end;
	
	LoadActor("WheelItems/Wheel highlight")..{
		 OnCommand=function(self)
			self:x(-80):zoomx(1.3):zoomy(1.4):y(-6):diffuseshift():effectcolor1(1,1,1,0.7):effectcolor2(1,1,1,0.3):effectperiod(1.0):effectoffset(0.2):effectclock("beat"):ztest(1)
		end
	},
}