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
  
  void setPos(){
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
  void display(){
    stroke(0,0,0,50);
    line(hbTopx1,hbTopy1,hbTopx2,hbTopy2); //TOP LINE
    line(hbRightx1,hbRighty1,hbRightx2,hbRighty2); //RIGHT LINE
    line(hbLeftx1,hbLefty1,hbLeftx2,hbLefty2);
    line(hbBottomx1,hbBottomy1,hbBottomx2,hbBottomy2);
  }
}//end hitBox
