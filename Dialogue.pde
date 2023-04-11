class Dialogue extends Component {

  // fields
  Timer displayTimer = new Timer(2);
  String[] lines;
  int currentLine = 0;

  Dialogue(Actor parent, String fileName) {
    
    name = "dialogue";

    this.parent = parent;
    
    lines = loadText(fileName);
    currentLine = lines.length - 1;
    displayTimer.isDone = true;
  }

  void update() {
    displayTimer.update();
  }

  void draw() {
    
    if (!displayTimer.isDone) {

      pushMatrix();
      fill(WHITE);
      text(lines[currentLine], parent.x - parent.w*.5, parent.y - parent.h*.85);
      popMatrix();
    }
  }
  
  void speak(){
    displayTimer.reset();
  }
  
    String nextLine(){
    currentLine++;
    if (currentLine >= lines.length) currentLine = 0;
    return lines[currentLine];
  }
  
  String[] loadText(String fileName) {
    
    try { // attempt to load in file
      String[] strArr = loadStrings(fileName);
      if (strArr == null) throw new NullPointerException("load failed");
      else return strArr;
    }
    catch (Exception e) {
      println(e + " // File '" + fileName + "' not found.");
      return new String[]{""};
    }
  }
}
