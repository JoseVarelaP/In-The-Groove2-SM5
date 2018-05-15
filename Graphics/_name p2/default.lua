return Def.ActorFrame{
	LoadActor( THEME:GetPathG("","_name frame") ),
	
	Def.BitmapText{ Text=GAMESTATE:GetPlayerDisplayName(PLAYER_2); Font="_eurostile normal",
		OnCommand=cmd(shadowlength,2;zoom,0.5;x,-16;y,-2;diffuse,PlayerColor(PLAYER_2)); 
	},

	LoadActor( "icon p2" )..{ OnCommand=cmd(shadowlength,2;x,44;y,2); },
}