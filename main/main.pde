import gifAnimation.*;

PImage[] click_PImage;
PImage mj;
Gif click_Gif;

Player player;
RandomBlock b1;
void setup(){
  size(800,600);
  player = new Player();
  b1 = new RandomBlock(100,100);
  
  mj = loadImage("gfx/mj.jpg");
  
  click_Gif = new Gif(this, "gfx/misc/click.gif");
  click_PImage = Gif.getPImages(this, "gfx/misc/click.gif");
}//end setup
  
