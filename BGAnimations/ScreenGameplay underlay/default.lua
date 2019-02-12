return Def.ActorFrame{
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:GetPlayMode()=="PlayMode_Regular" and GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()=="Difficulty_Beginner" or GAMESTATE:IsHumanPlayer(PLAYER_2) and GAMESTATE:GetPlayMode()=="PlayMode_Regular" and GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()=="Difficulty_Beginner";
		InitCommand=function(self)
			self:CenterX():y(SCREEN_CENTER_Y-30)
		end;
		Def.ActorFrame{
			LoadActor("light_frame");

			Def.ActorFrame{
				Name="LightColors";
				LoadActor("light_green")..{
					InitCommand=function(self)
						self:y(-96):diffusealpha(0):rotationz(0):blend(Blend.Add)
					end;
					NoteCrossedMessageCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):diffusealpha(0)
					end;
				};
				LoadActor("light_yellow")..{
					InitCommand=function(self)
						self:y(-32):diffusealpha(0):rotationz(45):blend(Blend.Add)
					end;
					NoteWillCrossIn400MsMessageCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(.8):diffusealpha(0)
					end;
				};
				LoadActor("light_yellow")..{
					InitCommand=function(self)
						self:y(31):diffusealpha(0):rotationz(90):blend(Blend.Add)
					end;
					NoteWillCrossIn800MsMessageCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(.8):diffusealpha(0)
					end;
				};
				LoadActor("light_red")..{
					InitCommand=function(self)
						self:y(95):diffusealpha(0):rotationz(135):blend(Blend.Add)
					end;
					NoteWillCrossIn1200MsMessageCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(.8):diffusealpha(0)
					end;
				};
			};

			Def.ActorFrame{
				Name="LightDots";
				LoadActor("light_dot")..{
					InitCommand=function(self)
						self:diffusealpha(0)
					end;
					NoteWillCrossIn400MsMessageCommand=function(self)
						self:finishtweening():y(-32):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0)
					end;
				};
				LoadActor("light_dot")..{
					InitCommand=function(self)
						self:diffusealpha(0)
					end;
					NoteWillCrossIn800MsMessageCommand=function(self)
						self:finishtweening():y(32):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0)
					end;
				};
				LoadActor("light_dot")..{
					InitCommand=function(self)
						self:diffusealpha(0)
					end;
					NoteWillCrossIn1200MsMessageCommand=function(self)
						self:finishtweening():y(96):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0)
					end;
				};
			};

			Def.ActorFrame{
				Name="DirectionText";
				InitCommand=function(self)
					self:y(-96)
				end;

				LoadFont("_eurostile outline")..{ Text="Left!"; InitCommand=function(self)
					self:diffusealpha(0):maxwidth(70)
				end;
					CrossCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0)
					end;
					NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Left" then self:playcommand("Cross"); end end;
					NoteCrossedJumpMessageCommand=function(self)
						self:finishtweening():diffusealpha(0)
					end;
				};
				LoadFont("_eurostile outline")..{ Text="Right!"; InitCommand=function(self)
					self:diffusealpha(0):maxwidth(70)
				end;
					CrossCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0)
					end;
					NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Right" then self:playcommand("Cross"); end end;
					NoteCrossedJumpMessageCommand=function(self)
						self:finishtweening():diffusealpha(0)
					end;
				};
				LoadFont("_eurostile outline")..{ Text="Up!"; InitCommand=function(self)
					self:diffusealpha(0):maxwidth(70)
				end;
					CrossCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0)
					end;
					NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Up" then self:playcommand("Cross"); end end;
					NoteCrossedJumpMessageCommand=function(self)
						self:finishtweening():diffusealpha(0)
					end;
				};
				LoadFont("_eurostile outline")..{ Text="Down!"; InitCommand=function(self)
					self:diffusealpha(0):maxwidth(70)
				end;
					CrossCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0)
					end;
					NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Down" then self:playcommand("Cross"); end end;
					NoteCrossedJumpMessageCommand=function(self)
						self:finishtweening():diffusealpha(0)
					end;
				};
				LoadFont("_eurostile outline")..{ Text="Jump!"; InitCommand=function(self)
					self:diffusealpha(0):maxwidth(70)
				end;
					NoteCrossedJumpMessageCommand=function(self)
						self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0)
					end;
				};
			};
		};
	};

	-- Platform stuff
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:GetPlayMode()=="PlayMode_Regular" and GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()=="Difficulty_Beginner";
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X-160):y(SCREEN_CENTER_Y+40):zoom(1.2):rotationx(-20):fov(45)
		end;

			
			LoadActor("platform")..{
				 OnCommand=function(self)
					self:y(7):diffuse(0.6,0.6,0.6,0.8)
				end
			},

			LoadActor("panelglow")..{ OnCommand=function(self)
				self:x(-45):blend("BlendMode_Add"):diffusealpha(0)
			end;
			CrossCommand=function(self)
				self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0)
			end;
			NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Left" then self:playcommand("Cross"); end end;
			},

			LoadActor("panelglow")..{ OnCommand=function(self)
				self:x(45):blend("BlendMode_Add"):diffusealpha(0)
			end;
			CrossCommand=function(self)
				self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0)
			end;
			NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Right" then self:playcommand("Cross"); end end;
			},

			LoadActor("panelglow")..{ OnCommand=function(self)
				self:y(-45):blend("BlendMode_Add"):diffusealpha(0)
			end;
			CrossCommand=function(self)
				self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0)
			end;
			NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Up" then self:playcommand("Cross"); end end;
			},

			LoadActor("panelglow")..{ OnCommand=function(self)
				self:y(45):blend("BlendMode_Add"):diffusealpha(0)
			end;
			CrossCommand=function(self)
				self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0)
			end;
			NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Down" then self:playcommand("Cross"); end end;
			},
	},

	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2) and GAMESTATE:GetPlayMode()=="PlayMode_Regular" and GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()=="Difficulty_Beginner";
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+160):y(SCREEN_CENTER_Y+40):zoom(1.2):rotationx(-20):fov(45)
		end;

			
			LoadActor("platform")..{
				 OnCommand=function(self)
					self:y(7):diffuse(0.6,0.6,0.6,0.8)
				end
			},

			LoadActor("panelglow")..{ OnCommand=function(self)
				self:x(-45):blend("BlendMode_Add"):diffusealpha(0)
			end;
			CrossCommand=function(self)
				self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0)
			end;
			NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Left" then self:playcommand("Cross"); end end;
			},

			LoadActor("panelglow")..{ OnCommand=function(self)
				self:x(45):blend("BlendMode_Add"):diffusealpha(0)
			end;
			CrossCommand=function(self)
				self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0)
			end;
			NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Right" then self:playcommand("Cross"); end end;
			},

			LoadActor("panelglow")..{ OnCommand=function(self)
				self:y(-45):blend("BlendMode_Add"):diffusealpha(0)
			end;
			CrossCommand=function(self)
				self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0)
			end;
			NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Up" then self:playcommand("Cross"); end end;
			},

			LoadActor("panelglow")..{ OnCommand=function(self)
				self:y(45):blend("BlendMode_Add"):diffusealpha(0)
			end;
			CrossCommand=function(self)
				self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0)
			end;
			NoteCrossedMessageCommand=function(self,param) if param.ButtonName == "Down" then self:playcommand("Cross"); end end;
			},
	},

	-- Additional scripts
	LoadActor("danger p1"),
	LoadActor("dead"),
};