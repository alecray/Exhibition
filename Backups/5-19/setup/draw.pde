 void draw(){ //gets called each frame
 
 //--OPENING SCREEN--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if(gameRunning == false){
   background(255);
   fill(0);
   textSize(30);
   textFont(fipps);
   text("Space",200,200);
   player.hp=100;
   if(keyPressed == true && key == ' '){
     gameRunning = true;
     playerAlive = true;
   }
 }
 //--IN GAME*********************************************************************************************************************************************************************************************
 if(gameRunning == true){
   if(playerAlive == true){
      player.setWeapons();
      background(0); //resets the background EACH FRAME
      //CREATE WALLS
      spawn.wallsAroundTiles();
      room1.wallsAroundTiles();
      room2.wallsAroundTiles();
      room3.wallsAroundTiles();
      room4.wallsAroundTiles();
      room5.wallsAroundTiles();
      room6.wallsAroundTiles();
      room7.wallsAroundTiles();
      room8.wallsAroundTiles();
      room9.wallsAroundTiles();
      room10.wallsAroundTiles();
      //END CREATE WALLS

      player.move(); //moves the player
      
      //WALL COLLISION
      for(int i=0;i<wall1V.length;i++){
         wall1V[i].hit();
      }
      for(int i=0;i<wall1H.length;i++){
        wall1H[i].hit();
      }
      for(int i=0; i < wall1LongH.length; i++){
        wall1LongH[i].hit();
      }
      for(int i=0; i < wall1LongV.length; i++){
        wall1LongV[i].hit();
      }
      for(int i=0; i < chestWall.length; i++){
        chestWall[i].hit();
      }
      //END WALL COLLISION
      
      //--PUT ANY PLAYER COLLISION BEFORE THIS LINE-- (also anything you want to not be translated (GUI, etc))
      player.follow(); //camera follow
      
      playerHitBox.setPos(); //sets the position of the hitbox to the player 
      
      //DRAW TILES
      spawn.display();
      room1.display();
      room2.display();
      room3.display();
      room4.display();
      room5.display();
      room6.display();
      room7.display();
      room8.display();
      room9.display();
      room10.display();
      //END DRAW TILES
      
      //draw lava
      for(int i=0; i < lava.length;i++){
        lava[i].display();
      }
      
      //DRAW WALLS
      for(int i=0; i < (wall1V.length);i++){
        wall1V[i].build();
      }
      for(int i=0; i < (wall1H.length);i++){
        wall1H[i].build();
      }
      for(int i=0; i < wall1LongH.length; i++){
        wall1LongH[i].build();
      }
      for(int i=0; i < wall1LongV.length; i++){
        wall1LongV[i].build();
      }

      //ALL GOBLIN COMMANDS WHILE LIVING
      for (int i = 0; i < goblin.length; i++){
        if(goblin[i].living == true){
          goblin[i].patrol(goblin[i].initxPos,goblin[i].inityPos,goblin[i].initxPos+100,goblin[i].inityPos + 100); //GOBLIN PATROL
          goblin[i].autoAttack();                                                                                  //GOBLIN AUTO ATTACK
          goblin[i].gifAssign();                                                                                   //GOBLIN GIF ASSIGNd
          goblin[i].collide();                                                                                     //GOBLIN COLLIDE
          goblin[i].hpDisplay();                                                                                   //GOBLIN HP DISPLAY
        }
        //GOBLIN DEATH
        if(goblin[i].HP <= 0){
          goblin[i].death(i);
        }
      }
      chest2.chestState(); //this is before player because it makes more sense graphically for this chest
      
      player.display(); 
      player.gifAssign(); //ALWAYS LAST besides lighting, gui and inventory and chests
      
      chest1.chestState();//this is after player because it makes more sense graphically for this chest
      darkness1.shroud();
      for(int i=0;i<lights.length;i++){
        lights[i].on();
      }
      //torchTest.lit();
        //LITCHECK
      spawn.lit();
      room1.lit();
      room2.lit();
      room3.lit();
      room4.lit();
      room5.lit();
      room6.lit();
      room7.lit();
      room8.lit();
      room9.lit();
      room10.lit();
      //END LITCHECK
      player.hpDisplay();
      player.xpDisplay();
      
      gui.display();
      gui.guiInventory();

      chest1.showChestInventory();
      chest2.showChestInventory();
      
      player.death();
  }//end IF PLAYERALIVE == TRUE
   }//end IF GAME RUNNING
}//end draw
