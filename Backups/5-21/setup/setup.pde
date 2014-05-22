import gifAnimation.*;

BufferedReader reader;
String loadedData;

InputStream input = createInput("saves/save.txt");
String savedData = "";

PFont fipps;//declares the fipps font

boolean gameRunning = false;
boolean playerAlive;
boolean showSaves=false;

//ITEM IDS
//1 = AXE
//2 = SWORD
//-------------TILE DECLARATIONS--------------******************
Tile spawn;
Tile room1;
Tile room2;
Tile room3;
Tile room4;
Tile room5;
Tile room6;
Tile room7;
Tile room8;
Tile room9;
Tile room10;
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
PImage startScreen;

//furniture
PImage table;

float timer = millis();
boolean saving = false;

GUI gui;
int startScreenSelectorYPos = 300;
Player player; //create the player object
//Light[] lights = new Light[1];

Chest chest1;
Chest chest2;

SavePoint savePoint1;

Darkness darkness1;

Monster[] goblin = new Monster[17]; //number in this array must be equal to the number of goblins present
Monster[] ogre = new Monster[2];

int playerMovement = 0; //used for loading gifs based on player direction

Wall[] wall1V = new Wall[44];
Wall[] wall1H = new Wall[44];

Wall[] wall1LongV = new Wall[11];
Wall[] wall1LongH = new Wall[12];

Wall[] chestWall = new Wall[1];

Lava[] lava = new Lava[1];

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
Gif barb_deathGif;

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
  
  //--OGRE GIFS
  Gif ogre_idleGif;
  Gif ogre_leftGif;
  Gif ogre_rightGif;
  Gif ogre_atkGif;

//--SCENERY GIFS
Gif torch1;
Gif lavaGif;
Gif save_pointGif;

void setup() {
  size(800, 600);
  
  reader = createReader("saves/save.txt");
  
  frameRate(30);
  //FONTS
  fipps = loadFont("Fipps-Regular-48.vlw");//fipps font setup

  gui = new GUI(); //GUI setup


  //TILE SETUP (Room number, XPOS, YPOS, TILE-TYPE, Number of goblins)
  spawn = new Tile(0, 300, 200, 2, 0);
  room1 = new Tile(1, spawn.xPos+320, spawn.yPos, 2, 2);
  room2 = new Tile(2, spawn.xPos+320, spawn.yPos+320, 2, 2);
  room3 = new Tile(3, room2.xPos+320,room2.yPos, 2, 3);
  room4 = new Tile(4, room1.xPos,room1.yPos-320,2,1);
  room5 = new Tile(5, room4.xPos,room4.yPos-320,2,2);
  room6 = new Tile(6, room5.xPos+320,room5.yPos,2,1);
  room7 = new Tile(7, room6.xPos+320,room6.yPos,2,1);
  room8 = new Tile(8, room6.xPos,room6.yPos-320,2,3);
  room9 = new Tile(9, room7.xPos,room7.yPos+320,2,2);
  room10 = new Tile(10, room9.xPos+320,room9.yPos,2,0);
  
  //END TILE SETUP

  extraWalls();
  lavaSetup();
  lightSetup();
  monsterSpawn();
  
  //furniture
  //image(table,spawn.xPos+100,spawn.xPos+200);
  
  player = new Player(384, 284, 4, 50, 100); //define the player object, inputs are player xPos, player yPos, player Speed, player ammo, and player health, active Weapon
  player.setInitInventory();
  
  darkness1 = new Darkness();

  //chest creation: xpos,ypos,ione,itwo,ithree
  chest1 = new Chest(room3.xPos+220, room3.yPos + 220, "HP Potion", "Tattered Robes", "Sword"); //in spawn
  chest2 = new Chest(room8.xPos+100,room8.yPos+16, "", "", " ");
  
  //save points
  savePoint1 = new SavePoint(spawn.xPos+50,spawn.yPos+34);
  
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
  startScreen = loadImage("gfx/misc/startScreen1.png");

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
  lavaGif = new Gif(this, "gfx/scenery/lava_new.gif");
  lavaGif.loop();
  
  save_pointGif = new Gif(this, "gfx/scenery/save_point.gif");
  save_pointGif.loop();
  
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
  //BARB DEATH
  barb_deathGif = new Gif(this, "gfx/sprites/barb/barb_death.gif");
  barb_deathGif.loop();
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
    goblin_deathGif.loop();
  
    //OGRE IMAGES
    //OGRE IDLE
    ogre_idleGif = new Gif(this, "gfx/sprites/monsters/ogre/ogre_idle.gif");
    ogre_idleGif.loop();
    ogre_leftGif = new Gif(this, "gfx/sprites/monsters/ogre/ogre_left.gif");
    ogre_leftGif.loop();
    ogre_rightGif = new Gif(this, "gfx/sprites/monsters/ogre/ogre_right.gif");
    ogre_rightGif.loop();
    ogre_atkGif = new Gif(this, "gfx/sprites/monsters/ogre/ogre_atk.gif");
    ogre_atkGif.loop();

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

