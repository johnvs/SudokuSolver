
import java.util.Set;
import java.util.HashSet;
import java.util.Arrays;
import java.util.Iterator;

final int NUM_CELLS = 9;

boolean isDebugMode = false;

//Cell[][] theGrid;
//Cell[][] rows;
//Cell[][] columns;
//Cell[][][][] grids;

void setup() {
  size(750, 750);
  
  theGrid = new Cell[9][9];      // The main array - the objects are actually stored here
  rows = new Cell[9][9];         // Three convenience arrays that point to the main array 
  columns = new Cell[9][9];
  grids = new Cell[3][3][3][3];
  
  // Create the main array
  for (int i = 0; i < theGrid.length; i++) {
    for (int j = 0; j < theGrid[i].length; j++) {
      theGrid[i][j] = new Cell();
    }
  }
  
  // Point the columns array to the appropriate objects of the main array 
  for (int i = 0; i < columns.length; i++) {
    for (int j = 0; j < columns[i].length; j++) {
      columns[i][j] = theGrid[i][j];
    }
  }
  
  // Point the rows array to the appropriate objects of the main array
  // i and j are intentionally reversed
  for (int i = 0; i < rows.length; i++) {
    for (int j = 0; j < rows[i].length; j++) {
      rows[j][i] = theGrid[i][j];
    }
  }
  
  // Fill the arrays with test data
  for (int i = 0; i < rows.length; i++) {
    for (int j = 0; j < rows[i].length; j++) {
      rows[i][j].theValue = j + (i * 10);
    }
  }
  
  for (int i = 0; i < theGrid.length; i++) {
    print("Data as theGrid: ");
    for (int j = 0; j < theGrid[i].length; j++) {
      print(theGrid[i][j].theValue + ", ");
    }
    println();
  }
  println();
  
  for (int i = 0; i < columns.length; i++) {
    print("Data as columns: ");
    for (int j = 0; j < columns[i].length; j++) {
      print(columns[i][j].theValue + ", ");
    }
    println();
  }
  println();
  
  for (int i = 0; i < rows.length; i++) {
    print("Data as rows: ");
    for (int j = 0; j < rows[i].length; j++) {
      print(rows[i][j].theValue + ", ");
    }
    println();
  }
  
  println("Possible values = " + rows[0][0].possibleValues);
  if (rows[0][0].possibleValues.contains(8)) {
    rows[0][0].possibleValues.remove(8);
  }
  println("Possible values = " + rows[0][0].possibleValues);


  for (int i = 0; i < theGrid.length; i++) {
    print("Data as rows: ");
    for (int j = 0; j < theGrid[i].length; j++) {
      if (theGrid[i][j].theValue == 0) {
        removeRowValuesFromPossibleValues(i, j);
        removeColumnValuesFromPossibleValues(i, j);
      }
      
      
      if (rows[0][1].possibleValues.contains(rows[i][j].theValue)) {
        print(rows[i][j].theValue + ", ");
      }
    }
    println();
  }
  

    
    
  //for (int i = 0; i < rows[0][0].possibleValues.size(); i++) {
  //  print("Data as rows: ");
  //  println();
  //}
  
    // create an iterator
    Iterator<Integer> iterator = rows[0][0].possibleValues.iterator(); 

    // check values
    while (iterator.hasNext()) {
      //if (iterator.next() == 4) {
      //  rows[0][0].possibleValues.remove();
      //}
      println("Value: " + iterator.next() + " ");
    }
  
  drawGrid();
  
}

void draw() {
  
  
  if (isDebugMode) {
  }
}

void removeRowValuesFromPossibleValues(int row, int col) {
  for (int i = 0; i < theGrid.length; i++) {
  }

}

void removeColumnValuesFromPossibleValues(int i, int j) {
}


void drawGrid() {
  float cellWidth = width / 9.0;

  background(255);
  
  for (int i = 1; i < NUM_CELLS; i++) {
    if (i % 3 == 0) {
      strokeWeight(5);
    } else {
      strokeWeight(1);
    }

    line((i * cellWidth), 0, (i * cellWidth), height);
    line(0, (i * cellWidth), width, (i * cellWidth));
  }
      
}

class TheGrid {
  
  final int NUM_CELLS = 9;
  
  private Cell[][] theGrid;
  private Cell[][] rows;
  private Cell[][] columns;
  private Cell[][][][] grids;
  
  TheGrid() {
  
    theGrid = new Cell[9][9];      // The main array - the objects are actually stored here
    rows = new Cell[9][9];         // Three convenience arrays that point to the main array 
    columns = new Cell[9][9];
    grids = new Cell[3][3][3][3];
    
    // Create the main array
    for (int i = 0; i < theGrid.length; i++) {
      for (int j = 0; j < theGrid[i].length; j++) {
        theGrid[i][j] = new Cell();
      }
    }
    
    // Point the columns array to the appropriate objects of the main array 
    for (int i = 0; i < columns.length; i++) {
      for (int j = 0; j < columns[i].length; j++) {
        columns[i][j] = theGrid[i][j];
      }
    }
    
    // Point the rows array to the appropriate objects of the main array
    // i and j are intentionally reversed
    for (int i = 0; i < rows.length; i++) {
      for (int j = 0; j < rows[i].length; j++) {
        rows[j][i] = theGrid[i][j];
      }
    }
  }
  
}

class Cell {
  
  private int theValue = 0;
  private boolean isLocked = false;
  Set<Integer> possibleValues; 

  Cell() {
    possibleValues = new HashSet<Integer>(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));
  }

}

void mousePressed() {
  activeCell = getCellNumber(mouseX, mouseY);
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
    } else if (keyCode == DOWN) {
    } else if (keyCode == LEFT) {
    } else if (keyCode == RIGHT) {
    }

  }

  if (key == 'd' || key == 'D') {
    isDebugMode = !isDebugMode;
  }
  
  if (key == 'b' || key == 'B') {
    // toggle background mode
    isWhiteBackground = !isWhiteBackground;
  }
  
  if (key == ' ') {
    //isLooping = !isLooping;
    //if (isLooping) {
    //  noLoop();
    //} else {
    //  loop();
    //}
  }
}