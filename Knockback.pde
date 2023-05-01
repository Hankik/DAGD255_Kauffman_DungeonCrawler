class Knockback extends Component {

  // fields
  Actor parent;
  float knockbackPower = 50;
  float knockbackCurrent = 0;
  boolean knocked = false;
  PVector direction = new PVector();


  Knockback(Actor parent) {

    name = "knockback";

    this.parent = parent;
  }

  void update() {

    if (knockbackCurrent > 0) {
      parent.x += direction.x * dt * knockbackCurrent;
      parent.y += direction.y * dt * knockbackCurrent;
      knockbackCurrent--;
    }
  }

  void draw() {
  }

  void activate(PVector direction) {
    knockbackCurrent = knockbackPower;
    this.direction = direction;
  }
}
