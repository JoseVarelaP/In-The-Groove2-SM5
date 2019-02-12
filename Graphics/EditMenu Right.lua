return Def.ActorFrame{
	
	LoadActor("EditMenu Left")..{
		 OnCommand=function(self)
			self:zoomx(-1)
		end
	},
}