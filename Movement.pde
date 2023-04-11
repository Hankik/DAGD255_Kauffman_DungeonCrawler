class Movement extends Component {

  // fields
  Timer stopDelay = new Timer(16);
  float maxVelocity = 20;
  float speed = 200;
  boolean accelerates = false;
  boolean isMoving = false;
  PVector velocity = new PVector(1, 1);
  PVector direction = new PVector();

  Movement(Actor parent) {

    name = "movement";
    this.parent = parent;
  }

  void update() {

    if (accelerates) {
      parent.x += velocity.x * dt;
      parent.y += velocity.y * dt;
    } else {
      parent.x += speed * direction.x * dt;
      parent.y += speed * direction.y * dt;
      direction.mult(0);
    }
  }

  void draw() {
  }

  void move(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown) {

    isMoving = moveLeft||moveRight||moveUp||moveDown;

    if (accelerates && !isMoving) {
      //velocity.x = lerp( velocity.x, 0, 1 - stopDelay.timeLeft / stopDelay.duration );
      //velocity.y = lerp( velocity.y, 0, 1 - stopDelay.timeLeft / stopDelay.duration );

      //stopDelay.update();
      velocity = velocity.mult(.95);
      return;
    }

    //if (stopDelay.timeLeft != stopDelay.duration) stopDelay.reset(); // reset timer once

    if (moveLeft && !moveRight) direction.x -= 1.0;
    if (!moveLeft && moveRight) direction.x += 1.0;
    if (moveUp && !moveDown) direction.y -= 1.0;
    if (!moveUp && moveDown) direction.y += 1.0;

    direction.normalize();

    if (!accelerates) return;

    if (velocity.x > maxVelocity || velocity.x < -maxVelocity) velocity.x = clamp(velocity.x, -maxVelocity, maxVelocity);
    else velocity.x += direction.x * speed;

    if (velocity.y > maxVelocity || velocity.y < -maxVelocity) velocity.y = clamp(velocity.y, -maxVelocity, maxVelocity);
    else velocity.y += direction.y * speed;
  }
}
