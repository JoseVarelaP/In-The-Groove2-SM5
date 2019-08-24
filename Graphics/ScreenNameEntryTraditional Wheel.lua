-- From the ITG3 theme
local Player = ...
if not Player then error("[ScreenNameEntryTraditional Wheel] If it had to done per player in StepMania 3.95, it has to be done per-player here.") end

local machineProfile = PROFILEMAN:GetMachineProfile()

-- something about making scroller items
local wheelItemFont = "_eurostile normal"
local wheelItemFocus = cmd(diffuseshift;effectcolor1,color("1,1,0,1");effectcolor2,color("0,1,1,1"))

local function MakeHighScoreWheelItem(index)
	return Def.ActorFrame{
		Name=string.format("WheelItem%i",index),
		Def.ActorFrame{
			OnCommand=function(s)
				s:zoom(0.75)
			end;
			UpdateWheelItemMessageCommand=function(self,param)
				if param.Index == index and param.Player == Player then
					local c = self:GetChildren()
					local hs = param.HighScore

					if hs then
						local scoreName = hs:GetName()
						if string.len(scoreName)<1 then
							scoreName = THEME:GetMetric("HighScore","EmptyName")
						end
						c.Name:settext(scoreName)

						-- todo: only use percent score if prefsman percentage scoring
						c.Score:settext(FormatPercentScore(hs:GetPercentDP()))

						-- format date text from "yyyy-mm-dd hh:mm:ss" into "mm/dd"
						local dateText = tostring(hs:GetDate())
						dateText = string.gsub(string.sub(dateText,6,10),"-","/")
						c.Date:settext(dateText)
					else
						c.Name:settext("????")
						c.Score:settext(FormatPercentScore(0))
						c.Date:settext("--/--")
					end

					if param.Focus == index then
						c.Rank:queuecommand("Focus")
						c.Name:queuecommand("Focus")
						c.Score:queuecommand("Focus")
						c.Date:queuecommand("Focus")
					else
						c.Rank:stopeffect()
						c.Name:stopeffect()
						c.Score:stopeffect()
						c.Date:stopeffect()
					end
				end
			end,

			LoadFont(wheelItemFont)..{
				Name="Rank",
				Text=index+1,
				InitCommand=cmd(x,-158;shadowlength,2),
				FocusCommand=wheelItemFocus,
			},
			LoadFont(wheelItemFont)..{
				Name="Name",
				InitCommand=cmd(x,-89;maxwidth,80;shadowlength,2),
				FocusCommand=wheelItemFocus,
			},
			LoadFont(wheelItemFont)..{
				Name="Score",
				InitCommand=cmd(x,87;halign,1;maxwidth,120;shadowlength,2),
				FocusCommand=wheelItemFocus,
			},
			LoadFont(wheelItemFont)..{
				Name="Date",
				InitCommand=cmd(x,134;maxwidth,60;shadowlength,2),
				FocusCommand=wheelItemFocus,
			}
		}
	}
end

--[[
float HighScoreWheel::Scroll()
{
	SetCurrentAndDestinationItem( m_SubActors.size()+5.0f );
	int iIndexToFocus = max( m_iIndexToFocus, 3 );
	SetDestinationItem( (float)iIndexToFocus );
	return GetTweenTimeLeft();
}
--]]

local curFeatNumber = {
	PlayerNumber_P1 = 1,
	PlayerNumber_P2 = 1
}

return Def.ActorFrame{
	InitCommand=cmd(fov,45),

	Def.Sprite{
		Texture=THEME:GetPathG("NameEntry","Items/BGA list frame"),
		OnCommand=function(s)
			s:y(20):queuecommand("DoChange")
		end;
		-- only run the feat update in non-course modes
		RunFeatCommand=function(self)
			if not GAMESTATE:IsCourseMode() then
				self:sleep(THEME:GetMetric("ScreenNameEntryTraditional","FeatInterval"))
				self:queuecommand("DoChange")
			end
		end,
		-- broadcast a message in order for various theme elements to cycle.
		DoChangeCommand=function(self)
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				local curIndex = curFeatNumber[pn]
				local nextIndex = (curIndex%STATSMAN:GetStagesPlayed())+1

				MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,CurrentIndex=curIndex,NewIndex=nextIndex})
				curFeatNumber[pn] = nextIndex
			end
			MESSAGEMAN:Broadcast("SongIndexChanged")
			self:queuecommand("RunFeat")
		end,
	};

	Def.ActorScroller{
		SecondsPerItem=0.2,
		NumItemsToDraw=10.5;
		TransformFunction=function(self,offset,itemIndex,numItems)
			local degrees=16*offset
			local radians=degrees*math.pi/310
			self:rotationx(degrees)
			self:y(math.sin(radians)*90+15)
			self:z(math.cos(radians)*90-90)
		end,
		OffCommand=cmd(stoptweening),

		ChangeDisplayedFeatMessageCommand=function(self,param)
			if param.Player == Player then
				-- reset Wheel position so it can scroll in from above
				self:SetCurrentAndDestinationItem(15)
				self:PositionItems()

				local itemToFocus = -1		-- "-1 means 'out of ranking'"
				local scrollerFocus = 3		-- by default, use 3.

				-- many things go on here, like getting the high scores.
				local playedSS,playerSS,myPercentDP,myScore

				if GAMESTATE:IsCourseMode() then
					playedSS = STATSMAN:GetPlayedStageStats(1)
					playerSS = playedSS:GetPlayerStageStats(Player)
					myPercentDP = playerSS:GetPercentDancePoints()
					myScore = playerSS:GetScore()

					local hsl = machineProfile:GetHighScoreListIfExists(GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(Player))
					if hsl then
						local highScores = hsl:GetHighScores()

						-- find focused item before attempting an update
						for i=1,10 do
							local hs = highScores[i]
							if hs then
								if hs:IsFillInMarker() then
									-- check if this is the proper player
									local hsName = hs:GetName()
									if string.find(hsName,PlayerNumberToString(Player)) then
										if hs:GetPercentDP() == myPercentDP and hs:GetScore() == myScore then
											itemToFocus = i-1
										end
									end
								end
							end
						end
						scrollerFocus = math.max(itemToFocus,3)

						-- update all wheel items
						for i=0,9 do
							MESSAGEMAN:Broadcast("UpdateWheelItem",{Player=param.Player,Index=i,HighScore=highScores[i+1],Focus=itemToFocus})
						end
					end
				else
					-- get high score list for current song/steps combo
					local stagesAgo = (STATSMAN:GetStagesPlayed() - (param.NewIndex-1))
					playedSS = STATSMAN:GetPlayedStageStats(stagesAgo)
					playerSS = playedSS:GetPlayerStageStats(Player)
					local songs = playedSS:GetPlayedSongs()
					local steps = playerSS:GetPlayedSteps()
					local hsl = machineProfile:GetHighScoreListIfExists(songs[1],steps[1])

					-- check player fill in (#P1#, #P2#), player percentDP, and player iScore
					-- versus high score list entry in order to find itemToFocus
					myPercentDP = playerSS:GetPercentDancePoints()
					myScore = playerSS:GetScore()

					if hsl then
						local highScores = hsl:GetHighScores()

						-- find focused item before attempting an update
						for i=1,10 do
							local hs = highScores[i]
							if hs then
								if hs:IsFillInMarker() then
									-- check if this is the proper player
									local hsName = hs:GetName()
									if string.find(hsName,PlayerNumberToString(Player)) then
										if hs:GetPercentDP() == myPercentDP and hs:GetScore() == myScore then
											itemToFocus = i-1
										end
									end
								end
							end
						end
						scrollerFocus = math.max(itemToFocus,3)

						-- update all wheel items
						for i=0,9 do
							MESSAGEMAN:Broadcast("UpdateWheelItem",{Player=param.Player,Index=i,HighScore=highScores[i+1],Focus=itemToFocus})
						end
					end
				end

				-- scroll to new wheel item
				self:SetDestinationItem(scrollerFocus)
				self:PositionItems()
			end
		end,

		MakeHighScoreWheelItem(0),
		MakeHighScoreWheelItem(1),
		MakeHighScoreWheelItem(2),
		MakeHighScoreWheelItem(3),
		MakeHighScoreWheelItem(4),
		MakeHighScoreWheelItem(5),
		MakeHighScoreWheelItem(6),
		MakeHighScoreWheelItem(7),
		MakeHighScoreWheelItem(8),
		MakeHighScoreWheelItem(9)
	},
}
