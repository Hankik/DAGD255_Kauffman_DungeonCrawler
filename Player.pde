class Player extends Actor {

  // fields
  Movement movement = new Movement(this);
  Hook hook = new Hook(this);

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
      .addComponent(hook);

    idle.yOffset = -10;
    walk.yOffset = -10; // for repositioning scuffed frames

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

    if (checkCollision(mouse)) hitboxVisible = true;
    else hitboxVisible = false;

    animations[currentAnim].draw();
  }

  void keyPressed() {
  }

  void mousePressed() {

    hook.mousePressed();
  }
}

class Flower extends Actor {

  // fields
  Combat combat = new Combat(this);
  Timer damageDelay = new Timer(1);


  Flower() {

    name = "flower";

    this
      .addComponent(combat)
      .addComponent(damageDelay);

    x = width*.5;
    y = width*.5;
    setSize(24, 32);
    stroke = BLUE;

    combat.maxHealth = 5;
    combat.refillHealth();
  }

  void update() {

    if (!isDead) {

      super.update();
    }
  }

  void draw() {
    if (!isDead) {

      super.draw();
      image(imgFlower, x - w*.67, y - h*.5);

      if (checkCollision(mouse)) hitboxVisible = true;
      else hitboxVisible = false;
    }
  }

  void damage(float damageAmount) {

    if (damageDelay.isDone) {
      combat.takeDamage(damageAmount);
      damageDelay.reset();
    }
  }

  void die() {

    isDead = true;
  }
}
