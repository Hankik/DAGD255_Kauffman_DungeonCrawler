class Exit extends Actor implements Interacting {

  // fields
  boolean showInstructions = false;

  Exit(float xPos, float yPos, float w, float h) {

    name = "exit";

    x = xPos;
    y = yPos;

    stroke = BLUE;
    setSize(w, h);
  }

  void update() {

    super.update();
  }

  void draw() {
    super.draw();

    image(imgStairs, x - w*.5, y - h*.5);

    fill(WHITE);
    textAlign(CENTER);
    textSize(12);
    if (showInstructions) text("Press E to descend.", x, y - 10);

    if (checkCollision(globalMouse)) hitboxVisible = true;
    else hitboxVisible = false;
  }

  void openLevel(int levelID) {

    if (levelID >= levels.length) levelID = 0;
    currentLevel = levelID;
    levels[currentLevel].popups.add(
      new Popup(100, 100, "Level " + currentLevel + "!", 15, 1));
  }

  void interact(Actor invoker) {

    if (invoker.name.equals("player")) {

      if (!sVictory2.isPlaying()) sVictory2.play();

      if (checkCollision(levels[currentLevel].flower)) {
        if (currentLevel == 3) {
          
          levels[5] = new Level(5);
          openLevel(5);
          
          return;
        }// win the game
        openLevel(currentLevel + 1);
      }

      println("player interacted with exit");
      Player player = (Player) invoker;
      player.exitInteractions.randomLine();
      player.exitInteractions.speak();
    }
  }
}
