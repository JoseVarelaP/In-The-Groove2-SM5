return Def.ActorFrame{

	LoadActor("ScreenWithMenuElements underlay"),

	LoadModule("HeaderText.lua")(Var "LoadingScreen"),

	Def.DeviceList {
		Font="Common Normal",
		InitCommand=function(self)
			self:xy(20,80):zoom(0.8):halign(0)
		end
	},

	Def.InputList {
		Font="Common Normal",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X-280,SCREEN_CENTER_Y):zoom(1):halign(0):vertspacing(8):zoom(0.6)
		end
	}
}