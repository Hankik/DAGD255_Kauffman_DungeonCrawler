class Level {

  // fields
  int id;
  ActorFactory actorFactory = new ActorFactory();
  Player player;
  View view = new View();
  Map map = new Map(32, 32);
  
  Timer temp = new Timer(.27); // DELETE

  Level(int id) {

    
  temp.isDone = true; // DELETE
    
    switch(id) {

    case 0:
      player = (Player) actorFactory.create("player", width/2, height/2, 32, 32);
      actorFactory.create("npc", width*.25, height*.25, 32, 32);
      break;
    }
  }

  void update() {
    
    temp.update(); // DELETE
    actorFactory.update();
  }

  void draw() {

    map.draw();
    actorFactory.draw(); // separating draw from update allows game to be paused without disappearing
    if (!temp.isDone) text("E KEY PRESSED!!!!", width*.5, height*.8);
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
   
    if (Keyboard.isDown(Keyboard.E)){
      // access this level's npcs . .. . .. check for collision w/ player . .. . . . cast to NPC and call its interact method
      for (Actor a : actorFactory.actors.get("npc")) if (player.checkCollision(a)) ((NPC) a).interact(player);
      temp.reset(); // DELETE
      
    }
  }
}
