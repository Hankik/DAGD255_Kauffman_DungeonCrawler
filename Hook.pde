class Hook extends Component {

  // fields
  Actor target = null;
  HookState state = HookState.IDLING;
  Timer hookTime = new Timer(2);
  PVector hookLocation = new PVector();
  int dotAmount = 8;
  int dotSize = 5;
  boolean pullingParent = false;
  boolean pullingTarget = false;

  Hook(Actor parent) {

    name = "hook";

    this.parent = parent;
    target = parent;
  }

  void update() {

    if (!state.equals(HookState.PULLING)) globalMouse.update();
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

        Flower flower = levels[currentLevel].flower;

        if (flower.checkCollision(globalMouse)) {
          if (!sPullFlower.isPlaying()) sPullFlower.play();
          target = flower;
          if (!flower.isStolen) levels[0].spawnWave();
          flower.isStolen = true;
          return;
        }

        // check if hook is overlapping something hookable in level's actorFactory
        for (HashMap.Entry<String, ArrayList<Actor>> entry : levels[currentLevel].actorFactory.actors.entrySet()) {
          for (Actor a : entry.getValue()) {
            if (!a.checkCollision(globalMouse)) continue;
            if (a.name.equals("textbox")) continue;


            if (a.name.equals("npc") && !sPullZombie.isPlaying()) sPullZombie.play();
            if (a.name.equals("pillar") || a.name.equals("exit") && !sPullParent.isPlaying()) sPullParent.play();
            target = a;
            return;
          }
        }
      }

      break;
    case PULLING:

      // move target/player to desired location
      hookTime.update();

      if (target.name.equals("pillar")) {
        pullParent(target);
        return;
      }

      if (target.name.equals("exit")) {

        pullParent(target);
        return;
      }

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

  void pullParent(Actor target) {

    pullingParent = true;

    float percentPull = hookTime.timeLeft / hookTime.duration;

    parent.x = lerp(parent.x, target.x, 1 - percentPull);
    parent.y = lerp(parent.y, target.y, 1 - percentPull);

    if (dist(parent.x, parent.y, target.x, target.y) < 26) {

      state = HookState.IDLING;
      this.target = parent;
      pullingParent = false;
    }
  }

  void pullTarget(Actor target) {

    pullingTarget = true;

    float percentPull = hookTime.timeLeft / hookTime.duration;

    target.x = lerp(target.x, parent.x, 1 - percentPull);
    target.y = lerp(target.y, parent.y, 1 - percentPull);

    if (dist(target.x, target.y, parent.x, parent.y) < 26) {

      if (target.name.equals("npc")) target.die();

      this.target = parent;
      // handle what to do with type of target

      state = HookState.IDLING;
      pullingTarget = false;
    }
  }

  void drawChain() {

    PVector direction = new PVector(target.x - parent.x, target.y - parent.y);
    direction.normalize();
    float chainLength = dist(parent.x, parent.y, target.x, target.y);
    float xFractionSize = (chainLength / (dotAmount + 1)) * direction.x;
    float yFractionSize = (chainLength / (dotAmount + 1)) * direction.y;

    for (int i = 1; i < dotAmount + 1; i++) {

      fill(HOOK);
      circle(parent.x + xFractionSize * i, parent.y + yFractionSize * i, dotSize);
    }
  }

  void mousePressed() {


    if (parent.checkCollision(globalMouse) && state.equals(HookState.IDLING)) {

      state = HookState.SEARCHING;
      if (!sSearching.isPlaying()) sSearching.play();
      target = globalMouse;
    }
  }
}

public enum HookState {

  SEARCHING,
    PULLING,
    EATING,
    IDLING
}
