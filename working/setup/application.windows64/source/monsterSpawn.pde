void monsterSpawn(){ // inputs are monster speed, monster size, monster xPos, monster yPos, monster attack range, hp, damage

  //no goblins in spawn
  //the goblins in room 1
  goblin[0] = new Monster("Goblin",1,32,room1.xPos+10, room1.yPos + 50, 10, 100, 10);
  goblin[1] = new Monster("Goblin",1,32,room1.xPos+10, room1.yPos + 250, 10, 100, 10);
  //the goblins in room 2
  goblin[2] = new Monster("Goblin",1,32,room2.xPos + 100, room2.yPos +30, 10, 100, 10);
  goblin[3] = new Monster("Goblin",1,32,room2.xPos + 100, room2.yPos + 230, 10,100, 10);
  //the goblins in room3
  goblin[4] = new Monster("Goblin",1,32,room3.xPos + 20, room3.yPos + 20, 10,100, 8);
  goblin[5] = new Monster("Goblin",1,32,room3.xPos + 20, room3.yPos + 200, 10,100, 8);
  goblin[6] = new Monster("Goblin",1,32,room3.xPos + 20, room3.yPos + 100, 10,100, 8);
  //the goblins in room 4
  goblin[7] = new Monster("Goblin",1,32,room4.xPos + 20, room4.yPos+20,10,100, 10);
  //goblins room5
  goblin[8] = new Monster("Goblin",1,32,room5.xPos+20,room5.yPos+20,10,100, 10);
  goblin[9] = new Monster("Goblin",1,32,room5.xPos+20,room6.yPos+200,10,100, 10);
  //goblins room6
  goblin[10] = new Monster("Goblin",1,32,room6.xPos+20,room6.yPos+200,10,100, 10);
  //goblins room8
  goblin[11] = new Monster("Goblin",1,32,room8.xPos + 20, room8.yPos + 20, 10,100, 8);
  goblin[12] = new Monster("Goblin",1,32,room8.xPos + 20, room8.yPos + 200, 10,100, 8);
  goblin[13] = new Monster("Goblin",1,32,room8.xPos + 20, room8.yPos + 100, 10,100, 8);
  //goblins room7
  goblin[14] = new Monster("Goblin",1,32,room7.xPos + 20, room7.yPos + 20,10,100, 10);
  //goblins room9
  goblin[15] = new Monster("Goblin",1,32,room9.xPos + 20,room9.yPos +20,10,100, 10);
  goblin[16] = new Monster("Goblin",1,32,room9.xPos +20,room9.yPos+200,10,100, 10);
  //THE NUMBER OF MONSTERS HERE MUST BE MATCHED TO THE NUMBER OF THE ARRAY SIZE
  
  //OGRE SETUP
  ogre[0] = new Monster("Ogre",0.2,64,room3.xPos+ 20,room3.yPos + 150,8,300, 20);
  ogre[1] = new Monster("Ogre",0.2,64,room8.xPos+ 20,room8.yPos + 150,8,300, 20);
}
