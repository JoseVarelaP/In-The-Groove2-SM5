return Def.ActorFrame{
	Def.Model{
      Materials = "platform materials.txt",
      Meshes = "platform meshes.txt",
      Bones = "platform bones.txt",
      InitCommand=cmd(rotationy,180);
  };
}