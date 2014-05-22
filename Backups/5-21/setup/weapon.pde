class Weapon{
  String ID;
  int type; 
  //1 = axe
  //2 = sword
  float damage;
  float range; 
  
  Weapon(String ID_, int type_, float damage_, float range_){ //Item ID, Type, Damage, Range
    ID = ID_;
    type = type_;
    damage = damage_;
    range = range_;
  }//end constructor
  
  void equip(){
    player.activeWeapon = ID;
    player.weaponType = type;
    player.range = range;
    player.damage = damage;
  }//end equip
  
  //void display(){}
    
}//end Weapon
