
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


  }

}
