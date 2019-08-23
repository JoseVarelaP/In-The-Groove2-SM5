local c;
local player = Var "Player";
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");
local Pulse = function(self)
	local combo=self:GetZoom()
	local newZoom=scale(combo,0,500,0.9,1.4)
	self:zoom(1.2*newZoom):linear(0.05):zoom(newZoom)
end
local PulseLabel = THEME:GetMetric("Combo", "PulseLabelCommand");

local FullComboGreats = THEME:GetMetric("Combo", "FullComboGreatsCommand");
local FullComboPerfects = THEME:GetMetric("Combo", "FullComboPerfectsCommand");
local FullComboMarvelouses = THEME:GetMetric("Combo", "FullComboMarvelousesCommand");

local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom");
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom");
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt");

local LabelMinZoom = THEME:GetMetric("Combo", "LabelMinZoom");
local LabelMaxZoom = THEME:GetMetric("Combo", "LabelMaxZoom");

local t = Def.ActorFrame {
	InitCommand=function(self)
		self:vertalign(bottom)
	end;
	
	-- These are behind the combo and label for obvious reasons.
	-- 100 Combo milestone
	LoadActor("explosion")..{
	InitCommand=function(self)
		self:diffusealpha(0):blend("BlendMode_Add")
	end;
	HundredMilestoneCommand=function(self)
		self:rotationz(0):zoom(2.6):diffusealpha(0.5):linear(0.5):rotationz(90):zoom(2):diffusealpha(0)
	end;
	},

	LoadActor("explosion")..{
	InitCommand=function(self)
		self:diffusealpha(0):blend("BlendMode_Add")
	end;
	HundredMilestoneCommand=function(self)
		self:rotationz(0):zoom(2.6):diffusealpha(0.5):linear(0.5):rotationz(-90):zoom(2):diffusealpha(0)
	end;
	},

	-- 1000 Combo milestone
	LoadActor("explosion")..{
	InitCommand=function(self)
		self:diffusealpha(0):blend("BlendMode_Add")
	end;
	ThousandMilestoneCommand=function(self)
		self:rotationz(0):zoom(2.6):diffusealpha(0.5):linear(0.5):rotationz(90):zoom(2):diffusealpha(0)
	end;
	},

	LoadActor("explosion")..{
	InitCommand=function(self)
		self:diffusealpha(0):blend("BlendMode_Add")
	end;
	ThousandMilestoneCommand=function(self)
		self:rotationz(0):zoom(2.6):diffusealpha(0.5):linear(0.5):rotationz(-90):zoom(2):diffusealpha(0)
	end;
	},

	LoadActor("shot")..{
	InitCommand=function(self)
		self:diffusealpha(0):blend("BlendMode_Add")
	end;
	ThousandMilestoneCommand=function(self)
		self:zoomx(-2):zoomy(2):diffusealpha(1):x(0):linear(0.5):diffusealpha(0):x(-150)
	end;
	},
	LoadActor("shot")..{
	InitCommand=function(self)
		self:diffusealpha(0):blend("BlendMode_Add")
	end;
	ThousandMilestoneCommand=function(self)
		self:zoomx(2):zoomy(2):diffusealpha(1):x(0):linear(0.5):diffusealpha(0):x(150)
	end;
	},

	LoadFont( "_xenotron", "metal" ) .. {
		Name="Number";
		OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		BeginCommand=function(self)
			self:y(5)
		end;
		ComboCommand=function(s)
			if s:GetText() and s:GetText() ~= "" then
				local zoomed = ThemePrefs.Get("UseComboZoom") and (scale( s:GetText() ,0,500,0.9,1.4) > 1.4 and 1.4 or scale( s:GetText() ,0,500,0.9,1.4)) or 1
				s:finishtweening():zoom(1.2*zoomed):linear(0.05):zoom(zoomed)
			end
		end;
	};
	LoadActor("label") .. {
		Name="Label";
		OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
	};
	LoadActor("misses") .. {
		Name="Misses";
		OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
	};



	
	InitCommand = function(self)
		c = self:GetChildren();
		c.Number:visible(false);
		c.Label:visible(false);
		c.Misses:visible(false);
	end;
	-- Milestones:
	-- 25,50,100,250,600 Multiples;
--[[ 		if (iCombo % 100) == 0 then
			c.OneHundredMilestone:playcommand("Milestone");
		elseif (iCombo % 250) == 0 then
			-- It should really be 1000 but thats slightly unattainable, since
			-- combo doesnt save over now.
			c.OneThousandMilestone:playcommand("Milestone");
		else
			return
		end; --]]
	ComboCommand=function(self, param)
		local iCombo = param.Misses or param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			c.Number:visible(false);
			c.Number:y(15);
			c.Label:visible(false);
			c.Label:y(10);
			c.Misses:y(10);
			c.Number:x(-5);
			c.Label:x(-5);
			c.Misses:x(-5);
			return;
		end

		c.Label:visible(false);

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );
		
		param.LabelZoom = scale( iCombo, 0, NumberMaxZoomAt, LabelMinZoom, LabelMaxZoom );
		param.LabelZoom = clamp( param.LabelZoom, LabelMinZoom, LabelMaxZoom );
		
		c.Number:visible(true);
		c.Label:visible(true);
		c.Number:settext( string.format("%i", iCombo) );
		-- FullCombo Rewards
		if param.FullComboW1 then
			c.Number:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#94EBFE")):effectperiod(0.5);
			c.Label:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#94EBFE")):effectperiod(0.5);
		elseif param.FullComboW2 then
			c.Number:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FDD599")):effectperiod(0.5);
			c.Label:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FDD599")):effectperiod(0.5);
		elseif param.FullComboW3 then
			c.Number:stopeffect();
			c.Label:stopeffect();
		elseif param.Combo then
			c.Number:diffuse(Color("White"));
			c.Number:stopeffect();
			c.Label:stopeffect();
			c.Misses:visible(false);
			c.Label:diffuse(Color("White"));
		else
			c.Number:diffuse(color("#ff0000"));
			c.Label:visible(false);
			c.Number:stopeffect();
			c.Label:stopeffect();
			c.Misses:visible(true);
			c.Misses:diffuse(color("#ff0000"));
		end

		c.Number:finishtweening();
		c.Label:finishtweening();
		-- Pulse
		Pulse( c.Number );
		PulseLabel( c.Label, param );
		PulseLabel( c.Misses, param );
		-- Milestone Logic
	end;
};

return t;
