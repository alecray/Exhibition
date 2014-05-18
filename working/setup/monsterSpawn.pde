void monsterSpawn(){ // inputs are monster speed, monster size, monster xPos, monster yPos, monster attack range, hp

  //no goblins in spawn
  //the goblins in room 1
  goblin[0] = new Monster(1,32,room1.xPos+10, room1.yPos + 50, 10, 100);
  goblin[1] = new Monster(1,32,room1.xPos+10, room1.yPos + 250, 10, 100);
  //the goblins in room 2
  goblin[2] = new Monster(1,32,room2.xPos + 100, room2.yPos +30, 10, 100);
  goblin[3] = new Monster(1,32,room2.xPos + 100, room2.yPos + 230, 10,100);
  //goblin[4] = new Monster(1,32,room2.xPos + 100, room2.yPos + 230, 10,100); //bottom of room 2
  
  //THE NUMBER OF MONSTERS HERE MUST BE MATCHED TO THE NUMBER OF THE ARRAY SIZE
}
