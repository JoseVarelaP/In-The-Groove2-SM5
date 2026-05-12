local gc = Var"GameCommand"

return Def.BitmapText{
	Text=THEME:GetString(Var "LoadingScreen","Desc"..gc:GetName()),
	Font="Common Normal",
	InitCommand=function(self)
		self:xy( SCREEN_CENTER_X - 280, SCREEN_CENTER_Y + 160 ):horizalign(left):vertalign(top):zoom(0.8)
		:wrapwidthpixels(500)
		:visible(false):cropright(1)
	end,
	GainFocusCommand=function(self)
		self:visible(true):stoptweening():cropright(1):linear(1.25):cropright(0)
	end,
	LoseFocusCommand=function(self)
		self:visible(false):stoptweening():cropright(1)
	end
}