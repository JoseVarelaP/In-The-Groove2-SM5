local style = ThemePrefs.Get("ITG1") and "_" or ""
local t = Def.ActorFrame{}
t[#t+1] = Def.Sprite{ Texture=style.."shared-frame" };
t[#t+1] = Def.BitmapText{
    Font="Common Normal", Text=THEME:GetString("ScreenWorkoutMenu","SelectType"),
    OnCommand=function(s) s:xy(-274,-14):halign(0):zoom(0.5):diffuse(color(".8,.8,.8,1")) end;
};
return t;