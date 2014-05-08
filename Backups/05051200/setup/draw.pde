 void draw(){ //gets called each frame
  background(0); //resets the background EACH FRAME
  
  //CREATE WALLS
  spawn.wallsAroundTiles();
  room1.wallsAroundTiles();
  //END CREATE WALLS
  
  player.move(); //moves the player
  
  //WALL COLLISION
  for(int i=0;i<wall1V.length;i++){
     wall1V[i].hit();
  }
  for(int i=0;i<wall1H.length;i++){
    wall1H[i].hit();
  }
  //END WALL COLLISION
  
  //--PUT ANY PLAYER COLLISION BEFORE THIS LINE-- (also anything you want to not be translated (GUI, etc))
  player.follow(); //camera follow
  
  //DRAW TILES
  spawn.display();
  room1.display();
  //END DRAW TILES
  
  //DRAW WALLS
  for(int i=0; i < (wall1V.length);i++){
    wall1V[i].build();
  }
  for(int i=0; i<wall1H.length;i++){
    wall1H[i].build();
  }
  //END DRAW WALLS

  chest.chestState();

  //goblin.display();
  goblin.patrol(0,0,200,200);
  goblin.gifAssign();
  
  player.display(); 
  player.gifAssign(); //ALWAYS LAST besides lighting
  darkness1.shroud();
  lightTest.on();
    //LITCHECK
  spawn.lit();
  room1.lit();
  //END LITCHECK
 
}//end draw
