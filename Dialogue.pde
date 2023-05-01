class Dialogue extends Component {

  // fields
  Timer displayTimer = new Timer(2);
  String[] lines;
  int currentLine = 0;

  Dialogue(Actor parent, String fileName) {
    
    name = fileName;

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
      textAlign(CENTER);
      fill(WHITE);
      textSize(12);
      text(lines[currentLine], parent.x, parent.y - parent.h*.85);
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
  
  String randomLine(){
  
    int rand = floor(random(0, lines.length - 1));
    currentLine = rand;
    return lines[rand];
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

/*
// Hank Kauffman's Dialogue Class
//
// Let your characters speak through text files.
class Dialogue {

  // fields
  Timer displayTimer = new Timer(2);
  String[] lines;
  int currentLine = 0;

  Dialogue(Actor parent, String fileName) {

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
*/
