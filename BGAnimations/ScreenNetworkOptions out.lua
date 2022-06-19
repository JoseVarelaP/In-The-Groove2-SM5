return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(color("#000000")):FullScreen()
		end,
		OnCommand=function(self)
			self:cropleft(1):fadeleft(.5):linear(0.5):cropleft(-0.5):sleep(0.5)
		end
	}
}
