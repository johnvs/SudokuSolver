
class TheGrid {

  private final int NUM_CELLS_MINOR = 3;
  private final int NUM_CELLS_MAJOR = NUM_CELLS_MINOR * NUM_CELLS_MINOR;

  private final int CELL_TEXT_SIZE_MIN = 4;
  private final int CELL_TEXT_SIZE_MAX = 24;
  private final int CELL_VALUE_MIN = 1;
  private final int CELL_VALUE_MAX = 9;

  private Cell[][] theGrid;
  private Cell[][] rows;
  private Cell[][] columns;
  private Cell[][][][] grids;
  private PVector cellSize;
  private int cellTextSize = 8;  // Default value
  private PVector activeCell;
  private boolean enableActiveCell = false;

  public TheGrid() {

    theGrid = new Cell[NUM_CELLS_MAJOR][NUM_CELLS_MAJOR];  // The main array - the objects are actually stored here
    rows =    new Cell[NUM_CELLS_MAJOR][NUM_CELLS_MAJOR];     // Three convenience arrays that point to the main array
    columns = new Cell[NUM_CELLS_MAJOR][NUM_CELLS_MAJOR];
    grids =   new Cell[NUM_CELLS_MINOR][NUM_CELLS_MINOR][NUM_CELLS_MINOR][NUM_CELLS_MINOR];

    cellSize = new PVector(width / NUM_CELLS_MAJOR, height / NUM_CELLS_MAJOR);
    int cellSizeHalfX = int(cellSize.x / 2);
    int cellSizeHalfY = int(cellSize.y / 2);

    activeCell = new PVector(0, 0);

    // Create the main array
    int x, y;

    for (int col = 0; col < theGrid.length; col++) {
      // Calculate cell center x
      int centerX = int(width * (float(col) / NUM_CELLS_MAJOR)) + cellSizeHalfX;

      for (int row = 0; row < theGrid[col].length; row++) {
        // Calculate cell center y
        int centerY = int(height * (float(row) / NUM_CELLS_MAJOR)) + cellSizeHalfY;

        theGrid[col][row] = new Cell(centerX, centerY);
      }
    }

    // Point the columns array to the appropriate objects of the main array
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        columns[col][row] = theGrid[col][row];
      }
    }

    // Point the rows array to the appropriate objects of the main array
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        rows[row][col] = theGrid[col][row];
      }
    }

    // Point the grids array to the appropriate objects of the main array
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        grids[col / NUM_CELLS_MINOR][row / NUM_CELLS_MINOR]
             [col % NUM_CELLS_MINOR][row % NUM_CELLS_MINOR] = theGrid[col][row];
      }
    }

  }

  private void printGrid() {
    // Fill the arrays with test data
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        rows[row][col].theValue = col + (row * 10);
      }
    }

    // Print the grid as Itself
    for (int col = 0; col < theGrid.length; col++) {
      print("Data as theGrid: ");
      for (int row = 0; row < theGrid[col].length; row++) {
        print(theGrid[col][row].theValue + ", ");
      }
      println();
    }
    println();

    // Print the grid by column
    for (int col = 0; col < columns.length; col++) {
      print("Data as columns: ");
      for (int row = 0; row < columns[col].length; row++) {
        print(columns[col][row].theValue + ", ");
      }
      println();
    }
    println();

    // Print the grid by row
    for (int row = 0; row < rows.length; row++) {
      print("Data as rows: ");
      for (int col = 0; col < rows[row].length; col++) {
        print(rows[row][col].theValue + ", ");
      }
      println();
    }
    println();

    // Print the whole grid as the grid of grids
    println("Data as a grid of grids: ");
    for (int majorCol = 0; majorCol < grids.length; majorCol++) {
      println("  Data as major cols: ");
      for (int majorRow = 0; majorRow < grids[majorCol].length; majorRow++) {
        println("    Data as major rows: ");
        for (int col = 0; col < grids[majorCol][majorRow].length; col++) {
          print("      Data as rows: ");
          for (int row = 0; row < grids[majorCol][majorRow][col].length; row++) {
            print(grids[majorCol][majorRow][row][col].theValue + ", ");
          }
          println();
        }
        println();
      }
      println();
    }
    println();

    println("Possible values = " + rows[0][0].possibleValues);
    if (rows[0][0].possibleValues.contains(8)) {
      rows[0][0].possibleValues.remove(8);
    }
    println("Possible values = " + rows[0][0].possibleValues);

    // for (int i = 0; i < theGrid.length; i++) {
    //   print("Data as rows: ");
    //   for (int j = 0; j < theGrid[i].length; j++) {
    //     if (theGrid[i][j].theValue == 0) {
    //       removeRowValuesFromPossibleValues(i, j);
    //       removeColumnValuesFromPossibleValues(i, j);
    //     }
    //
    //
    //     if (rows[0][1].possibleValues.contains(rows[i][j].theValue)) {
    //       print(rows[i][j].theValue + ", ");
    //     }
    //   }
    //   println();
    // }

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
  }

  public void incCellTextSize() {
    if (cellTextSize < CELL_TEXT_SIZE_MAX) {
      cellTextSize++;
      setCellTextSize();
    }
  }

  public void decCellTextSize() {
    if (cellTextSize > CELL_TEXT_SIZE_MIN) {
      cellTextSize--;
      setCellTextSize();
    }
  }

  private void setCellTextSize() {
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        theGrid[col][row].setTextSize(cellTextSize);
      }
    }
  }

  public void moveActiveCell(CellDirection cellDir) {

  }

  public void update() {

  }

  public void display() {
    drawGrid();

    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        theGrid[col][row].display();
      }
    }

    // Draw Possible values

  }

  public void setActiveCell(int x, int y) {
    theGrid[int(activeCell.x)][int(activeCell.y)].setActive(false);

    activeCell.x = x / cellSize.x;
    activeCell.y = y / cellSize.y;

    theGrid[int(activeCell.x)][int(activeCell.y)].setActive(true);
  }

  private void setCellValue(int col, int row, int value) {
    if ((value >= CELL_VALUE_MIN) && (value <= CELL_VALUE_MAX)) {
      theGrid[col][row].setValue(value);
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

    background(float(Colors.HUE_MAX));

    for (int i = 1; i < NUM_CELLS_MAJOR; i++) {
      if (i % 3 == 0) {
        strokeWeight(5);
      } else {
        strokeWeight(1);
      }

      line((i * cellWidth), 0, (i * cellWidth), height);
      line(0, (i * cellWidth), width, (i * cellWidth));
    }

  }


}
