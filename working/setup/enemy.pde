class Monster
{
  float initxPos;
  float inityPos;
  float xPos;
  float yPos;
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
  
  void display() {
    rectMode(CORNER);
    noStroke();
    fill(0,255,255,0);
    rect(xPos,yPos,size,size);//monster size is 32x32
    
  }//end display
  
  void hpDisplay() {
    if(type == "Goblin"){
      rectMode(CORNERS);
      stroke(0);
      fill(200,0,0);
      rect(xPos - 10,yPos - 10, xPos - 10 + maxHP*0.55, yPos - 5); //the 0.55 here is the make the healthbar the right size
      rectMode(CORNERS);
      stroke(0);
      fill(0,200,0);
      rect(xPos - 10,yPos - 10, xPos - 10 + HP*0.55, yPos - 5); //the 0.55 here is the make the healthbar the right size
    }
    if(type == "Ogre"){
      rectMode(CORNERS);
      stroke(0);
      fill(200,0,0);
      rect(xPos - 10,yPos - 42, xPos - 10 + maxHP*0.2, yPos - 37); //the 0.55 here is the make the healthbar the right size
      rectMode(CORNERS);
      stroke(0);
      fill(0,200,0);
      rect(xPos - 10,yPos - 42, xPos - 10 + HP*0.2, yPos - 37); //the 0.55 here is the make the healthbar the right size
    }
  }//end hpDisplay
  
  void patrol(float pX, float pY, float pW, float pH) {//a patrol function. inputs are x,y,width,height
        
    if (sighted == false){ 
      
      if (xPos + size > pX + pW){    //moves up vertically    
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
      speed = 1.5;
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
  
  void halt(){
    haltX = xPos;
    haltY = yPos;
  }//end halt
  
  
  void collide (){
    
      for (int i = 0; i < wall1V.length; i++){
    
        //BEGIN MONSTER/VERTICAL WALLS HIT DETECT
        if (yPos < wall1V[i].y2 && yPos > wall1V[i].y2-speed-1 && xPos < wall1V[i].x2 && xPos+size > wall1V[i].x1){
          yPos = wall1V[i].y2;
          ySpeed = -ySpeed;
          monsterMovement = 1;
        }//end bottom edge
        
        if (yPos+size > wall1V[i].y1 && yPos+size < wall1V[i].y1+speed+1 && xPos < wall1V[i].x2 && xPos + size > wall1V[i].x1){
          yPos = wall1V[i].y1 - size;
          ySpeed = -ySpeed;
          monsterMovement = 3;
        }//end top edge
        
        if (xPos < wall1V[i].x2 && xPos > wall1V[i].x2-speed-1 && yPos < wall1V[i].y2 && yPos+size > wall1V[i].y1){
          xPos = wall1V[i].x2;
          xSpeed = -xSpeed;
          monsterMovement = 4;
        }//end right edge
        
        if (xPos+size > wall1V[i].x1 && xPos+size < wall1V[i].x1+speed+1 && yPos < wall1V[i].y2 && yPos + size > wall1V[i].y1){
          xPos = wall1V[i].x1 - size;
          xSpeed = -xSpeed;
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
    
  void autoAttack(){
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
      
        
  void death (int i){
    
    if (living == true){
      
      player.xp+=20;
      
    }
    
    living = false;
    goblin[i] = goblin[goblin.length-1];
    shorten(goblin);
    image(goblin_deathGif, goblin[i].xPos, goblin[i].yPos);
        
  }
    void gifAssign(){
      //GOBLIN
        //IDLE/AFK
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

