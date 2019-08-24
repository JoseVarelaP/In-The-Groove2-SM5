local stopatframe=...
return Def.ActorFrame{
	Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+2):y(SCREEN_CENTER_Y+18)
	end;
		LoadActor("credits frame"),
		
		Def.Quad{
			 OnCommand=function(self)
				self:y(-228):zwrite(1):blend("BlendMode_NoEffect"):zoomto(340,66)
			end
		},
		
		Def.Quad{
			 OnCommand=function(self)
				self:y(223):zwrite(1):blend("BlendMode_NoEffect"):zoomto(340,66)
			end
		},
		LoadActor( THEME:GetPathB("","_ITG credits text"), stopatframe ),
	},
}