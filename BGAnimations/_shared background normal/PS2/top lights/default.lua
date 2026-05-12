local t = Def.ActorFrame{
    FOV=70,
    OnCommand=function(self)
        self:Center():z(300)
    end
}


local c = 0
for i = 0,1 do
    for a = 1,3 do
        local calc = i + (a*2) - 2
        t[#t+1] = Def.ActorFrame{
            Name="1",
            OnCommand=function(self)
                self:zbuffer(false):y(-90):zoom(0.5):rotationy(60 * (calc)):spin():effectmagnitude(0,20,0)
            end,

            LoadActor("set".. (i+1)) .. { 
                InitCommand=function(self)
                    self:z(-200):rotationx(30)
                end
            }
        }
    end
end

return t