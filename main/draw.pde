void draw(){
  background(255);
  pushMatrix();
  player.cameraFollow();
  b1.display();
  image(mj, -500,-500);
  if (mousePressed == true){
    image(click_Gif, player.clickLocX-5, player.clickLocY-5);
  }
  popMatrix();
  player.update();
  player.display();
}//end draw
