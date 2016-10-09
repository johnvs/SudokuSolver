
/*
  pseudo code for solving algorithm
  1. For every cell, generate it's PossibleValues set
      During this process, if any cell ends up with only one possible value,
      make that the cell's value

  2. For every minor grid, scan every cell's PossibleValues set to look for any cells
      that have the only occurance of a value in that minor grid. (whose PossibleValues
      set doesn't necessarily have only that value.)

      For example, minor grid 8, cell 1, it's first pass PossibleValues set is:
        2,3,6,7,9

      though it is the only cell in that minor grid with a possible value of 7

      For example,
      Minor grid x, y
        Cell number  Possible values
        0            *2 (* = value is already assigned to that cell, theValue > 0)
        1            3,6,8,9
        2            *5
        3            3,4
        4            3,4,9
        5            1,3,4,9
        6            4,6
        7            4,6,8,9
        8            *7

        Possible values  Cells with that value
        1                5
        2                -1 (meaning that the value is already assigned to a cell)
        3                1,3,4,5
        4                3,4,5,6,7
        5                -1
        6                1,6,7
        7                -1
        8                1,7
        9                1,4,5,7

          Note: -1 = the value has been assigned, so theValue > 0, and there are no

  3. For every minor grid column and row, for every cell with a non-0 value, look for
      that value in the other minor grids in that column or row.

*/


import java.util.Set;
import java.util.HashSet;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;
import java.util.HashMap;
import java.awt.event.KeyEvent;

boolean isDebugMode = false;

TheGrid theGrid;

Map<String, Boolean> modifierKeys;
final int VK_COMMAND = 157;

void setup() {
  size(750, 750);
  colorMode(HSB, Colors.HUE_MAX, Colors.SAT_MAX, Colors.BRIGHT_MAX);
  ellipseMode(CENTER);

  theGrid = new TheGrid();

  modifierKeys = new HashMap<String, Boolean>(3);
  modifierKeys.put("Control", false);
  modifierKeys.put("Alt", false);
  modifierKeys.put("Command", false);
}

void draw() {

  theGrid.update();
  theGrid.display();

  if (isDebugMode) {
  }
}

void mousePressed() {
  theGrid.setActiveCell(mouseX, mouseY);
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
      case KeyEvent.VK_CONTROL:
        modifierKeys.put("Control", true);
        // println("CONTROL pressed");
        break;
      case KeyEvent.VK_ALT:
        modifierKeys.put("Alt", true);
        // println("ALT pressed");
        break;
      case VK_COMMAND:
        modifierKeys.put("Command", true);
        // println("COMMAND pressed");
        break;
      case UP:
        if (modifierKeys.get("Command")) {
          // println("CMD+1 was pressed.");
          theGrid.incCellTextSize();
        } else {
          // Change which cell is active
          theGrid.setActiveCell(CellDirection.UP);
        }
        break;
      case DOWN:
        if (modifierKeys.get("Command")) {
          // println("CMD+1 was pressed.");
          theGrid.decCellTextSize();
        } else {
          // Change which cell is active
          theGrid.setActiveCell(CellDirection.DOWN);
        }
        break;
      case LEFT:
        if (modifierKeys.get("Command")) {
          // println("CMD+1 was pressed.");
        } else {
          // Change which cell is active
          theGrid.setActiveCell(CellDirection.LEFT);
        }
        break;
      case RIGHT:
        if (modifierKeys.get("Command")) {
          // println("CMD+1 was pressed.");
        } else {
          // Change which cell is active
          theGrid.setActiveCell(CellDirection.RIGHT);
        }
        break;

    }
  } else {
    if ((key >= '0') && (key <='9')) {
      if (modifierKeys.get("Command")) {
        // println("CMD+1 was pressed.");
      } else {
        theGrid.setCellValue(Character.getNumericValue(key));
      }

    }
    switch (key) {
      case 's':
        if (modifierKeys.get("Command")) {
          // println("CMD+s was pressed.");
        } else {
        }
        break;
      case 'd':
      case 'D':
        isDebugMode = !isDebugMode;
        break;
      case 'b':
      case 'B':
        break;
      case ' ':
        break;

    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch(keyCode) {
      case KeyEvent.VK_CONTROL:
        modifierKeys.put("Control", false);
        // println("CONTROL released");
        break;
      case KeyEvent.VK_ALT:
        modifierKeys.put("Alt", false);
        // println("ALT released");
        break;
      case VK_COMMAND:
        modifierKeys.put("Command", false);
        // println("COMMAND released");
        break;
    }
  }
}
