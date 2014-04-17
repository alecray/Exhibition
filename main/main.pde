import gifAnimation.*;

PImage[] click_PImage;

Gif click_Gif;

Player player;

void setup(){
  size(800,600);
  player = new Player();
  
  click_Gif = new Gif(this, "gfx/misc/click.gif");
  click_PImage = Gif.getPImages(this, "gfx/misc/click.gif");
}//end setup
  
