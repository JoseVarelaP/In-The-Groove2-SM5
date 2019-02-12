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
	local song = params.Song;
		if song then
			self:settext(song:GetDisplayMainTitle())
			if string.len( song:GetDisplaySubTitle() ) > 2 then
				self:zoom(0.9)
				self:y(-7)
			else
				self:zoom(0.95)
				self:y(0)
			end
		end
		self:horizalign('right')
	end
	},
	Def.BitmapText{
	Font="_eurostile normal", InitCommand=function(self)
		self:zoom(1):y(-10):x(-110):maxwidth(480)
	end;
	SetMessageCommand=function(self,params)
	self:shadowlength(1)
	local song = params.Song;
		if song then
			self:settext(song:GetDisplaySubTitle())
			self:zoom(0)
			if string.len( song:GetDisplaySubTitle() ) > 2 then
				self:zoom(0.6)
				self:y(8)
				self:x(100)
			end
		end
		self:horizalign('right')
	end
	},
}