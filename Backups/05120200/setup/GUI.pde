class GUI{

  
  void display(){
    timer = millis(); //set timer to each millisecond
    fill(255);
    
    //display timer in upper left corner
    textSize(12);
    text(timer, player.xPos - 385, player.yPos - 270);
    
    //display GUI PImage
    image(guiPImage, player.xPos - 384, player.yPos - 284);
    
    //display FPS in upper right corner 
    text(int(frameRate), player.xPos + 365, player.yPos -270);
    
    }
  
}//end GUI
    
