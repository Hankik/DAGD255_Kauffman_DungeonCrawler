/* This .pde contains the ActorFactory and ParticleFactory class */

class ActorFactory implements ListDraw { // see ListDraw's implementation details in 'Interfaces'.pde

  // A HashMap storing an arraylist for each type of actor
  HashMap<String, ArrayList<Actor>> actors = new HashMap(); // used to store each type of actor in their own arraylist
  
  ///
  /// the HashMap + ArrayLists logic and data could be moved inside Level class
  /// but I want to use this 'Factories' .pde to keep Level decluttered. 
  ///

  void update() {

    // this is how you for-each loop through a hashmap
    for (HashMap.Entry<String, ArrayList<Actor>> entry : actors.entrySet()) {
      updateActors(entry.getValue()); // access each type of actorList and update contents
    }
  }

  void draw() {
    for (HashMap.Entry<String, ArrayList<Actor>> entry : actors.entrySet()) {
      listDraw( entry.getValue() );
    }
  }

  void updateActors(ArrayList<Actor> type) {

    for (int i = type.size() - 1; i >= 0; i--) {

      Actor a = type.get(i);

      if (a.isDead) {    // check if actor has died

        type.remove(i);  // then cull actor
        continue;        // continue to skip update
      }

      a.update();        // update actor
    }
  }



  Actor create(String name, float x, float y, float w, float h) {

    if (name == null) return null;

    if (name.equalsIgnoreCase("PLAYER")) { // checks for requested class and handles construction details

      Player p = new Player(x, y, w, h);
      addActor(p);
      return p;
    }

    if (name.equalsIgnoreCase("NPC")) {

      NPC npc = new NPC(x, y, w, h);
      addActor(npc);
      return npc;
    }
    
    if (name.equalsIgnoreCase("TREE")) {
    
      Pillar tree = new Pillar(x, y, w, h);
      addActor(tree);
      return tree;
    }
    if (name.equalsIgnoreCase("EXIT")){
    
      Exit exit = new Exit(x, y, w, h);
      addActor(exit);
      return exit;
    }
    if (name.substring(0, 6).equalsIgnoreCase("BUTTON")){
      Button b = new Button(x, y, w, h, name.substring(6));
      addActor(b);
      return b;
    }
    if (name.substring(0, 7).equalsIgnoreCase("TEXTBOX")){
    
      TextBox t = new TextBox(x, y, w, h, name.substring(7));
      addActor(t);
      return t;
    }

    println("ActorFactory create failed: could not find recipe for '" + name + "'");
    return null;
  }

  void addActor(Actor a) {
    try {
      // attempt to add element to arraylist located in hashmap using actors name as key
      actors.get(a.name).add(a);
      if (a.name == "pillar") return;
      println("Actor " + a.name + " created successfully");
    }
    // if key is not found, error is caught and handled
    catch (Exception e) {
      ArrayList<Actor> actorList = new ArrayList();       // arraylist created
      actors.put(a.name, actorList);                      // arraylist added to hashmap under actors name
      actorList.add(a);                                   // actor added to arraylist
      println("ArrayList for " + a.name + "s created successfully");
      println("Actor " + a.name + " created successfully");
    }
  }
}

class ParticleFactory implements ListDraw {

  HashMap<String, ArrayList<Particle>> particles = new HashMap();

  void update() {

    for (HashMap.Entry<String, ArrayList<Particle>> entry : particles.entrySet()) {
      updateParticles(entry.getValue());
    }
  }
  
  void draw() {
    for (HashMap.Entry<String, ArrayList<Particle>> entry : particles.entrySet()) {
      listDraw( entry.getValue() );
    }
  }
  
  Particle create(String name, PImage sprite, float xPos, float yPos, float speed, PVector dir, float duration){
  
    if (name == null) return null;
    
    if (name.equalsIgnoreCase("BLOOD")){
      Particle blood = new Particle(name, null, xPos, yPos, speed, dir, duration);
      addParticle(blood);
      return blood;
    }
    if (name.equalsIgnoreCase("BLUEBLOOD")){
      Particle bb = new Particle(name, null, xPos, yPos, speed, dir, duration);
      bb.fill = color(LIGHTBLUE);
      addParticle(bb);
      return bb;
      
    }
    
    println("ParticleFactory create failed: could not find recipe for '" + name + "'");
    return null;
  }

  void updateParticles(ArrayList<Particle> type) {

    for (int i = type.size() - 1; i >= 0; i--) {
      Particle p = type.get(i);

      if (p.lifetime.isDone) {    // check if particle's lifetime is over

        type.remove(i);  // then cull particle
        continue;        // continue to skip update method
      }

      p.update();        // update particle
    }
  }
  
  void addParticle(Particle p){
    try {
      // attempt to add element to arraylist located in hashmap using particles name as key
      particles.get(p.name).add(p);
      println("Particle " + p.name + " created sucessfully");
    }
    catch(Exception e) {
      ArrayList<Particle> particleList = new ArrayList();
      particles.put(p.name, particleList);
      particleList.add(p);
      println("ArrayList for " + p.name + "s created successfully");
      println("Particle " + p.name + " created successfully");
    }
    
  }
}
