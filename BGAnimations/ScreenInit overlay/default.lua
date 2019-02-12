return Def.ActorFrame {
		Def.Quad {
			InitCommand=function(self)
				self:FullScreen()
			end;
			OnCommand=function(self)
				self:diffuse(Color.Black):sleep(1.5):linear(0.25)
			end;
		};
		
		LoadActor("splash")..{
			 OnCommand=function(self)
				self:Center()
			end
		},
	};
