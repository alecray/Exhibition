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
  int activeWeapon;
  int weaponType;
  float range;
  float damage=20;
  
  float autoTimer;
  
  //stats
  float kills;
  
  boolean eh=false;
  
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
  
  void hpDisplay(){
    rectMode(CORNERS);
    fill(255,0,0);
    rect(xPos - 213, yPos + 384, xPos-74, yPos + 284 - (0.85*hp));
  }
  void gifAssign(){
    //IDLE/AFK
    if(playerMovement == 0 && keyPressed == false){
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
      
      
    }//end mousePressed 
  }//end gifAssign
}//end of player class


