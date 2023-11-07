local t = Def.ActorFrame{}

local positions = {
    { -200, -100, 100, 0 },
    { 100, -100, 0, 100 },
    { 200, 100, -100, 0 },
    { -200, 100, 0, -100 },
    { 100, -100, 0, 100 }
}

-- local totalXMove = 100
for i = 1,5 do
    t[#t+1] = Def.BitmapText{
        Font = "Common Normal",
        Text = THEME:GetString("ScreenIntro","MoreList"..i),
        InitCommand=function(self)
            local totalXMove = positions[i][3]
            local totalYMove = positions[i][4]
            self:xy( positions[i][1], positions[i][2] ):shadowlength(2):zoom(0.6)
            self:diffusealpha(0):sleep( 0.5 * (i-1) )
            :linear(0.5):diffusealpha(1):addx(totalXMove*.25):addy(totalYMove*.25)
            :linear(1):addx(totalXMove*.5):addy(totalYMove*.5)
            :linear(0.5):diffusealpha(0):addx(totalXMove*.25):addy(totalYMove*.25)
        end
    }
end


return t