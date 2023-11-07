return Def.ActorFrame{
	Def.Sprite{
		Texture="1.png",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
			:zoom(1.3):fadeleft(0.2):faderight(0.2)
		end,
		OnCommand=function(self)
			-- self:zoomx(1):zoomy(1)
			self:valign(0):glowshift()
			:effectcolor1(color("#ffffff10"))
			:effectcolor2(color("#ffffff00"))
		end
	},
	Def.Sprite{
		Texture="1.png",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
			:zoom(1.3):rotationz(180):fadeleft(0.2):faderight(0.2)
		end,
		OnCommand=function(self)
			-- self:zoomx(1):zoomy(1)
			self:valign(0):glowshift()
			:effectcolor1(color("#ffffff10"))
			:effectcolor2(color("#ffffff00"))
		end
	}
}