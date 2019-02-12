return Def.ActorFrame{
	LoadActor("../_prompt.ogg")..{
		OnCommand=function(self)
			self:play()
		end;
	},
}
