class Level {

  // fields
  int id;
  ActorFactory actorFactory = new ActorFactory();
  Player player;
  Flower flower = new Flower();
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
    flower.update();
    actorFactory.update();

    for (Actor a : getActors("npc")) if (a.checkCollision(flower)) {
      flower.damage( ((NPC)a).combat.damage);
      return;
    }
  }

  void draw() {

    map.draw();
    
    actorFactory.draw(); // separating draw from update allows game to be paused without disappearing
    
    fill(YELLOW);
    if (!temp.isDone) text("E KEY PRESSED!!!!", width*.5, height*.8);
    
    flower.draw();
  }

  void keyPressed() {

    if (Keyboard.isDown(Keyboard.E)) {
      // access this level's npcs . .. . .. check for collision w/ player . .. . . . cast to NPC and call its interact method
      for (Actor a : actorFactory.actors.get("npc")) if (player.checkCollision(a)) ((NPC) a).interact(player);
      temp.reset(); // DELETE
    }
  }

  ArrayList<Actor> getActors(String name) {

    return actorFactory.actors.get(name);
  }

  void mousePressed() {

    player.mousePressed();
    for (Actor a : getActors("npc")) a.mousePressed();
  }
}
