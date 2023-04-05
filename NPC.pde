class NPC extends Actor {

  // fields
  Movement movement = new Movement(this);
  Combat combat = new Combat(this);
  Animation walk = new Animation(this, roboWalk);
  
  NPC(float x, float y, float w, float h){
    
    name = "npc";
    
    this
      .addComponent(movement)
      .addComponent(combat)
      .addComponent(walk);
    
    walk.yOffset = -10;
  
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
