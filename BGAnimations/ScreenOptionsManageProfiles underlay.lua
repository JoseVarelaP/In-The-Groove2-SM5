return Def.ActorFrame{
	
	LoadActor("_frame 3x1",{"explanation metal",SCREEN_WIDTH/1.15})..{
		OnCommand=function(self)
			self:CenterX():y(SCREEN_BOTTOM-60)
		end
	},

	Def.BitmapText{
		Font="Common Normal",
		Text="&START; OK\n&BACK; Salir",
		OnCommand=function(self)
			self:x(SCREEN_RIGHT-180):y(SCREEN_BOTTOM-60):halign(0)
			:diffuseblink():shadowlength(2):zoom(0.9)
		end
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X+140,SCREEN_CENTER_Y):addx(SCREEN_WIDTH):decelerate(0.3):addx(-SCREEN_WIDTH)
		end,
		CancelMessageCommand=function(self)
			self:accelerate(0.3):addx(SCREEN_WIDTH)
		end,

		LoadActor( THEME:GetPathB("","_frame 3x3"), {"info",190,70}),
		Def.BitmapText{ Font="Common Normal",
			OnCommand=function(self) self:y(-50):zoom(0.7) end,
			ProfileSelectedMessageCommand=function(self,params)
				self:settext( params.Name or "" )
			end
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self) self:y(30):zoom(0.4) end,
			ProfileSelectedMessageCommand=function(self,params)
				self:settext("")
				for i=1,PROFILEMAN:GetNumLocalProfiles() do
					local current = PROFILEMAN:GetLocalProfileFromIndex(i-1)
					-- SCREENMAN:SystemMessage( "total: "..Profiles.. " now:".. tostring(current) .. " Sent: "..Sent)
					if current and params.Name == current:GetDisplayName() then
						local Complete = ""
						local Items = {
							{ {"ScreenOptionsManageProfiles","Total Songs Played"}, current:GetNumTotalSongsPlayed() },
							{ {"ScreenEvaluation","Calories Burned"}, current:GetTotalCaloriesBurned() },
							{ {"ScreenEvaluation","Total Play Time"}, SecondsToMMSS(current:GetTotalGameplaySeconds()) },
							{ {"ScreenWorkoutMenu","Weight"}, current:GetWeightPounds() .. " Lb" },
							{ "GUID", current:GetGUID() },
						}
						for v in ivalues(Items) do
							Complete = Complete .. string.format( (type(v[2]) == "string" and v[2].." - " or "%i - ")..
							(type(v[1]) == "table" and THEME:GetString(v[1][1],v[1][2]) or v[1])
							, v[2] ) .. "\n"
						end
						self:settext(Complete)
					end
				end
			end
		}
	}

}