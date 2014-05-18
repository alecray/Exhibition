import gifAnimation.*;

PFont fipps;//declares the fipps font

boolean gameRunning = false;
boolean playerAlive;

//ITEM IDS
//1 = AXE
//2 = SWORD
//-------------TILE DECLARATIONS--------------******************
Tile spawn;
Tile room1;
Tile room2;
//--------------------------end of tile DECLARATIONS
PImage darkness; //the darkness that follows the player
PImage brick1;
PImage noLit; //darkness in each room
PImage guiPImage;
PImage playerBag;
PImage playerBagIcn;
PImage activeWeaponIndicator;
PImage commandBubble;
PImage weaponTicker;
PImage weaponSelector;

float timer = millis();

GUI gui;

Player player; //create the player object
Light[] lights = new Light[1];

Chest chest1;
Darkness darkness1;

Monster[] goblin = new Monster[4]; //number in this array must be equal to the number of goblins present

int playerMovement = 0; //used for loading gifs based on player direction

Wall[] wall1V = new Wall[12];
Wall[] wall1H = new Wall[12];

Wall[] wall1LongV = new Wall[3];
Wall[] wall1LongH = new Wall[3];

Wall[] chestWall = new Wall[1];

HitBox playerHitBox;

//--WEAPONS
Weapon oneHandedAxe;
Weapon oneHandedSword;

//--WORLD
//--TILES
PImage mossyRock1;
PImage darkRock1;
//--OBSTACLES
PImage wall1VImage;
PImage wall1HImage;
PImage wall1LongVImage;
PImage wall1LongHImage;
//--SCENERY
PImage skullchestClosed;
PImage skullchestOpen;
PImage skullchestInterior;

//--PLAYER GIFS
Gif barb_idleGif;
Gif barb_downGif;
Gif barb_upGif;
Gif barb_leftGif;
Gif barb_rightGif;

//--WEAPON GIFS
//AXE
Gif axe_left;
Gif axe_right;
Gif axe_idle;
Gif axe_down;
Gif axe_up;
Gif axe_rotating;

//SWORD
Gif sword_left;
Gif sword_right;
Gif sword_idle;
Gif sword_down;
Gif sword_up;
Gif sword_rotating;

//--ITEM GIFS
Gif hpPotion;

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

void setup() {
  size(800, 600);
  frameRate(30);
  //FONTS
  fipps = loadFont("Fipps-Regular-48.vlw");//fipps font setup

  gui = new GUI(); //GUI setup


  //TILE SETUP (Room number, XPOS, YPOS, TILE-TYPE, Number of goblins)
  spawn = new Tile(0, 300, 200, 2, 0);
  room1 = new Tile(1, spawn.xPos+320, spawn.yPos, 2, 2);
  room2 = new Tile(2, spawn.xPos+320, spawn.yPos+320, 2, 2);
  //END TILE SETUP

  extraWalls();
  monsterSpawn();

  player = new Player(384, 284, 4, 50, 100); //define the player object, inputs are player xPos, player yPos, player Speed, player ammo, and player health, active Weapon
  player.setInitInventory();
  
  darkness1 = new Darkness();

  //chest creation: xpos,ypos,ione,itwo,ithree
  chest1 = new Chest(spawn.xPos+200, spawn.yPos + 200, "HP Potion", "Tattered Robes", "Sword"); //in spawn

  //torchTest = new Torch(300,0,0);
  //--WEAPONS Item ID, Type, Damage, Range
  oneHandedAxe = new Weapon("Axe", 1, 10, 10); //Item ID, Type, Damage, Range
  oneHandedSword = new Weapon("Sword", 2, 8, 12);

  darkness = loadImage("gfx/misc/darkness.png");
  noLit = loadImage("gfx/misc/noLit.png");
  wall1VImage = loadImage("gfx/world/obstacles/wall1V_new.gif");
  wall1HImage = loadImage("gfx/world/obstacles/wall1H_new.gif");
  wall1LongVImage = loadImage("gfx/world/obstacles/wall1LongV_new.gif");
  wall1LongHImage = loadImage("gfx/world/obstacles/wall1LongH_new.gif");
  guiPImage = loadImage("gfx/misc/GUI.png");
  playerBag = loadImage("gfx/misc/playerBag.png");
  playerBagIcn = loadImage("gfx/misc/playerBagIcn.png");
  activeWeaponIndicator = loadImage("gfx/misc/activeWeaponIndicator.png");
  commandBubble = loadImage("gfx/misc/commandBubble.png");
  weaponTicker = loadImage("gfx/misc/weaponTicker.png");
  weaponSelector = loadImage("gfx/misc/weaponSelector.png");

  //--WORLD 
  //--TILES
  mossyRock1 = loadImage("gfx/world/tiles/mossyRock1.gif");
  darkRock1 = loadImage("gfx/world/tiles/darkRock1_new.gif");
  //--OBSTACLES
  //--SCENERY
  skullchestClosed = loadImage("gfx/scenery/skullchestClosed_new.gif");
  skullchestOpen = loadImage("gfx/scenery/skullchestOpen_new.gif");
  skullchestInterior = loadImage("gfx/scenery/skullchestInterior.png");
  //torch1 = new Gif(this, "gfx/scenery/torch1.png");
  //torch1.loop();

  playerHitBox = new HitBox();
  //--PLAYER IMAGES-----------------------------------------------
  //BARB IDLE
  barb_idleGif = new Gif(this, "gfx/sprites/barb/barb_idle_new.gif");
  barb_idleGif.loop();
  //BARB DOWN
  barb_downGif = new Gif(this, "gfx/sprites/barb/barb_down_new.gif");
  barb_downGif.loop();
  //BARB UP
  barb_upGif = new Gif(this, "gfx/sprites/barb/barb_up_new.gif");
  barb_upGif.loop();
  //BARB LEFT
  barb_leftGif = new Gif(this, "gfx/sprites/barb/barb_left_new.gif");
  barb_leftGif.loop();
  //BARB RIGHT
  barb_rightGif = new Gif(this, "gfx/sprites/barb/barb_right_new.gif");
  barb_rightGif.loop();
  //end BARB IMAGES-------------------------------------------------------------

  //--MONSTER IMAGES
  //GOBLIN IMAGES
  //GOBLIN IDLE
  goblin_idleGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_idle_new.gif");
  goblin_idleGif.loop();
  //GOBLIN DOWN
  goblin_downGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_down_new.gif");
  goblin_downGif.loop();
  //GOBLIN UP
  goblin_upGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_up_new.gif");
  goblin_upGif.loop();
  //GOBLIN LEFT
  goblin_leftGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_left_new.gif");
  goblin_leftGif.loop();
  //GOBLIN RIGHT
  goblin_rightGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_right_new.gif");
  goblin_rightGif.loop();
  //GOBLIN ATTACK 
  goblin_atkGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_atk_new.gif");
  goblin_atkGif.loop();
  //GOBLIN DEATH 
  goblin_deathGif = new Gif(this, "gfx/sprites/monsters/goblin/goblin_death_new.gif");
  goblin_deathGif.play();

  //--WEAPON IMAGES
  //AXE
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

  //SWORD
  sword_left = new Gif(this, "gfx/weapons/sword_left.gif");
  sword_left.loop();
  sword_right = new Gif(this, "gfx/weapons/sword_right.gif");
  sword_right.loop();
  sword_idle = new Gif(this, "gfx/weapons/sword_idle.gif");
  sword_idle.loop();
  sword_down = new Gif(this, "gfx/weapons/sword_down.gif");
  sword_down.loop();
  sword_up = new Gif(this, "gfx/weapons/sword_up.gif");
  sword_up.loop();
  sword_rotating = new Gif(this, "gfx/weapons/sword_rotating.gif");
  sword_rotating.loop();
  axe_rotating = new Gif(this, "gfx/weapons/axe_rotating.gif");
  axe_rotating.loop();
  
  //--ITEM IMAGES
  hpPotion = new Gif(this, "gfx/items/hpPotion.gif");
  hpPotion.loop();
}//end setup

