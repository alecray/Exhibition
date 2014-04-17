void draw(){
  frameRate(240);
  background(255);
  player.update();
  player.display();
  
  if (mousePressed == true){
    image(click_Gif, player.clickLocX-5, player.clickLocY-5);
  }
}//end draw
