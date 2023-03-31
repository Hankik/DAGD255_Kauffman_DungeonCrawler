class Movement extends Component {
  
  // fields
  float maxVelocity = 1;
  float minVelocity = -1;
  float speed = 200;

  Movement(Actor parent) {
  
    name = "movement";
    this.parent = parent;
  }
  
  void update(){}
  
  void draw(){}
  
  void move(float horizontal, float vertical){ // i dont like this. change back to direction handling
    
    horizontal = clamp(horizontal, minVelocity, maxVelocity);
    vertical = clamp(vertical, minVelocity, maxVelocity);
    
  
    boolean isMoving = horizontal > 0.01 || horizontal < -0.01 || vertical > 0.01 || vertical < -0.01;
    
    if (!isMoving) return;
    
    parent.x += dt * speed * horizontal;
    parent.y += dt * speed * vertical;
  }
}
