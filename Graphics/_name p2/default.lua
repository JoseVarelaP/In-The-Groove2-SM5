return Def.ActorFrame{
	LoadActor( THEME:GetPathG("","_name frame") ),
	Def.BitmapText{
	Font="_eurostile normal",
	OnCommand=function(self)
		self:shadowlength(2):zoom(0.5):x(-16):y(-2)
		if GAMESTATE:IsSideJoined(PLAYER_2) then
			self:diffuse(PlayerColor(PLAYER_2))
			self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_2))
		end
	end
	},
	LoadActor( "icon p2" )..{ OnCommand=cmd(shadowlength,2;x,44;y,2); },
}