class Particle {

  // fields
  PImage shape;
  Timer lifetime;
  float x;
  float y;
  float speed;
  PVector direction;
  
  Particle(PImage sprite, float xPos, float yPos, float speed, PVector dir, float duration){
  
    shape = sprite;
    x = xPos;
    y = yPos;
    this.speed = speed;
    direction = dir;
    lifetime = new Timer(duration);
  }
  
  Particle(float xPos, float yPos, float speed, PVector dir, float duration){
  
    x = xPos;
    y = yPos;
    this.speed = speed;
    direction = dir;
    lifetime = new Timer(duration);
  }
  
  void update(){
  
    lifetime.update();
    x += dt * direction.x * speed;
    y += dt * direction.y * speed;
  }
  
  void draw(){
  
    pushMatrix();
    fill(BLACK);
    noStroke();
    translate(x,y);
    imageMode(CENTER);
    if (shape != null) image(shape, 0, 0);
    else rect(0, 0, random(2,5), random(2,5));
    
    popMatrix();
    imageMode(CORNER);
    stroke(4);
  }
  
}
