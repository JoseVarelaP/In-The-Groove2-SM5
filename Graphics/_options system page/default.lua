return Def.ActorFrame{
	LoadActor("options page")..{
	OnCommand=function(self)
		self:addy(-1)
	end;
	},

	LoadActor("line highlight mask right")..{
	OnCommand=function(self)
		self:addy(-135):x(290):zwrite(1):blend(Blend.NoEffect)
	end;
	},
}