local t = Def.ActorFrame{
	CodeMessageCommand=function(self,param)
		local ts = SCREENMAN:GetTopScreen()
		-- check if player is done entering name, or if screen is transitioning
		if ts:GetFinalized(param.PlayerNumber) or ts:IsTransitioning() then
			return
		end

		-- otherwise, handle inputs.
		-- param.PlayerNumber
		-- param.Name: "Left","Right","Backspace","Enter"

		if param.Name == "Left" or param.Name == "AltLeft" then
			MESSAGEMAN:Broadcast("KeyboardLeft",{Player=param.PlayerNumber})
		elseif param.Name == "Right" or param.Name == "AltRight" then
			MESSAGEMAN:Broadcast("KeyboardRight",{Player=param.PlayerNumber})
		elseif param.Name == "Backspace" then
			ts:Backspace(param.PlayerNumber)
			MESSAGEMAN:Broadcast("UpdateSelection",{Player=param.PlayerNumber})
		elseif param.Name == "Enter" then
			MESSAGEMAN:Broadcast("KeyboardEnter",{Player=param.PlayerNumber})

			-- todo: run any checks needed here?
		end
	end,
};
-- Keyboard
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "Keyboard" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Keyboard"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name(MetricsName)
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end


return t;