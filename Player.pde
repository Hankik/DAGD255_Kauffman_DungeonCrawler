/* This .pde contains the Player and Flower class */

class Player extends Actor {

  // fields
  Movement movement = new Movement(this);
  Hook hook = new Hook(this);
  Combat combat = new Combat(this);
  Timer blinkTime = new Timer(.3);

  // interaction fields
  Dialogue exitInteractions = new Dialogue(this, "exitInteractions.txt");
  Dialogue pillarInteractions = new Dialogue(this, "pillarInteractions.txt");
  Dialogue flowerInteractions = new Dialogue(this, "flowerInteractions.txt");


  // animation fields
  Animation walk = new Animation(this, roboWalk);
  Animation idle = new Animation(this, roboIdles);
  Animation[] animations = {walk, idle};
  int currentAnim = 0;

  Player(float x, float y, float w, float h) {

    name = "player";

    // addComponent() makes sure given component is drawn and updated
    this
      .addComponent(movement)
      .addComponent(hook)
      .addComponent(combat)
      .addComponent(exitInteractions)
      .addComponent(pillarInteractions)
      .addComponent(flowerInteractions);

    movement.speed = 80;

    combat.visible = false;
    combat.setBaseStats(100, 2);
    combat.damage = combat.baseDamage;

    exitInteractions.displayTimer.duration = 3;

    concerns.add("npc");
    concerns.add("exit");
    concerns.add("pillar");
    concerns.add("flower");

    idle.yOffset = -10;
    idle.xOffset = -4;
    walk.yOffset = -10; // for repositioning scuffed frames
    walk.xOffset = -4;

    this.x = x;
    this.y = y;
    setSize(w, h);
    stroke = BLUE;
  }

  void update() {

    animations[currentAnim].update();

    movement.move(Keyboard.isDown(Keyboard.LEFT),
      Keyboard.isDown(Keyboard.RIGHT),
      Keyboard.isDown(Keyboard.UP),
      Keyboard.isDown(Keyboard.DOWN));

    if (movement.direction.x < 0) walk.flipped = true;
    if (movement.direction.x > 0) walk.flipped = false;
    if (movement.direction.x == 0 && movement.direction.y == 0) currentAnim = 1;
    else currentAnim = 0;

    super.update();
  }

  void draw() {
    super.draw();

    if (checkCollision(globalMouse)) hitboxVisible = true;
    else hitboxVisible = false;

    animations[currentAnim].draw();
  }

  @Override
    void handleConcernsCollision(Actor a) {
    if (a.name.equals("npc")) {
      NPC n = (NPC)a;
      if (Keyboard.onDown(Keyboard.E)) n.interact(this);
      n.damage(this);
      PVector knockbackDirection = new PVector(n.x - x, n.y - y).normalize();
      n.knockback.activate(knockbackDirection);
      return;
    }
    if (a.name.equals("exit")) {

      Exit exit = (Exit) a;
      if (Keyboard.onDown(Keyboard.E)) exit.interact(this);
      exit.showInstructions = true;
    }

    if (a.name.equals("pillar")) {

      Pillar pillar = (Pillar) a;
      if (Keyboard.onDown(Keyboard.E) && pillar.hitbox.checkCollision(this)) pillar.interact(this);
      applyFix(findOverlapFix(pillar));
    }
    
    if (a.name.equals("flower")){
    
      Flower flower = (Flower) a;
      if (Keyboard.onDown(Keyboard.E)) flower.interact(this);
    }
  }

  @Override
    void handleConcern(Actor a) {

    if (checkCollision(a)) return;

    if (a.name == "exit") {

      Exit exit = (Exit) a;
      exit.showInstructions = false;
    }
  }

  void keyPressed() {
  }

  void mousePressed() {

    hook.mousePressed();
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

class Flower extends Actor implements Interacting {

  // fields
  Combat combat = new Combat(this);
  Dialogue dialogue = new Dialogue(this, "flower.txt");
  Knockback knockback = new Knockback(this);
  boolean isStolen = false;
  Timer damageTimer = new Timer(.5);
  Dialogue playerInteractions = new Dialogue(this, "playerInteractions.txt");


  Flower() {

    name = "flower";
    
    playerInteractions.displayTimer.duration = 2.5;

    this
      .addComponent(combat)
      .addComponent(dialogue)
      .addComponent(knockback)
      .addComponent(playerInteractions);

    x = width*.5 + 22;
    y = width*.5;
    setSize(24, 32);
    stroke = BLUE;

    combat.maxHealth = 5;
    combat.refillHealth();
  }

  void update() {

    super.update();
    
    damageTimer.update();
  }

  void draw() {
    if (!isDead) {

      super.draw();
      image(imgFlower, x - w*.67, y - h*.5);

      if (checkCollision(globalMouse)) hitboxVisible = true;
      else hitboxVisible = false;
    }
  }

  void damage(float damageAmount) {
    if (!damageTimer.isDone) return;
    
    damageTimer.reset();
    
    if (!sHurtFlower.isPlaying()) sHurtFlower.play();
    
    for (int i = 0; i < 8; i++) levels[currentLevel].particleFactory.create("blueblood",
      null,
      x, y,
      40,
      new PVector(random(-1, 1), random(-1, 1)),
      .5);
    
    combat.takeDamage(damageAmount);
    dialogue.randomLine();
    dialogue.speak();
  }

  void die() {

    isDead = true;

    for (int i = 0; i < 8; i++) levels[currentLevel].particleFactory.create("blueblood",
      null,
      x, y,
      40,
      new PVector(random(-1, 1), random(-1, 1)),
      .5);
      
    currentLevel = 4;
  }
  
  void interact(Actor invoker) {
  
    if (invoker.name == "player"){
      
      if (!sVictory2.isPlaying()) sVictory2.play();
      
      Player p = (Player) invoker;
    
      int rand = floor(random(0,2));
      
      if (rand == 0) {
        p.flowerInteractions.randomLine();
        p.flowerInteractions.speak();
      }
      
      if (rand == 1) {
        playerInteractions.randomLine();
        playerInteractions.speak();
      }
    }
  }
}
