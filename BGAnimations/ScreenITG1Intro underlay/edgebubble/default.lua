return Def.ActorFrame{
	Def.Sprite{
		Texture="1.png",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
			:zoom(1.3):fadeleft(0.2):faderight(0.2)
		end,
		OnCommand=function(self)
			-- self:zoomx(1):zoomy(1)
			self:valign(0)--:glowshift()
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
			self:valign(0)--:glowshift()
		end
	},

	Def.Quad{
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X):valign(0)
			:zoomto(SCREEN_WIDTH, 200):fadebottom(0.8)
			:diffuseshift()
		end,
		OnCommand=function(self)
			-- self:zoomx(1):zoomy(1)
			self:valign(0)--:glowshift()
			:effectcolor1(color("#ffffff20"))
			:effectcolor2(color("#ffffff10"))
		end
	},

	Def.Quad{
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM):valign(1)
			:zoomto(SCREEN_WIDTH, 200):fadetop(0.8)
			:diffuseshift()
		end,
		OnCommand=function(self)
			self:effectcolor1(color("#ffffff20"))
			:effectcolor2(color("#ffffff10"))
		end
	}
}