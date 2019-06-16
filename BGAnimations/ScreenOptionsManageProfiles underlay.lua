return Def.ActorFrame{
	
	LoadActor("_frame 3x1",{"explanation metal",SCREEN_WIDTH/1.15})..{
		OnCommand=function(self)
			self:CenterX():y(SCREEN_BOTTOM-60)
		end;
	};

	Def.BitmapText{
		Font="Common Normal";
		Text="&START; OK\n&BACK; Salir";
		OnCommand=function(self)
			self:x(SCREEN_RIGHT-180):y(SCREEN_BOTTOM-60):halign(0)
			:diffuseblink():shadowlength(2):zoom(0.9)
		end;
	};

}