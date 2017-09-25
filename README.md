# Sudoku Solver
<!-- ============= -->

This is a Processing sketch that solves Sudoku puzzles. Currently, it only does what I call the first phase, a simple analysis of all the cells' Possible Values. This phase is executed in as many passes are required to solve the puzzle or determine that it can't be solved by this phase alone.

I plan to add a second phase that will traverse a tree of all the grid's Possible Values, performing the first phase check after each possible value is selected from a cell's PV array.

### Keyboard Commands
| Key | Action |
| --- | ------ |
| Up Arrow | Move the cursor to the cell above the current cell. |
| Down Arrow | Move the cursor to the cell below the current cell. |
| Left Arrow | Move the cursor to the cell to the left of the current cell. |
| Right Arrow | Move the cursor to the cell to the left of the current cell. |
| 0 - 9 | Enter digit into cell. 0 clears the current value if there is one. |
| r | Reset the grid |
| s | Solve the puzzle |
| d | Toggle debug mode |
| CMD+Up Arrow | Increase size of cell text. |
| CMD+Down Arrow | Decrease size of cell text. |


<!-- [johnvanstrien.com](http://johnvanstrien.com) -->
