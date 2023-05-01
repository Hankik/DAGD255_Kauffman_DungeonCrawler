class Combat extends Component {

  ///
  /// A Component class to store combat stats and methods health and damage
  ///

  // fields
  float health = 0;
  float damage = 0;
  float maxHealth = 20;
  float baseDamage = 0;
  boolean healthDepleted = false;
  Timer damageDelay = new Timer(1.5);

  Combat(Actor parent) {

    name = "combat";

    this.parent = parent;

    visible = true;
  }

  void update() {

    damageDelay.update();
  }

  void draw() {

    if (visible) {
      noStroke();
      pushMatrix();
      fill(WHITE);
      translate(parent.x, parent.y);
      rect(-parent.w*.5, -parent.h*.8, parent.w, 3);
      fill(RED);
      rect(-parent.w*.5, -parent.h*.8, parent.w*(health/maxHealth), 3);
      popMatrix();
      strokeWeight(4);
    }
  }

  void setBaseStats(float maxHealth, float baseDamage) {

    this.maxHealth = maxHealth;
    this.baseDamage = baseDamage;
  }

  void refillHealth() {

    health = maxHealth;
    healthDepleted = false;
  }

  void gainHealth(float healthGained) {

    health += abs(healthGained);
    if (health > maxHealth) health = maxHealth;
    if (health > 0) healthDepleted = false;
  }

  void takeDamage(float damageTaken) {

    if (!damageDelay.isDone) return;
    if (!healthDepleted) health -= damageTaken;
    //levels[currentLevel].popups.add(new Popup(parent.x, parent.y, "" + damageTaken, 8));
    if (health <= 0) {
      healthDepleted = true;
      parent.die();
    }
    damageDelay.reset();
  }
}
