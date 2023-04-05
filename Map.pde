class Map {

  // fields
  int[] row = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  int[][] tiles = new int[20][20];
  int rowAmount = tiles.length;
  int colAmount = tiles[0].length;
  int cellWidth = 32;
  int cellHeight = 32;

  Map(int w, int h) {

    cellWidth = w;
    cellHeight = h;
    
    for (int[] i : tiles) for (int j : i) j = 0; // populate map with zeros
    
    
    println("Map created successfully");
  }

  void update() {
  }

  void draw() {

    noFill();
    stroke(BLUE);
    for (int currentRow = 0; currentRow < rowAmount; currentRow++) {

      for (int currentCol = 0; currentCol < colAmount; currentCol++) {

        switch (tiles[currentRow][currentCol]) {

        case 0:
          
          rect(currentCol*cellWidth, currentRow*cellHeight, cellWidth, cellHeight);
          break;
        }
      }
    }
    noStroke();
    
    fill(BLACK);
  }
}
