return Def.ActorFrame{
	LoadActor("roxor logo")..{
	OnCommand=function(self)
		self:Center():FullScreen():zoomtoheight(SCREEN_WIDTH/4*3)
	end;
	},
}