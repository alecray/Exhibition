class SavePoint{
  float xPos;
  float yPos;
  SavePoint(float xPos_, float yPos_){
    xPos = xPos_;
    yPos = yPos_;
  }
  
  void display(){
    if(player.xPos > xPos -10 && player.xPos < xPos +42 && player.yPos > yPos -10 && player.yPos < yPos + 74){
      saving = true;
      int x=0; //variable for making a gradiated light
        while(x<5){
          noStroke();
          fill(0,0,255,255-(x*51));
          ellipse(xPos+16,yPos+32,30*x,30*x);
          x+=1;
        }
    } else {
      saving = false;
    }
    image(save_pointGif,xPos,yPos);
  }
}
