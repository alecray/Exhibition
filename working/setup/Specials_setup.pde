void extraWalls(){
  //LONG VERTICAL WALLS
  wall1LongV[0] = new Wall(3,spawn.xPos,spawn.yPos,spawn.xPos+16,spawn.yPos+320); //the wall on the left side of spawn
  wall1LongV[1] = new Wall(3,room1.xPos +304,room1.yPos,room1.xPos+320,room1.yPos+320); //the wall at the right edge of room 1
  wall1LongV[2] = new Wall(3,room2.xPos,room2.yPos,room2.xPos+16,room2.yPos+320); //the wall on the left side of room2
  
  //LONG HORIZONTAL WALLS
  wall1LongH[0] = new Wall(4,spawn.xPos,spawn.yPos,spawn.xPos + 320, spawn.yPos + 16); //the wall at the top of spawn
  wall1LongH[1] = new Wall(4,spawn.xPos,spawn.yPos+304,spawn.xPos + 320, spawn.yPos + 320); //the wall at the bottom of spawn
  wall1LongH[2] = new Wall(4,room2.xPos,room2.yPos+304,room2.xPos + 320, room2.yPos + 320); //the wall at the bottom of room 2
  
  //CHEST WALLS
  chestWall[0] = new Wall(5,spawn.xPos+200,spawn.yPos+232,spawn.xPos+264,spawn.yPos+264);
  
  //LIGHTS xpos,ypos,radius,brightness,r,g,b, (255,125,0 for orange)
  lights[0] = new Light(spawn.xPos,spawn.yPos,5,0.1,255,125,0);
}
