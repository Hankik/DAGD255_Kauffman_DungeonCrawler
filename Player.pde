class Player extends Actor {

  // fields
  
  Player(float x, float y, float w, float h){
    
    name = "player";
  
    this.x = x;
    this.y = y;
    setSize(w, h);
  }
  
  void update(){
    super.update();
  }
  
  void draw(){
    super.draw();
  }
}
