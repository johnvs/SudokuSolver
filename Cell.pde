
import java.util.Arrays;
import java.util.Set;
import java.util.HashSet;

class Cell {

  private float textAscentScale = 0.76;
  private int theValue = 0;
  private boolean isLocked = false;
  private int theHue = Colors.HUE_MIN;
  // private color theColor;
  private Set<Integer> possibleValues;
  private PVector center;
  private boolean isActive;
  private int textSize;

  public Cell(int x, int y, int txSz) {
    possibleValues = new HashSet<Integer>(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));
    center = new PVector(x, y);
    textSize = txSz;
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
      ellipse(center.x, center.y, width / 9, width / 9);
      // println("Center = " + center.x + ", " + center.y);
    }

    if (theValue > 0) {
      fill(color(theHue, Colors.SAT_MAX, Colors.BRIGHT_MAX));
      // println("displaying cell value " + theValue + " at x, y: " + center.x + ", " + center.y);
      String numString = str(theValue);
      textSize(textSize);
      float numStringWidth = textWidth(numString);
      float numStringAscent = textAscent() * textAscentScale;
      // println("numString = " + numString);
      text(numString, (center.x - numStringWidth / 2), center.y + (numStringAscent / 2));

      // noFill();
      // rect((center.x - numStringWidth / 2), center.y - (numStringAscent / 2),
      //       numStringWidth, numStringAscent);
      // text(numString, center.x, center.y);
    } else {
    }
  }

  // public void display(int h)  {
  //   // TODO - do something with h
  //   _display();
  // }

}
