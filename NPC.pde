class NPC extends Actor {

  // fields
  Movement movement = new Movement(this);
  Combat combat = new Combat(this);
  
  NPC(float x, float y, float w, float h){
    
    name = "npc";
    
    this
      .addComponent(movement)
      .addComponent(combat);
  
    this.x = x;
    this.y = y;
    setSize(w, h);
  }
  
  void update(){
  
    super.update();
  }
  
  void draw(){
  
    super.draw();
  }
}
