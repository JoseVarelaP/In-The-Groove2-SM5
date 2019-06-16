local t = Def.ActorFrame{};
InitUserPrefs();
t[#t+1] = Def.ActorFrame {
    OnCommand=function(self)
        if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
            Trace("ThemePrefs doesn't exist; creating file")
            ThemePrefs.ForceSave()
        end
        ThemePrefs.Save()
    end;

    LoadActor("_frame 3x1",{"explanation metal",SCREEN_WIDTH/1.15})..{
		OnCommand=function(self)
			self:CenterX():y(SCREEN_BOTTOM-60)
		end;
	};

	Def.BitmapText{
		Text="&START; OK\n&BACK; Salir";
		OnCommand=function(self)
			self:x(SCREEN_RIGHT-180):y(SCREEN_BOTTOM-60):halign(0)
			:diffuseblink():shadowlength(2):zoom(0.9)
		end;
	};

};

return t;