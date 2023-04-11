class NPC extends Actor implements Interacting {

  // fields
  Movement movement = new Movement(this);
  Combat combat = new Combat(this);
  Animation walk = new Animation(this, roboWalk);
  Dialogue lines = new Dialogue(this, "test.txt");
  Hook hook = new Hook(this);
  
  NPC(float x, float y, float w, float h){
    
    name = "npc";
    
    this
      .addComponent(movement)
      .addComponent(combat)
      .addComponent(walk)
      .addComponent(hook);
    
    walk.yOffset = -10;
  
    this.x = x;
    this.y = y;
    setSize(w, h);
  }
  
  void update(){
    lines.update();
    
    super.update();
  }
  
  void draw(){
    lines.draw();
    
    super.draw();
    
    stroke(WHITE);
    noStroke();
  }
  
  void interact(Actor invoker) {
  
    lines.speak();
    lines.nextLine();
  }
  
  void mousePressed(){
  
    hook.mousePressed();
  }
}
