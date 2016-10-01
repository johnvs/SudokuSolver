
class Cell {

  private int theValue = 0;
  private boolean isLocked = false;
  Set<Integer> possibleValues;

  Cell() {
    possibleValues = new HashSet<Integer>(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));
  }

}
