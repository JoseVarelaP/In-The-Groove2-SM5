local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{ Texture="in", OnCommand=function(s) s:xy(-240,-60):diffusealpha(0):sleep(1):zoom(4):linear(0.3):diffusealpha(1):zoom(1) end; }
t[#t+1] = Def.Sprite{ Texture="in", OnCommand=function(s) s:xy(-240,-60):diffusealpha(0):sleep(1):glow(Color.White):zoom(1):linear(0.5):glow(color("1,1,1,0")):zoom(3) end; }
t[#t+1] = Def.Sprite{ Texture="the", OnCommand=function(s) s:xy(-80,-60):diffusealpha(0):sleep(1.2):zoom(4):linear(0.3):diffusealpha(1):zoom(1) end; }
t[#t+1] = Def.Sprite{ Texture="the", OnCommand=function(s) s:xy(-80,-60):diffusealpha(0):sleep(1.2):glow(Color.White):zoom(1):linear(0.5):glow(color("1,1,1,0")):zoom(3) end; }
t[#t+1] = Def.Sprite{ Texture="groove", OnCommand=function(s) s:xy(-40,46):diffusealpha(0):sleep(1.4):zoom(4):linear(0.3):diffusealpha(1):zoom(1) end; }
t[#t+1] = Def.Sprite{ Texture="groove", OnCommand=function(s) s:xy(-40,46):diffusealpha(0):sleep(1.4):glow(Color.White):zoom(1):linear(0.5):glow(color("1,1,1,0")):zoom(3) end; }

return t;
