local style = ThemePrefs.Get("ITG1") and "_" or ""
local t = Def.ActorFrame{}
t[#t+1] = Def.Sprite{ Texture=style.."player-frame" };
t[#t+1] = Def.BitmapText{ Font="Common Normal", Text=THEME:GetString("ScreenWorkoutMenu","Weight"), OnCommand=function(s) s:xy(-128,-38):halign(0):zoom(0.5):diffuse(color(".8,.8,.8,1")):shadowlength(2) end; };
t[#t+1] = Def.BitmapText{ Font="Common Normal", Text=THEME:GetString("ScreenWorkoutMenu","GoalType"), OnCommand=function(s) s:xy(-128,-14):halign(0):zoom(0.5):diffuse(color(".8,.8,.8,1")):shadowlength(2) end; };
t[#t+1] = Def.BitmapText{ Font="Common Normal", Text=THEME:GetString("ScreenWorkoutMenu","GoalAmount"), OnCommand=function(s) s:xy(-128,10):halign(0):zoom(0.5):diffuse(color(".8,.8,.8,1")):shadowlength(2) end; };
t[#t+1] = Def.BitmapText{ Font="Common Normal", Text=THEME:GetString("ScreenWorkoutMenu","SimpleSteps"), OnCommand=function(s) s:xy(-128,34):halign(0):zoom(0.5):diffuse(color(".8,.8,.8,1")):shadowlength(2) end; };
return t;