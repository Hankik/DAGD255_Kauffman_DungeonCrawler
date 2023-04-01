class Player extends Actor implements Damaging {

  // fields
  Movement movement = new Movement(this);
  Combat combat = new Combat(this);

  Player(float x, float y, float w, float h) {

    name = "player";

    this
      .addComponent(combat) // addComponent makes sure given component is drawn and updated
      .addComponent(movement);

    this.x = x;
    this.y = y;
    setSize(w, h);
    
    combat.setBaseStats(30, 30);
    combat.refillHealth();
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
