class NPC extends Actor implements Interacting, Damaging {

  // fields
  Movement movement = new Movement(this);
  Dialogue lines = new Dialogue(this, "test.txt");
  Combat combat = new Combat(this);
  
  // animation fields
  Animation idle = new Animation(this, zombieIdles);
  Animation walk = new Animation(this, zombieWalk);
  Animation[] animations = {walk, idle};
  int currentAnim = 0;

  NPC(float x, float y, float w, float h) {

    name = "npc";

    this
      .addComponent(movement)
      .addComponent(combat);

    walk.yOffset = -10;
    idle.yOffset = -10;

    this.x = x;
    this.y = y;
    setSize(w, h);
    
    combat.setBaseStats(1f, 1f);
    combat.damage = 1f;
    combat.refillHealth();
    
    movement.speed = 20;
  }

  void update() {
    
    
    lines.update();
    
    animations[currentAnim].update();
    
    /*
    
    movement.move(levels[currentLevel].flower.x < x,
                  levels[currentLevel].flower.x > x,
                  levels[currentLevel].flower.y < y,
                  levels[currentLevel].flower.y > y);
                  */

    if (movement.direction.x < 0) walk.flipped = true;
    if (movement.direction.x > 0) walk.flipped = false;
    if (movement.direction.x != 0f || movement.direction.y != 0f) currentAnim = 0;
    else currentAnim = 1;

    super.update();
  }

  void draw() {
    

    super.draw();
    
    lines.draw();
    
    animations[currentAnim].draw();
    
    if (checkCollision(mouse)) hitboxVisible = true;
    else hitboxVisible = false;

    stroke(WHITE);
    noStroke();
  }

  void interact(Actor invoker) {

    lines.speak();
    lines.nextLine();
  }

  void mousePressed() {
  }
}
