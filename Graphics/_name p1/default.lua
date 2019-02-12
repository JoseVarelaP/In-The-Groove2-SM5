return Def.ActorFrame{
	LoadActor( THEME:GetPathG("","_name frame") ),
	Def.BitmapText{
	Font="_eurostile normal",
	OnCommand=function(self)
		self:shadowlength(2):zoom(0.5):x(-16):y(-2)
		if GAMESTATE:IsSideJoined(PLAYER_1) then
			self:diffuse(PlayerColor(PLAYER_1))
			self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_1))
		end
	end
	},
	
	LoadActor( "icon p1" )..{
		 OnCommand=function(self)
			self:shadowlength(2):x(44):y(-4)
		end
	},
}