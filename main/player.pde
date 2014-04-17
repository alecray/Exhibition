class Player {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float clickLocX;
  float clickLocY;
  float topspeed;
  float size = 32;
  
    Player() {
      location = new PVector(200,200);
      velocity = new PVector();
    }//end constructor
    
    void update(){
      if (mousePressed == true){
        clickLocX = mouseX;
        clickLocY = mouseY;
      }
      PVector mouse = new PVector(clickLocX,clickLocY);
      PVector dir = PVector.sub(mouse,location); //find vector pointing towards mouse
      dir.normalize();    //normalize
      dir.mult(5);       //scale
      velocity = dir;
      
      //velocity.add(acceleration);
      //velocity.limit(topspeed);
      location.add(velocity);

    }
    
    void display() {
      rectMode(CORNER);
      noStroke();
      fill(0,255,255);
      rect(location.x,location.y,size,size);
    }//end display
    
}//end class player
