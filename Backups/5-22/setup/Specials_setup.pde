void extraWalls(){
  //LONG VERTICAL WALLS
  //spawn
  wall1LongV[0] = new Wall(3,spawn.xPos,spawn.yPos,spawn.xPos+16,spawn.yPos+320); //the wall on the left side of spawn
  //room1
  wall1LongV[1] = new Wall(3,room1.xPos +304,room1.yPos,room1.xPos+320,room1.yPos+320); //the wall at the right edge of room 1
  //room2
  wall1LongV[2] = new Wall(3,room2.xPos,room2.yPos,room2.xPos+16,room2.yPos+320); //the wall on the left side of room2
  //room3
  wall1LongV[3] = new Wall(3,room3.xPos +304,room3.yPos,room3.xPos+320,room3.yPos+320);//the wall at the right edge of room 3
  //room4
  wall1LongV[4] = new Wall(3,room4.xPos,room4.yPos,room4.xPos+16,room4.yPos+320);//left side wall
  wall1LongV[5] = new Wall(3,room4.xPos+304,room4.yPos,room4.xPos+320,room4.yPos+320); //right side wall
  //room5
  wall1LongV[6] = new Wall(3,room5.xPos,room5.yPos,room5.xPos+16,room5.yPos+320);//left side
  //room8
  wall1LongV[7] = new Wall(3,room8.xPos,room8.yPos,room8.xPos+16,room8.yPos+320);//left side 
  wall1LongV[8] = new Wall(3,room8.xPos+304,room8.yPos,room8.xPos+320,room8.yPos+320);//right side
  //room7
  wall1LongV[9] = new Wall(3,room7.xPos+304,room7.yPos,room7.xPos+320,room7.yPos+320);//right side
  //room9
  wall1LongV[10] = new Wall(3,room9.xPos,room9.yPos,room9.xPos+16,room9.yPos+320);//left
  
  //LONG HORIZONTAL WALLS
  //spawn
  wall1LongH[0] = new Wall(4,spawn.xPos,spawn.yPos,spawn.xPos + 320, spawn.yPos + 16); //the wall at the top of spawn
  wall1LongH[1] = new Wall(4,spawn.xPos,spawn.yPos+304,spawn.xPos + 320, spawn.yPos + 320); //the wall at the bottom of spawn
  //room2
  wall1LongH[2] = new Wall(4,room2.xPos,room2.yPos+304,room2.xPos + 320, room2.yPos + 320); //the wall at the bottom of room 2
  //room3
  wall1LongH[3] = new Wall(4,room3.xPos,room3.yPos,room3.xPos+320,room3.yPos+16);// wall at the top of room 3
  wall1LongH[4] = new Wall(4,room3.xPos,room3.yPos+304,room3.xPos+320,room3.yPos+320); //wall at the bottom of room 3
  //room5
  wall1LongH[5] = new Wall(4,room5.xPos,room5.yPos,room5.xPos+320,room5.yPos+16); //top
  //room6
  wall1LongH[6] = new Wall(4,room6.xPos,room6.yPos+304,room6.xPos+320,room6.yPos+320); //bottom
  //room8
  wall1LongH[7] = new Wall(4,room8.xPos,room8.yPos,room8.xPos+320,room8.yPos+16); //top
  //room7
  wall1LongH[8] = new Wall(4,room7.xPos,room7.yPos,room7.xPos+320,room8.yPos+16);//top
  //room9
  wall1LongH[9] = new Wall(4,room9.xPos,room9.yPos+304,room9.xPos+320,room9.yPos+320);//bottom
  //room10
  wall1LongH[10] = new Wall(4,room10.xPos,room10.yPos,room10.xPos+320,room10.yPos+16); //top
  wall1LongH[11] = new Wall(4,room10.xPos,room10.yPos+304,room10.xPos+320,room10.yPos+320);
  
  
  //CHEST WALLS
  chestWall[0] = new Wall(5,room3.xPos+220,room3.yPos+252,room3.xPos+284,room3.yPos+284);
}
void lavaSetup(){
  lava[0] = new Lava(room4.xPos, room4.yPos+90);
}

void lightSetup(){
  //LIGHTS xpos,ypos,radius,brightness,r,g,b, (255,125,0 for orange)
  //lights[0] = new Light(spawn.xPos,spawn.yPos,5,0.1,255,125,0);
}
