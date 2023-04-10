class Animation extends Component {
  
  // fields
  Timer nextFrameDelay = new Timer(.025);
  PImage[] frames;
  boolean flipped = false;
  int currentFrame = 0;
  float xOffset = 0;
  float yOffset = 0;

  Animation(Actor parent, PImage[] frames){
    
    name = "animation";
  
    this.parent = parent;
    this.frames = frames;
  }
  
  void update(){
    
    nextFrameDelay.update();
  }
  
  void draw(){
    
    pushMatrix();
    translate(parent.x, parent.y); // makes draws relative to parent
    
    if (flipped) scale(-1, 1);
    
    image(frames[currentFrame], -parent.w*.5 + xOffset, - parent.h*.5 + yOffset);
    if (nextFrameDelay.isDone) {
      nextFrameDelay.reset();
      currentFrame++;
    }
    if (currentFrame > frames.length - 1) currentFrame = 0; 
    
    popMatrix();
  }
}

/*               Do this in main .pde to most easily bring in sprites

String[] nameRoboWalk = {"robot/walk0.png", "robot/walk1.png", "robot/walk2.png", "robot/walk3.png",
                     "robot/walk4.png", "robot/walk5.png", "robot/walk6.png", "robot/walk7.png"};
PImage[] roboWalk = new PImage[nameRoboWalk.length];

void setup(){
  ...
  for (int i = 0; i < roboWalk.length; i++){
    roboWalk[i] = loadImage(nameRoboWalk[i]);
    roboWalk[i].resize(32, 40);
  }
}
*/
