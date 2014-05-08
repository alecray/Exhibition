class RandomBlock {
  
  float xPos;
  float yPos;
  
  RandomBlock(float xPos_, float yPos_){
    xPos = xPos_;
    yPos = yPos_;
  }
  
  void display(){
    int var = 0;
    while(var <=100){
      fill(255,0,255,0);
      rect(xPos+var*32,yPos,64,32);
      image(brick1,xPos,yPos);
      var+=1;
    }
    
  }
}
