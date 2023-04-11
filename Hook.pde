class Hook extends Component {

  // fields
  Actor target = null;
  HookState state = HookState.IDLING;
  MouseActor mouse = new MouseActor();
  Timer hookTime = new Timer(2);
  PVector hookLocation = new PVector();
  int dotAmount = 8;
  int dotSize = 5;

  Hook(Actor parent) {

    name = "hook";

    this.parent = parent;
    target = parent;
  }

  void update() {

    if (!state.equals(HookState.PULLING)) mouse.update();
    handleState(state);
  }

  void draw() {
    
    PVector direction = new PVector(target.x - parent.x, target.y - parent.y);
    float rotation = atan2(direction.x, direction.y);
    PImage img = hookClosed;
    
    if (state.equals(HookState.SEARCHING)) img = hookOpen;
    
    pushMatrix();
    translate(target.x, target.y);
    rotate(-rotation - 0.785398);
    image(img, 0 - hookClosed.width*.5, 0 - hookClosed.height*.5);

    popMatrix();

    if (!state.equals(HookState.IDLING)) {

      drawChain();
    }
  }

  void handleState(HookState state) {

    switch (state) {

    case SEARCHING:

      if (!mousePressed) {
        hookTime.reset();
        this.state = HookState.PULLING;
        
        // check if hook is overlapping something hookable
        for (Actor a : levels[currentLevel].getActors("npc")) if (a.checkCollision(mouse)) {
          target = a;
          return;
        }
        for (Actor a : levels[currentLevel].getActors("player")) if (a.checkCollision(mouse)){
          target = a;
          return;
        }
      }

      break;
    case PULLING:

      // move target/player to desired location
      hookTime.update();
      pullTarget(target);
      break;

    case EATING:

      // destroy and kill target
      target.die();
      break;
    case IDLING:

      // search for player input
      break;
    }
  }
  
  void pullTarget(Actor target){
    
    float percentPull = hookTime.timeLeft / hookTime.duration;
  
    target.x = lerp(target.x, parent.x, 1 - percentPull);
    target.y = lerp(target.y, parent.y, 1 - percentPull);
    
    if (dist(target.x, target.y, parent.x, parent.y) < 24) {
    
      this.target = parent;
      // handle what to do with type of target
      
      state = HookState.IDLING;
    }
    
  }

  void drawChain() {
    
    PVector direction = new PVector(target.x - parent.x, target.y - parent.y);
    direction.normalize();
    float chainLength = dist(parent.x, parent.y, target.x, target.y);
    float xFractionSize = (chainLength / (dotAmount + 1)) * direction.x;
    float yFractionSize = (chainLength / (dotAmount + 1)) * direction.y;
    
    for (int i = 1; i < dotAmount + 1; i++){
    
      fill(HOOK);
      circle(parent.x + xFractionSize * i, parent.y + yFractionSize * i, dotSize);
    }
    
  }

  void mousePressed() {


    if (parent.checkCollision(mouse) && state.equals(HookState.IDLING)) {
      
      state = HookState.SEARCHING;
      target = mouse;
    }
  }
}

public enum HookState {

  SEARCHING,
    PULLING,
    EATING,
    IDLING
}

// allows easily assigning mouse as target for hook
class MouseActor extends Actor {

  MouseActor() {

    name = "mouseActor";
    x = 10000; // without changing x and y in constructor,
    y = 10000; // frame one had player and mouse at same location somehow

    setSize(24,24);
  }

  void update() {
    super.update();

    x = mouseX;
    y = mouseY;
  }
}
