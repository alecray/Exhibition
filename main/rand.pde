class RandomBlock {
  
  float xPos;
  float yPos;
  
  RandomBlock(float xPos_, float yPos_){
    xPos = xPos_;
    yPos = yPos_;
  }
  
  void display(){
    
    fill(255,0,255);
    rect(xPos,yPos,100,100);
    
  }
}
    
