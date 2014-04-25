class Player{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float clickLocX;
  float clickLocY;
  float topspeed;
  float size = 32;
  float tempX;
  float tempY;
  float countX;
  float countY;
  float tempDirX;
  float tempDirY;
  
    Player() {
      location = new PVector(400,300);
      velocity = new PVector(0,0);
    }//end constructor
    
    void update(){
      
      tempX = location.x;
      tempY = location.y;
      
      if (mousePressed == true){//if the mouse is pressed,
        clickLocX = mouseX;     //create a location that the player
        clickLocY = mouseY;     //moves towards
      }
      
      PVector mouse = new PVector(clickLocX,clickLocY);
      PVector dir = PVector.sub(mouse,location); //find vector pointing towards mouse
      dir.normalize();    //normalize
      dir.mult(5);       //scale
      velocity = dir;
      
      //velocity.add(acceleration);
      //velocity.limit(topspeed);
      location.add(velocity);
      
      if   (player.location.x >= player.clickLocX - 5
         && player.location.x <= player.clickLocX + 5
         && player.location.y >= player.clickLocY - 5
         && player.location.y <= player.clickLocY + 5
         ){
        player.location.x = player.clickLocX;
        player.location.y = player.clickLocY;
      }
      
      tempDirX = dir.x;
      tempDirY = dir.y;
    }
    
    void cameraFollow() {//function for camera to follow player
      countX += (tempX - location.x);
      countY += tempY - location.y;
         translate(countX,countY);
    }
    void display() {
      rectMode(CORNER);
      noStroke();
      fill(0,255,255);
      rect(location.x,location.y,size,size);
    }//end display
    
}//end class player
