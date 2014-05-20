void monsterSpawn(){ // inputs are monster speed, monster size, monster xPos, monster yPos, monster attack range, hp

  //no goblins in spawn
  //the goblins in room 1
  goblin[0] = new Monster(1,32,room1.xPos+10, room1.yPos + 50, 10, 100);
  goblin[1] = new Monster(1,32,room1.xPos+10, room1.yPos + 250, 10, 100);
  //the goblins in room 2
  goblin[2] = new Monster(1,32,room2.xPos + 100, room2.yPos +30, 10, 100);
  goblin[3] = new Monster(1,32,room2.xPos + 100, room2.yPos + 230, 10,100);
  //the goblins in room3
  goblin[4] = new Monster(1,32,room3.xPos + 20, room3.yPos + 20, 10,100);
  goblin[5] = new Monster(1,32,room3.xPos + 20, room3.yPos + 200, 10,100);
  goblin[6] = new Monster(1,32,room3.xPos + 20, room3.yPos + 100, 10,100);
  //the goblins in room 4
  goblin[7] = new Monster(1,32,room4.xPos + 20, room4.yPos+20,10,100);
  //goblins room5
  goblin[8] = new Monster(1,32,room5.xPos+20,room5.yPos+20,10,100);
  goblin[9] = new Monster(1,32,room5.xPos+20,room6.yPos+200,10,100);
  //goblins room6
  goblin[10] = new Monster(1,32,room6.xPos+20,room6.yPos+200,10,100);
  //goblins room8
  goblin[11] = new Monster(1,32,room8.xPos + 20, room8.yPos + 20, 10,100);
  goblin[12] = new Monster(1,32,room8.xPos + 20, room8.yPos + 200, 10,100);
  goblin[13] = new Monster(1,32,room8.xPos + 20, room8.yPos + 100, 10,100);
  //goblins room7
  goblin[14] = new Monster(1,32,room7.xPos + 20, room7.yPos + 20,10,100);
  //goblins room9
  goblin[15] = new Monster(1,32,room9.xPos + 20,room9.yPos +20,10,100);
  goblin[16] = new Monster(1,32,room9.xPos +20,room9.yPos+200,10,100);
  //THE NUMBER OF MONSTERS HERE MUST BE MATCHED TO THE NUMBER OF THE ARRAY SIZE
}
