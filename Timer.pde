// Hank Kauffman's Timer
//
// A useful time keeper!
class Timer extends Component {

  // fields
  float duration;
  float timeLeft;
  boolean isDone = true;
  boolean autoRestart = false;
  boolean isPaused = false;

  Timer(float duration) {
    
    name = "timer";

    this.duration = duration;
    this.timeLeft = duration;
    isDone = false;
  }

  void update() {

    if (this.isPaused) return; // early return if paused
    
    if (timeLeft <= 0) {

      timeLeft = 0;
      isDone = true;
      if (autoRestart) reset();
      
    } else {

      if (!isDone) {

        timeLeft -= dt;
      }
    }
  }

  void draw() {
  }

  void reset() {

    timeLeft = duration;
    isDone = false;
  }
  
  void togglePause(){
    isPaused = !isPaused;
  }
}

/*

// Hank Kauffman's Timer
//
// A useful time keeper!

class Timer extends {

  // variables
  float duration;
  float timeLeft;
  boolean isDone = true;
  boolean autoRestart = false;
  boolean isPaused = false;

  Timer(float duration) {

    this.duration = duration;
    this.timeLeft = duration;
    isDone = false;
  }

  // The timer will not work unless this gets called every frame
  void update() { 

    if (this.isPaused) return; // early return if paused
    
    if (timeLeft <= 0) {

      timeLeft = 0;
      isDone = true;
      if (autoRestart) reset();
      
    } else {

      if (!isDone) {

        timeLeft -= dt;
      }
    }
  }

  void draw() {
  }

  void reset() {

    timeLeft = duration;
    isDone = false;
  }
  
  void togglePause(){
    isPaused = !isPaused;
  }
}

*/
