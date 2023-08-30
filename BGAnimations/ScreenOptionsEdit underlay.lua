local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame {
    InitCommand=function(self)
        self:y(SCREEN_BOTTOM-60)
    end,
	Def.ActorFrame{
		LoadActor("_frame 3x1",{"explanation metal",SCREEN_WIDTH/1.15})..{
			OnCommand=function(self)
				self:CenterX()
			end
		},
	
		Def.BitmapText{
			Font="Common Normal",
			Text=THEME:GetString("ScreenOptionsService","HelpText"),
			OnCommand=function(self)
				self:x(SCREEN_RIGHT-180):halign(0)
				:diffuseblink():shadowlength(2):zoom(0.9):maxwidth(145)
			end
		}
	}
}

return t