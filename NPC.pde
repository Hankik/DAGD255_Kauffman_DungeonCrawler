class NPC extends Actor implements Interacting {

  // fields
  Movement movement = new Movement(this);
  Dialogue lines = new Dialogue(this, "test.txt");
  Combat combat = new Combat(this);
  Knockback knockback = new Knockback(this);
  Actor target = null;
  NPCState state = NPCState.IDLING;

  // animation fields
  Animation idle = new Animation(this, zombieIdles);
  Animation walk = new Animation(this, zombieWalk);
  Animation[] animations = {walk, idle};
  int currentAnim = 0;
  
  NPC(){}

  NPC(float x, float y, float w, float h) {

    name = "npc";

    this
      .addComponent(movement)
      .addComponent(combat)
      .addComponent(knockback);

    concerns.add("flower");
    concerns.add("npc");
    concerns.add("pillar");

    walk.yOffset = -10;
    idle.yOffset = -10;

    this.x = x;
    this.y = y;
    setSize(w, h);

    combat.setBaseStats(4f, 5f);
    combat.damage = 1f;
    combat.refillHealth();

    movement.speed = 60;

    combat.damageDelay.duration = 1;
  }

  void update() {


    lines.update();

    animations[currentAnim].update();
    
    handleState(state); // NEEDS WRITTEN

    if (target != null) {

      movement.move(target.x < x,
        target.x > x,
        target.y < y,
        target.y > y);

      if (target.isDead) target = null;
    }

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

    if (checkCollision(globalMouse)) hitboxVisible = true;
    else hitboxVisible = false;

    stroke(WHITE);
    noStroke();
  }

  // I am not a big fan of the way I am using this. In Level object I am casting actor to npc just to call this interface method
  // maybe this is handy if I have child classes of NPC, but that is just a hypothetical. This is waste. -Hank
  void interact(Actor invoker) {

    lines.speak();
    lines.nextLine();
  }

  @Override
    void handleConcernsCollision(Actor a) {

    if (a.name.equals("flower")) {
      Flower f = (Flower)a;
      f.damage(combat.damage);
      PVector knockbackDirection = new PVector(f.x - x, f.y - y).normalize();
      f.knockback.activate(knockbackDirection);
      return;
    }
    
    if (a.name.equals("npc") && !a.equals(this)){
      
      applyFix(findOverlapFix(a));
    } 
    if (a.name.equals("pillar")){
    
      applyFix(findOverlapFix(a));
    }
  }

  void damage(Player player) {
    
    combat.takeDamage(player.combat.damage);
    PVector bloodSplatterDirection = new PVector(player.x - x, player.y - y).normalize();
    bloodSplatterDirection.x += random(-.5, .5);
    bloodSplatterDirection.y += random(-.5, .5);
    levels[currentLevel].particleFactory.create("blood", null, x, y, 100, bloodSplatterDirection, .4);
  }

  void die() {

    if (!sKillZombie.isPlaying()) sKillZombie.play();
    isDead = true;
    for (int i = 0; i < 8; i++) levels[currentLevel].particleFactory.create("blood",
      null,
      x, y,
      40,
      new PVector(random(-1, 1), random(-1, 1)),
      .5);
  }

  void handleState(NPCState state) {

    switch (state) {

    case IDLING:
      break;

    case CHASING:
      break;

    case RETREATING:
      break;
    }
  }

  void handleConcern(Actor a) {

    if (a.name.equals("flower")) {
      target = a;
    }
  }

  void mousePressed() {
  }

  void applyFix(PVector fix) {
    x += fix.x;
    y += fix.y;
    if (fix.x != 0) {
      // If we move the player left or right, the player must have hit a wall, so we set horizontal velocity to zero.
      movement.velocity.x = 0;
    }
    if (fix.y != 0) {
      // If we move the player up or down, the player must have hit a floor or ceiling, so we set vertical velocity to zero.
      movement.velocity.y = 0;
      if (fix.y < 0) {
        // If we move the player up, we must have hit a floor.
      }
      if (fix.y > 0) {
        // If we move the player down, we must have hit our head on a ceiling.
      }
    }
    // recalculate AABB (since we moved the object AND we might have other collisions to fix yet this frame):
    calculateAABB();
  }
}

public enum NPCState {

  CHASING,
    RETREATING,
    IDLING
}
