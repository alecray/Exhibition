import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class setup extends PApplet {


String[] loadSave;
PFont fipps;//declares the fipps font

boolean gameRunning = false;
boolean playerAlive;
boolean showSaves=false;
boolean classSelect=false; //for displaying the class select window
boolean isClassSelected=false; //to check whether or not a class has been selected

boolean inSpawn=  false;
boolean wPressed= false;
boolean aPressed= false;
boolean sPressed= false;
boolean dPressed= false;

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
PImage arrowDown;
PImage longArrowDown;
PImage slowedPNG;


//furniture
PImage table;

float timer = millis();
float slowTimer; //used for mage ice bolt spell
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

Gif mage_idleGif;
Gif mage_downGif;
Gif mage_upGif;
Gif mage_leftGif;
Gif mage_rightGif;

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

//FIREBALL
Gif fireball_icn;
Gif fireball_idle;
Gif fireball_down;
Gif fireball_left;
Gif fireball_right;
Gif fireball_up;

//ICE BOLT
Gif icebolt_icn;
Gif icebolt_idle;
Gif icebolt_down;
Gif icebolt_left;
Gif icebolt_right;
Gif icebolt_up;
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
Gif levelUPGif;

public void setup() {
  size(800, 600);
  
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
  
  player = new Player(384, 284, 4, 50, 100); //define the player object, inputs are player xPos, player yPos, player Speed, player ammo, and player health
  
  darkness1 = new Darkness();

  //chest creation: xpos,ypos,ione,itwo,ithree
  chest1 = new Chest(room3.xPos+220, room3.yPos + 220, "HP Potion", "Tattered Robes", "Sword"); //in spawn
  chest2 = new Chest(room8.xPos+100,room8.yPos+16, "HP Potion", "Useless Gold", "Spell: Ice Bolt");
  
  //save points
  savePoint1 = new SavePoint(spawn.xPos+50,spawn.yPos+34);
  
  //torchTest = new Torch(300,0,0);
  //--WEAPONS Item ID, Type, Damage, Range
  oneHandedAxe = new Weapon("Axe", 1, 25, 10); //Item ID, Type, Damage, Range
  oneHandedSword = new Weapon("Sword", 2, 20, 15);

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
  arrowDown = loadImage("gfx/misc/arrow_down.png");
  longArrowDown = loadImage("gfx/misc/long_arrow_down.png");
  slowedPNG = loadImage("gfx/misc/slowed.png");

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
  levelUPGif = new Gif(this, "gfx/misc/levelUP.gif");
  levelUPGif.play();
  
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
  
  //MAGE 
  //MAGE IDLE
  mage_idleGif = new Gif(this, "gfx/sprites/mage/mage_idle.gif");
  mage_idleGif.loop();
  //MAGE DOWN
  mage_downGif = new Gif(this, "gfx/sprites/mage/mage_down.gif");
  mage_downGif.loop();
  //MAGE UP
  mage_upGif = new Gif(this, "gfx/sprites/mage/mage_up.gif");
  mage_upGif.loop();
  //MAGE LEFT
  mage_leftGif = new Gif(this, "gfx/sprites/mage/mage_left.gif");
  mage_leftGif.loop();
  //MAGE RIGHT
  mage_rightGif = new Gif(this, "gfx/sprites/mage/mage_right.gif");
  mage_rightGif.loop();
  
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
  
  //FIREBALL
  fireball_icn = new Gif(this, "gfx/weapons/fireball_icn.gif");
  fireball_icn.loop();
  fireball_idle = new Gif(this, "gfx/weapons/fireball_idle.gif");
  fireball_idle.loop();
  fireball_down = new Gif(this, "gfx/weapons/fireball_down.gif");
  fireball_down.loop();
  fireball_left = new Gif(this, "gfx/weapons/fireball_left.gif");
  fireball_left.loop();
  fireball_right = new Gif(this, "gfx/weapons/fireball_right.gif");
  fireball_right.loop();
  fireball_up = new Gif(this, "gfx/weapons/fireball_up.gif");
  fireball_up.loop();
  
  //ICE BOLT
  icebolt_icn = new Gif(this, "gfx/weapons/icebolt_icn.gif");
  icebolt_icn.loop();
  icebolt_idle = new Gif(this, "gfx/weapons/icebolt_idle.gif");
  icebolt_idle.loop();
  icebolt_down = new Gif(this, "gfx/weapons/icebolt_down.gif");
  icebolt_down.loop();
  icebolt_left = new Gif(this, "gfx/weapons/icebolt_left.gif");
  icebolt_left.loop();
  icebolt_right = new Gif(this, "gfx/weapons/icebolt_right.gif");
  icebolt_right.loop();
  icebolt_up = new Gif(this, "gfx/weapons/icebolt_up.gif");
  icebolt_up.loop();
  
  //--ITEM IMAGES
  hpPotion = new Gif(this, "gfx/items/hpPotion.gif");
  hpPotion.loop();
}//end setup

class GUI{
  boolean isInvOpen = false;
  
  public void display(){
    timer = millis(); //set timer to each millisecond
    fill(255);
    
    //display weapon ticker
    image(weaponTicker,player.xPos-384,player.yPos-131);
    
    //display timer in upper left corner (commented out because it's just a developer tool)
    //textFont(fipps);
    //textSize(12);
    //text(timer, player.xPos - 385, player.yPos - 265);
    
    //display GUI PImage
    image(guiPImage, player.xPos - 384, player.yPos - 284);
    
    //display FPS in upper right corner 
    text(PApplet.parseInt(frameRate), player.xPos + 365, player.yPos -265);
    
    //display player lvl
    textFont(fipps);
    textSize(12); 
    text(player.lvl, player.xPos - 202, player.yPos + 213);
    
    //display hp potion
    textFont(fipps);
    textSize(8);
    text(player.HPPotionAmount, player.xPos+320, player.yPos+305);
    image(hpPotion,player.xPos + 330 ,player.yPos+280);
    
    //display player xp
    textFont(fipps);
    textSize(8);
    fill(200);
    text(PApplet.parseInt(100*(player.xp/160)) + "/100", player.xPos-3, player.yPos + 231);
    
    //player inventory size with bag icon
    textFont(fipps);
    textSize(8);
    image(playerBagIcn, player.xPos + 380, player.yPos + 280);
    text(player.inventory.length + "/10", player.xPos +370, player.yPos + 306);
    
    //Show the player's stats in a box
    fill(0,0,0,100);
    rect(player.xPos-400,player.yPos+300,player.xPos-250,player.yPos+400,5);
    textFont(fipps);
    textSize(8);
    fill(180,0,0);
    text(PApplet.parseInt(player.damage),player.xPos-381,player.yPos+313);
    fill(0,180,0);
    text(PApplet.parseInt(player.range),player.xPos-361,player.yPos+313);
    fill(100,255,100);
    text(PApplet.parseInt(player.speed),player.xPos-341,player.yPos+313);
    textFont(fipps);
    textSize(8);
    fill(255);
    
    //display possible weapons
    for(int i=0;i<player.weaponsHeld.length;i++){
      if(player.weaponsHeld[i].contains("Axe")){
        image(axe_rotating,player.xPos-376,player.yPos+200);
      }
      if(player.weaponsHeld[i].contains("Sword")){
        image(sword_rotating,player.xPos-374,player.yPos+160);
      }
      if(player.weaponsHeld[i].contains("Spell: Fireball")){
        image(fireball_icn,player.xPos-374,player.yPos+200);
      }
      if(player.weaponsHeld[i].contains("Spell: Ice Bolt")){
        image(icebolt_icn,player.xPos-374, player.yPos+160);
      }
    }
    
    //display selected weapon
    if(player.playerClass == "Barbarian"){
      if(keyPressed == true && (key == '1') && player.activeWeapon != "Axe"){
        for(int i=0;i<player.weaponsHeld.length;i++){
          if(player.weaponsHeld[i].contains("Axe")){
            player.activeWeapon = "Axe";
          }
        }
      }
       if(keyPressed == true && (key == '2') && player.activeWeapon != "Sword"){
         for(int i=0;i<player.weaponsHeld.length;i++){
            if(player.weaponsHeld[i].contains("Sword")){
              player.activeWeapon = "Sword";
          }
        }
      }
    }
    
    if(player.playerClass == "Mage"){
      if(keyPressed == true && (key == '1') && player.activeWeapon != "Spell: Fireball"){
        for(int i=0;i<player.weaponsHeld.length;i++){
          if(player.weaponsHeld[i].contains("Spell: Fireball")){
            player.activeWeapon = "Spell: Fireball";
          }
        }
      }
      if(keyPressed == true && (key == '2') && player.activeWeapon != "Spell: Ice Bolt"){
         for(int i=0;i<player.weaponsHeld.length;i++){
            if(player.weaponsHeld[i].contains("Spell: Ice Bolt")){
              player.activeWeapon = "Spell: Ice Bolt";
          }
        }
      }
    }
    //display weapon selector and numbers next to weapons
    textFont(fipps);
    textSize(8);
    for(int i=0;i<9;i++){
      text(i+1,player.xPos-346,player.yPos+221-(40*i));
    }
    if(player.activeWeapon == "Axe"){
      image(weaponSelector,player.xPos-374,player.yPos+200);
    }
    if(player.activeWeapon == "Sword"){
      image(weaponSelector,player.xPos-374,player.yPos+160);
    }
    if(player.activeWeapon == "Spell: Fireball"){
      image(weaponSelector,player.xPos-374,player.yPos+200);
    }
    if(player.activeWeapon == "Spell: Ice Bolt"){
      image(weaponSelector,player.xPos-374,player.yPos+160);
    }

  }//end Display
  
  public void guiInventory(){
    if(isInvOpen == true){
      player.playerInventory();
    }//end if isInvOpen
    
  }//end inventory
}//end GUI
    
class HitBox{
  float hbTopx1;
  float hbTopy1;
  float hbTopx2;
  float hbTopy2;
  
  float hbRightx1;
  float hbRighty1;
  float hbRightx2;
  float hbRighty2;
  
  float hbLeftx1;
  float hbLefty1;
  float hbLeftx2;
  float hbLefty2;
  
  float hbBottomx1;
  float hbBottomy1;
  float hbBottomx2;
  float hbBottomy2;
  
  HitBox(){
  }
  
  public void setPos(){
    hbTopx1 = player.xPos + 3;
    hbTopy1 = player.yPos;
    hbTopx2 = player.xPos + player.sizeX -3;
    hbTopy2 = player.yPos;
    
    hbRightx1 = hbTopx2 +3;
    hbRighty1 = hbTopy2 + 3;
    hbRightx2 = hbRightx1;
    hbRighty2 = hbTopy2 + player.sizeY - 3;
    
    hbLeftx1 = player.xPos;
    hbLefty1 = player.yPos + 3;
    hbLeftx2 = player.xPos;
    hbLefty2 = player.yPos + player.sizeY - 3;
    
    hbBottomx1 = hbLeftx2 + 3;
    hbBottomy1 = hbLefty2 + 3;
    hbBottomx2 = hbRightx2 - 3;
    hbBottomy2 = hbBottomy1;
  }//end setPos
  public void display(){
    stroke(0,0,0,50);
    line(hbTopx1,hbTopy1,hbTopx2,hbTopy2); //TOP LINE
    line(hbRightx1,hbRighty1,hbRightx2,hbRighty2); //RIGHT LINE
    line(hbLeftx1,hbLefty1,hbLeftx2,hbLefty2);
    line(hbBottomx1,hbBottomy1,hbBottomx2,hbBottomy2);
  }
}//end hitBox
public void HPPotion(){
  float hpTimer=-10000;
  int tempINT;
  for(int i =0; i<player.inventory.length; i++){
    if(player.inventory[i].contains("HP Potion") && player.hp < 100 && player.HPPotionAmount > 0 && timer - hpTimer > 10000){
      tempINT = player.inventory.length-1;
      player.inventory[i] = player.inventory[tempINT];
      player.inventory[tempINT] = "HP Potion";
      player.hp += 50;
      if(player.hp > 100){
        player.hp = 100;
      }
      player.tempInventory = shorten(player.inventory);
      player.inventory = player.tempInventory;
      player.HPPotionAmount-=1;
      hpTimer = timer;
    }
  }
}
public void extraWalls(){
  //LONG VERTICAL WALLS
  //spawn
  wall1LongV[0] = new Wall(3,spawn.xPos,spawn.yPos,spawn.xPos+16,spawn.yPos+320); //the wall on the left side of spawn
  //room1
  wall1LongV[1] = new Wall(3,room1.xPos +304,room1.yPos,room1.xPos+320,room1.yPos+320); //the wall at the right edge of room 1
  //room2
  wall1LongV[2] = new Wall(3,room2.xPos,room2.yPos,room2.xPos+16,room2.yPos+320); //the wall on the left side of room2
  //room3
  wall1LongV[3] = new Wall(3,room3.xPos +304,room3.yPos,room3.xPos+320,room3.yPos+320);//the wall at the right edge of room 3
  //room4
  wall1LongV[4] = new Wall(3,room4.xPos,room4.yPos,room4.xPos+16,room4.yPos+320);//left side wall
  wall1LongV[5] = new Wall(3,room4.xPos+304,room4.yPos,room4.xPos+320,room4.yPos+320); //right side wall
  //room5
  wall1LongV[6] = new Wall(3,room5.xPos,room5.yPos,room5.xPos+16,room5.yPos+320);//left side
  //room8
  wall1LongV[7] = new Wall(3,room8.xPos,room8.yPos,room8.xPos+16,room8.yPos+320);//left side 
  wall1LongV[8] = new Wall(3,room8.xPos+304,room8.yPos,room8.xPos+320,room8.yPos+320);//right side
  //room7
  wall1LongV[9] = new Wall(3,room7.xPos+304,room7.yPos,room7.xPos+320,room7.yPos+320);//right side
  //room9
  wall1LongV[10] = new Wall(3,room9.xPos,room9.yPos,room9.xPos+16,room9.yPos+320);//left
  
  //LONG HORIZONTAL WALLS
  //spawn
  wall1LongH[0] = new Wall(4,spawn.xPos,spawn.yPos,spawn.xPos + 320, spawn.yPos + 16); //the wall at the top of spawn
  wall1LongH[1] = new Wall(4,spawn.xPos,spawn.yPos+304,spawn.xPos + 320, spawn.yPos + 320); //the wall at the bottom of spawn
  //room2
  wall1LongH[2] = new Wall(4,room2.xPos,room2.yPos+304,room2.xPos + 320, room2.yPos + 320); //the wall at the bottom of room 2
  //room3
  wall1LongH[3] = new Wall(4,room3.xPos,room3.yPos,room3.xPos+320,room3.yPos+16);// wall at the top of room 3
  wall1LongH[4] = new Wall(4,room3.xPos,room3.yPos+304,room3.xPos+320,room3.yPos+320); //wall at the bottom of room 3
  //room5
  wall1LongH[5] = new Wall(4,room5.xPos,room5.yPos,room5.xPos+320,room5.yPos+16); //top
  //room6
  wall1LongH[6] = new Wall(4,room6.xPos,room6.yPos+304,room6.xPos+320,room6.yPos+320); //bottom
  //room8
  wall1LongH[7] = new Wall(4,room8.xPos,room8.yPos,room8.xPos+320,room8.yPos+16); //top
  //room7
  wall1LongH[8] = new Wall(4,room7.xPos,room7.yPos,room7.xPos+320,room8.yPos+16);//top
  //room9
  wall1LongH[9] = new Wall(4,room9.xPos,room9.yPos+304,room9.xPos+320,room9.yPos+320);//bottom
  //room10
  wall1LongH[10] = new Wall(4,room10.xPos,room10.yPos,room10.xPos+320,room10.yPos+16); //top
  wall1LongH[11] = new Wall(4,room10.xPos,room10.yPos+304,room10.xPos+320,room10.yPos+320);
  
  
  //CHEST WALLS
  chestWall[0] = new Wall(5,room3.xPos+220,room3.yPos+252,room3.xPos+284,room3.yPos+284);
}
public void lavaSetup(){
  lava[0] = new Lava(room4.xPos, room4.yPos+90);
}

public void lightSetup(){
  //LIGHTS xpos,ypos,radius,brightness,r,g,b, (255,125,0 for orange)
  //lights[0] = new Light(spawn.xPos,spawn.yPos,5,0.1,255,125,0);
}
 public void draw(){ //gets called each frame
 
 //--OPENING SCREEN--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if(gameRunning == false){
   background(255);
   fill(0);
   image(startScreen,0,0);
   fill(0,0,0,100);
   rectMode(CORNERS);
   stroke(100);
   rect(70,270,176,600,5);
   fill(255);
   textFont(fipps);
   textSize(12);
   text("New",100,300);
   if(startScreenSelectorYPos == 300){
     fill(200);
     text("Create a new game.", 200, startScreenSelectorYPos);
     text("(Basic tutorial as well)", 200, startScreenSelectorYPos + 20);
   }
   text("Load",100,320);
   if(startScreenSelectorYPos == 320){
     fill(200);
     text("Load from your last game", 200, startScreenSelectorYPos);
   }
   text("Exit",100,340);
   if(startScreenSelectorYPos == 340){
     fill(200);
     text("Exit the game.", 200, startScreenSelectorYPos);
   }
   fill(0,150,0);
   text("{           }",80,startScreenSelectorYPos);
   
   player.hp=100;
   if(classSelect == true && isClassSelected == false){
     background(255);
     image(startScreen,0,0);
     fill(0,0,0,100);
     rectMode(CORNERS);
     stroke(100);
     rect(70,270,225,600,5);
     textSize(12);
     fill(255);
     text("Barbarian",100,300);
     text("Mage",100,320);
     text("Back",100,340);
     fill(0,150,0);
     text("{                    }",80,startScreenSelectorYPos);
     if(startScreenSelectorYPos == 300){
       image(barb_idleGif, 240,280);
     }
     if(startScreenSelectorYPos == 320){
       image(mage_idleGif, 240,280);
     }
     if(keyPressed == true && (key == ENTER || key == RETURN)){
       if(startScreenSelectorYPos == 300 && isClassSelected == false){
            player.playerClass = "Barbarian";
            println(player.playerClass);
            gameRunning = true;
            playerAlive = true;
            player.activeWeapon = "Axe";
            player.mana = 0; //barbarians don't use mana
            player.setInitInventory();
            //player.setStatsByLevel();
        }
        if(startScreenSelectorYPos == 320 && isClassSelected == false){
            player.playerClass = "Mage";
            println(player.playerClass);
            gameRunning = true;
            playerAlive = true;
            player.activeWeapon = "Spell: Fireball";
            player.mana = 100;
            player.setInitInventory();
            //player.setStatsByLevel();
            player.manaTimer = 0;
            slowTimer = 0;
        }
        if(startScreenSelectorYPos == 340 && isClassSelected == false){
          classSelect = false;
          startScreenSelectorYPos = 300;
        }
          
     }
   }
}
 
 //--IN GAME*********************************************************************************************************************************************************************************************
 if(gameRunning == true){
   classSelect = false;
   showSaves = false;
   if(playerAlive == true){
      player.setWeapons();
      player.activeWeaponSetup();
      background(0); //resets the background EACH FRAME
      //CREATE WALLS
      spawn.wallsAroundTiles();
      room1.wallsAroundTiles();
      room2.wallsAroundTiles();
      room3.wallsAroundTiles();
      room4.wallsAroundTiles();
      room5.wallsAroundTiles();
      room6.wallsAroundTiles();
      room7.wallsAroundTiles();
      room8.wallsAroundTiles();
      room9.wallsAroundTiles();
      room10.wallsAroundTiles();
      //END CREATE WALLS

      player.move(); //moves the player
      
      //WALL COLLISION
      for(int i=0;i<wall1V.length;i++){
         wall1V[i].hit();
      }
      for(int i=0;i<wall1H.length;i++){
        wall1H[i].hit();
      }
      for(int i=0; i < wall1LongH.length; i++){
        wall1LongH[i].hit();
      }
      for(int i=0; i < wall1LongV.length; i++){
        wall1LongV[i].hit();
      }
      for(int i=0; i < chestWall.length; i++){
        chestWall[i].hit();
      }
      //END WALL COLLISION
      
      //--PUT ANY PLAYER COLLISION BEFORE THIS LINE-- (also anything you want to not be translated (GUI, etc))
      player.follow(); //camera follow
      
      playerHitBox.setPos(); //sets the position of the hitbox to the player 
      
      //DRAW TILES
      spawn.display();
      room1.display();
      room2.display();
      room3.display();
      room4.display();
      room5.display();
      room6.display();
      room7.display();
      room8.display();
      room9.display();
      room10.display();
      //END DRAW TILES
      //draw lava
      for(int i=0; i < lava.length;i++){
        lava[i].display();
      }
      savePoint1.display();
      savePoint1.saving();
      //DRAW WALLS
      for(int i=0; i < (wall1V.length);i++){
        wall1V[i].build();
      }
      for(int i=0; i < (wall1H.length);i++){
        wall1H[i].build();
      }
      for(int i=0; i < wall1LongH.length; i++){
        wall1LongH[i].build();
      }
      for(int i=0; i < wall1LongV.length; i++){
        wall1LongV[i].build();
      }

      //ALL GOBLIN COMMANDS WHILE LIVING
      for (int i = 0; i < goblin.length; i++){
        if(goblin[i].living == true){
          goblin[i].patrol(goblin[i].initxPos,goblin[i].inityPos,goblin[i].initxPos+100,goblin[i].inityPos + 100); //GOBLIN PATROL
          goblin[i].autoAttack();                                                                                  //GOBLIN AUTO ATTACK
          goblin[i].gifAssign();                                                                                   //GOBLIN GIF ASSIGNd
          goblin[i].collide();                                                                                     //GOBLIN COLLIDE
          goblin[i].hpDisplay();                                                                                   //GOBLIN HP DISPLAY
        }
        //GOBLIN DEATH
        if(goblin[i].HP <= 0){
          goblin[i].death(i);
        }
      }
      
      //ALL OGRE COMMANDS WHILE LIVING
      for (int i = 0; i < ogre.length; i++){
        if(ogre[i].living == true){
          ogre[i].patrol(ogre[i].initxPos,ogre[i].inityPos,ogre[i].initxPos+20,ogre[i].inityPos + 20); //OGRE PATROL
          ogre[i].autoAttack();                                                                                  //OGRE AUTO ATTACK
          ogre[i].gifAssign();                                                                                   //OGRE GIF ASSIGNd
          ogre[i].collide();                                                                                     //OGRE COLLIDE
          ogre[i].hpDisplay();                                                                                   //OGRE HP DISPLAY
        }
        //OGRE DEATH
        if(ogre[i].HP <= 0){
          ogre[i].death(i);
        }
      }
      chest2.chestState(); //this is before player because it makes more sense graphically for this chest
      player.display(); 
      player.gifAssign(); //ALWAYS LAST besides lighting, gui and inventory and chests
      
      chest1.chestState();//this is after player because it makes more sense graphically for this chest
      darkness1.shroud();
      /*for(int i=0;i<lights.length;i++){
        lights[i].on();
      }*/
      //torchTest.lit();
        //LITCHECK
      spawn.lit();
      room1.lit();
      room2.lit();
      room3.lit();
      room4.lit();
      room5.lit();
      room6.lit();
      room7.lit();
      room8.lit();
      room9.lit();
      room10.lit();
      //END LITCHECK
      
      if(inSpawn == false){
        textFont(fipps);
        textSize(12);
        fill(255,255,255,150);
        text("Re-enter this room for help!", spawn.xPos, room1.yPos+180); //this is to show the player they can re-enter spawn for a refresher on the controls
      }
      
      player.hpDisplay();
      player.manaDisplay();
      player.xpDisplay();
      
      gui.display();

      chest1.showChestInventory();
      chest2.showChestInventory();
      player.death();
      player.tutorial();
      gui.guiInventory();
  }//end IF PLAYERALIVE == TRUE
  if(playerAlive == false){
    background(100);
    image(darkRock1,0,0);
    image(darkRock1,320,0);
    image(darkRock1,640,0);
    image(darkRock1,0,320);
    image(darkRock1,320,320);
    image(darkRock1,640,320);
    
    fill(255);
    textFont(fipps);
    textSize(50);
    text("YOU HAVE DIED",102,102);
    fill(200,0,0,200);
    textFont(fipps);
    textSize(50);
    text("YOU HAVE DIED",100,100);
    image(barb_deathGif,384,284);
    image(goblin_idleGif,424,284);
    image(goblin_idleGif,384,230);
    image(goblin_idleGif,344,284);
    image(ogre_idleGif,380,350);
    textSize(12);
    fill(255);
    text("Press enter to respawn",521,571);
    fill(200,0,0,200);
    text("Press enter to respawn",520,570);
    
  }
   }//end IF GAME RUNNING
}//end draw
class Monster{ //class for the monsters in the game
  float xPos;
  float yPos;
  float initxPos;
  float inityPos;
  float speed;
  float xSpeed;
  float ySpeed;
  float ang;
  float size;
  float xPatrolReg;
  float yPatrolReg;
  boolean sighted = false;
  boolean living = true;
  int monsterMovement=4; //idle = 0, down = 3, up = 1, left = 2, right = 4
  float haltX; //for when the monster comes to a stop
  float haltY; //for when the monster comes to a stop
  float atkRNG; //monster's Attack Range
  float autoTimer; //used for timing the auto attack
  boolean attacking = false; //while the monster is attacking, for use in stopping the movement gifs
  boolean inRange = false; //while the monster is in range to attack
  float tempX;
  float tempY;
  float damage;
  String type;
  float maxHP;
  float HP;
  
  boolean slowed = false;
  
  //inputs are monster speed, monster size, monster xPos, monster yPos, monster attack range, hp
  //MONSTERS ARE DECLARED IN TILE CLASS
  Monster(String type_, float speed_, float size_, float xPos_, float yPos_, float atkRNG_, float maxHP_, float damage_) {
    type = type_;
    speed = speed_;
    xSpeed = speed;
    ySpeed = 0;
    size = size_;
    xPos = xPos_;
    yPos = yPos_;
    initxPos = xPos_;
    inityPos = yPos_;
    atkRNG = atkRNG_;
    
    maxHP = maxHP_;
    HP = maxHP;
    damage = damage_;

  }//end of constructor
  
  public void display() { //useless invisible box
    rectMode(CORNER);
    noStroke();
    fill(0,255,255,0);
    rect(xPos,yPos,size,size);//monster size is 32x32
    
  }//end display
  
  public void hpDisplay() { //displays an HP bar above the monster
    if(type == "Goblin"){
      rectMode(CORNERS);
      stroke(0);
      fill(200,0,0);
      rect(xPos - 10,yPos - 10, xPos - 10 + maxHP*0.55f, yPos - 5); //the 0.55 here is the make the healthbar the right size
      rectMode(CORNERS);
      stroke(0);
      fill(0,200,0);
      rect(xPos - 10,yPos - 10, xPos - 10 + HP*0.55f, yPos - 5); //the 0.55 here is the make the healthbar the right size
    }
    if(type == "Ogre"){
      rectMode(CORNERS);
      stroke(0);
      fill(200,0,0);
      rect(xPos - 10,yPos - 42, xPos - 10 + maxHP*0.2f, yPos - 37); //the 0.55 here is the make the healthbar the right size
      rectMode(CORNERS);
      stroke(0);
      fill(0,200,0);
      rect(xPos - 10,yPos - 42, xPos - 10 + HP*0.2f, yPos - 37); //the 0.55 here is the make the healthbar the right size
    }
  }//end hpDisplay
  
  public void patrol(float pX, float pY, float pW, float pH) { //a patrol function. inputs are x,y,width,height. makes the goblin walk back and forth
        
    if (sighted == false){ 
      
      if (xPos + size > pX + pW){    //moves down   
        xSpeed = 0;
        ySpeed = speed; 
        xPos = (pX + pW) - size;
        monsterMovement = 3; //change to monster up gif
      }
      
      if (yPos + size > pY + pH){ //moves left horizontally
       xSpeed = -speed;
       ySpeed = 0;
       yPos = (pY + pH) - size;
       monsterMovement = 2; //change to monster left gif
      } 
      
      if (xPos < pX){ //moves down vertically
        xSpeed = 0;
        ySpeed = -speed;
        xPos = pX;
        monsterMovement = 1; //change to monster down gif
      }
      
      if (yPos < pY){ //moves right horizontally
        xSpeed = speed;
        ySpeed = 0;
        yPos = pY;
        monsterMovement = 4; //change to monster right gif
      }
      
    }//end if sighted == false
    
    else {
      if(type == "Goblin"){
        speed = 1.5f;
        if(slowed == true){
          speed = 1;
        }
      }
      if(type == "Ogre"){
        speed = 0.3f;
        if(slowed == true){
          speed = 0.2f;
        }
      }
      ang = atan2 (player.yPos - yPos, player.xPos - xPos);
      xSpeed = speed*cos(ang);
      ySpeed = speed*sin(ang);
      if(xPos < player.xPos){ //if the monster is to the left of the player, display right-moving gif
        monsterMovement = 4; 
      }
      if(xPos > player.xPos){ //if the monster is to the right of the player, display left-moving gif
        monsterMovement = 2;
      }
      if(  xPos > player.xPos - atkRNG
        && xPos < player.xPos + player.sizeX
        && yPos > player.yPos - atkRNG
        && yPos < player.yPos + player.sizeY + atkRNG){ //if the monster is within a certain range of the player, stop the monster to attack
        speed = 0;
        xSpeed = 0;
        ySpeed = 0;
        halt();
        xPos = haltX;
        yPos = haltY;
      }
    }//end else
    
    if (dist (player.xPos,player.yPos,xPos,yPos) < 200){
      
      sighted = true;
            
    }//end sight detect
    
    
    
    xPos += xSpeed;
    yPos += ySpeed;
            
  }//end patrol
  
  public void halt(){ //stops the goblin
    haltX = xPos;
    haltY = yPos;
  }//end halt
  
  
  public void collide (){ //monster collision detection
    
      for (int i = 0; i < wall1V.length; i++){
    
        //BEGIN MONSTER/VERTICAL WALLS HIT DETECT
        if (yPos < wall1V[i].y2 && yPos > wall1V[i].y2-speed-1 && xPos < wall1V[i].x2 && xPos+size > wall1V[i].x1){
          if(sighted == false){
            ySpeed = -ySpeed;
          }
          if(sighted == true){
            yPos = wall1V[i].y2;
          }
          monsterMovement = 1;
        }//end bottom edge
        
        if (yPos+size > wall1V[i].y1 && yPos+size < wall1V[i].y1+speed+1 && xPos < wall1V[i].x2 && xPos + size > wall1V[i].x1){
          if(sighted == true){
          yPos = wall1V[i].y1 - size;
          }
          if(sighted == false){
            yPos = wall1V[i].y1 - size;
            ySpeed = -ySpeed;
          }
          monsterMovement = 3;
        }//end top edge
        
        if (xPos < wall1V[i].x2 && xPos > wall1V[i].x2-speed-1 && yPos < wall1V[i].y2 && yPos+size > wall1V[i].y1){
          if(sighted == true){
            xPos = wall1V[i].x2;
          }
          if(sighted == false){
            xPos = wall1V[i].x2;
            xSpeed = -xSpeed;
          }
          monsterMovement = 4;
        }//end right edge
        
        if (xPos+size > wall1V[i].x1 && xPos+size < wall1V[i].x1+speed+1 && yPos < wall1V[i].y2 && yPos + size > wall1V[i].y1){
          if(sighted == true){
            xPos = wall1V[i].x1 - size;
          }
          if(sighted == false){
            xPos = wall1V[i].x1 - size;
            xSpeed = -xSpeed;
          }
          monsterMovement = 2;
        }//end left edge
        //END MONSTER/VERTICAL WALLS HIT
      }
    for (int i = 0; i < wall1H.length; i++){
    
      //BEGIN MONSTER/HORIZONTAL WALLS HIT DETECT
      if (yPos < wall1H[i].y2 && yPos > wall1H[i].y2-speed-1 && xPos < wall1H[i].x2 && xPos+size > wall1H[i].x1){
        yPos = wall1H[i].y2;
        ySpeed = -ySpeed;
        monsterMovement = 1;
      }//end bottom edge
      
      if (yPos+size > wall1H[i].y1 && yPos+size < wall1H[i].y1+speed+1 && xPos < wall1H[i].x2 && xPos + size > wall1H[i].x1){
        yPos = wall1H[i].y1 - size;
        ySpeed = -ySpeed;
        monsterMovement = 3;
      }//end top edge
      
      if (xPos < wall1H[i].x2 && xPos > wall1H[i].x2-speed-1 && yPos < wall1H[i].y2 && yPos+size > wall1H[i].y1){
        xPos = wall1H[i].x2;
        xSpeed = -xSpeed;
        monsterMovement = 4;
      }//end right edge
      
      if (xPos+size > wall1H[i].x1 && xPos+size < wall1H[i].x1+speed+1 && yPos < wall1H[i].y2 && yPos + size > wall1H[i].y1){
        xPos = wall1H[i].x1 - size;
        xSpeed = -xSpeed;
        monsterMovement = 2;
      }//end left edge
      //END MONSTER/HORIZONTAL WALLS HIT
    }
  }//end hit
      
    //end for loop
    
  public void autoAttack(){ //the monster auto attack, on a timer of 1 second
    tempX = xPos;
    tempY = yPos;
    //if the monster is in range of the player's right side
    if(timer - autoTimer > 1000){
      if(  xPos > player.xPos - atkRNG
        && xPos < player.xPos + player.sizeX
        && yPos > player.yPos - atkRNG
        && yPos < player.yPos + player.sizeY + atkRNG){ //if it's been more than 1000ms than last hit
        autoTimer = timer;
        player.hp -= damage;
        attacking = true;
        inRange = true;
      }
      else{
        inRange = false;
        if(timer - autoTimer < 1000){
          xPos = tempX;
          yPos = tempY;
      }
    }
    }
  }//end AutoAttack
      
        
  public void death (int i){ //when the monster dies, gives player 20xp
    
    if (living == true){
      if(type == "Goblin"){
        player.xp+=20;
      }
      if(type == "Ogre"){
        player.xp+=40;
      }
    }
    
    living = false;
    goblin[i] = goblin[goblin.length-1];
    shorten(goblin);
    image(goblin_deathGif, goblin[i].xPos, goblin[i].yPos);
        
  }
    public void gifAssign(){ //assigns a gif based on the monster's motion
      //GOBLIN
        //IDLE/AFK
        if(type == "Goblin" && slowed == true){
          image(slowedPNG,xPos,yPos-32);
        }
        if(type == "Goblin" && monsterMovement == 0 && inRange == false){ 
          image(goblin_idleGif, xPos, yPos); //display idle image at monster coords
        }
        //MOVING DOWN
        if(type == "Goblin" && monsterMovement == 3 && inRange == false){
          image(goblin_downGif, xPos, yPos); //display moving down image at monster coords
        }
        //MOVING UP
        if(type == "Goblin" && monsterMovement == 1 && inRange == false){
          image(goblin_upGif, xPos, yPos); //display moving up image at monster coords
        }
        //MOVING LEFT
        if(type == "Goblin" && monsterMovement == 2 && inRange == false){
          image(goblin_leftGif, xPos, yPos); //display moving left image at monster coords
        }
        //MOVING RIGHT
        if(type == "Goblin" && monsterMovement == 4 && inRange == false){
          image(goblin_rightGif, xPos, yPos); //display moving right image at monster coords
        }
        if(type == "Goblin" && attacking == true && inRange == true){
          image(goblin_atkGif, xPos,yPos);
        }
     //OGRE
        if(type == "Ogre" && slowed == true){
          image(slowedPNG,xPos,yPos);
        }
        if(type == "Ogre" && monsterMovement == 0 && inRange == false){ 
          image(ogre_idleGif, xPos, yPos-32); //display idle image at monster coords
        }
        //MOVING DOWN
        if(type == "Ogre" && monsterMovement == 3 && inRange == false){
          image(ogre_idleGif, xPos, yPos-32); //display moving down image at monster coords
        }
        //MOVING UP
        if(type == "Ogre" && monsterMovement == 1 && inRange == false){
          image(ogre_idleGif, xPos, yPos-32);//display moving up image at monster coords
        }
        //MOVING LEFT
        if(type == "Ogre" && monsterMovement == 2 && inRange == false){
          image(ogre_leftGif, xPos, yPos-32);//display moving left image at monster coords 
        }
        //MOVING RIGHT
        if(type == "Ogre" && monsterMovement == 4 && inRange == false){
          image(ogre_rightGif, xPos, yPos-32); //display moving right image at monster coords
        }
        if(type == "Ogre" && attacking == true && inRange == true){
          image(ogre_atkGif, xPos, yPos-32);
        }
      
  }//end gifAssign*/
}//end monsterOne class

public void keyTyped() {
  if(gameRunning == true){
    if (key == 'w' || key == 'W') {
      up = true;
      playerMovement = 1;
      wPressed = true;
    }
    if (key == 'a' || key == 'A') {
      left = true;
      playerMovement = 2;
      aPressed = true;
    }
    if (key == 's' || key == 'S') {
      dn = true;
      playerMovement = 3;
      sPressed = true;
    }
    if (key == 'd' || key == 'D') {
      right = true;
      playerMovement = 4;
      dPressed = true;
    }
    if (key == 'e' || key == 'E'){
      playerMovement = 0;
    }
  }
  if(gameRunning == true && playerAlive == false &&(key == ENTER || key == RETURN)){
    player.tempX = player.xPos;
    player.tempY = player.yPos;
    player.xPos = 384;
    player.yPos = 284;
    player.follow();
    playerAlive = true;
    player.hp = 80;
    if(player.lvl>1){
      player.lvl-=1;
      player.xp=0;
    }
  }
}//end of keyPressed

public void keyReleased() {
  if(gameRunning == false){
    if(key == 'w'|| key == 'W'){
      if(showSaves == false){
        if(startScreenSelectorYPos>300){
          startScreenSelectorYPos-=20;
        }else{
          startScreenSelectorYPos=340;
        }
      }
      if(showSaves == true){
        if(startScreenSelectorYPos == 125){
          startScreenSelectorYPos = 580;
        }
        if(startScreenSelectorYPos == 580){
          startScreenSelectorYPos = 125;
        }
      }
    }
    if(key == 's' || key == 'S'){
      if(showSaves == false){
        if(startScreenSelectorYPos<340){
            startScreenSelectorYPos+=20;
          }else{
            startScreenSelectorYPos=300;
          }
      }
      if(showSaves == true){
        if(startScreenSelectorYPos == 125){
          startScreenSelectorYPos = 580;
        }
        if(startScreenSelectorYPos == 580){
          startScreenSelectorYPos = 125;
        }
    }
    }
    if(key == ENTER || key == RETURN){
      
      if(showSaves == false && classSelect == false){
        if(startScreenSelectorYPos == 300){
          classSelect = true;
          startScreenSelectorYPos = 300;
        }
        if(startScreenSelectorYPos == 320){
          showSaves = true;
          startScreenSelectorYPos = 125;
        }
        if(startScreenSelectorYPos == 340){
          exit();
        }
      }
      
      if(showSaves == true){
        if(startScreenSelectorYPos == 580){
          showSaves = false;
          startScreenSelectorYPos = 300;
        }
        if(startScreenSelectorYPos == 125){
          loadSave = loadStrings("saves/save.txt");
          player.loadSaveFile();
          gameRunning = true;
          playerAlive = true;
        }
      }
    }
      /*if(classSelect == true && showSaves == false){
        startScreenSelectorYPos = 300;
        if(startScreenSelectorYPos == 300 && isClassSelected == false){
            player.playerClass = "Barbarian";
            println(player.playerClass);
            barbarian = true;
        }
        if(startScreenSelectorYPos == 320  && isClassSelected == false){
            player.playerClass = "Mage";
            println(player.playerClass);
            mage = true;
        }
      }*/
    

  }//end if gamerunning == false
  if (key == 'w' || key == 'W') {
    up = false;
    playerMovement = 0;
  }
  if (key == 'a' || key == 'A') {
    left = false;
    playerMovement = 0;
  }
  if (key == 's' || key == 'S') {
    dn = false;
    playerMovement = 0;
  }
  if (key == 'd' || key == 'D') {
    right = false;
    playerMovement = 0;
  }
  if (key == 'e' || key == 'E'){
    playerMovement = 0;
  }
  if (key == 'i' || key == 'I'){
    gui.isInvOpen ^= true;
  }
  if (key == 'r' || key == 'R'){
    playerMovement = 0;
    HPPotion();
  }
  if (key == 'j' || key == 'J'){
    if(player.speed <3){
      player.speed += 5;
    }
    else{
      player.speed = 1;
    }
  }
  if (key == 'h' || key == 'H'){
    gameRunning = false;
  }
}

public void mouseReleased() {
  if(mouseButton == LEFT){
  for (int i = 0; i < goblin.length; i++) {
    if (  player.xPos > goblin[i].xPos - player.sizeX - player.range
       && player.xPos < goblin[i].xPos + goblin[i].size + player.range
       && player.yPos > goblin[i].yPos - player.range - player.sizeY
       && player.yPos < goblin[i].yPos + goblin[i].size + player.range
       && timer - player.autoTimer > 200
      ) {
      if(player.playerClass == "Mage" && player.mana > 10){
        goblin[i].HP -= player.damage;
        player.autoTimer = timer;
        if(player.activeWeapon == "Spell: Fireball"){
          player.mana-=10;
        }
        if(player.activeWeapon == "Spell: Ice Bolt" && player.mana > 13){
          player.mana-=13;
          slowTimer = timer;
          goblin[i].slowed = true;
        }
      }
      if(player.playerClass == "Barbarian"){
        goblin[i].HP -= player.damage;
        player.autoTimer = timer;
      }
    }
  }
  }
  for (int i = 0; i < ogre.length; i++) {
    if (  player.xPos > ogre[i].xPos - player.sizeX - player.range
       && player.xPos < ogre[i].xPos + ogre[i].size + player.range
       && player.yPos > ogre[i].yPos - player.range - player.sizeY
       && player.yPos < ogre[i].yPos + ogre[i].size + player.range
       && timer - player.autoTimer > 200
      ) {
      ogre[i].HP -= player.damage;
      player.autoTimer = timer;
      if(player.playerClass == "Mage" && player.mana > 10){
        ogre[i].HP -= player.damage;
        player.autoTimer = timer;
        if(player.activeWeapon == "Spell: Fireball"){
          player.mana-=10;
        }
        if(player.activeWeapon == "Spell: Ice Bolt" && player.mana > 13){
          player.mana-=13;
          slowTimer = timer;
          ogre[i].slowed = true;
        }
      }
      if(player.playerClass == "Barbarian"){
        ogre[i].HP -= player.damage;
        player.autoTimer = timer;
      }
    }
  }
}//end mousePressed

public void monsterSpawn(){ // inputs are monster speed, monster size, monster xPos, monster yPos, monster attack range, hp, damage

  //no goblins in spawn
  //the goblins in room 1
  goblin[0] = new Monster("Goblin",1,32,room1.xPos+10, room1.yPos + 50, 10, 100, 10);
  goblin[1] = new Monster("Goblin",1,32,room1.xPos+10, room1.yPos + 250, 10, 100, 10);
  //the goblins in room 2
  goblin[2] = new Monster("Goblin",1,32,room2.xPos + 100, room2.yPos +30, 10, 100, 10);
  goblin[3] = new Monster("Goblin",1,32,room2.xPos + 100, room2.yPos + 230, 10,100, 10);
  //the goblins in room3
  goblin[4] = new Monster("Goblin",1,32,room3.xPos + 20, room3.yPos + 20, 10,100, 8);
  goblin[5] = new Monster("Goblin",1,32,room3.xPos + 20, room3.yPos + 200, 10,100, 8);
  goblin[6] = new Monster("Goblin",1,32,room3.xPos + 20, room3.yPos + 100, 10,100, 8);
  //the goblins in room 4
  goblin[7] = new Monster("Goblin",1,32,room4.xPos + 20, room4.yPos+20,10,100, 10);
  //goblins room5
  goblin[8] = new Monster("Goblin",1,32,room5.xPos+20,room5.yPos+20,10,100, 10);
  goblin[9] = new Monster("Goblin",1,32,room5.xPos+20,room6.yPos+200,10,100, 10);
  //goblins room6
  goblin[10] = new Monster("Goblin",1,32,room6.xPos+20,room6.yPos+200,10,100, 10);
  //goblins room8
  goblin[11] = new Monster("Goblin",1,32,room8.xPos + 20, room8.yPos + 20, 10,100, 8);
  goblin[12] = new Monster("Goblin",1,32,room8.xPos + 20, room8.yPos + 200, 10,100, 8);
  goblin[13] = new Monster("Goblin",1,32,room8.xPos + 20, room8.yPos + 100, 10,100, 8);
  //goblins room7
  goblin[14] = new Monster("Goblin",1,32,room7.xPos + 20, room7.yPos + 20,10,100, 10);
  //goblins room9
  goblin[15] = new Monster("Goblin",1,32,room9.xPos + 20,room9.yPos +20,10,100, 10);
  goblin[16] = new Monster("Goblin",1,32,room9.xPos +20,room9.yPos+200,10,100, 10);
  //THE NUMBER OF MONSTERS HERE MUST BE MATCHED TO THE NUMBER OF THE ARRAY SIZE
  
  //OGRE SETUP
  ogre[0] = new Monster("Ogre",0.2f,64,room3.xPos+ 20,room3.yPos + 150,8,300, 20);
  ogre[1] = new Monster("Ogre",0.2f,64,room8.xPos+ 20,room8.yPos + 150,8,300, 20);
}
boolean up;
boolean right;
boolean dn;
boolean left;

class Player {

  float xPos;
  float yPos;
  float speed;
  float sizeX = 32;
  float sizeY = 64;
  float countX;
  float countY;
  float tempX;
  float tempY;

  float weaponRightPosX = xPos + sizeX;
  float weaponRightPosY = yPos + sizeY/2;

  float weaponLeftPosX = xPos;
  float weaponLeftPosY = yPos + sizeY/2;

  float hp;
  float mana;
  float manaTimer;
  
  int ammo;
  String activeWeapon;
  int weaponType;
  float range;
  float damage=20;

  float autoTimer;
  
  String playerClass;
  
  //stats
  float kills;
  float xp = 0;
  float xpOverlap;
  int lvl = 1;
  boolean eh=false;

  String[] inventory = new String[2];
  String[] tempInventory;
  String[] weaponsHeld = new String[0];

  int HPPotionAmount = 0;

  float tempNum;
  
  Player(float xPos_, float yPos_, float speed_, int ammo_, float hp_) { //inputs are player xPos, player yPos, player Speed, player ammo, and player health

    xPos = xPos_;
    yPos = yPos_;
    speed = speed_;
    ammo = ammo_;
    hp = hp_;
  }//end of constructor

  public void display() { //useless invisible rectangle player display

      rectMode(CORNER);
    noStroke();
    fill(0, 255, 255, 0);
    rect(xPos, yPos, sizeX, sizeY);//player size is 32x64
  }//end display

  public void tutorial() { //this is just for the simple tutorial in the spawn room
    if (xPos > spawn.xPos && xPos < spawn.xPos + 320 && yPos > spawn.yPos && yPos < spawn.yPos + 320) {
      inSpawn = true;
    } 
    else {
      inSpawn = false;
    }
    if (inSpawn == true) {
      if (wPressed == false) {
        fill(255);
        textSize(14);
        text("W", player.xPos -80, player.yPos + 100);
      } 
      else {
        fill(255, 255, 255, 50);
        textSize(14);
        text("W", player.xPos -80, player.yPos + 100);
      }

      if (aPressed == false) {
        fill(255);
        textSize(14);
        text("A", player.xPos -60, player.yPos + 100);
      } 
      else {
        fill(255, 255, 255, 50);
        textSize(14);
        text("A", player.xPos -60, player.yPos + 100);
      }

      if (sPressed == false) {
        fill(255);
        textSize(14);
        text("S", player.xPos -40, player.yPos + 100);
      } 
      else {
        fill(255, 255, 255, 50);
        textSize(14);
        text("S", player.xPos -40, player.yPos + 100);
      }

      if (dPressed == false) {
        fill(255);
        textSize(14);
        text("D", player.xPos -20, player.yPos + 100);
      } 
      else {
        fill(255, 255, 255, 50);
        textSize(14);
        text("D", player.xPos -20, player.yPos + 100);
      }
      if (wPressed == true && aPressed == true && sPressed == true && dPressed == true) {
        fill(255, 255, 255, 50);
        textSize(14);
        text("to move", player.xPos - 0, player.yPos + 100);
      } 
      else {
        fill(255);
        textSize(14);
        text("to move", player.xPos - 0, player.yPos + 100);
      }
      //DESCRIPTION OF INTERFACE
      fill(255);
      textSize(8);
      text("Here's your health", player.xPos -205, player.yPos + 260);
      text("Here's your mana", player.xPos +120, player.yPos + 260);
      image(arrowDown, player.xPos - 210, player.yPos+120);
      text("Here's your level", player.xPos -250, player.yPos+ 110);
      text("Here's your experience", player.xPos-60, player.yPos + 200);
      image(arrowDown, player.xPos + 338, player.yPos+200);
      image(arrowDown, player.xPos + 388, player.yPos+200);
      text("Health    Bag", player.xPos + 300, player.yPos + 188);
      text("Potions  Space", player.xPos + 310, player.yPos + 200);
      image(longArrowDown, player.xPos -366, player.yPos+50);
      textSize(10);
      text("This is your active weapon", player.xPos-360, player.yPos+40);
      fill(100);
      text("- Mouse Click to attack", player.xPos -380, player.yPos -240);
      text("- 'R' for HP Potion (Use sparingly)", player.xPos -380, player.yPos - 220);
      text("- 'I' for Inventory", player.xPos - 380, player.yPos - 200);
      text("- Killing monsters earns experience", player.xPos - 380, player.yPos - 180);
      text("- Experience gives levels, levels give strength", player.xPos - 380, player.yPos - 160);
      //END DESCRIPTION OF INTERFACE
      fill(200, 200, 250);
      text("Stand over these things to save your game", savePoint1.xPos-100, savePoint1.yPos);
      fill(255, 255, 0, 170);
      text("Go this way, watch out for monsters! -->", savePoint1.xPos +100, savePoint1.yPos+140);
    }
  }

  public void loadSaveFile() { //loads data from the save files in saves/save.txt
    player.lvl = parseInt(loadSave[0]);
    player.xp = parseFloat(loadSave[1]);
    player.hp = parseFloat(loadSave[2]);
    player.HPPotionAmount = parseInt(loadSave[3]);
    if(parseInt(loadSave[4]) == 0){
      player.playerClass = "Barbarian";
    }
    if(parseInt(loadSave[4]) == 1){
      player.playerClass = "Mage";
    }
  }

  public void activeWeaponSetup() {//stuff that happens when the player selects a weapon, damage increases based on player level
    if (activeWeapon == "Axe") {
      player.damage = oneHandedAxe.damage + lvl -1;
      player.range = oneHandedAxe.range;
    }
    if (activeWeapon == "Sword") {
      player.damage = oneHandedSword.damage + lvl -1;
      player.range = oneHandedSword.range;
    }
    if (activeWeapon == "Spell: Fireball"){
      player.damage = 30 + lvl-1;
      player.range = 40 + (lvl/3);
    }
    if (activeWeapon == "Spell: Ice Bolt"){
     player.damage = 15 + lvl-1;
     player.range = 30 + (lvl/3); 
    }
  }

  public void move() { //controls the player movement based on booleans from input

    tempX = xPos;
    tempY = yPos;

    if (up == true) {
      yPos -= speed;
    }
    if (left == true) {
      xPos -= speed;
    }        
    if (dn == true) {
      yPos += speed;
    }
    if (right == true) {
      xPos += speed;
    }
  }//end of move function

  public void follow() {//function for the "camera" to follow the player

    countX += tempX - xPos;
    countY += tempY - yPos;
    translate (countX, countY);
  }

  public void setInitInventory() { //sets the player's initial inventory upon starting a game
    if(playerClass == "Barbarian"){
      inventory[0] = "Axe";
      inventory[1] = "HP Potion";
      player.HPPotionAmount = 1;
    }
    if(playerClass == "Mage"){
      inventory[0] = "Spell: Fireball";
      inventory[1] = "HP Potion";
      player.HPPotionAmount = 1;
    }
  }

  public void playerInventory() { //draws the player inventory when you hit "i"
    fill(255);
    rect(xPos-223, yPos-200, xPos-64, yPos+150);
    image(playerBag, xPos-223, yPos-200);
    fill(50);
    textSize(10);
    text("Inventory:", player.xPos-210, player.yPos-175);

    for (int i=0; i < inventory.length; i++) {
      fill(0);
      textSize(8);
      text(inventory[i], player.xPos-190, player.yPos-150+(i*15));
    }
    for (int i=0; i < inventory.length; i++) {
      if (inventory[i].contains(activeWeapon)) {
        image(activeWeaponIndicator, player.xPos-230, player.yPos-163+(i*15));
      }
    }
  }
  
  public void setWeapons() { //sets weapons from what's in inventory
    for (int i=0; i<inventory.length; i++) {
      if (inventory[i].contains("Sword")) {
        weaponsHeld = append(weaponsHeld, "Sword");
      }
      if (inventory[i].contains("Axe")) {
        weaponsHeld = append(weaponsHeld, "Axe");
      }
      if (inventory[i].contains("Spell: Fireball")){
        weaponsHeld = append(weaponsHeld, "Spell: Fireball");
      }
      if (inventory[i].contains("Spell: Ice Bolt")){
        weaponsHeld = append(weaponsHeld, "Spell: Ice Bolt");
      }
      else{ }
    }
  }//end setWeapons

  public void xpDisplay() { //displays the player xp bar and controls levelup
    rectMode(CORNERS);
    fill(148, 0, 148, 150);
    rect(xPos-64, yPos+215, xPos-64+xp, yPos+236); //-64 to +96 is range for XP, a.k.a. a range of 160
    if (xp >= 160) {
      xpOverlap = xp - 160;
      lvl+=1;
      image(levelUPGif, player.xPos, player.yPos+32);
      levelUPGif.loop();
      xp = xpOverlap;
    }
  }
  public void hpDisplay() { //displays the player hp globe
    rectMode(CORNERS);
    fill(255, 0, 0);
    rect(xPos - 213, yPos + 384, xPos-74, yPos + 284 - (hp*0.85f));
    fill(255,255,255);
  }
  
  public void manaDisplay() {
    rectMode(CORNERS);
    fill(0,0,255);
    rect(xPos+243, yPos + 384, xPos + 108, yPos + 284 - (mana*0.85f));
    if(timer-manaTimer>100 && mana < 100){
      mana+=1;
      manaTimer = timer;
    }
    
  }
  
  public void death() { //when the player dies, resets monster position and de-aggros
    if (hp <=0) {
      playerAlive = false;
      for (int i=0; i<goblin.length;i++) {
        goblin[i].sighted = false;
        goblin[i].xPos = goblin[i].initxPos;
        goblin[i].yPos = goblin[i].inityPos;
      }
      for (int i=0; i<ogre.length;i++) {
        ogre[i].sighted = false;
        ogre[i].xPos = ogre[i].initxPos;
        ogre[i].yPos = ogre[i].inityPos;
      }
    }
  }//end death

  public void gifAssign() { //assigns a gif based on player motion and equipped weapon
    //IDLE/AFK
    if (playerMovement == 0) {
      if(playerClass == "Barbarian"){
        image(barb_idleGif, player.xPos, player.yPos);
      }
      if(playerClass == "Mage"){
        image(mage_idleGif, player.xPos, player.yPos);
      }
    }
    //MOVING DOWN
    if (playerMovement == 3 && keyPressed == true) {
      if(playerClass == "Barbarian"){
        image(barb_downGif, player.xPos, player.yPos);
      }
      if(playerClass == "Mage"){
        image(mage_downGif, player.xPos, player.yPos);
      }
    }
    //MOVING UP
    if (playerMovement == 1 && keyPressed == true) {
      if(playerClass == "Barbarian"){
        image(barb_upGif, player.xPos, player.yPos);
      }
      if(playerClass == "Mage"){
        image(mage_upGif, player.xPos, player.yPos);
      }
    }
    //MOVING LEFT
    if (playerMovement == 2 && keyPressed == true) {
      if(playerClass == "Barbarian"){
        image(barb_leftGif, player.xPos, player.yPos);
      }
      if(playerClass == "Mage"){
        image(mage_leftGif, player.xPos, player.yPos);
      }
    }
    //MOVING RIGHT
    if (playerMovement == 4 && keyPressed == true) {
      if(playerClass == "Barbarian"){
        image(barb_rightGif, player.xPos, player.yPos);
      }
      if(playerClass == "Mage"){
        image(mage_rightGif, player.xPos, player.yPos);
      }
    }
    //FOR ATTACKING
    if (mousePressed) {
      if (activeWeapon == "Axe") {
        if (playerMovement == 0) { //IDLE
          image(axe_idle, player.xPos - player.sizeX, player.yPos);
        }
        if (playerMovement == 3) { //DOWN
          image(axe_down, player.xPos, player.yPos + player.sizeY/2);
        }
        if (playerMovement == 1) { //UP
          image(axe_up, player.xPos, player.yPos - player.sizeY/2);
        }
        if (playerMovement == 4) { //RIGHT
          image(axe_right, player.xPos+player.sizeX, player.yPos + 10);
          axe_right.play();
        }
        if (playerMovement == 2) { //LEFT
          image(axe_left, player.xPos - player.sizeX, player.yPos + 10);
        }
      }//end if activeWeapon == Axe

      if (activeWeapon == "Sword") {
        if (playerMovement == 0) { //IDLE
          image(sword_idle, player.xPos - player.sizeX, player.yPos);
        }
        if (playerMovement == 3) { //DOWN
          image(sword_down, player.xPos, player.yPos + player.sizeY/2);
        }
        if (playerMovement == 1) { //UP
          image(sword_up, player.xPos, player.yPos - player.sizeY/2);
        }
        if (playerMovement == 4) { //RIGHT
          image(sword_right, player.xPos+player.sizeX, player.yPos + 10);
        }
        if (playerMovement == 2) { //LEFT
          image(sword_left, player.xPos - player.sizeX, player.yPos + 10);
        }
      }
      
      if (activeWeapon == "Spell: Fireball" && mana > 10){
        if (playerMovement == 0) { //IDLE
          image(fireball_idle, player.xPos - player.sizeX - 15, player.yPos);
        }
        if (playerMovement == 3) { //DOWN
          image(fireball_down, player.xPos, player.yPos + player.sizeY/2);
        }
        if (playerMovement == 1) { //UP
          image(fireball_up, player.xPos, player.yPos-128);
        }
        if (playerMovement == 4) { //RIGHT
          image(fireball_right, player.xPos+player.sizeX, player.yPos + 10);
        }
        if (playerMovement == 2) { //LEFT
          image(fireball_left, player.xPos-128, player.yPos + 10);
        }
      }
      if (activeWeapon == "Spell: Ice Bolt" && mana > 13){
        if (playerMovement == 0) { //IDLE
          image(icebolt_idle, player.xPos - player.sizeX - 15, player.yPos);
        }
        if (playerMovement == 3) { //DOWN
          image(icebolt_down, player.xPos, player.yPos + player.sizeY/2);
        }
        if (playerMovement == 1) { //UP
          image(icebolt_up, player.xPos, player.yPos-128);
        }
        if (playerMovement == 4) { //RIGHT
          image(icebolt_right, player.xPos+player.sizeX, player.yPos + 10);
        }
        if (playerMovement == 2) { //LEFT
          image(icebolt_left, player.xPos-128, player.yPos + 10);
        }
      }
    }//end mousePressed
  }//end gifAssign
}//end of player class

class SavePoint{
  float xPos;
  float yPos;
  boolean inArea = false;
  SavePoint(float xPos_, float yPos_){
    xPos = xPos_;
    yPos = yPos_;
  }
  
  public void display(){
    if(player.xPos > xPos -10 && player.xPos < xPos +42 && player.yPos > yPos -10 && player.yPos < yPos + 74){
      saving = true;
      int x=0; //variable for making a gradiated light
        while(x<5){
          noStroke();
          fill(0,0,255,255-(x*51));
          ellipse(xPos+16,yPos+32,30*x,30*x);
          x+=1;
        }
    } else {
      saving = false;
    }
    image(save_pointGif,xPos,yPos);
  }
  
  public void saving(){
    if(player.xPos > xPos -10 && player.xPos < xPos +42 && player.yPos > yPos -10 && player.yPos < yPos + 74 && inArea == false){
      String lvlString = nf(player.lvl,1);
      round(player.xp);
      String xpString = nf(player.xp,3,0);
      String hpString = nf(player.hp, 3,0);
      String hpPotionNo = nf(player.HPPotionAmount, 1);
      String playerClassNo = nf(0,1,0);
      if(player.playerClass == "Barbarian"){
       playerClassNo = nf(0,1,0);
      }
      if(player.playerClass == "Mage"){
       playerClassNo = nf(1,1,0);
      } 
      String[] toSave = {lvlString
                        ,xpString,hpString,hpPotionNo,playerClassNo};
      saveStrings("saves/save.txt", toSave);
    } else {
      inArea = false;
    }
  }
}
class Lava {
  float xPos;
  float yPos;
  
  Lava(float xPos_, float yPos_){
    xPos = xPos_;
    yPos = yPos_;
  }
  
  public void display(){
    image(lavaGif,xPos,yPos);
  }
  
  public void burn(){
  }
}

class Light {
  float xPos;
  float yPos;
  float radius; //largest radius
  float brightness; //brightness, use range 0.00-1.00 for percent change 
  float r;
  float g;
  float b;
  
  Light(float xPos_, float yPos_, float radius_, float brightness_, float r_, float g_, float b_){
    xPos = xPos_;
    yPos = yPos_;
    radius = radius_;
    brightness = brightness_;
    r=r_;
    g=g_;
    b=b_;
  }//end constructor
  
  public void on(){
    int x=30; //variable for making a gradiated light
    while(x>0){
      fill(r,g,b,x*brightness*10);
      ellipse(xPos,yPos,radius*x,radius*x);
      x=x-3;
    }
  }//end on
}//end Light

/*class Torch {
  float xPos;
  float yPos;
  float rotation;
  
  Torch(float xPos_, float yPos_, float rotation_){
    xPos = xPos_;
    yPos = yPos_;
    rotation = rotation_;
  }
  
  void lit(){
    rotate(rotation);
    image(torch1, xPos, yPos);
  }
}//end Torch*/

class Darkness {
  
  public void shroud(){ 
    image(darkness, player.xPos-384, player.yPos-284);
  }
}//end Darkness
      
class Chest {
  String ione;
  String itwo;
  String ithree;

  float xPos;
  float yPos;
  
  int chestState = 0; // 0 = closed, 1 = open
  boolean chestEmpty = false;
  
  Chest(float xPos_, float yPos_, String ione_, String itwo_, String ithree_){
    xPos = xPos_;
    yPos = yPos_;
    
    ione = ione_;
    itwo = itwo_;
    ithree = ithree_;
  }//end constructor
  
  public void chestState(){//if the e is pressed and the player is in range
    if(keyPressed == true && (key == 'e' || key == 'E') && (player.xPos > xPos -50) && (player.xPos < xPos + 50)
       && (player.yPos > yPos -50) && (player.yPos < yPos + 50)){
      image(skullchestOpen,xPos,yPos);
      chestState = 1;
          
              if(keyPressed == true && mousePressed == true && chestEmpty == false){
                if(ione == "HP Potion"){
                  player.HPPotionAmount+=1;
                }
                if(itwo == "HP Potion"){
                  player.HPPotionAmount+=1;
                }
                if(ithree == "HP Potion"){
                  player.HPPotionAmount+=1;
                }
          player.inventory = append(player.inventory, ione);
          player.inventory = append(player.inventory, itwo);
          player.inventory = append(player.inventory, ithree);
          ione = "Chest looted!";
          itwo = " ";
          ithree = " ";
          chestEmpty = true;
          println(player.inventory);
        }
    }
    else{
      image(skullchestClosed,xPos,yPos);
      chestState = 0;
    }
  }//end cheststate
    
  public void showChestInventory(){
      if(chestState == 1){
        fill(255);
        rect(player.xPos+96,player.yPos-200,player.xPos+256,player.yPos+150);
        image(skullchestInterior,player.xPos+96,player.yPos-200);
        fill(255);
        text(ione,player.xPos + 110,player.yPos - 175);
        text(itwo,player.xPos + 110,player.yPos - 160);
        text(ithree,player.xPos + 110,player.yPos - 145);
        fill(255,255,0);
        textSize(8);
        if(chestEmpty == false){
          text("Click anywhere to loot all!", player.xPos -370, player.yPos+170);
        }
        }
      
      if(chestState == 0 && (player.xPos > xPos -50) && (player.xPos < xPos + 50)
       && (player.yPos > yPos -50) && (player.yPos < yPos + 50)){
         textSize(10);
         fill(0);
         image(commandBubble, player.xPos-11,player.yPos-30);
         text("E", player.xPos, player.yPos -14);
       }
    }//end showChestInventory
}//end Chest
     
class Wall {
  int type; //0=vert,1=hor
  float x1;
  float y1;
  float x2;
  float y2;
  
  Wall (int type_, float x1_, float y1_, float x2_, float y2_){
    type = type_;
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
  }
  
  public void build(){
    
    rectMode (CORNERS);
    noStroke();
    fill (0,0,0,0);
    rect (x1, y1, x2, y2);
    if(type == 0){ //vertical wall
      image(wall1VImage,x1,y1);
    }
    if(type == 1){ //horizontal wall
      image(wall1HImage,x1,y1);
    }
    if(type == 3){ //vertical long wall
      image(wall1LongVImage,x1,y1);
    }
    if(type == 4){ //horizontal long wall
      image(wall1LongHImage,x1,y1);
    }
    if(type == 5){ //chests
      rectMode(CORNERS);
      rect(x1,y1,x2,y2);
    }
  }
  
  public void hit() {
    
    //BEGIN PLAYER HIT DETECT
        //BEGIN PLAYER HIT DETECT
    
    //when you hit the bottom of the wall, moving up
    if (playerHitBox.hbTopy1 > y1   //top portion of hitbox is below top of wall (reversed because processing grid is flipped)
       && playerHitBox.hbTopx2 > x1 //player's top right corner is within horizontal bounds of wall
       && playerHitBox.hbTopy1 < y2 //if player's top is inside wall, bump it out
       && playerHitBox.hbTopx1 < x2 //player's top left corner is within horizontal bounds of wall
       && up == true){              //the 'W' or 'w' key is pressed
      player.yPos = y2 - 3; //the +/- 3 is to correct for the bounding box
      
    }//end bottom edge
    //when you hit the right side of the wall, moving left
    if (playerHitBox.hbLeftx1 < x2
       && playerHitBox.hbLefty1 < y2
       && playerHitBox.hbLefty2 > y1
       && playerHitBox.hbLeftx1 > x1
       && left == true){
         player.xPos = x2 - 3; //the +/- 3 is to correct for the bounding box
    }//end right edge
    
    //when you hit the left side of the wall, moving right
    if (playerHitBox.hbRightx1 > x1
       && playerHitBox.hbRighty1 < y2
       && playerHitBox.hbRighty2 > y1
       && playerHitBox.hbRightx1 < x2
       && right == true){
         player.xPos = x1 - player.sizeX + 3; //the +/- 3 is to correct for the bounding box
       }//end left edge
    
    //when you hit the top side of the wall, moving down
    if (playerHitBox.hbBottomy1 > y1
       && playerHitBox.hbBottomx2 > x1
       && playerHitBox.hbBottomx1 < x2
       && playerHitBox.hbBottomy1 < y2
       && dn == true){
         player.yPos = y1 - player.sizeY + 3; //the +/- 3 is to correct for the bounding box
       }//end bottom edge
  }//end hit
  
}
class Tile{
  boolean lit = false;
  float xPos; //tile position
  float yPos; //tile position
  int type; //type of tile (1 = mossyRock1, 2 = darkRock1)
  int tileNo;
  int numberOfGoblins=4;
  int totalMonsterCount = 0;
  
  Tile(int tileNo_,float xPos_, float yPos_, int type_, int numberOfGoblins_){
    tileNo = tileNo_;
    xPos = xPos_;
    yPos = yPos_;
    type = type_;
    numberOfGoblins = numberOfGoblins_;
  }//end constructor
  
  public void display(){
    rectMode(CORNER);
    rect(xPos,yPos,320,320);
    if(type == 1){
      image(mossyRock1, xPos, yPos);
    } 
    if(type == 2){
      image(darkRock1, xPos, yPos);
    }
  }//end display
  
  public void wallsAroundTiles(){
        wall1V[0+(tileNo*4)] = new Wall(0,xPos,yPos,xPos+16,yPos+128);           //upper left
        wall1V[1+(tileNo*4)] = new Wall(0,xPos,yPos+192,xPos+16,yPos+320);       //lower left
        wall1V[2+(tileNo*4)] = new Wall(0,xPos+304,yPos,xPos+320,yPos+128);      //upper right
        wall1V[3+(tileNo*4)] = new Wall(0,xPos+304,yPos+192,xPos+320,yPos+320);  //lower right
        
        wall1H[0+(tileNo*4)] = new Wall(1,xPos+16,yPos,xPos+112,yPos+16);        //upper left
        wall1H[1+(tileNo*4)] = new Wall(1,xPos+16,yPos+304,xPos+112,yPos+320);   //lower left
        wall1H[2+(tileNo*4)] = new Wall(1,xPos+196,yPos,xPos+304,yPos+16);       //upper right
        wall1H[3+(tileNo*4)] = new Wall(1,xPos+196,yPos+304,xPos+304,yPos+320);  //lower right 
  }//end wallsAroundTiles
  
  public void lit(){
    if(player.xPos > xPos && player.xPos < xPos + 320 && player.yPos > yPos && player.yPos < yPos + 320){
      lit = true;
    }
    else{
      lit = false;
      image(noLit,xPos,yPos);
    }
  }//end lit
      
  
}//end Tile
class Weapon{
  String ID;
  int type; 
  //1 = axe
  //2 = sword
  float damage;
  float range; 
  
  Weapon(String ID_, int type_, float damage_, float range_){ //Item ID, Type, Damage, Range
    ID = ID_;
    type = type_;
    damage = damage_;
    range = range_;
  }//end constructor
  
  public void equip(){
    player.activeWeapon = ID;
    player.weaponType = type;
    player.range = range;
    player.damage = damage;
  }//end equip
  
  //void display(){}
    
}//end Weapon
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "setup" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
