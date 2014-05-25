 void draw(){ //gets called each frame
 
 //--OPENING SCREEN--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if(gameRunning == false){
   background(255);
   fill(0);
   image(startScreen,0,0);
   fill(0,0,0,100);
   rectMode(CORNERS);
   stroke(100);
   rect(70,270,176,600,5);
   fill(255);
   textFont(fipps);
   textSize(12);
   text("New",100,300);
   if(startScreenSelectorYPos == 300){
     fill(200);
     text("Create a new game.", 200, startScreenSelectorYPos);
     text("(Basic tutorial as well)", 200, startScreenSelectorYPos + 20);
   }
   text("Load",100,320);
   if(startScreenSelectorYPos == 320){
     fill(200);
     text("Load from your last game", 200, startScreenSelectorYPos);
   }
   text("Exit",100,340);
   if(startScreenSelectorYPos == 340){
     fill(200);
     text("Exit the game.", 200, startScreenSelectorYPos);
   }
   fill(0,150,0);
   text("{           }",80,startScreenSelectorYPos);
   
   player.hp=100;
   if(classSelect == true && isClassSelected == false){
     background(255);
     image(startScreen,0,0);
     fill(0,0,0,100);
     rectMode(CORNERS);
     stroke(100);
     rect(70,270,225,600,5);
     textSize(12);
     fill(255);
     text("Barbarian",100,300);
     text("Mage",100,320);
     text("Back",100,340);
     fill(0,150,0);
     text("{                    }",80,startScreenSelectorYPos);
     if(startScreenSelectorYPos == 300){
       image(barb_idleGif, 240,280);
     }
     if(startScreenSelectorYPos == 320){
       image(mage_idleGif, 240,280);
     }
     if(keyPressed == true && (key == ENTER || key == RETURN)){
       if(startScreenSelectorYPos == 300 && isClassSelected == false){
            player.playerClass = "Barbarian";
            println(player.playerClass);
            gameRunning = true;
            playerAlive = true;
            player.activeWeapon = "Axe";
            player.mana = 0; //barbarians don't use mana
            player.setInitInventory();
            //player.setStatsByLevel();
        }
        if(startScreenSelectorYPos == 320 && isClassSelected == false){
            player.playerClass = "Mage";
            println(player.playerClass);
            gameRunning = true;
            playerAlive = true;
            player.activeWeapon = "Spell: Fireball";
            player.mana = 100;
            player.setInitInventory();
            //player.setStatsByLevel();
            player.manaTimer = 0;
            slowTimer = 0;
        }
        if(startScreenSelectorYPos == 340 && isClassSelected == false){
          classSelect = false;
          startScreenSelectorYPos = 300;
        }
          
     }
   }
}
 
 //--IN GAME*********************************************************************************************************************************************************************************************
 if(gameRunning == true){
   classSelect = false;
   showSaves = false;
   if(playerAlive == true){
      player.setWeapons();
      player.activeWeaponSetup();
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
      savePoint1.display();
      savePoint1.saving();
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
      
      //ALL OGRE COMMANDS WHILE LIVING
      for (int i = 0; i < ogre.length; i++){
        if(ogre[i].living == true){
          ogre[i].patrol(ogre[i].initxPos,ogre[i].inityPos,ogre[i].initxPos+20,ogre[i].inityPos + 20); //OGRE PATROL
          ogre[i].autoAttack();                                                                                  //OGRE AUTO ATTACK
          ogre[i].gifAssign();                                                                                   //OGRE GIF ASSIGNd
          ogre[i].collide();                                                                                     //OGRE COLLIDE
          ogre[i].hpDisplay();                                                                                   //OGRE HP DISPLAY
        }
        //OGRE DEATH
        if(ogre[i].HP <= 0){
          ogre[i].death(i);
        }
      }
      chest2.chestState(); //this is before player because it makes more sense graphically for this chest
      player.display(); 
      player.gifAssign(); //ALWAYS LAST besides lighting, gui and inventory and chests
      
      chest1.chestState();//this is after player because it makes more sense graphically for this chest
      darkness1.shroud();
      /*for(int i=0;i<lights.length;i++){
        lights[i].on();
      }*/
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
      
      if(inSpawn == false){
        textFont(fipps);
        textSize(12);
        fill(255,255,255,150);
        text("Re-enter this room for help!", spawn.xPos, room1.yPos+180); //this is to show the player they can re-enter spawn for a refresher on the controls
      }
      
      player.hpDisplay();
      player.manaDisplay();
      player.xpDisplay();
      
      gui.display();

      chest1.showChestInventory();
      chest2.showChestInventory();
      player.death();
      player.tutorial();
      gui.guiInventory();
  }//end IF PLAYERALIVE == TRUE
  if(playerAlive == false){
    background(100);
    image(darkRock1,0,0);
    image(darkRock1,320,0);
    image(darkRock1,640,0);
    image(darkRock1,0,320);
    image(darkRock1,320,320);
    image(darkRock1,640,320);
    
    fill(255);
    textFont(fipps);
    textSize(50);
    text("YOU HAVE DIED",102,102);
    fill(200,0,0,200);
    textFont(fipps);
    textSize(50);
    text("YOU HAVE DIED",100,100);
    image(barb_deathGif,384,284);
    image(goblin_idleGif,424,284);
    image(goblin_idleGif,384,230);
    image(goblin_idleGif,344,284);
    image(ogre_idleGif,380,350);
    textSize(12);
    fill(255);
    text("Press enter to respawn",521,571);
    fill(200,0,0,200);
    text("Press enter to respawn",520,570);
    
  }
   }//end IF GAME RUNNING
}//end draw
