class Animation extends Component {
  
  // fields
  Timer nextFrameDelay = new Timer(.025);
  PImage[] frames;
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
    
    image(frames[currentFrame], parent.x -parent.w*.5 + xOffset, parent.y - parent.h*.5 + yOffset);
    if (nextFrameDelay.isDone) {
      nextFrameDelay.reset();
      currentFrame++;
    }
    if (currentFrame > frames.length - 1) currentFrame = 0; 
  }
}
