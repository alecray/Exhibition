import gifAnimation.*;
//-------------TILE DECLARATIONS--------------******************
Tile spawn;
Tile room1;
//--------------------------end of tile DECLARATIONS
PImage darkness; //the darkness that follows the player
PImage brick1;
PImage noLit; //darkness in each room


Player player; //create the player object

Light lightTest;

Chest chest;

Darkness darkness1;

Monster goblin;

int playerMovement = 0; //used for loading gifs based on player direction

Wall[] wall1V = new Wall[8];
Wall[] wall1H = new Wall[8];

//--WORLD
  //--TILES
  PImage mossyRock1;
  PImage darkRock1;
  //--OBSTACLES
  PImage wall1VImage;
  PImage wall1HImage;
  //--SCENERY
  PImage skullchestClosed;
  PImage skullchestOpen;
  
 
//--PLAYER PIMAGES
PImage[] barb_idlePImage;
PImage[] barb_downPImage;
PImage[] barb_upPImage;
PImage[] barb_leftPImage;
PImage[] barb_rightPImage;

//--MONSTER PIMAGES
  //--GOBLIN PIMAGES
  PImage[] goblin_idlePImage;
  PImage[] goblin_downPImage;
  PImage[] goblin_upPImage;
  PImage[] goblin_leftPImage;
  PImage[] goblin_rightPImage;
  
//--PLAYER GIFS
Gif barb_idleGif;
Gif barb_downGif;
Gif barb_upGif;
Gif barb_leftGif;
Gif barb_rightGif;

//--MONSTER GIFS
  //--GOBLIN GIFS
  Gif goblin_idleGif;
  Gif goblin_downGif;
  Gif goblin_upGif;
  Gif goblin_leftGif;
  Gif goblin_rightGif;


void setup(){
  size(800,600);
  
  //TILE SETUP (XPOS,YPOS,TILE TYPE,TILE NUMBER)
  spawn = new Tile(0,300,200,1);
  room1 = new Tile(1,spawn.xPos+320,spawn.yPos,2);
  //END TILE SETUP
  
  player = new Player(384,284,2,50); //define the player object
  lightTest = new Light(300,300,10,0.5,0.9); //a test light

  darkness1 = new Darkness();
  goblin = new Monster(1,32,0,0);
  chest = new Chest(400,400);
  
  darkness = loadImage("gfx/misc/darkness.png");
  noLit = loadImage("gfx/misc/noLit.png");
  wall1VImage = loadImage("gfx/world/obstacles/wall1V.gif");
  wall1HImage = loadImage("gfx/world/obstacles/wall1H.gif");
  
  //--WORLD 
  //--TILES
  mossyRock1 = loadImage("gfx/world/tiles/mossyRock1.gif");
  darkRock1 = loadImage("gfx/world/tiles/darkRock1.gif");
  //--OBSTACLES
  //--SCENERY
  skullchestClosed = loadImage("gfx/scenery/skullchestClosed.gif");
  skullchestOpen = loadImage("gfx/scenery/skullchestOpen.gif");

  
  //--PLAYER IMAGES-----------------------------------------------
  //BARB IDLE
  barb_idleGif = new Gif(this, "gfx/sprites/barb/barb_idle.gif");
  barb_idleGif.loop();
  barb_idlePImage = Gif.getPImages(this, "gfx/sprites/barb/barb_idle.gif");
  //BARB DOWN
  barb_downGif = new Gif(this, "gfx/sprites/barb/barb_down.gif");
  barb_downGif.loop();
  barb_downPImage = Gif.getPImages(this, "gfx/sprites/barb/barb_down.gif");
  //BARB UP
  barb_upGif = new Gif(this, "gfx/sprites/barb/barb_up.gif");
  barb_upGif.loop();
  barb_upPImage = Gif.getPImages(this, "gfx/sprites/barb/barb_up.gif");
  //BARB LEFT
  barb_leftGif = new Gif(this, "gfx/sprites/barb/barb_left.gif");
  barb_leftGif.loop();
  barb_leftPImage = Gif.getPImages(this, "gfx/sprites/barb/barb_left.gif");
  //BARB RIGHT
  barb_rightGif = new Gif(this, "gfx/sprites/barb/barb_right.gif");
  barb_rightGif.loop();
  barb_rightPImage = Gif.getPImages(this, "gfx/sprites/barb/barb_right.gif");
  //end BARB IMAGES-------------------------------------------------------------
  
  //--MONSTER IMAGES
    //GOBLIN IMAGES
      //GOBLIN IDLE
      goblin_idleGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_idle.gif");
      goblin_idleGif.loop();
      goblin_idlePImage = Gif.getPImages(this, "gfx/sprites/monsters/goblin/goblin_idle.gif");
      //GOBLIN DOWN
      goblin_downGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_down.gif");
      goblin_downGif.loop();
      goblin_downPImage = Gif.getPImages(this, "gfx/sprites/monsters/goblin/goblin_down.gif");
      //GOBLIN UP
      goblin_upGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_up.gif");
      goblin_upGif.loop();
      goblin_upPImage = Gif.getPImages(this, "gfx/sprites/monsters/goblin/goblin_up.gif");
      //GOBLIN LEFT
      goblin_leftGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_left.gif");
      goblin_leftGif.loop();
      goblin_leftPImage = Gif.getPImages(this, "gfx/sprites/monsters/goblin/goblin_left.gif");
      //GOBLIN RIGHT
      goblin_rightGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_right.gif");
      goblin_rightGif.loop();
      goblin_rightPImage = Gif.getPImages(this, "gfx/sprites/monsters/goblin/goblin_right.gif");
}//end setup
  

