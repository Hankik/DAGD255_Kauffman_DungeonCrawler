/* this .pde contains Actor and Component classes
 */

/// ACTOR /// blueprint for a game object

// contains logic for AABB collision, Component updates and draws, and accessing and calling concerning actors

class Actor {

  // AABB fields
  float x, y, w, h;
  float edgeL, edgeR, edgeT, edgeB;
  float halfW, halfH;

  // actor fields
  String name = "actor";
  boolean isDead = false;
  boolean hitboxVisible = false;
  HashMap<String, Component> components = new HashMap();
  ArrayList<String> concerns = new ArrayList();

  // draw fields
  color fill = WHITE;
  color stroke = RED;



  Actor() {
  } // All child classes of Actor must call setSize() in constructor

  void update() {

    handleAllConcerns();

    updateComponents();

    calculateAABB();
  }

  void draw() {
    drawComponents();

    pushMatrix();

    if (hitboxVisible) {

      fill(fill);
      stroke(stroke);
      strokeWeight(2);

      //rect(x - w/2, y - h/2, w, h);
      line(edgeL, edgeT, edgeR, edgeT);
      line(edgeR, edgeT, edgeR, edgeB);
      line(edgeR, edgeB, edgeL, edgeB);
      line(edgeL, edgeB, edgeL, edgeT);
      textAlign(CENTER);
      textSize(12);
      //text("x: " + (int)x + " | y: " + (int)y, x, y + h*.75);

      noStroke();
    }

    popMatrix();
  }

  void die() {
  }

  void setSize(float w, float h) {
    this.w = w;
    this.h = h;
    halfW = w/2;
    halfH = h/2;
  }

  void calculateAABB() {
    edgeL = x - halfW;
    edgeR = x + halfW;
    edgeT = y - halfH;
    edgeB = y + halfH;
  }

  boolean checkCollision(Actor other) {
    if (edgeR < other.edgeL) return false;
    if (edgeL > other.edgeR) return false;
    if (edgeB < other.edgeT) return false;
    if (edgeT > other.edgeB) return false;
    return true;
  }

  //
  // Collision resolution methods
  //
  public void fixOverlap(Actor other) {
    float pushUp = edgeB - other.edgeT;
    float pushLeft = edgeR - other.edgeL;

    if (pushUp <= pushLeft) setBottomEdge(other.edgeT);
    else {
    }//setRightEdge(other.edgeL);
  }
  public void setBottomEdge(float Y) {
    y = Y - halfH;
    calculateAABB();
  }
  public void setRightEdge(float X) {
    x = X - halfW;
    calculateAABB();
  }
  /**
   * This method finds the best solution for moving (this) AABB out from an (other)
   * AABB object. The method compares four possible solutions: moving (this) box
   * left, right, up, or down. We only want to choose one of those four solutions.
   * The BEST solution is whichever one is the smallest. So after finding the four
   * solutions, we compare their absolute values to discover the smallest.
   * We then return a vector of how far to move (this) AABB.
   * NOTE: you should first verify that (this) and (other) are overlapping before
   * calling this method.
   * @param  other  The (other) AABB object that (this) AABB is overlapping with.
   * @return  The vector that respresents how far (and in which direction) to move (this) AABB.
   */
  public PVector findOverlapFix(Actor other) {

    float moveL = other.edgeL - edgeR; // how far to move this box so it's to the LEFT of the other box.
    float moveR = other.edgeR - edgeL; // how far to move this box so it's to the RIGHT of the other box.
    float moveU = other.edgeT - edgeB; // how far to move this box so it's to the TOP of the other box.
    float moveD = other.edgeB - edgeT; // how far to move this box so it's to the BOTTOM of the other box.

    // The above values are potentially negative numbers; the sign indicates what direction to move.
    // But we want to find out which ABSOLUTE value is smallest, so we get a non-signed version of each.

    float absMoveL = abs(moveL);
    float absMoveR = abs(moveR);
    float absMoveU = abs(moveU);
    float absMoveD = abs(moveD);

    PVector result = new PVector();

    result.x = (absMoveL < absMoveR) ? moveL : moveR; // store the smaller horizontal value.
    result.y = (absMoveU < absMoveD) ? moveU : moveD; // store the smaller vertical value.

    if (abs(result.y) <= abs(result.x)) {
      // If the vertical value is smaller, set horizontal to zero.
      result.x = 0;
    } else {
      // If the horizontal value is smaller, set vertical to zero.
      result.y = 0;
    }

    return result;
  }

  void updateComponents() {
    for (HashMap.Entry<String, Component> entry : components.entrySet()) entry.getValue().update();
  }

  void drawComponents() {
    for (HashMap.Entry<String, Component> entry : components.entrySet()) entry.getValue().draw();
  }

  // A method to add components to actor
  Actor addComponent(Component c) {

    components.put(c.name, c);

    println(name + " added component '" + c.name + "' successfully");
    return this; // Actor return type allows for chaining addComponent() calls
  }

  // If using this method, always check for possibility of NULL
  Component getComponent(String name) {

    if (components.containsKey(name)) return components.get(name);

    println(this.name + " could not find component '" + name + "'.");
    return null;
  }

  void handleAllConcerns() {

    for (String actorType : concerns) {
      if (!levels[currentLevel].actorFactory.actors.containsKey(actorType)) continue;
      for (Actor a : levels[currentLevel].actorFactory.actors.get(actorType)) {

        // check for collision
        if (a.checkCollision(this)) {
          handleConcernsCollision(a);
        }

        // do anything else
        handleConcern(a);
      }
    }
  }

  // override this to handle collision
  void handleConcernsCollision(Actor a) {
  }

  void handleConcern(Actor a) {
  }

  void mousePressed() {
  }
}

/// COMPONENT ///  modular functionality for actors

abstract class Component {

  // fields
  String name = "";
  Actor parent;
  boolean visible = true;

  abstract void update();

  abstract void draw();
}

// allows easily assigning mouse as target for hook
class MouseActor extends Actor {

  MouseActor() {

    name = "mouseActor";
    x = 1000; // without changing x and y in constructor,
    y = 1000; // frame one had player and mouse at same location somehow
    hitboxVisible = false;

    setSize(24, 24);
  }

  void update() {
    super.update();

    x = mouseX + levels[currentLevel].view.x;
    y = mouseY + levels[currentLevel].view.y;
  }

  void draw() {
    super.draw();
  }
}
