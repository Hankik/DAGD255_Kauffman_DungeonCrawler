interface Interacting {
  
  abstract void interact(Actor invoker);
}

interface ListDraw <T> { // <T> refers to generic object class

  default void listDraw(ArrayList<T> list) { // ie, can be used on any arraylist in theory
  
    if (list.size() <= 0) return;

    // but we check to make sure the arraylist is of a type that has a draw method
    if (list.get(0) instanceof Actor) {
      for (T actor : list) ((Actor)actor).draw(); // then we have to cast the generic to the proper class type 'Actor'
      
      return;  // if found to be actor arraylist, leave function
    }
    if (list.get(0) instanceof Particle) for (T particle : list) {
      ((Particle)particle).draw();
    }
  }
}
