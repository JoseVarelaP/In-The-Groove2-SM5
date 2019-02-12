return Def.ActorFrame{
	Def.ActorFrame{
	OnCommand=function(self)
		self:wag():effectmagnitude(0,5,0):effectperiod(12)
	end;
		Def.ActorFrame{
			OnCommand=function(self)
				self:fov(105):zoom(1.3)
			end;
			-- Overlay
			
			LoadActor("bgoverlay")..{
				 OnCommand=function(self)
					self:vertalign(bottom):zoomtowidth(SCREEN_WIDTH*1.1):zoomy(1.1):rotationy(180)
				end
			},
			
			LoadActor("bgoverlay")..{
				 OnCommand=function(self)
					self:vertalign(bottom):zoomtowidth(SCREEN_WIDTH*1.1):zoomy(-1.1)
				end
			},
		},

		-- upper top dots
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-200):z(-400):customtexturerect(0.2,0,1.2,1):texcoordvelocity(-0.06,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-200):z(-200):customtexturerect(0.5,0,1.5,1):texcoordvelocity(0.03,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-200):z(-100):customtexturerect(0.8,0,1.8,1):texcoordvelocity(0.06,0):diffuse(color("#832626")):diffusealpha(0.15)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-200):z(-050):customtexturerect(0.1,0,1.1,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.15)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-200):z(000):customtexturerect(0.1,0,1.1,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.2)
 			end
 		},

 		-- lower top dots
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-100):z(-400):customtexturerect(0.4,0,1.4,1):texcoordvelocity(-0.06,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-150):z(-200):customtexturerect(0.7,0,1.7,1):texcoordvelocity(0.03,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-100):z(-100):customtexturerect(0.0,0,1.0,1):texcoordvelocity(0.06,0):diffuse(color("#832626")):diffusealpha(0.15)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-150):z(-50):customtexturerect(0.3,0,1.3,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.15)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(-150):z(000):customtexturerect(0.3,0,1.3,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.2)
 			end
 		},

 		-- upper bottom dots
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(100):z(-400):customtexturerect(0.0,0,1.0,1):texcoordvelocity(-0.06,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(150):z(-200):customtexturerect(0.3,0,1.3,1):texcoordvelocity(0.03,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(100):z(-100):customtexturerect(0.6,0,1.6,1):texcoordvelocity(0.06,0):diffuse(color("#832626")):diffusealpha(0.15)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(150):z(-050):customtexturerect(0.9,0,1.9,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.15)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(150):z(000):customtexturerect(0.9,0,1.9,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.2)
 			end
 		},

 		-- lower bottom dots
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(200):z(-400):customtexturerect(0.8,0,1.8,1):texcoordvelocity(-0.06,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(200):z(-200):customtexturerect(0.1,0,1.1,1):texcoordvelocity(0.03,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(200):z(-100):customtexturerect(0.4,0,1.4,1):texcoordvelocity(0.06,0):diffuse(color("#832626")):diffusealpha(0.15)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(200):z(-050):customtexturerect(0.7,0,1.7,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.15)
 			end
 		},
 		
 		LoadActor("dots")..{
 			 OnCommand=function(self)
 				self:zoom(1.5):y(200):z(000):customtexturerect(0.7,0,1.7,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.2)
 			end
 		},

 		-- top blocks 
 		
 		LoadActor("BLOCK")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(-100):z(-350):customtexturerect(0.3,0,1.3,1):texcoordvelocity(-0.06,0):diffuse(color("#832626")):diffusealpha(0.05)
 			end
 		},
 		
 		LoadActor("ARROWS")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(-100):z(-200):customtexturerect(0.6,0,1.6,1):texcoordvelocity(0.03,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("TICKS")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(-150):z(-200):customtexturerect(0.6,0,1.6,1):texcoordvelocity(0.03,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("ARROWS")..{
 			 OnCommand=function(self)
 				self:zoomx(1.5):zoomy(3):y(-200):z(-100):customtexturerect(0.9,0,1.4,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.2)
 			end
 		},
 		
 		LoadActor("BLOCK")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(-150):z(-050):customtexturerect(0.2,0,1.2,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("TICKS")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(-50):z(-050):customtexturerect(0.9,0,1.9,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.1)
 			end
 		},

 		-- bottom blocks 
 		
 		LoadActor("BLOCK")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(100):z(-350):customtexturerect(0.5,0,1.5,1):texcoordvelocity(-0.06,0):diffuse(color("#832626")):diffusealpha(0.05)
 			end
 		},
 		
 		LoadActor("ARROWS")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(100):z(-200):customtexturerect(0.0,0,1.0,1):texcoordvelocity(0.03,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("TICKS")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(150):z(-200):customtexturerect(0.8,0,1.8,1):texcoordvelocity(0.03,0):diffuse(color("#832626")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("ARROWS")..{
 			 OnCommand=function(self)
 				self:zoomx(1.5):zoomy(3):y(200):z(-100):customtexturerect(0.1,0,0.6,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.2)
 			end
 		},
 		
 		LoadActor("BLOCK")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(150):z(-050):customtexturerect(0.4,0,1.4,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.1)
 			end
 		},
 		
 		LoadActor("TICKS")..{
 			 OnCommand=function(self)
 				self:zoom(3):y(50):z(-050):customtexturerect(0.8,0,1.8,1):texcoordvelocity(0.06,0):diffuse(color("#885151")):diffusealpha(0.1)
 			end
 		},
	},
}
