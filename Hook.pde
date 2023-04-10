class Hook extends Component {

  // fields
  Actor target = null;
  HookState state = HookState.IDLING;
  MouseActor mouse = new MouseActor();
  PVector hookLocation = new PVector();
  int dotAmount = 5;
  int dotSize = 5;

  Hook(Actor parent) {

    name = "hook";

    this.parent = parent;
    target = parent;
  }

  void update() {

    if (!state.equals(HookState.PULLING)) mouse.update();
    handleState(state);
    println(state);
  }

  void draw() {

    pushMatrix();
    translate(target.x, target.y);
    image(hookClosed, 0 - hookClosed.width*.5, 0 - hookClosed.height*.5);

    popMatrix();

    if (!state.equals(HookState.IDLING)) {

      drawChain();
    }
  }

  void handleState(HookState state) {

    switch (state) {

    case SEARCHING:

      if (!mousePressed) {
        println("switch state");
        this.state = HookState.PULLING;
      }

      break;
    case PULLING:

      // move target/player to desired location
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
  
    target.x = lerp(target.x, parent.x, .1);
    target.y = lerp(target.y, parent.y, .1);
    
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


    if (parent.checkCollision(mouse)) {
      
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

    setSize(1, 1);
  }

  void update() {
    super.update();

    x = mouseX;
    y = mouseY;
  }
}
