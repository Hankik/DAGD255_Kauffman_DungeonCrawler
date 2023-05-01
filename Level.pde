class Level {

  // fields
  int id;
  final int START_MENU = 0;
  final int LEVEL_ONE = 1;
  final int LEVEL_TWO = 2;
  final int LEVEL_THREE = 3;
  final int GAME_OVER = 4;
  final int VICTORY = 5;
  ActorFactory actorFactory = new ActorFactory();
  ParticleFactory particleFactory = new ParticleFactory();
  ArrayList<Popup> popups = new ArrayList();
  Player player;
  Flower flower = new Flower();
  View view;
  PVector lastSpawnLocation = new PVector(width*.5, height*.5);
  int currentWave = 0;
  int wavesTillExit = 1;
  int npcSpawnAmount = 15;
  Map map = new Map(32, 32);
  Timer newNPCTimer = new Timer(5);

  Level(int id) {

    map.xOffset = -2560;
    map.yOffset = -2560;

    switch(id) {

    case START_MENU:

      for (int i = 0; i < 12; i++)  actorFactory.create("tree", 128 + i*32, 128, 21, 32);
      for (int i = 0; i < 10; i++) actorFactory.create("tree", 512, 160 + i * 32, 21, 32);
      for (int i = 0; i < 10; i++) actorFactory.create("tree", 96, 160 + i * 32, 21, 32);
      for (int i = 0; i < 12; i++) actorFactory.create("tree", 128 + i * 32, 480, 21, 32);

      actorFactory.addActor(flower);
      actorFactory.create("TEXTBOXPetal and Metal", width*.5 - 100, height*.015, 200, 100);
      TextBox t = (TextBox) actorFactory.create("TEXTBOXClick and Drag on Robot to Grab\nPress E to Interact with Objects", width*.5 - 140, height*.8, 280, 50);
      t.textSize = 14;

      actorFactory.create("exit", 160, 192, 32, 32);
      player = (Player) actorFactory.create("player", width*.5, lastSpawnLocation.y, 24, 32);

      view = new View(player);

      break;

    case LEVEL_ONE: // LEVEL ONE
      actorFactory.addActor(flower);
      flower.isStolen = true;
      player = (Player) actorFactory.create("player", lastSpawnLocation.x, lastSpawnLocation.y, 24, 32);
      actorFactory.create("npc", width*.25, height*.25, 32, 32);
      for (int i = 0; i < 200; i++) {

        actorFactory.create("tree", random(-2560, 2560), random(-2560, 2560), 21, 32);
      }


      view = new View(player);
      break;

    case LEVEL_TWO:
      wavesTillExit = 2;
      actorFactory.addActor(flower);
      flower.isStolen = true;
      player = (Player) actorFactory.create("player", lastSpawnLocation.x, lastSpawnLocation.y, 24, 32);
      actorFactory.create("npc", width*.25, height*.25, 32, 32);
      for (int i = 0; i < 200; i++) {

        actorFactory.create("tree", random(-2560, 2560), random(-2560, 2560), 21, 32);
      }

      view = new View(player);
      break;

    case LEVEL_THREE:

      wavesTillExit = 3;
      actorFactory.addActor(flower);
      flower.isStolen = true;
      player = (Player) actorFactory.create("player", lastSpawnLocation.x, lastSpawnLocation.y, 24, 32);
      actorFactory.create("npc", width*.25, height*.25, 32, 32);
      for (int i = 0; i < 200; i++) {

        actorFactory.create("tree", random(-2560, 2560), random(-2560, 2560), 21, 32);
      }
      view = new View(player);
      break;

    case GAME_OVER:

      for (int i = 0; i < 12; i++)  actorFactory.create("tree", 128 + i*32, 128, 21, 32);
      for (int i = 0; i < 10; i++) actorFactory.create("tree", 512, 160 + i * 32, 21, 32);
      for (int i = 0; i < 10; i++) actorFactory.create("tree", 96, 160 + i * 32, 21, 32);
      for (int i = 0; i < 12; i++) actorFactory.create("tree", 128 + i * 32, 480, 21, 32);

      actorFactory.create("TEXTBOXGame Over\nRun far away to escape!", width*.5 - 100, height*.015, 200, 100);
      actorFactory.create("BUTTONPlay Again?", width*.5 - 100, height*.8, 200, 80);

      flower.isDead = true;
      player = (Player) actorFactory.create("player", lastSpawnLocation.x, lastSpawnLocation.y, 24, 32);
      view = new View(player);
      break;

    case VICTORY:
    
      float timeToWin = elapsed;
    
      newNPCTimer.duration = 500000;
      newNPCTimer.timeLeft = 500000;

      for (int i = 0; i < 12; i++)  actorFactory.create("tree", 128 + i*32, 128, 21, 32);
      for (int i = 0; i < 10; i++) actorFactory.create("tree", 512, 160 + i * 32, 21, 32);
      for (int i = 0; i < 10; i++) actorFactory.create("tree", 96, 160 + i * 32, 21, 32);
      for (int i = 0; i < 12; i++) actorFactory.create("tree", 128 + i * 32, 480, 21, 32);
      
      actorFactory.create("TEXTBOXVICTORY!!!\n Your Time: " + timeToWin, width*.5 - 100, height*.015, 200, 100);
      actorFactory.create("BUTTONPlay Again?", width*.5 - 100, height*.8, 200, 80);

      actorFactory.addActor(flower);
      player = (Player) actorFactory.create("player", lastSpawnLocation.x, lastSpawnLocation.y, 24, 32);
      view = new View(player);
      break;
    }

    println("Level with id '" + id + "' construction successful\n");
  }

  void update() {
    newNPCTimer.update();
    flower.update();
    actorFactory.update();
    particleFactory.update();
    for (int i = popups.size() - 1; i >= 0; i--) {
      popups.get(i).update();
      if (popups.get(i).isDead) popups.remove(i);
    }
    tryCreateNPCWave();
    trySpawnNPC();
  }

  void draw() {

    map.draw();
    actorFactory.draw(); // separating draw from update allows game to be paused without disappearing
    particleFactory.draw();
    for (Popup p : popups) p.draw();

    fill(YELLOW);

    flower.draw();
    view.update();
    view.draw();
  }

  void trySpawnNPC() {

    if (!flower.isStolen) return;
    if (!newNPCTimer.isDone) return;

    newNPCTimer.reset();

    int rand = floor(random(4));

    switch (rand) {

    case 0: // spawn npc at top of screen
      actorFactory.create("npc", random(view.x, view.x + width), view.y - 32, 32, 32);
      break;
    case 1: // spawn npc at bottom
      actorFactory.create("npc", random(view.x, view.x + width), view.y + height + 32, 32, 32);
      break;
    case 2: // spawn at left
      actorFactory.create("npc", view.x - 32, random(view.y, view.y + height), 32, 32);
      break;
    case 3: // spawn at right
      actorFactory.create("npc", view.x + width + 32, random(view.y, view.y + height), 32, 32);
      break;
    }
  }

  void spawnWave() {

    for (int i = 0; i < npcSpawnAmount; i++) {

      int rand = floor(random(4));

      switch (rand) {

      case 0: // spawn npc at top of screen
        actorFactory.create("npc", random(view.x, view.x + width), view.y - 32, 32, 32);
        break;
      case 1: // spawn npc at bottom
        actorFactory.create("npc", random(view.x, view.x + width), view.y + height + 32, 32, 32);
        break;
      case 2: // spawn at left
        actorFactory.create("npc", view.x - 32, random(view.y, view.y + height), 32, 32);
        break;
      case 3: // spawn at right
        actorFactory.create("npc", view.x + width + 32, random(view.y, view.y + height), 32, 32);
        break;
      }
    }
  }

  void tryCreateNPCWave() {
    if (dist(lastSpawnLocation.x, lastSpawnLocation.y, player.x, player.y) < 1280) return;
    currentWave++;
    NPC npc = new NPC(); // keep track of this npc while inside function to spawn an exit on the last created npc
    lastSpawnLocation = new PVector(player.x, player.y);
    for (int i = 0; i < npcSpawnAmount; i++) {

      int rand = floor(random(4));

      switch (rand) {

      case 0: // spawn npc at top of screen
        npc = (NPC) actorFactory.create("npc", random(view.x, view.x + width), view.y - 32, 32, 32);
        break;
      case 1: // spawn npc at bottom
        npc = (NPC) actorFactory.create("npc", random(view.x, view.x + width), view.y + height + 32, 32, 32);
        break;
      case 2: // spawn at left
        npc = (NPC) actorFactory.create("npc", view.x - 32, random(view.y, view.y + height), 32, 32);
        break;
      case 3: // spawn at right
        npc = (NPC) actorFactory.create("npc", view.x + width + 32, random(view.y, view.y + height), 32, 32);
        break;
      }
    }
    if (currentWave == wavesTillExit) actorFactory.create("exit", npc.x, npc.y, 32, 32); // npc's location is needed
  }

  void keyPressed() {
  }

  ArrayList<Actor> getActors(String name) {

    return actorFactory.actors.get(name);
  }

  void mousePressed() {

    player.mousePressed();
  }
}
