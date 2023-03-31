class Player extends Actor implements Damaging {

  // fields
  Movement movement = new Movement(this);
  Combat combat = new Combat(this);

  Player(float x, float y, float w, float h) {

    name = "player";

    this
      .addComponent(movement)
      .addComponent(combat); // addComponent makes sure given component is drawn and updated

    this.x = x;
    this.y = y;
    setSize(w, h);
  }

  void update() {
    handleInputs();

    super.update();
  }

  void draw() {
    super.draw();
  }

  void handleInputs() {


    PVector axesValues = new PVector();

    if (Keyboard.isDown(Keyboard.UP)) axesValues.y--;
    if (Keyboard.isDown(Keyboard.DOWN)) axesValues.y++;
    if (Keyboard.isDown(Keyboard.LEFT)) axesValues.x--;
    if (Keyboard.isDown(Keyboard.RIGHT)) axesValues.x++;
    axesValues.normalize();
    
    movement.move(axesValues.x, axesValues.y); // change this function (i dont like it)
  }

  void keyPressed() {
  }
}
