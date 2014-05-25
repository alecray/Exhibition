class SavePoint{
  float xPos;
  float yPos;
  boolean inArea = false;
  SavePoint(float xPos_, float yPos_){
    xPos = xPos_;
    yPos = yPos_;
  }
  
  void display(){
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
  
  void saving(){
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
