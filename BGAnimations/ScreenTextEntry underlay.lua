return Def.ActorFrame{

	Def.Quad{
		OnCommand=function(s)
			s:FullScreen():diffuse( color("0,0,0,0") ):linear(0.5):diffuse( color("0,0,0,0.7") )
		end;
	};
	
	LoadActor("_frame 3x1",{"answer",450})..{
		OnCommand=function(s)
			s:Center()
		end;
	};

	LoadActor("_frame 3x1",{"text entry question",SCREEN_WIDTH})..{
		OnCommand=function(s)
			s:CenterX():y(SCREEN_CENTER_Y-100)
			:diffuse( ThemePrefs.Get("ITG1") and color("#0099FF") or color("#EE3333"))
		end;
	};

}