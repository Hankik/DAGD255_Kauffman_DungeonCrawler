class View extends Actor {

  // fields
  Player target;
  Actor hitbox = new Actor();
  float tx, ty;
  boolean followingPlayer = true;

  View(Player p) {

    name = "view";

    concerns.add("exit");
    concerns.add("flower");

    target = p;
    tx = target.x - width*.5;
    ty = target.y - height*.5;
    x = tx;
    y = ty;

    hitbox.x = x + width*.5;
    hitbox.y = y + height*.5;
    hitbox.setSize(width, height);
  }

  void update() {

    hitbox.x = x + width*.5;
    hitbox.y = y + height*.5;
    hitbox.update();

    if (!followingPlayer) return;

    tx = target.x - width*.5;
    ty = target.y - height*.5;

    float dx = tx - x;
    float dy = ty - y;
    x += dx * .2;
    y += dy * .2;

    super.update();
  }

  @Override
    void handleConcern(Actor a) {

    // I only care if exit or flower are no longer visible
    if (hitbox.checkCollision(a)) return;

    if (a.name == "exit") {

      float iconW = 32;
      float iconH = 32;

      float exitX = clamp(a.x - a.w*.5, hitbox.x - width*.5, hitbox.x + width*.5 - iconW);
      float exitY = clamp(a.y - a.h*.5, hitbox.y - height*.5, hitbox.y + height*.5 - iconH);

      fill(WHITE);
      rect(exitX, exitY, 32, 32, 4);
      image(imgSmallStairs, exitX + 4, exitY + 4);
    }

    if (a.name == "flower") {

      float iconW = 32;
      float iconH = 32;

      float exitX = clamp(a.x - a.w*.5, hitbox.x - width*.5, hitbox.x + width*.5 - iconW);
      float exitY = clamp(a.y - a.h*.5, hitbox.y - height*.5, hitbox.y + height*.5 - iconH);

      fill(WHITE);
      rect(exitX, exitY, 32, 32, 4);
      image(imgSmallFlower, exitX + 4, exitY + 4);
    }
  }



  void draw() {
    super.draw();

    if (hitbox.checkCollision(globalMouse)) hitbox.hitboxVisible = true;
    else hitbox.hitboxVisible = false;
  }
}
