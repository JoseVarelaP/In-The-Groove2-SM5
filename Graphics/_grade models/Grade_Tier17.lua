return Def.ActorFrame{
	LoadActor("d.txt")..{
	OnCommand=function(self)
		self:zoom(0.85):wag():effectmagnitude(0,0,10)
	end;
	},
}