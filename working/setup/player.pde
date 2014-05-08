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
  int ammo;
  float countX;
  float countY;
  float tempX;
  float tempY;
  
  Player(float xPos_, float yPos_, float speed_, int ammo_) {
    
    xPos = xPos_;
    yPos = yPos_;
    speed = speed_;
    ammo = ammo_;
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
  }//end gifAssign
}//end of player class


