/*
 Hank Kauffman
 3/27/23
 DAGD 255
 
 a dungeon crawling game
 */
import java.util.ArrayList;
import java.util.HashMap;

//
// declare global fields
//
final int LEVEL_AMOUNT = 1;
int currentLevel = 0;
Level[] levels = new Level[LEVEL_AMOUNT];

float dt, prevTime, elapsed = 0;

boolean isPaused = false;

// color constants
final color RED = #bf616a;
final color ORANGE = #d08770;
final color YELLOW = #ebcb8b;
final color GREEN = #a3be8c;
final color PURPLE = #b48ead;
final color BLUE = #5e81ac;
final color WHITE = #eceff4;
final color BLACK = #3b4252;
final color BROWN = #9e6257;
final color LIGHTGREEN = #d9e68f;
final color PINK = #db96ad;
final color LIGHTBLUE = #92cade;
final color LIGHTRED = #FF8C8C;

void setup() {

  size(600, 600, P2D);

  for (int i = 0; i < LEVEL_AMOUNT; i++) {

    levels[i] = new Level(i);
  }
}

void draw() {
  calcDeltaTime();
  background(BLACK);


  if (!isPaused) {
    elapsed += dt;
    levels[currentLevel].update();
  }

  text(elapsed, width/16, height/16);

  levels[currentLevel].draw();

  Keyboard.update();
}

void keyPressed() {

  Keyboard.handleKeyDown(keyCode);
  if (key == 'p') isPaused = !isPaused; // pause game if 'P' pressed
  if (!isPaused) levels[currentLevel].keyPressed();
}

void keyReleased() {

  Keyboard.handleKeyUp(keyCode);
}

// A method to get delta time
void calcDeltaTime() {

  float currTime = millis();
  dt = (currTime - prevTime) / 1000;
  prevTime = currTime;
}

float clamp(float val, float min, float max) {
    return Math.max(min, Math.min(max, val));
}
