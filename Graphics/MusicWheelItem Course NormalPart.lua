return Def.ActorFrame{
	OnCommand=function(self)
		self:ztest(1):addx(-420):sleep(0.35):linear(0.5):addx(420)
	end;
	OffCommand=function(self)
		self:linear(0.5):addx(-420)
	end;

	LoadActor("WheelItems/WheelSong NormalPart"),
	Def.BitmapText{
	Font="_eurostile normal", InitCommand=function(self)
		self:zoom(1):y(0):x(100):maxwidth(280)
	end;
	SetMessageCommand=function(self,params)
	self:shadowlength(1)
	local song = params.Course;
		if song then
			self:settext(song:GetDisplayFullTitle())
		end
		self:horizalign('right')
	end
	},
}