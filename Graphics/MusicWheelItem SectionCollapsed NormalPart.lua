return Def.ActorFrame{
	OnCommand=function(self)
		self:ztest(1):addx(-420):sleep(0.35):linear(0.5):addx(420)
	end;
	OffCommand=function(self)
		self:linear(0.5):addx(-420)
	end;
	
	Def.Sprite{ Texture="WheelItems/SectionCollapsed" },
	
	Def.BitmapText{
	Font="_eurostile normal", InitCommand=function(self)
		self:zoom(1):x(-30):strokecolor(0.2,0.2,0.2,1):maxwidth(220)
	end;
	SetMessageCommand=function(self,params)
	self:shadowlength(1)
	local Group = params.Text;
		if Group then
			self:settext(Group)
		end
	end
	},
};