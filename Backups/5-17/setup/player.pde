boolean up;
boolean right;
boolean dn;
boolean left;

class Player {
  
  float xPos;
  float yPos;
  float speed;
  float sizeX = 32;
  float sizeY = 64;
  float countX;
  float countY;
  float tempX;
  float tempY;
  
  float weaponRightPosX = xPos + sizeX;
  float weaponRightPosY = yPos + sizeY/2;
  
  float weaponLeftPosX = xPos;
  float weaponLeftPosY = yPos + sizeY/2;
  
  float hp;
  
  int ammo;
  String activeWeapon = "Axe";
  int weaponType;
  float range;
  float damage=20;
  
  float autoTimer;
  
  //stats
  float kills;
  float xp = 0;
  float xpOverlap;
  int lvl = 1;
  boolean eh=false;
  
  String[] inventory = new String[2];
  String[] tempInventory;
  String[] weaponsHeld=new String[0];
  
  int HPPotionAmount = 1;
  
  int[] invSlot = {1,2,3,4,5,6,7,8,9,0};
  
  Player(float xPos_, float yPos_, float speed_, int ammo_, float hp_) { //inputs are player xPos, player yPos, player Speed, player ammo, and player health
    
    xPos = xPos_;
    yPos = yPos_;
    speed = speed_;
    ammo = ammo_;
    hp = hp_;
}//end of constructor
  
  void display() {
    
    rectMode(CORNER);
    noStroke();
    fill(0,255,255,0);
    rect(xPos,yPos,sizeX,sizeY);//player size is 32x64
    
  }//end display
  
  void move() {
   
    tempX = xPos;
    tempY = yPos;
    
    if(up == true /* && yPos > 0*/){
      yPos -= speed;  
    }
    if(left == true /* && xPos > 0*/){
      xPos -= speed;
    }        
    if(dn == true /* &&  yPos  < height - size*/){
      yPos += speed;
    }
    if(right == true /* && xPos < width - size*/){
      xPos += speed;
    }
    
              
  }//end of move function
  
  void follow() {//function for the "camera" to follow the player
    
    countX += tempX - xPos;
    countY += tempY - yPos;
    translate (countX, countY);
  }
  
  void setInitInventory(){
    inventory[0] = "Axe";
    inventory[1] = "HP Potion";
  }
  
  void playerInventory(){
    fill(255);
    rect(xPos-223,yPos-200,xPos-64,yPos+150);
    image(playerBag,xPos-223,yPos-200);
    fill(50);
    textSize(10);
    text("Inventory:", player.xPos-210,player.yPos-175);
    
    for(int i=0; i < inventory.length; i++){
      fill(0);
      textSize(8);
      text(inventory[i],player.xPos-190,player.yPos-150+(i*15));
    }
    for(int i=0; i < invSlot.length; i++){
      fill(0);
      textSize(8);
      text(invSlot[i], player.xPos-210, player.yPos-150+(i*15));
    }
    for(int i=0; i < inventory.length; i++){
      if(inventory[i].contains(activeWeapon)){
        image(activeWeaponIndicator, player.xPos-230,player.yPos-163+(i*15));
      }
    }
  }
  
  void setWeapons(){
    for(int i=0; i<inventory.length; i++){
      if(inventory[i].contains("Sword")){
        weaponsHeld = append(weaponsHeld, "Sword");
      }
      if(inventory[i].contains("Axe")){
        weaponsHeld = append(weaponsHeld, "Axe");
      }
    }
  }//end setWeapons
        
  void xpDisplay(){
    rectMode(CORNERS);
    fill(148,0,148,150);
    rect(xPos-64,yPos+215,xPos-64+xp,yPos+236); //-64 to +96 is range for XP, a.k.a. a range of 160
    if(xp >= 160){
      xpOverlap = xp - 160;
      lvl+=1;
      xp = xpOverlap;
    }
  }
  
  void hpDisplay(){
    rectMode(CORNERS);
    fill(255,0,0);
    rect(xPos - 213, yPos + 384, xPos-74, yPos + 284 - (0.85*hp));
  }
  
  void death(){
    if(hp <=0){
      gameRunning = false;
    }
  }//end death
  
  void gifAssign(){
    //IDLE/AFK
    if(playerMovement == 0){
      image(barb_idleGif, player.xPos, player.yPos);
    }
    //MOVING DOWN
    if(playerMovement == 3 && keyPressed == true){
      image(barb_downGif, player.xPos, player.yPos);
    }
    //MOVING UP
    if(playerMovement == 1 && keyPressed == true){
      image(barb_upGif, player.xPos, player.yPos);
    }
    //MOVING LEFT
    if(playerMovement == 2 && keyPressed == true){
      image(barb_leftGif, player.xPos, player.yPos);
    }
    //MOVING RIGHT
    if(playerMovement == 4 && keyPressed == true){
      image(barb_rightGif, player.xPos, player.yPos);
    }
    
    //FOR ATTACKING
    if(mousePressed){
      if(activeWeapon == "Axe"){
        if(playerMovement == 0){ //IDLE
          image(axe_idle,player.xPos - player.sizeX, player.yPos);
        }
        if(playerMovement == 3){ //DOWN
          image(axe_down, player.xPos, player.yPos + player.sizeY/2);
        }
        if(playerMovement == 1){ //UP
          image(axe_up, player.xPos, player.yPos - player.sizeY/2);
        }
        if(playerMovement == 4){ //RIGHT
          image(axe_right,player.xPos+player.sizeX, player.yPos + 10);
          axe_right.play();
        }
        if(playerMovement == 2){ //LEFT
          image(axe_left,player.xPos - player.sizeX, player.yPos + 10);
        }
      }//end if activeWeapon == Axe
      
      if(activeWeapon == "Sword"){
        if(playerMovement == 0){ //IDLE
          image(sword_idle,player.xPos - player.sizeX, player.yPos);
        }
        if(playerMovement == 3){ //DOWN
          image(sword_down, player.xPos, player.yPos + player.sizeY/2);
        }
        if(playerMovement == 1){ //UP
          image(sword_up, player.xPos, player.yPos - player.sizeY/2);
        }
        if(playerMovement == 4){ //RIGHT
          image(sword_right,player.xPos+player.sizeX, player.yPos + 10);
          axe_right.play();
        }
        if(playerMovement == 2){ //LEFT
          image(sword_left,player.xPos - player.sizeX, player.yPos + 10);
        }
      }
    }//end mousePressed 
  }//end gifAssign
}//end of player class


