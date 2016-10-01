
class Cell {

  private int theValue = 0;
  private boolean isLocked = false;
  private int theHue;
  private Set<Integer> possibleValues;
  private PVector center;
  private boolean isActive;
  private int textSize;

  public Cell(int x, int y) {
    possibleValues = new HashSet<Integer>(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));
    center = new PVector(x, y);
  }

  public void setHue(int h) {
    theHue = h;
  }

  public void setActive(boolean isAct) {
    isActive = isAct;
  }

  public void setValue(int value) {
    theValue = value;
  }

  public int getValue() {
    return theValue;
  }

  public void setTextSize(int txtSize)  {
      textSize = txtSize;
  }

  // public void display(int txtSize)  {
  //     textSize(txtSize);
  //     display();
  // }

  public void display() {

    stroke(color(theHue, Colors.SAT_MAX, Colors.BRIGHT_MAX));

    if (isActive) {
      ellipse(center.x, center.y, width / 9, width / 9);
      // println("Center = " + center.x + ", " + center.y);
    }

    if (theValue > 0) {
      // stroke(color(theHue, Colors.SAT_MAX, Colors.BRIGHT_MAX));
      String numString = str(theValue);
      textSize(textSize);
      float numStringWidth = textWidth(numString);
      float numStringAscent = textAscent();
      text(numString, (center.x - numStringWidth / 2), center.y + (numStringAscent / 2));
    } else {
    }
  }

  // public void display(int h)  {
  //   // TODO - do something with h
  //   _display();
  // }

}
