class Item extends Actor implements Interacting {

  // fields
  boolean consumable = false;
  boolean autoPickup = false;
  float value = 0;
  ArrayList<String> effects = new ArrayList();
    
  Item() {
  
    name = "item";
  }
  
  void update(){}
  
  void draw(){}
  
  void interact(Actor invoker){}
}
