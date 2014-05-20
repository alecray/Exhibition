class GUI{
  boolean isInvOpen = false;
  
  void display(){
    timer = millis(); //set timer to each millisecond
    fill(255);
    
    //display weapon ticker
    image(weaponTicker,player.xPos-384,player.yPos-131);
    
    //display timer in upper left corner
    textFont(fipps);
    textSize(12);
    text(timer, player.xPos - 385, player.yPos - 265);
    
    //display GUI PImage
    image(guiPImage, player.xPos - 384, player.yPos - 284);
    
    //display FPS in upper right corner 
    text(int(frameRate), player.xPos + 365, player.yPos -265);
    
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
    text(int(100*(player.xp/160)) + "/100", player.xPos-3, player.yPos + 231);
    
    //player inventory size with bag icon
    textFont(fipps);
    textSize(8);
    image(playerBagIcn, player.xPos + 380, player.yPos + 280);
    text(player.inventory.length + "/10", player.xPos +370, player.yPos + 306);
    
    
    //display possible weapons
    for(int i=0;i<player.weaponsHeld.length;i++){
      if(player.weaponsHeld[i].contains("Axe")){
        image(axe_rotating,player.xPos-376,player.yPos+200);
      }
      if(player.weaponsHeld[i].contains("Sword")){
        image(sword_rotating,player.xPos-374,player.yPos+160);
      }
    }
    
    //display selected weapon
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
  }//end Display
  
  void guiInventory(){
    if(isInvOpen == true){
      player.playerInventory();
    }//end if isInvOpen
    
  }//end inventory
}//end GUI
    
