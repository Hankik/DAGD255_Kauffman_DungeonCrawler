class Player extends Actor implements Damaging {

  // fields
  Movement movement = new Movement(this);
  Combat combat = new Combat(this);
  HashMap<String, Integer> inventory = new HashMap<String, Integer>(); 
  
  // animations
  Animation walk = new Animation(this, roboWalk);  

  Player(float x, float y, float w, float h) {

    name = "player";

    this
      .addComponent(combat) 
      .addComponent(movement)
      .addComponent(walk); // addComponent makes sure given component is drawn and updated
    
    walk.yOffset = -10; // for repositioning scuffed frames

    this.x = x;
    this.y = y;
    setSize(w, h);
    
    combat.setBaseStats(30, 30);    // sets base stats for health and damage respectfully
    combat.refillHealth();          // health starts at zero, so we refill
  }

  void update() {
    
    movement.move(Keyboard.isDown(Keyboard.LEFT), 
                  Keyboard.isDown(Keyboard.RIGHT), 
                  Keyboard.isDown(Keyboard.UP), 
                  Keyboard.isDown(Keyboard.DOWN));

    super.update();
  }

  void draw() {
    super.draw();
  }

  void keyPressed() {
  }
}
