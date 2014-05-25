class Lava {
  float xPos;
  float yPos;
  
  Lava(float xPos_, float yPos_){
    xPos = xPos_;
    yPos = yPos_;
  }
  
  void display(){
    image(lavaGif,xPos,yPos);
  }
  
  void burn(){
  }
}

class Light {
  float xPos;
  float yPos;
  float radius; //largest radius
  float brightness; //brightness, use range 0.00-1.00 for percent change 
  float r;
  float g;
  float b;
  
  Light(float xPos_, float yPos_, float radius_, float brightness_, float r_, float g_, float b_){
    xPos = xPos_;
    yPos = yPos_;
    radius = radius_;
    brightness = brightness_;
    r=r_;
    g=g_;
    b=b_;
  }//end constructor
  
  void on(){
    int x=30; //variable for making a gradiated light
    while(x>0){
      fill(r,g,b,x*brightness*10);
      ellipse(xPos,yPos,radius*x,radius*x);
      x=x-3;
    }
  }//end on
}//end Light

/*class Torch {
  float xPos;
  float yPos;
  float rotation;
  
  Torch(float xPos_, float yPos_, float rotation_){
    xPos = xPos_;
    yPos = yPos_;
    rotation = rotation_;
  }
  
  void lit(){
    rotate(rotation);
    image(torch1, xPos, yPos);
  }
}//end Torch*/

class Darkness {
  
  void shroud(){ 
    image(darkness, player.xPos-384, player.yPos-284);
  }
}//end Darkness
      
class Chest {
  String ione;
  String itwo;
  String ithree;

  float xPos;
  float yPos;
  
  int chestState = 0; // 0 = closed, 1 = open
  boolean chestEmpty = false;
  
  Chest(float xPos_, float yPos_, String ione_, String itwo_, String ithree_){
    xPos = xPos_;
    yPos = yPos_;
    
    ione = ione_;
    itwo = itwo_;
    ithree = ithree_;
  }//end constructor
  
  void chestState(){//if the e is pressed and the player is in range
    if(keyPressed == true && (key == 'e' || key == 'E') && (player.xPos > xPos -50) && (player.xPos < xPos + 50)
       && (player.yPos > yPos -50) && (player.yPos < yPos + 50)){
      image(skullchestOpen,xPos,yPos);
      chestState = 1;
          
              if(keyPressed == true && mousePressed == true && chestEmpty == false){
                if(ione == "HP Potion"){
                  player.HPPotionAmount+=1;
                }
                if(itwo == "HP Potion"){
                  player.HPPotionAmount+=1;
                }
                if(ithree == "HP Potion"){
                  player.HPPotionAmount+=1;
                }
          player.inventory = append(player.inventory, ione);
          player.inventory = append(player.inventory, itwo);
          player.inventory = append(player.inventory, ithree);
          ione = "Chest looted!";
          itwo = " ";
          ithree = " ";
          chestEmpty = true;
          println(player.inventory);
        }
    }
    else{
      image(skullchestClosed,xPos,yPos);
      chestState = 0;
    }
  }//end cheststate
    
  void showChestInventory(){
      if(chestState == 1){
        fill(255);
        rect(player.xPos+96,player.yPos-200,player.xPos+256,player.yPos+150);
        image(skullchestInterior,player.xPos+96,player.yPos-200);
        fill(255);
        text(ione,player.xPos + 110,player.yPos - 175);
        text(itwo,player.xPos + 110,player.yPos - 160);
        text(ithree,player.xPos + 110,player.yPos - 145);
        fill(255,255,0);
        textSize(8);
        if(chestEmpty == false){
          text("Click anywhere to loot all!", player.xPos -370, player.yPos+170);
        }
        }
      
      if(chestState == 0 && (player.xPos > xPos -50) && (player.xPos < xPos + 50)
       && (player.yPos > yPos -50) && (player.yPos < yPos + 50)){
         textSize(10);
         fill(0);
         image(commandBubble, player.xPos-11,player.yPos-30);
         text("E", player.xPos, player.yPos -14);
       }
    }//end showChestInventory
}//end Chest
     
class Wall {
  int type; //0=vert,1=hor
  float x1;
  float y1;
  float x2;
  float y2;
  
  Wall (int type_, float x1_, float y1_, float x2_, float y2_){
    type = type_;
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
  }
  
  void build(){
    
    rectMode (CORNERS);
    noStroke();
    fill (0,0,0,0);
    rect (x1, y1, x2, y2);
    if(type == 0){ //vertical wall
      image(wall1VImage,x1,y1);
    }
    if(type == 1){ //horizontal wall
      image(wall1HImage,x1,y1);
    }
    if(type == 3){ //vertical long wall
      image(wall1LongVImage,x1,y1);
    }
    if(type == 4){ //horizontal long wall
      image(wall1LongHImage,x1,y1);
    }
    if(type == 5){ //chests
      rectMode(CORNERS);
      rect(x1,y1,x2,y2);
    }
  }
  
  void hit() {
    
    //BEGIN PLAYER HIT DETECT
        //BEGIN PLAYER HIT DETECT
    
    //when you hit the bottom of the wall, moving up
    if (playerHitBox.hbTopy1 > y1   //top portion of hitbox is below top of wall (reversed because processing grid is flipped)
       && playerHitBox.hbTopx2 > x1 //player's top right corner is within horizontal bounds of wall
       && playerHitBox.hbTopy1 < y2 //if player's top is inside wall, bump it out
       && playerHitBox.hbTopx1 < x2 //player's top left corner is within horizontal bounds of wall
       && up == true){              //the 'W' or 'w' key is pressed
      player.yPos = y2 - 3; //the +/- 3 is to correct for the bounding box
      
    }//end bottom edge
    //when you hit the right side of the wall, moving left
    if (playerHitBox.hbLeftx1 < x2
       && playerHitBox.hbLefty1 < y2
       && playerHitBox.hbLefty2 > y1
       && playerHitBox.hbLeftx1 > x1
       && left == true){
         player.xPos = x2 - 3; //the +/- 3 is to correct for the bounding box
    }//end right edge
    
    //when you hit the left side of the wall, moving right
    if (playerHitBox.hbRightx1 > x1
       && playerHitBox.hbRighty1 < y2
       && playerHitBox.hbRighty2 > y1
       && playerHitBox.hbRightx1 < x2
       && right == true){
         player.xPos = x1 - player.sizeX + 3; //the +/- 3 is to correct for the bounding box
       }//end left edge
    
    //when you hit the top side of the wall, moving down
    if (playerHitBox.hbBottomy1 > y1
       && playerHitBox.hbBottomx2 > x1
       && playerHitBox.hbBottomx1 < x2
       && playerHitBox.hbBottomy1 < y2
       && dn == true){
         player.yPos = y1 - player.sizeY + 3; //the +/- 3 is to correct for the bounding box
       }//end bottom edge
  }//end hit
  
}
