class Level {

  // fields
  int id;
  ActorFactory actorFactory = new ActorFactory();
  Player player;
  View view;

  Level(int id) {

    switch(id) {

    case 0:
      player = (Player) actorFactory.create("player", width/2, height/2, 30, 30);
      break;
    }
  }
  
  void update(){
  
    actorFactory.update();
  }
  
  void draw(){
  
    actorFactory.draw();
  }
}
