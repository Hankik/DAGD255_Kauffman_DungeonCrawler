class Button extends Actor {

  // fields
  String text = "";
  boolean hovered = false;
  boolean pressed = false;
  boolean pressedLastFrame = false;
  boolean enabled = true;
  ButtonState state = ButtonState.IDLE;

  Button(float xPos, float yPos, float w, float h,  String text) {
    
    name = "button";

    x = xPos;
    y = yPos;
    setSize(w, h);
    this.text = text;
  }

  void update() {

    if (!enabled) return;

    pressedLastFrame = pressed;
    
    if (globalMouse.x > x && globalMouse.x < x + w && globalMouse.y > y && globalMouse.y < y + h) {

      state = ButtonState.HOVERED;
      hovered = true;
    } else {

      state = ButtonState.IDLE;
      hovered = false;
      pressed = false;
    }

    if (!hovered) return;

    if (!leftMousePressed) {
      pressed = false;
      return;
    }
    
    pressed = true;

    if (!pressedLastFrame) {

      state = ButtonState.PRESSED;
      onClick();
    }
    
    super.update();
  }

  void draw() {
    
    super.draw();
    
    switch(state) {

    case IDLE:
      fill(LIGHTBLUE);

      break;

    case HOVERED:
      fill(BLUE);
      if(leftMousePressed) fill(BLACK);
      break;

    case PRESSED:
      fill(BLACK);
      break;
    }
    
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h, 14);
    fill(0);
    textAlign(CENTER,CENTER);
    textSize(14);
    text(text, x + w*.5, y + h*.5);
  }

  void onClick() {
    
    if (!sNewGame.isPlaying()) sNewGame.play();
    for (int i = 0; i < LEVEL_AMOUNT; i++) {

    levels[i] = new Level(i);
    elapsed = 0;
  }
  currentLevel = 0;
    
  }
}

public enum ButtonState {

  IDLE,
    HOVERED,
    PRESSED,
}
