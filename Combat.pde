class Combat extends Component { 
  
///
/// A Component class to store combat stats like health and damage
///
  
  // fields
  Actor parent;
  
  Combat(Actor parent){
  
    name = "combat";
    
    this.parent = parent;
  }
  
  void update(){}
  
  void draw(){}
}
