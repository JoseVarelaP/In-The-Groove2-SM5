return Def.ActorFrame{
	OnCommand=cmd(ztest,1;addx,-420;sleep,0.35;linear,0.5;addx,420);
	OffCommand=cmd(linear,0.5;addx,-420);
	
	Def.Sprite{ Texture="WheelItems/SectionCollapsed" },
	
	Def.BitmapText{
	Font="_eurostile normal", InitCommand=cmd(zoom,1;x,-30;strokecolor,0.2,0.2,0.2,1;maxwidth,220);
	SetMessageCommand=function(self,params)
	self:shadowlength(1)
	local Group = params.Text;
		if Group then
			self:settext(Group)
		end
	end
	},
};