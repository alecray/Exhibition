void keyTyped() {

  if (key == 'w' || key == 'W') {
    up = true;
    playerMovement = 1;
  }
  if (key == 'a' || key == 'A') {
    left = true;
    playerMovement = 2;
  }
  if (key == 's' || key == 'S') {
    dn = true;
    playerMovement = 3;
  }
  if (key == 'd' || key == 'D') {
    right = true;
    playerMovement = 4;
  }
  if (key == 'e' || key == 'E'){
    playerMovement = 0;
  }
}//end of keyPressed

void keyReleased() {

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
  /*if (key == 'q' || key == 'Q'){ //change weapon
    if(player.activeWeapon == "Axe"){
        player.activeWeapon = "Sword";
    }
    if(player.activeWeapon == "Sword"){
        player.activeWeapon = "Axe";
    }
        
  }*/
  if (key == 'h' || key == 'H'){
    gameRunning = false;
  }
}

void mousePressed() {
  if(mouseButton == LEFT){
  for (int i = 0; i < goblin.length; i++) {
    if (  player.xPos > goblin[i].xPos - player.sizeX - player.range
       && player.xPos < goblin[i].xPos + goblin[i].size + player.range
       && player.yPos > goblin[i].yPos - player.range - player.sizeY
       && player.yPos < goblin[i].yPos + goblin[i].size + player.range
       && timer - player.autoTimer > 200
      ) {
      goblin[i].HP -= player.damage;
      player.autoTimer = timer;
    }
  }
  }
}//end mousePressed

