class Popup {

  // variables
  float x, y;
  String text = "";
  float textSize = 25;
  Timer timer = new Timer(.5);
  boolean isDead = false;

  Popup(float x, float y, String text, float size, float duration){
  
    this.x = x;
    this.y = y;
    this.text = text;
    textSize = size;
    timer.duration = duration;
    timer.timeLeft = duration;
  }

  Popup(float x, float y, String text, float size) {
    
    // what to pop up
    this.text = text;
    textSize = size;
    this.x = x;
    this.y = y;
  }

  void update() {
    
    timer.update();
    growAndShrink(0.5, 2);
    if (timer.isDone) isDead = true;
  }

  void draw() {

    pushMatrix();
    translate(x - 20, y);
    fill(WHITE);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text( text, 0, 0);

    popMatrix();
  }
  
  void growAndShrink(float swapPoint, float changeRate ){
    
    if (timer.timeLeft/timer.duration >= swapPoint) textSize += changeRate;
    if (timer.timeLeft/timer.duration < swapPoint) textSize -= changeRate;
  
  }
}
