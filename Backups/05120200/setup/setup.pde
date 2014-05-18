import gifAnimation.*;
int totalGoblins =5;
int totalMonsters;

boolean gameRunning = false;
boolean playerAlive;
//-------------TILE DECLARATIONS--------------******************
Tile spawn;
Tile room1;
Tile room2;
//--------------------------end of tile DECLARATIONS
PImage darkness; //the darkness that follows the player
PImage brick1;
PImage noLit; //darkness in each room
PImage guiPImage;

float timer = millis();

GUI gui;

Player player; //create the player object

Light lightTest;
//Torch torchTest;

Chest chest;

Darkness darkness1;

Monster[] goblin = new Monster[totalGoblins]; //number in this array must be equal to the number of goblins present

int playerMovement = 0; //used for loading gifs based on player direction

Wall[] wall1V = new Wall[12];
Wall[] wall1H = new Wall[12];

HitBox playerHitBox;

//--WEAPONS
Weapon oneHandedAxe;

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
  
//--PLAYER GIFS
Gif barb_idleGif;
Gif barb_downGif;
Gif barb_upGif;
Gif barb_leftGif;
Gif barb_rightGif;

//--WEAPON GIFS
Gif axe_left;
Gif axe_right;
Gif axe_idle;
Gif axe_down;
Gif axe_up;

//--MONSTER GIFS
  //--GOBLIN GIFS
  Gif goblin_idleGif;
  Gif goblin_downGif;
  Gif goblin_upGif;
  Gif goblin_leftGif;
  Gif goblin_rightGif;
    Gif goblin_atkGif;
      Gif goblin_deathGif;

//--SCENERY GIFS
Gif torch1;

void setup(){
  size(800,600);
  gui = new GUI(); //GUI setup
  
  //TILE SETUP (Room number, XPOS, YPOS, TILE-TYPE, Number of goblins)
  spawn = new Tile(0,300,200,1,0);
  room1 = new Tile(1,spawn.xPos+320,spawn.yPos,2,2);
  room2 = new Tile(2,spawn.xPos+320,spawn.yPos+320,2,2);
  //END TILE SETUP
  
  monsterSpawn();
  
  player = new Player(384,284,2,50,100); //define the player object, inputs are player xPos, player yPos, player Speed, player ammo, and player health
  lightTest = new Light(300,300,10,0.5,0.9); //a test light

  darkness1 = new Darkness();
  chest = new Chest(400,400);
  //torchTest = new Torch(300,0,0);
  //--WEAPONS
  oneHandedAxe = new Weapon(1,1,10,10);
  
  darkness = loadImage("gfx/misc/darkness.png");
  noLit = loadImage("gfx/misc/noLit.png");
  wall1VImage = loadImage("gfx/world/obstacles/wall1V.gif");
  wall1HImage = loadImage("gfx/world/obstacles/wall1H.gif");
  guiPImage = loadImage("gfx/misc/GUI.png");
  
  //--WORLD 
  //--TILES
  mossyRock1 = loadImage("gfx/world/tiles/mossyRock1.gif");
  darkRock1 = loadImage("gfx/world/tiles/darkRock1.gif");
  //--OBSTACLES
  //--SCENERY
  skullchestClosed = loadImage("gfx/scenery/skullchestClosed.gif");
  skullchestOpen = loadImage("gfx/scenery/skullchestOpen.gif");
  
  //torch1 = new Gif(this, "gfx/scenery/torch1.png");
  //torch1.loop();
   
  playerHitBox = new HitBox();
  //--PLAYER IMAGES-----------------------------------------------
  //BARB IDLE
  barb_idleGif = new Gif(this, "gfx/sprites/barb/barb_idle.gif");
  barb_idleGif.loop();
  //BARB DOWN
  barb_downGif = new Gif(this, "gfx/sprites/barb/barb_down.gif");
  barb_downGif.loop();
  //BARB UP
  barb_upGif = new Gif(this, "gfx/sprites/barb/barb_up.gif");
  barb_upGif.loop();
  //BARB LEFT
  barb_leftGif = new Gif(this, "gfx/sprites/barb/barb_left.gif");
  barb_leftGif.loop();
  //BARB RIGHT
  barb_rightGif = new Gif(this, "gfx/sprites/barb/barb_right.gif");
  barb_rightGif.loop();
  //end BARB IMAGES-------------------------------------------------------------
  
  //--MONSTER IMAGES
    //GOBLIN IMAGES
      //GOBLIN IDLE
      goblin_idleGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_idle.gif");
      goblin_idleGif.loop();
      //GOBLIN DOWN
      goblin_downGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_down.gif");
      goblin_downGif.loop();
      //GOBLIN UP
      goblin_upGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_up.gif");
      goblin_upGif.loop();
      //GOBLIN LEFT
      goblin_leftGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_left.gif");
      goblin_leftGif.loop();
      //GOBLIN RIGHT
      goblin_rightGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_right.gif");
      goblin_rightGif.loop();
        //GOBLIN ATTACK 
        goblin_atkGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_atk.gif");
        goblin_atkGif.loop();
          //GOBLIN DEATH 
          goblin_deathGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_death.gif");
          goblin_deathGif.play();
          
  //--WEAPON IMAGES
  axe_left = new Gif(this, "gfx/weapons/axe_left.gif");
  axe_left.loop();
  axe_right = new Gif(this, "gfx/weapons/axe_right.gif");
  axe_right.loop();
  axe_idle = new Gif(this, "gfx/weapons/axe_idle.gif");
  axe_idle.loop();
  axe_down = new Gif(this, "gfx/weapons/axe_down.gif");
  axe_down.loop();
  axe_up = new Gif(this, "gfx/weapons/axe_up.gif");
  axe_up.loop();
}//end setup
  

