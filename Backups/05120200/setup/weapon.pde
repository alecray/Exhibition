class Weapon{
  int ID;
  int type; 
  //1 = axe
  float damage;
  float range; 
  
  Weapon(int ID_, int type_, float damage_, float range_){
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
