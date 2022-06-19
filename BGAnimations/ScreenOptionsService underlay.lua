local t = Def.ActorFrame{}
InitUserPrefs()

local TweenNoList = {
	["ScreenOptionsService"] = {5,6,7},
	["ScreenOptionsDisplaySub"] = {6},
	["ScreenOptionsInputSub"] = {5},
}

t[#t+1] = Def.ActorFrame {
    OnCommand=function(self)
        if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
            Trace("ThemePrefs doesn't exist; creating file")
            ThemePrefs.ForceSave()
        end
        ThemePrefs.Save()
    end,

	Def.ActorFrame{
		OnCommand=function(self)
			local di = 0
			self:y(SCREEN_BOTTOM-60)
			if SCREENMAN:GetTopScreen():GetName() then GAMESTATE:Env()["LastScreen"] = SCREENMAN:GetTopScreen():GetName() end
			if GAMESTATE:Env()["LastScreen"] then
				if TweenNoList[ GAMESTATE:Env()["LastScreen"] ] then
					for v in ivalues( TweenNoList[ GAMESTATE:Env()["LastScreen"] ] ) do
						if (v == GAMESTATE:Env()["CurrentServiceItem"]) then di = 1 end
					end
				end
			end
			self:diffusealpha(di):accelerate(0.5):diffusealpha(1)
		end,
		OffCommand=function(self)
			local di = 0
			if GAMESTATE:Env()["LastScreen"] then
				if TweenNoList[ GAMESTATE:Env()["LastScreen"] ] then
					for v in ivalues( TweenNoList[ GAMESTATE:Env()["LastScreen"] ] ) do
						if (v == GAMESTATE:Env()["CurrentServiceItem"]) then di = 1 end
					end
				end
			end
			self:accelerate(0.5):diffusealpha(di)
		end,
		
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