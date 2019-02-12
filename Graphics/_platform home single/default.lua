return Def.ActorFrame{
	Def.Model{
      Materials = "platform materials.txt",
      Meshes = "platform meshes.txt",
      Bones = "platform bones.txt",
      InitCommand=function(self)
      	self:rotationy(180)
      end;
  };
}