void HPPotion(){
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
