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

MouseActor mouse;

// PImage sprites
String[] nameRoboWalk = {"robot/walk0.png", "robot/walk1.png", "robot/walk2.png", "robot/walk3.png",
                     "robot/walk4.png", "robot/walk5.png", "robot/walk6.png", "robot/walk7.png"};
String[] nameZombieWalk = {"zombie/walk0.png", "zombie/walk1.png", "zombie/walk2.png", "zombie/walk3.png",
                           "zombie/walk4.png", "zombie/walk5.png", "zombie/walk6.png", "zombie/walk7.png"};
PImage[] zombieWalk = new PImage[nameZombieWalk.length];
PImage[] zombieIdles = new PImage[2];
PImage[] roboWalk = new PImage[nameRoboWalk.length];
PImage[] roboIdles = new PImage[2];
PImage imgActor, hookOpen, hookClosed, roboIdle, zombieIdle, imgFlower;


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
final color HOOK = #5393c5;

void setup() {

  size(640, 640, P2D);

  // load images
  imgFlower = loadImage("flower.png");
  imgFlower.resize(32,32);
  hookOpen = loadImage("hookOpen.png");
  hookOpen.resize(16,16);
  hookClosed = loadImage("hookClosed.png");
  hookClosed.resize(16,16);
  imgActor = loadImage("actor.png");
  imgActor.resize(30, 30);
  roboIdle = loadImage("robot/idle.png");
  roboIdle.resize(32, 40);
  zombieIdle = loadImage("zombie/idle.png");
  zombieIdle.resize(32, 40);
  for (int i = 0; i < zombieWalk.length; i++){
    zombieWalk[i] = loadImage(nameZombieWalk[i]);
    zombieWalk[i].resize(32, 40);
  }
  for (int i = 0; i < roboIdles.length; i++) roboIdles[i] = roboIdle;
  for (int i = 0; i < zombieIdles.length; i++) zombieIdles[i] = zombieIdle;
  for (int i = 0; i < roboWalk.length; i++){
    roboWalk[i] = loadImage(nameRoboWalk[i]);
    roboWalk[i].resize(32, 40);
  }

  println("Sprites loaded successfully");
  
  mouse = new MouseActor();

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


  levels[currentLevel].draw();
  
  fill(WHITE);
  text(elapsed, width/16, height/16);

  Keyboard.update();
}

void keyPressed() {

  Keyboard.handleKeyDown(keyCode);
  if (key == 'p') isPaused = !isPaused; // pause game if 'P' pressed
  if (!isPaused) levels[currentLevel].keyPressed();
}

void mousePressed(){

  if (!isPaused) levels[currentLevel].mousePressed();
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
