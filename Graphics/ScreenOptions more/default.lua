return Def.ActorFrame{
	LoadActor("triangle")..{
	OnCommand=function(self)
		self:x(-48):diffuseblink():effectcolor1(0.6,0.6,0.6,1):effectperiod(0.4):effectoffset(0.2):effectclock("bgm")
	end;
	ExitSelectedP1Command=function(self)
		self:stoptweening():linear(.15):rotationz(-90)
	end;
	ExitUnselectedP1Command=function(self)
		self:stoptweening():linear(.15):rotationz(0)
	end;
	},
	
	LoadActor("triangle")..{
	OnCommand=function(self)
		self:x(48):diffuseblink():effectcolor1(0.6,0.6,0.6,1):effectperiod(0.4):effectoffset(0.2):effectclock("bgm")
	end;
	ExitSelectedP2Command=function(self)
		self:stoptweening():linear(.15):rotationz(90)
	end;
	ExitUnselectedP2Command=function(self)
		self:stoptweening():linear(.15):rotationz(0)
	end;
	},

	LoadActor("moreexit")..{
	OnCommand=function(self)
		self:y(-18):croptop(.57):cropbottom(.1)
	end;
	},
}
