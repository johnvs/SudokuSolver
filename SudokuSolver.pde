
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
          theGrid.moveActiveCell(CellDirection.UP);
        }
        break;
      case DOWN:
        if (modifierKeys.get("Command")) {
          // println("CMD+1 was pressed.");
          theGrid.decCellTextSize();
        } else {
          // Change which cell is active
          theGrid.moveActiveCell(CellDirection.DOWN);
        }
        break;
      case LEFT:
        if (modifierKeys.get("Command")) {
          // println("CMD+1 was pressed.");
        } else {
          // Change which cell is active
          theGrid.moveActiveCell(CellDirection.LEFT);
        }
        break;
      case RIGHT:
        if (modifierKeys.get("Command")) {
          // println("CMD+1 was pressed.");
        } else {
          // Change which cell is active
          theGrid.moveActiveCell(CellDirection.RIGHT);
        }
        break;

    }
  } else {
    switch (key) {
      case '1':
        if (modifierKeys.get("Command")) {
          // println("CMD+1 was pressed.");
        }
        break;
      case '2':
        if (modifierKeys.get("Command")) {
          // println("CMD+2 was pressed.");
        }
        break;
      case '3':
        if (modifierKeys.get("Command")) {
          // println("CMD+3 was pressed.");
        }
        break;
      case '4':
        if (modifierKeys.get("Command")) {
          // println("CMD+4 was pressed.");
        }
        break;
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
