/* this .pde contains Tree and Pit claseses */
class Pillar extends Actor implements Interacting {

  // fields
  Actor hitbox = new Actor();

  Pillar(float xPos, float yPos, float w, float h) {

    name = "pillar";

    x = xPos;
    y = yPos;

    stroke = BLUE;

    setSize(w, h);
    hitbox.x = x;
    hitbox.y = y;
    hitbox.setSize(w*1.5, h*1.5);
  }

  void update() {

    hitbox.update();
    super.update();
  }

  void draw() {

    super.draw();
    hitbox.draw();

    if (checkCollision(globalMouse)) hitboxVisible = true;
    else hitboxVisible = false;

    image(imgPillar, x - w*.5 - 14, y - h*.5);
  }

  void interact(Actor invoker) {
    if (invoker.name == "player") {
      
      if (!sVictory2.isPlaying()) sVictory2.play();

      Player player = (Player) invoker;
      player.pillarInteractions.randomLine();
      player.pillarInteractions.speak();
    }
  }
}

class TextBox extends Actor {

  // fields
  String text = "";
  float textSize = 20;

  TextBox(float xPos, float yPos, float w, float h, String text) {
    
    name = "textbox";

    x = xPos;
    y = yPos;

    this.text = text;

    setSize(w, h);
  }

  void update() {

    super.update();
  }

  void draw() {

    super.draw();

    fill(LIGHTBLUE);
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h, 3);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x + w*.5, y + h*.5);
    noStroke();
  }
}
