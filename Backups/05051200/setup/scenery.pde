class Light {
  float xPos;
  float yPos;
  float radius; //largest radius
  float brightness; //brightness, use range 0.00-1.00 for percent change 
  float c; //color, use range 0.00-1.00 for percent change
  
  Light(float xPos_, float yPos_, float radius_, float brightness_, float c_){
    xPos = xPos_;
    yPos = yPos_;
    radius = radius_;
    brightness = brightness_;
    c = c_;
  }//end constructor
  
  void on(){
    int x=10; //variable for making a gradiated light
    while(x>0){
      fill(255,255,0,x*brightness*10);
      ellipse(xPos,yPos,radius*(x^2),radius*(x^2));
      x=x-1;
    }
  }//end on
}//end Light

class Darkness {
  
  void shroud(){
    image(darkness, player.xPos-384, player.yPos-284);
  }
}//end Darkness
      
class Chest {
  
  float xPos;
  float yPos;
  Chest(float xPos_, float yPos_){
    xPos = xPos_;
    yPos = yPos_;
  }//end constructor
  
  void display(){
    fill(0,0,0,0);//invis
    rectMode(CORNERS);
    rect(xPos,yPos,xPos+64,yPos+64);
  }
  
  void chestState(){//if the mouse is clicked on the chest and the player is in range
    if(mousePressed && (mouseButton == LEFT) && (mouseX > xPos) && (mouseX < xPos + 64)  && (mouseY > yPos) && (mouseY < yPos + 64)
    /*&& (player.xPos > xPos -200) && (player.xPos < xPos + 200)
    && (player.yPos > yPos -200) && (player.yPos < yPos + 200)*/){
      image(skullchestOpen,xPos,yPos);
    }
    else{
      image(skullchestClosed,xPos,yPos);
    }
  }//end cheststate
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
    if(type == 0){
      image(wall1VImage,x1,y1);
    }
    if(type == 1){
      image(wall1HImage,x1,y1);
    }
    
  }
  
  void hit() {
    
    //BEGIN PLAYER HIT DETECT
        //BEGIN PLAYER HIT DETECT
    
    //when you hit the bottom of the wall
    if (player.yPos < y2 && player.yPos + player.size > y1 && player.xPos < x2 && player.xPos+player.size > x1 && up == true){
      player.yPos = y2;
      
    }//end bottom edge
    
    //when you hit the top of the wall
    if (player.yPos < y2 && player.yPos + player.size > y1 && player.xPos < x2 && player.xPos+player.size > x1 && dn == true){
      player.yPos = y1 - player.size;
    }//end top edge
    
    //when you hit the right side of the wall
    if (player.yPos < y2 && player.yPos + player.size > y1 && player.xPos < x2 && player.xPos+player.size > x1 && left == true){
      player.xPos = x2;
    }//end right edge
    
    //when you hit the left side of the wall
    if (player.yPos < y2 && player.yPos + player.size > y1 && player.xPos < x2 && player.xPos+player.size > x1 && right == true){
      player.xPos = x1 - player.size;

    }//end left edge

  }//end hit
  
}
