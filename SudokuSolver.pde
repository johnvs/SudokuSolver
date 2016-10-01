
import java.util.Set;
import java.util.HashSet;
import java.util.Arrays;
import java.util.Iterator;

boolean isDebugMode = false;

void setup() {
  size(750, 750);

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
