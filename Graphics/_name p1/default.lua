return Def.ActorFrame{
	LoadActor( THEME:GetPathG("","_name frame") ),
	
	Def.BitmapText{
	Text=GAMESTATE:GetPlayerDisplayName(PLAYER_1);
	Font="_eurostile normal",
	OnCommand=cmd(shadowlength,2;zoom,0.5;x,-16;y,-2;diffuse,PlayerColor(PLAYER_1)); 
	},

	LoadActor( "icon p1" )..{ OnCommand=cmd(shadowlength,2;x,44;y,-4); },
}