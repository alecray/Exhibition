class Tile{
  boolean lit = false;
  float xPos; //tile position
  float yPos; //tile position
  int type; //type of tile (1 = mossyRock1, 2 = darkRock1)
  int tileNo;
  
  Tile(int tileNo_,float xPos_, float yPos_, int type_){
    tileNo = tileNo_;
    xPos = xPos_;
    yPos = yPos_;
    type = type_;
  }//end constructor
  
  void display(){
    rectMode(CORNER);
    rect(xPos,yPos,320,320);
    if(type == 1){
      image(mossyRock1, xPos, yPos);
    } 
    if(type == 2){
      image(darkRock1, xPos, yPos);
    }
  }//end display
  
  void wallsAroundTiles(){
        wall1V[0+(tileNo*4)] = new Wall(0,xPos,yPos,xPos+16,yPos+128);           //upper left
        wall1V[1+(tileNo*4)] = new Wall(0,xPos,yPos+192,xPos+16,yPos+320);       //lower left
        wall1V[2+(tileNo*4)] = new Wall(0,xPos+304,yPos,xPos+320,yPos+128);      //upper right
        wall1V[3+(tileNo*4)] = new Wall(0,xPos+304,yPos+192,xPos+320,yPos+320);  //lower right
        
        wall1H[0+(tileNo*4)] = new Wall(1,xPos+16,yPos,xPos+112,yPos+16);        //upper left
        wall1H[1+(tileNo*4)] = new Wall(1,xPos+16,yPos+304,xPos+112,yPos+320);   //lower left
        wall1H[2+(tileNo*4)] = new Wall(1,xPos+196,yPos,xPos+304,yPos+16);       //upper right
        wall1H[3+(tileNo*4)] = new Wall(1,xPos+196,yPos+304,xPos+304,yPos+320);  //lower right 
  }//end wallsAroundTiles
  
  void lit(){
    if(player.xPos > xPos && player.xPos < xPos + 320 && player.yPos > yPos && player.yPos < yPos + 320){
      lit = true;
    }
    else{
      lit = false;
      image(noLit,xPos,yPos);
    }
  }//end lit
      
  
}//end Tile
