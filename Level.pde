class Level {

  // fields
  int id;
  ActorFactory actorFactory = new ActorFactory();
  Player player;
  View view = new View();

  Level(int id) {

    switch(id) {

    case 0:
      player = (Player) actorFactory.create("player", width/2, height/2, 30, 30);
      break;
    }
  }

  void update() {

    actorFactory.update();
  }

  void draw() {

    actorFactory.draw(); // separating draw from update allows game to be paused without disappearing
  }

  void keyPressed() {

    player.keyPressed();
    if (Keyboard.isDown(Keyboard.SPACE)) {
      if (!player.combat.healthDepleted) {
        player.combat.takeDamage(10);
      } else {
        player.combat.refillHealth();
      }
    }
  }
}
