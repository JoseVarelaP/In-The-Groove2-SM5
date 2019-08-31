local t = Def.ActorFrame{
	OnCommand=function(s) s:xy(SCREEN_CENTER_X,SCREEN_TOP+24):addy(-100):sleep(0.5):decelerate(0.8):addy(100) end;
	OffCommand=function(s) s:sleep(1):accelerate(0.8):addy(-100) end;
}

local meterbar = { {0.5,0,SCREEN_WIDTH/11.5},{0,0.5,SCREEN_WIDTH/-11.5},{0.326,0.326,0} }
for v in ivalues(meterbar) do
	t[#t+1] = Def.Sprite{ Texture="meter frame",
		OnCommand=function(s) s:zoomtowidth(SCREEN_WIDTH/2):cropright(v[2]):cropleft(v[1]):x(v[3]) end
	}
end

return t;
