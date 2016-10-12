import java.util.Map;
import java.util.Map.Entry;
import java.util.HashMap;

class TheGrid {

  private final int NUM_CELLS_MINOR = 3;
  private final int NUM_CELLS_MAJOR = NUM_CELLS_MINOR * NUM_CELLS_MINOR;

  private final int CELL_TEXT_SIZE_BASE = 24;
  private final int WIDTH_BASE = 250;
  private final float WIDTH_SCALE = 0.08;

  private final int CELL_TEXT_SIZE_MIN = 24;
  private final int CELL_TEXT_SIZE_MAX = 96;
  private final int CELL_VALUE_MIN = 0;
  private final int CELL_VALUE_MAX = 9;
  private final int NUM_CELL_VALUES = 10;

  private Cell[][] theGrid;
  private Cell[][][][] minorGrids;
  private PVector cellSize;
  private int cellTextSize;
  private GridCoords activeCell;
  private boolean isActiveCellEnabled = false;
  // private Map<Integer, HashSet<Integer>> cellsByPossibleValue;
  // private List<HashMap<Integer, HashSet<Integer>>> columnCellMaps;
  // private List<HashMap<Integer, HashSet<Integer>>> rowCellMaps;
  // private List<HashMap<Integer, HashSet<Integer>>> minorGridCellMaps;

  public TheGrid() {

    theGrid    = new Cell[NUM_CELLS_MAJOR][NUM_CELLS_MAJOR];  // The main array - the objects are actually stored here
    minorGrids = new Cell[NUM_CELLS_MINOR][NUM_CELLS_MINOR][NUM_CELLS_MINOR][NUM_CELLS_MINOR];

    cellSize = new PVector(width / NUM_CELLS_MAJOR, height / NUM_CELLS_MAJOR);
    int cellSizeHalfX = int(cellSize.x / 2);
    int cellSizeHalfY = int(cellSize.y / 2);

    // cellsByPossibleValue = new HashMap<Integer, HashSet<Integer>>(NUM_CELLS_MAJOR);
    // columnCellMaps    = new ArrayList<HashMap<Integer, HashSet<Integer>>>(NUM_CELLS_MAJOR);
    // rowCellMaps       = new ArrayList<HashMap<Integer, HashSet<Integer>>>(NUM_CELLS_MAJOR);
    // minorGridCellMaps = new ArrayList<HashMap<Integer, HashSet<Integer>>>(NUM_CELLS_MAJOR);

    cellTextSize = int(((width - WIDTH_BASE) * WIDTH_SCALE) + CELL_TEXT_SIZE_BASE);

    activeCell = new GridCoords(0, 0);

    int cellWidth = int(width / NUM_CELLS_MAJOR);

    // Create the main array
    for (int col = 0; col < theGrid.length; col++) {
      // Calculate cell center x
      int centerX = int(width * (float(col) / NUM_CELLS_MAJOR)) + cellSizeHalfX;

      for (int row = 0; row < theGrid[col].length; row++) {
        // Calculate cell center y
        int centerY = int(height * (float(row) / NUM_CELLS_MAJOR)) + cellSizeHalfY;
        theGrid[col][row] = new Cell(centerX, centerY, cellWidth, cellTextSize);
      }
    }

    // Point the minorGrids array to the appropriate objects of the main array
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        minorGrids[col / NUM_CELLS_MINOR][row / NUM_CELLS_MINOR]
                  [col % NUM_CELLS_MINOR][row % NUM_CELLS_MINOR] = theGrid[col][row];
      }
    }

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

  private void setCellValue(int value) {
    // Use the active cell
    setCellValue(activeCell.col, activeCell.row, value);
  }

  private void setCellValue(int col, int row, int value) {
    // TODO - check that the active cell is enabled
    if ((value >= CELL_VALUE_MIN) && (value <= CELL_VALUE_MAX)) {
      if (isValidDigit(col, row, value)) {
        theGrid[col][row].setValue(value);

        if (value > 0) {
          // If the value is anything other than 0, slear the possibla values set
          theGrid[col][row].clearPossibleValues();
        } else {
          theGrid[col][row].initPossibleValues();
        }

        generatePossibleValuesSets();
      }
    }
  }

  public void reset() {
    // Set the value of all cells to 0
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        setCellValue(col, row, 0);
      }
    }
  }

  private void lookForSingleOccurancePosValCols() {
    // For every column, scan every cell's PossibleValues set to look for any
    // cells that have the only occurance of a value in that column, whose
    // PossibleValues set doesn't necessarily have only that value.

    println("**** Checking columns ****");

    for (int col = 0; col < theGrid.length; col++) {
      Map<Integer, Set<Integer>> cellsByPossibleValue =
          new HashMap<Integer, Set<Integer>>();

      println("For column " + col);
      for (int row = 0; row < theGrid[col].length; row++) {
        println("  For row " + row);
        if (theGrid[col][row].getValue() == 0) {
          for (Integer possibleValue : theGrid[col][row].possibleValues) {
            // Add this row to the map
            if (cellsByPossibleValue.containsKey(possibleValue)) {
              // A map entry for this possible value already exists, add this row to it
              Set<Integer> cellNumbers = cellsByPossibleValue.get(possibleValue);
              cellNumbers.add(row);
              println("    Adding row " + row + " to possible values map entry for " + possibleValue);
            } else {
              // Create a new set (the map's value) and add it to the map
              // for this possible value and row
              Set<Integer> cellNumbers = new HashSet<Integer>();
              cellNumbers.add(row);
              cellsByPossibleValue.put(possibleValue, cellNumbers);
              println("    Creating new set for possible value " + possibleValue +
                " and putting row " + row + " in it");
            }
            // println("Value: " + iterator.next() + " ");
          }
        }
      }

      // Look for any sets (the values) with only one entry.
      // that is the cell's only possible value
      for (Map.Entry<Integer, Set<Integer>> entry : cellsByPossibleValue.entrySet()) {
        if (entry.getValue().size() == 1) {
          for (Integer value : entry.getValue()) {
            setCellValue(col, value, entry.getKey());
            println("Row " + value + " has the only " + entry.getKey() + " in column " + col);
          }
        }
      }

    }

  }

  private void lookForSingleOccurancePosValRows() {
    // For every row, scan every cell's PossibleValues set to look for any
    // cells that have the only occurance of a value in that row, whose
    // PossibleValues set doesn't necessarily have only that value.

    println("**** Checking rows ****");

    for (int row = 0; row < theGrid[0].length; row++) {
      Map<Integer, Set<Integer>> cellsByPossibleValue =
          new HashMap<Integer, Set<Integer>>();

      println("For row " + row);
      for (int col = 0; col < theGrid.length; col++) {
        println("  For col " + col);
        if (theGrid[col][row].getValue() == 0) {
          for (Integer possibleValue : theGrid[col][row].possibleValues) {
            // Add this row to the map
            if (cellsByPossibleValue.containsKey(possibleValue)) {
              // A map entry for this possible value already exists, add this row to it
              Set<Integer> cellNumbers = cellsByPossibleValue.get(possibleValue);
              cellNumbers.add(col);
              println("    Adding col " + col + " to possible values map entry for " + possibleValue);
            } else {
              // Create a new set (the map's value) and add it to the map
              // for this possible value and col
              Set<Integer> cellNumbers = new HashSet<Integer>();
              cellNumbers.add(col);
              cellsByPossibleValue.put(possibleValue, cellNumbers);
              println("    Creating new set for possible value " + possibleValue +
                " and putting col " + col + " in it");
            }
            // println("Value: " + iterator.next() + " ");
          }
        }
      }

      // Look for any sets (the values) with only one entry.
      // that is the cell's only possible value
      for (Map.Entry<Integer, Set<Integer>> entry : cellsByPossibleValue.entrySet()) {
        if (entry.getValue().size() == 1) {
          for (Integer value : entry.getValue()) {
            setCellValue(value, row, entry.getKey());
            println("Column " + value + " has the only " + entry.getKey() + " in row " + row);
          }
        }
      }

    }

  }

  private void lookForSingleOccurancePosValMinorGrids() {
    // For every minor grid, scan every cell's PossibleValues set to look for any
    // cells that have the only occurance of a value in that minor grid, whose
    // PossibleValues set doesn't necessarily have only that value.

    println("**** Checking minor grids ****");

    for (int majorCol = 0; majorCol < minorGrids.length; majorCol++) {
      println("For major column " + majorCol);
      for (int majorRow = 0; majorRow < minorGrids[majorCol].length; majorRow++) {
        println("  For major row " + majorRow);
        Map<Integer, Set<Integer>> cellsByPossibleValue =
            new HashMap<Integer, Set<Integer>>();

        for (int col = 0; col < minorGrids[majorCol][majorRow].length; col++) {
          for (int row = 0; row < minorGrids[majorCol][majorRow][col].length; row++) {
            // Convert col (0 - 2) and row (0 - 2) to single digit index (0 - 8)
            int cellNum = col + (row * NUM_CELLS_MINOR);
            println("    For col, row, cellNum " + col + ", " + row + ", " + cellNum);
            println("      value = " + minorGrids[majorCol][majorRow][col][row].getValue());

            if (minorGrids[majorCol][majorRow][col][row].getValue() == 0) {
              for (Integer possibleValue : minorGrids[majorCol][majorRow][col][row].possibleValues) {
                // Add this cell to the map
                if (cellsByPossibleValue.containsKey(possibleValue)) {
                  // A map entry for this possible value already exists, add this row to it
                  Set<Integer> cellNumbers = cellsByPossibleValue.get(possibleValue);
                  cellNumbers.add(cellNum);
                  println("    Adding cellNum " + cellNum + " to possible values map entry for " + possibleValue);
                } else {
                  // Create a new set (the map's value) and add it to the map
                  // for this possible value and row
                  Set<Integer> cellNumbers = new HashSet<Integer>();
                  cellNumbers.add(cellNum);
                  cellsByPossibleValue.put(possibleValue, cellNumbers);
                  println("    Creating new set for possible value " + possibleValue +
                    " and putting cellNum " + cellNum + " in it");
                }
                // println("Value: " + iterator.next() + " ");
              }
            }

            // print(minorGrids[majorCol][majorRow][col][row].theValue + ", ");
          }
        }
        // Look for any sets (the values) with only one entry.
        // that is the cell's only possible value
        for (Map.Entry<Integer, Set<Integer>> entry : cellsByPossibleValue.entrySet()) {
          if (entry.getValue().size() == 1) {
            for (Integer value : entry.getValue()) {
              // Convert majorCol, majorRow and cellNum to col and row
              int minorCol = value % NUM_CELLS_MINOR;
              int minorRow = value / NUM_CELLS_MINOR;
              int col = (majorCol * NUM_CELLS_MINOR) + minorCol;
              int row = (majorRow * NUM_CELLS_MINOR) + minorRow;

              setCellValue(col, row, entry.getKey());
              println("Minor Grid column, row " + majorCol + ", " + majorRow + " has the only " +
                  entry.getKey() + " in cellNum " + value);
            }
          }
        }

      }
    }
  }

  private void lookForSingleOccurancePosValMajor() {
    // For every column and row, scan every cell's PossibleValues set to look for any
    // cells that have only one PossibleValues.

    println("**** Checking Major Grid ****");

    for (int col = 0; col < theGrid.length; col++) {
      println("For column " + col);
      for (int row = 0; row < theGrid[col].length; row++) {
        println("  For row " + row);
        if (theGrid[col][row].getValue() == 0) {
          if (theGrid[col][row].possibleValues.size() == 1) {
            for (Integer value : theGrid[col][row].possibleValues) {
              setCellValue(col, row, value);
              println("    Column, row " + col + ", " + row + " has only " + value + " as a possible value");
            }
          }
        }
      }
    }

  }

  public void solve() {
    int passes = 0;
    // Do until all cells are filled
    while (areAnyZeroValues()) {
      lookForSingleOccurancePosValCols();
      lookForSingleOccurancePosValRows();
      lookForSingleOccurancePosValMinorGrids();
      lookForSingleOccurancePosValMajor();
      passes++;
    }
    println("All done in " + passes + " passes!");
  }

  private boolean areAnyZeroValues() {
    boolean areAnyZeros = false;

    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        if (theGrid[col][row].getValue() == 0) {
          areAnyZeros = true;
          // break out of inner loop
          break;
        }
      }
      if (areAnyZeros) {
        // break out of outer loop
        break;
      }
    }
    return areAnyZeros;
  }

  private void generatePossibleValuesSets() {

    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {

        theGrid[col][row].initPossibleValues();

        // Check the value of the other cells in this column
        for (int i = 0; i < theGrid[col].length; i++) {
          if (i != row) {
            if (theGrid[col][i].getValue() > 0) {
              theGrid[col][row].removeNumFromPossValues(theGrid[col][i].getValue());
            }
          }
        }

        // Check the value of the other cells int this row
        for (int i = 0; i < theGrid.length; i++) {
          if (i != col) {
            if (theGrid[i][row].getValue() > 0) {
              theGrid[col][row].removeNumFromPossValues(theGrid[i][row].getValue());
            }
          }
        }

        // Check the values of the other cells in this minor grid
        int minorGridCol = col / NUM_CELLS_MINOR;
        int minorGridRow = row / NUM_CELLS_MINOR;
        int cellCol      = col % NUM_CELLS_MINOR;
        int cellRow      = row % NUM_CELLS_MINOR;

        for (int c = 0; c < minorGrids[minorGridCol][minorGridRow].length; c++) {
          for (int r = 0; r < minorGrids[minorGridCol][minorGridRow][c].length; r++) {
            if ((c == cellCol) && (r == cellRow))  {
              // Don't compare the cell in question with itself
            } else {
              int value = minorGrids[minorGridCol][minorGridRow][c][r].getValue();
              if (value > 0) {
                theGrid[col][row].removeNumFromPossValues(value);
              }
            }
          }
        }

      }
    }

  }

  private boolean isValidDigit(int col, int row, int value) {
    boolean isValid = true;
    // Check the value of the other cells in this column
    for (int i = 0; i < theGrid[col].length; i++) {
      if (i != row) {
        if ((theGrid[col][i].getValue() > 0) &&
            (value == theGrid[col][i].getValue())) {
          isValid = false;
          break;
        }
      }
    }

    // Check the value of the other cells in this row
    for (int i = 0; i < theGrid.length; i++) {
      if (i != col) {
        if ((theGrid[i][row].getValue() > 0) &&
            (value == theGrid[i][row].getValue())) {
          isValid = false;
          break;
        }
      }
    }

    // Check the values of the other cells in this minor grid
    int minorGridCol = col / NUM_CELLS_MINOR;
    int minorGridRow = row / NUM_CELLS_MINOR;
    int cellCol      = col % NUM_CELLS_MINOR;
    int cellRow      = row % NUM_CELLS_MINOR;

    for (int c = 0; c < minorGrids[minorGridCol][minorGridRow].length; c++) {
      for (int r = 0; r < minorGrids[minorGridCol][minorGridRow][c].length; r++) {
        if ((c == cellCol) && (r == cellRow))  {
          // Don't compare the cell in question with itself
        } else {
          if ((minorGrids[minorGridCol][minorGridRow][c][r].getValue() > 0) &&
              (value == minorGrids[minorGridCol][minorGridRow][c][r].getValue())) {
            isValid = false;
            // break out of inner for loop
            break;
          }
        }
      }

      if (!isValid) {
        // break out of outer for loop
        break;
      }
    }

    return isValid;

  }

  public void setActiveCell(int col, int row) {
    theGrid[activeCell.col][activeCell.row].setActive(false);

    activeCell.col = int(col / cellSize.x);
    activeCell.row = int(row / cellSize.y);

    theGrid[activeCell.col][activeCell.row].setActive(true);
  }

  public void setActiveCell(CellDirection cellDir) {

    // Make the current active cell not active
    theGrid[activeCell.col][activeCell.row].setActive(false);

    // Find the new active cell and set it active
    switch (cellDir) {
      case UP:
        if (activeCell.row > 0) {
          activeCell.row--;
        } else {
          // In top row
          if (activeCell.col > 0) {
            activeCell.col--;
            activeCell.row = NUM_CELLS_MAJOR - 1;
          } else {
            // In top left cell

          }
        }
        break;
      case DOWN:
        if (activeCell.row < NUM_CELLS_MAJOR - 1) {
          activeCell.row++;
        } else {
          // In bottom row
          if (activeCell.col < NUM_CELLS_MAJOR - 1) {
            activeCell.col++;
            activeCell.row = 0;
          } else {
            // In bottom right cell

          }
        }
        break;
      case LEFT:
        if (activeCell.col > 0) {
          activeCell.col--;
        } else {
          // In left column
          if (activeCell.row > 0) {
            activeCell.row--;
            activeCell.col = NUM_CELLS_MAJOR - 1;
          } else {
            // In top left cell

          }
        }
        break;
      case RIGHT:
        if (activeCell.col < NUM_CELLS_MAJOR - 1) {
          activeCell.col++;
        } else {
          // In right column
          if (activeCell.row < NUM_CELLS_MAJOR - 1) {
            activeCell.row++;
            activeCell.col = 0;
          } else {
            // In bottom right cell

          }
        }
        break;
    }

    // println("Setting cell active: " + activeCell.row + ", " + activeCell.col);
    theGrid[activeCell.col][activeCell.row].setActive(true);
  }

  void drawGrid() {
    float cellWidth = width / 9.0;

    background(Colors.WHITE_GREY_SCL);  //
    stroke(Colors.BLACK_GREY_SCL);

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

  public void incCellTextSize() {
    if (cellTextSize < CELL_TEXT_SIZE_MAX) {
      cellTextSize += 2;
      setCellTextSize();
      println("Text size = " + cellTextSize);
    }
  }

  public void decCellTextSize() {
    if (cellTextSize > CELL_TEXT_SIZE_MIN) {
      cellTextSize -= 2;
      setCellTextSize();
      println("Text size = " + cellTextSize);
    }
  }

  private void setCellTextSize() {
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        theGrid[col][row].setTextSize(cellTextSize);
      }
    }
  }

  private void printGrid() {
    // Fill the arrays with test data
    for (int col = 0; col < theGrid.length; col++) {
      for (int row = 0; row < theGrid[col].length; row++) {
        theGrid[col][row].theValue = col + (row * 10);
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
    // for (int col = 0; col < columns.length; col++) {
    //   print("Data as columns: ");
    //   for (int row = 0; row < columns[col].length; row++) {
    //     print(columns[col][row].theValue + ", ");
    //   }
    //   println();
    // }
    // println();

    // Print the grid by row
    // for (int row = 0; row < rows.length; row++) {
    //   print("Data as rows: ");
    //   for (int col = 0; col < rows[row].length; col++) {
    //     print(rows[row][col].theValue + ", ");
    //   }
    //   println();
    // }
    // println();

    // Print the whole grid as the grid of grids
    println("Data as a grid of grids: ");
    for (int majorCol = 0; majorCol < minorGrids.length; majorCol++) {
      println("  Data as major cols: ");
      for (int majorRow = 0; majorRow < minorGrids[majorCol].length; majorRow++) {
        println("    Data as major rows: ");
        for (int col = 0; col < minorGrids[majorCol][majorRow].length; col++) {
          print("      Data as rows: ");
          for (int row = 0; row < minorGrids[majorCol][majorRow][col].length; row++) {
            print(minorGrids[majorCol][majorRow][row][col].theValue + ", ");
          }
          println();
        }
        println();
      }
      println();
    }
    println();

    println("Possible values = " + theGrid[0][0].possibleValues);
    if (theGrid[0][0].possibleValues.contains(8)) {
      theGrid[0][0].possibleValues.remove(8);
    }
    println("Possible values = " + theGrid[0][0].possibleValues);

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

    // Iterator<Integer> iterator = theGrid[0][0].possibleValues.iterator();
    // check values
    // while (iterator.hasNext()) {
      //if (iterator.next() == 4) {
      //  rows[0][0].possibleValues.remove();
      //}
    //   println("Value: " + iterator.next() + " ");
    // }
  }

  class GridCoords {
    int col;
    int row;

    GridCoords(int c, int r) {
      col = c;
      row = r;
    }
  }

}
