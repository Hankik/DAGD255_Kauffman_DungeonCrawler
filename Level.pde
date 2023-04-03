class Level {

  // fields
  int id;
  ActorFactory actorFactory = new ActorFactory();
  Player player;
  View view = new View();
  Map map = new Map(32, 32);

  Level(int id) {

    switch(id) {

    case 0:
      player = (Player) actorFactory.create("player", width/2, height/2, 32, 32);
      actorFactory.create("npc", width*.25, height*.25, 32, 32);
      break;
    }
  }

  void update() {

    actorFactory.update();
  }

  void draw() {

    map.draw();
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
