class Combat extends Component {

  ///
  /// A Component class to store combat stats and methods health and damage
  ///

  // fields
  Actor parent;
  float health = 0;
  float damage = 0;
  float maxHealth = 20;
  float baseDamage = 0;
  boolean healthDepleted = false;

  Combat(Actor parent) {

    name = "combat";

    this.parent = parent;
    
    visible = true;
  }

  void update() {
  }

  void draw() {
  
    if (visible){
      pushMatrix();
      fill(WHITE);
      translate(parent.x, parent.y);
      rect(-parent.w*.5, -parent.h*.8, parent.w, 3);
      fill(RED);
      rect(-parent.w*.5, -parent.h*.8, parent.w*(health/maxHealth) , 3);
      popMatrix();
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
  
  void gainHealth(float healthGained){
  
    health += abs(healthGained);
    if (health > maxHealth) health = maxHealth;
    if (health > 0) healthDepleted = false;
  }

  void takeDamage(float damageTaken) {

    health -= damageTaken;
    if (health <= 0) {
      healthDepleted = true;
      parent.die();
    }
  }
}
