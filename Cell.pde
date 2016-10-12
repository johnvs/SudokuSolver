import java.awt.Color;
import java.util.Arrays;
import java.util.Set;
import java.util.HashSet;

class Cell {

  private final float TEXT_ASCENT_SCALE = 0.76;
  private final float POSS_VAL_TEXT_SIZE_SCALE = 0.3;
  private final int POSS_VALUE_GRID_SIZE = 3;

  private int theValue = 0;
  private boolean isLocked = false;
  private int theHue = Colors.HUE_MIN;
  private int possValuesHue = Colors.HUE_BLUE;
  private Set<Integer> possibleValues;
  private PVector center;
  private int cellWidth;
  private boolean isActive;
  private int textSize;

  public Cell(int x, int y, int w, int txSz) {
    possibleValues = new HashSet<Integer>(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));
    center = new PVector(x, y);
    cellWidth = w;
    textSize = txSz;
  }

  public void removeNumFromPossValues(int value) {
    possibleValues.remove(value);
  }

  public void clearPossibleValues() {
    // Clear the set and add -1 to indicate that theValue is valid
    possibleValues.clear();
    possibleValues.add(-1);
  }

  public void initPossibleValues() {
    possibleValues.clear();
    for (int i = 1; i <= 9; i++) {
      possibleValues.add(i);
    }
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

    // stroke(color(theHue, Colors.SAT_MAX, Colors.BRIGHT_MAX));

    if (isActive) {
      stroke(Colors.BLACK_GREY_SCL);
      noFill();
      ellipse(center.x, center.y, cellWidth, cellWidth);
      // println("Center = " + center.x + ", " + center.y);
    }

    if (theValue > 0) {
      // Draw the cell's value
      fill(color(theHue, Colors.SAT_MAX, Colors.BRIGHT_MAX));
      // println("displaying cell value " + theValue + " at x, y: " + center.x + ", " + center.y);
      String numString = str(theValue);
      textSize(textSize);
      float numStringWidth = textWidth(numString);
      float numStringAscent = textAscent() * TEXT_ASCENT_SCALE;
      // println("numString = " + numString);
      text(numString, (center.x - numStringWidth / 2), center.y + (numStringAscent / 2));

      // noFill();
      // rect((center.x - numStringWidth / 2), center.y - (numStringAscent / 2),
      //       numStringWidth, numStringAscent);
      // text(numString, center.x, center.y);
    } else {
      // Draw the cell's PossibleValues set
      int index = 0;
      int cellX = int(center.x - cellWidth / 2);
      int cellY = int(center.y - cellWidth / 2);
      float cellWidthOneSixth = float(cellWidth) / 6;
      float cellWidthOneThird = float(cellWidth) / 3;
      int textSizePosVal = int(textSize * POSS_VAL_TEXT_SIZE_SCALE);

      for (Integer possibleValue : possibleValues) {
        // Draw each value in the set
        int col = index % POSS_VALUE_GRID_SIZE;
        int row = index / POSS_VALUE_GRID_SIZE;
        int x = int(cellX + cellWidthOneSixth + (cellWidthOneThird * col));
        int y = int(cellY + cellWidthOneSixth + (cellWidthOneThird * row));

        fill(color(possValuesHue, Colors.SAT_MAX, Colors.BRIGHT_MAX));
        // println("displaying cell value " + theValue + " at x, y: " + center.x + ", " + center.y);
        String numString = str(possibleValue);
        textSize(textSizePosVal);
        float numStringWidth = textWidth(numString);
        float numStringAscent = textAscent() * TEXT_ASCENT_SCALE;
        // println("numString = " + numString);
        text(numString, (x - numStringWidth / 2), y + (numStringAscent / 2));
        index++;
        // println("Value: " + iterator.next() + " ");
      }

    }
  }

}
