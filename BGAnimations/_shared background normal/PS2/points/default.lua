local t = Def.ActorFrame{}

local nextToPass = 0
local function CheckRotationAndCulling(self, delta)
    
    local beat = math.floor(GAMESTATE:GetSongPosition():GetSongBeat())

    if beat < 1 then
        nextToPass = 0
    end

    if (beat > nextToPass) and beat < 61 then
        MESSAGEMAN:Broadcast("CrossedBeat"..beat)
        nextToPass = beat
    end

    local rot = self:GetRotationY()
    rot = rot % 360

    if( rot < 150 or rot > 210 ) then
        self:visible(true)
    else
        self:visible(false)
    end
end

local genArray = function(rotmult,panelColor,lightsColor,flareColor)
    local af = Def.ActorFrame{
        OnCommand=function(self)
            self:zoom(0.5):rotationy(45*rotmult):spin():effectmagnitude(0,20,0)
            self:SetUpdateFunction(CheckRotationAndCulling)
        end,
    }

    local rotpoints = {18, 6, -6, -18}
    for i = 1,4 do
        af[#af+1] = Def.ActorFrame{
            InitCommand=function(self)
                self:rotationx(rotpoints[i]):y( 80 * (i-2) ):z(-260):zoom(0.25)
            end,
            Def.Sprite{
                Texture="point panel",
                InitCommand=function(self)
                    self:zbuffer(0):zoom(1.25):z(2)
                    :diffuse( panelColor )
                end
            },

            Def.Sprite{
                Texture="point lights",
                InitCommand=function(self)
                    self:zbuffer(0):zoom(1.25):z(2):effectclock("beat"):playcommand("CrossedBeat1")
                end,
                CrossedBeat1MessageCommand=function(self)
                    self:diffuseshift():effecttiming(0.2,0,1.8,0):effectoffset(-0.7)
                    :effectcolor1(color("#303030")):effectcolor2(lightsColor)
                end,
                CrossedBeat14MessageCommand=function(self)
                    self:diffuse(Color.White):linear(0.3):queuecommand("StopEffect")
                    :linear(0.2):diffuse(color("#303030"))
                    :sleep(0.2):linear(0.2):diffuse(color("#FFFFFF"))
                    :linear(0.2):diffuse(color("#303030"))
                end,
                CrossedBeat17MessageCommand=function(self)
                    self:diffuseshift():effecttiming(0.2,0,1.8,0):effectoffset(-0.7)
                    :effectcolor1(color("#303030")):effectcolor2(lightsColor)
                end,
                CrossedBeat49MessageCommand=function(self)
                    self:diffuseshift():effecttiming(0.2,0,3.8,0):effectoffset(-0.7)
                    :effectcolor1(color("#303030")):effectcolor2(lightsColor)
                end,
                CrossedBeat61MessageCommand=function(self)
                    self:playcommand("CrossedBeat1")
                end,
                StopEffectCommand=function(self) self:stopeffect() end
            },

            Def.Sprite{
                Texture="point flare",
                InitCommand=function(self)
                    self:z(6):zoom(1.25):blend("BlendMode_Add"):effectclock("beat"):playcommand("CrossedBeat1")
                end,
                CrossedBeat1MessageCommand=function(self)
                    self:diffuseshift():effecttiming(0.2,0,1.8,0):effectoffset(-0.7)
                    :effectcolor1(color("#000000")):effectcolor2(flareColor)
                end,
                CrossedBeat14MessageCommand=function(self)
                    self:diffuse(Color.White):linear(0.3):queuecommand("StopEffect")
                    :linear(0.2):diffuse(color("#000000"))
                    :sleep(0.2):linear(0.2):diffuse(color("#FFFFFF"))
                    :linear(0.2):diffuse(color("#000000"))
                end,
                CrossedBeat17MessageCommand=function(self)
                    self:diffuseshift():effecttiming(0.2,0,1.8,0):effectoffset(-0.7)
                    :effectcolor1(color("#000000")):effectcolor2(flareColor)
                end,
                CrossedBeat49MessageCommand=function(self)
                    self:diffuseshift():effecttiming(0.2,0,3.8,0):effectoffset(-0.7)
                    :effectcolor1(color("#000000")):effectcolor2(flareColor)
                end,
                CrossedBeat61MessageCommand=function(self)
                    self:playcommand("CrossedBeat1")
                end,
                StopEffectCommand=function(self) self:stopeffect() end
            }
        }
    end

    return af
end

local column = Def.ActorFrame{
    FOV=72,
    OnCommand=function(self)
        self:Center():z(300)
    end,

    -- Red
    genArray(3,color("#808080B0"),color("#D83D3D"),color("#D83D3D")),
    genArray(7,color("#808080B0"),color("#D83D3D"),color("#D83D3D")),

    -- Green
    genArray(2,color("#808080B0"),color("#5BD83D"),color("#5BD83D")),
    genArray(6,color("#808080B0"),color("#5BD83D"),color("#5BD83D")),

    -- Blue
    genArray(0,color("#808080B0"),color("#3AA0D2"),color("#3AA0D2")),
    genArray(4,color("#808080B0"),color("#3AA0D2"),color("#3AA0D2")),

    -- Yellow
    genArray(1,color("#808080B0"),color("#E2D249"),color("#E2D249")),
    genArray(5,color("#808080B0"),color("#E2D249"),color("#E2D249"))
}

t[#t+1] = column

return t