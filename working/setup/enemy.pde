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
  
  //inputs are monster speed, patrol box x, patrol box y, patrol box width, patrol box height, monster size
  Monster(float speed_, float size_, float xPos_, float yPos_ ) {
    
    speed = speed_;
    xSpeed = speed;
    ySpeed = 0;
    size = size_;
    xPos = xPos_;
    yPos = yPos_;
    initxPos = xPos_;
    inityPos = yPos_;
    

  }//end of constructor
  
  void display() {
    rectMode(CORNER);
    noStroke();
    fill(0,255,255,0);
    rect(xPos,yPos,size,size);//monster size is 32x32
    
  }//end display
  
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
      speed = 3;
      ang = atan2 (player.yPos - yPos, player.xPos - xPos);
      xSpeed = speed*cos(ang);
      ySpeed = speed*sin(ang);
      if(xPos < player.xPos){ //if the monster is to the left of the player, display right-moving gif
        monsterMovement = 4; 
      }
      if(xPos > player.xPos){ //if the monster is to the right of the player, display left-moving gif
        monsterMovement = 2;
      }
      if((xPos > player.xPos - 20)
      &&(xPos < player.xPos + player.sizeX + 20)
      &&(yPos > player.yPos - 20)
      &&(yPos < player.yPos + player.sizeY + 20)){ //if the monster is within a certain range of the player, stop the monster to attack
        speed = 0;
        xSpeed = 0;
        ySpeed = 0;
        monsterMovement = 0;
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
  
  void hit (){
    
      for (int i = 0; i < wall1V.length; i++){
    
        //BEGIN MONSTER/VERTICAL WALLS HIT DETECT
        if (yPos < wall1V[i].y2 && yPos > wall1V[i].y2-speed-1 && xPos < wall1V[i].x2 && xPos+size > wall1V[i].x1){
          yPos = wall1V[i].y2;
        }//end bottom edge
        
        if (yPos+size > wall1V[i].y1 && yPos+size < wall1V[i].y1+speed+1 && xPos < wall1V[i].x2 && xPos + size > wall1V[i].x1){
          yPos = wall1V[i].y1 - size;
        }//end top edge
        
        if (xPos < wall1V[i].x2 && xPos > wall1V[i].x2-speed-1 && yPos < wall1V[i].y2 && yPos+size > wall1V[i].y1){
          xPos = wall1V[i].x2;
        }//end right edge
        
        if (xPos+size > wall1V[i].x1 && xPos+size < wall1V[i].x1+speed+1 && yPos < wall1V[i].y2 && yPos + size > wall1V[i].y1){
          xPos = wall1V[i].x1 - size;
        }//end left edge
        //END MONSTER/VERTICAL WALLS HIT
      }
    for (int i = 0; i < wall1H.length; i++){
    
      //BEGIN MONSTER/HORIZONTAL WALLS HIT DETECT
      if (yPos < wall1H[i].y2 && yPos > wall1H[i].y2-speed-1 && xPos < wall1H[i].x2 && xPos+size > wall1H[i].x1){
        yPos = wall1H[i].y2;
      }//end bottom edge
      
      if (yPos+size > wall1H[i].y1 && yPos+size < wall1H[i].y1+speed+1 && xPos < wall1H[i].x2 && xPos + size > wall1H[i].x1){
        yPos = wall1H[i].y1 - size;
      }//end top edge
      
      if (xPos < wall1H[i].x2 && xPos > wall1H[i].x2-speed-1 && yPos < wall1H[i].y2 && yPos+size > wall1H[i].y1){
        xPos = wall1H[i].x2;
      }//end right edge
      
      if (xPos+size > wall1H[i].x1 && xPos+size < wall1H[i].x1+speed+1 && yPos < wall1H[i].y2 && yPos + size > wall1H[i].y1){
        xPos = wall1H[i].x1 - size;
      }//end left edge
      //END MONSTER/HORIZONTAL WALLS HIT
    }
  }//end hit
      /*//BEGIN PLAYER/MONSTER HIT DETECT
      if (player.yPos < yPos+size && player.yPos > yPos+size-player.speed-1 && player.xPos < xPos+size && player.xPos+player.size > xPos){
        player.yPos += speed*5;
        playerLifebar.health -= 10; 
        player.countY -= speed*5;
      }//end bottom edge
      
      if (player.yPos+player.size > yPos && player.yPos+player.size < yPos+player.speed+1 && player.xPos < xPos+size && player.xPos + player.size > xPos){
        player.yPos -= speed*5;
        playerLifebar.health -= 10;
        player.countY += speed*5;
      }//end top edge
      
      if (player.xPos < xPos+size && player.xPos > xPos+size-player.speed-1 && player.yPos < yPos+size && player.yPos+player.size > yPos){
        player.xPos += speed*5;
        playerLifebar.health -= 10;
        player.countX -= speed*5;
      }//end right edge
      
      if (player.xPos+player.size > xPos && player.xPos+player.size < xPos+player.speed+1 && player.yPos < yPos+size && player.yPos + player.size > yPos){
        player.xPos -= speed*5;
        playerLifebar.health -= 10;
        player.countX += speed*5;
      }//end left edge
      //END PLAYER/MONSTER HIT*/
      
      
    //end for loop
    
  
  
  /*void death (int i){
    
    if (living == true){
      
      playerXP.XP +=15;
      monsterKills +=1;
      
    }
    
    living = false;
    monsters[i] = monsters[monsters.length-1];
    shorten(monsters);
        
  }*/
    void gifAssign(){
    //IDLE/AFK
    if(monsterMovement == 0){ 
      image(goblin_idleGif, xPos, yPos); //display idle image at monster coords
    }
    //MOVING DOWN
    if(monsterMovement == 3){
      image(goblin_downGif, xPos, yPos); //display moving down image at monster coords
    }
    //MOVING UP
    if(monsterMovement == 1){
      image(goblin_upGif, xPos, yPos); //display moving up image at monster coords
    }
    //MOVING LEFT
    if(monsterMovement == 2){
      image(goblin_leftGif, xPos, yPos); //display moving left image at monster coords
    }
    //MOVING RIGHT
    if(monsterMovement == 4){
      image(goblin_rightGif, xPos, yPos); //display moving right image at monster coords
    }
  }//end gifAssign*/
}//end monsterOne class

