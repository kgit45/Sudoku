/********************************************************
 * Sudoku 1.0
 * by Kendall Copp
 * Project started: 7/30/2020
 *
 * Instructions:
 * left mouse to increment
 * right mouse to decrement
 * center wheel button to erase
 *
 * increase number of puzzles
 * puzzle select
 * add achievements
 * add hints
 * break program into modules as this one file is too long
*********************************************************/

PShape square; //pshape objects
PShape lock;
PShape hline;
PShape vline;
PShape button;
PShape completeMessageBox;
String numbers = " 123456789";

int mode = 0; //0 = menu, 1 = puzzle

String instructionsText[] = {"Fill each row, column, and 3x3 box with the",
                              "numbers 1-9",
                              "Left click to increment",
                              "Right click to decrement",
                              "Center button/scroll wheel to erase"};

//allocate storage for board memory
/*int board[][] = { {5,6,0,8,4,7,0,0,0},
                  {3,0,9,0,0,0,6,0,0},
                  {0,0,8,0,0,0,0,0,0},
                  {0,1,0,0,8,0,0,4,0},
                  {7,9,0,6,0,2,0,1,8},
                  {0,5,0,0,3,0,0,9,0},
                  {0,0,0,0,0,0,2,0,0},
                  {0,0,6,0,0,0,8,0,7},
                  {0,0,0,3,1,6,0,5,9} };*/
int board[][] = { {5,4,6,0,7,8,1,0,0},
                  {3,0,9,2,6,1,5,7,4},
                  {2,0,1,5,0,0,0,8,0},
                  {9,2,4,0,0,0,8,6,0},
                  {8,1,3,7,9,6,2,4,5},
                  {0,0,7,0,0,2,3,0,0},
                  {7,3,5,8,1,0,9,0,6},
                  {4,6,0,9,2,0,7,0,1},
                  {0,9,0,0,5,7,4,3,8} };
int workingBoard[][] = { {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0} };
int locks[][] = { {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0},
                  {0,0,0,0,0,0,0,0,0} };
                  
int completeRows[] = {0,0,0,0,0,0,0,0,0}; //keep track of completion progress
int completeColumns[] = {0,0,0,0,0,0,0,0,0}; 
int completeBoxes[] = {0,0,0,0,0,0,0,0,0}; 
int rowsComplete = 0;
int columnsComplete = 0;
int boxesComplete = 0;
int puzzleComplete = 0;

void draw() {} //required for code to work

void setup() {
  size(500, 575); //canvas size
  
  //define shape properties
  square = createShape(RECT, 0, 0, 50, 50);
  square.setFill(color(255, 255, 255));
  square.setStroke(color(0, 0, 0));
  
  lock = createShape(RECT, 0, 0, 50, 50);
  lock.setFill(color(200, 200, 255));
  lock.setStroke(color(0, 0, 0));
  
  hline = createShape(RECT, 0, 0, 452, 3);
  hline.setFill(color(0, 0, 0));
  hline.setStroke(color(0, 0, 0));
  
  vline = createShape(RECT, 0, 0, 3, 452);
  vline.setFill(color(0, 0, 0));
  vline.setStroke(color(0, 0, 0));
  
  button = createShape(RECT, 0, 0, 200, 50);
  button.setFill(color(200, 200, 200));
  button.setStroke(color(0, 0, 0));
  
  completeMessageBox = createShape(RECT, 0, 0, 300, 200);
  completeMessageBox.setFill(color(200, 255, 200));
  completeMessageBox.setStroke(color(0, 0, 0));
  
  doMenu();
  
}

void doMenu() {
  //create menu
  background(255); //white background
  textSize(64);
  fill(0, 0, 0);
  text("Sudoku!", 125, 150);
  shape(button, 150, 200);
  shape(button, 150, 275);
  textSize(32);
  text("Start", 213, 235);
  text("How to Play", 160, 310);
  textSize(12);
  text("v1.0 by Kendall Copp", 190, 400);
}

void doPuzzle() { //draw the puzzle
  int i, j;
  for (i = 0; i < 9; i++){
    for (j = 0; j < 9; j++){
      if (locks[i][j] == 0) {
        workingBoard[i][j] = board[i][j];
      }
    }
  }
  background(255); //white background
  createLocks();
  updateBoard();
  shape(button, 25, 500); 
  shape(button, 275, 500);
  textSize(32);
  fill(0, 0, 0);
  text("Menu", 80, 535);
  text("Restart", 320, 535);
}

void doInstructions() { 
  int i;
  background(255); //white background
  shape(button, 25, 500); 
  textSize(32);
  fill(0, 0, 0);
  text("Menu", 80, 535);
  text("Instructions:", 25, 50);
  textSize(20);
  for (i = 0; i < 5; i++) {
    if (i == 1) {
      text(instructionsText[i], 25, 125);
    }
    else {
      text(instructionsText[i], 25, 100 + 50*i);
    }
  }
}

void mousePressed(){
  if(mode == 0) { //menu mode
     if (mouseX > 150 && mouseX < 350) {
       if (mouseY > 200 && mouseY < 250) {
         mode = 1;
         doPuzzle();
       }
       else if (mouseY > 275 && mouseY < 325) {
         mode = 2;
         doInstructions();
       }
       else {}
     }
     else {}
  }
  else if (mode == 2) { //instructions mode
    if(mouseY > 500 && mouseY < 550) {
      if (mouseX > 25 && mouseX < 225) {
        mode = 0;
        doMenu();
      }
      else {}
    }
  }
  else if (mode == 3) { //win message mode
    if (mouseX > 150 && mouseX < 350) {
      if (mouseY > 275 && mouseY < 325) {
        mode = 0;
        doMenu();
      }
      else{
      }
    }
    else{
    }
  }
  else { //puzzle mode
    if (mouseX > 25 && mouseX < 475) {
      if (mouseY > 25 && mouseY < 475) {
        
        //increment numbers
        int boardx = (mouseX-25)/50;
        int boardy = (mouseY-25)/50;
        
        if (mouseButton == LEFT) {
          if(locks[boardx][boardy] != 1) {
            workingBoard[boardx][boardy] += 1;
          }
        }
        else if (mouseButton == RIGHT) {
          if(locks[boardx][boardy] != 1) {
            workingBoard[boardx][boardy] -= 1;
          }
        }
        else if (mouseButton == CENTER) {
          if(locks[boardx][boardy] != 1) {
            workingBoard[boardx][boardy] = 0;
          }
        }
        updateBoard();
        checkBoard(); 
      }
      if(mouseY > 500 && mouseY < 550) {
        if (mouseX > 25 && mouseX < 225) {
          mode = 0;
          doMenu();
        }
        else if (mouseX > 275 && mouseX < 475) {  
          //doResetWarning();
          doPuzzle();
        }
        else {} //do nothing
      }
    }
  }
}

void createLocks() {
  int i, j;
  for(i = 0; i < 9; i++) {
    for( j = 0; j < 9; j++) {
      if (board[i][j] == 0) {
        locks[i][j] = 0;
      }
      else {
        locks[i][j] = 1;
      }
    }
  }
}

void checkBoard(){
  int i, j, k, x;
  int l = 0, lIncremented = 0;
  int dummySection[] = {0,0,0,0,0,0,0,0,0};

  //CHECK ROWS, COLUMNS, AND BOXES
  for(x = 0; x < 3; x++) {

    for(k = 0; k < 9; k++) { //for all 9 rows, columns, and boxes
      l = 0; //reinitialize counter
      
      //Put row, column, or box into dummy 
      if (x == 0) { //get row into dummy 
        for(i = 0; i < 9; i++) { 
          dummySection[i] = workingBoard [i][k];
        }
      }
      else if (x == 1) { //get column into dummy
        for(i = 0; i < 9; i++) { 
          dummySection[i] = workingBoard [k][i];
        }
      }
      else { //get box into dummy
        for(i = 0; i < 3; i++) { 
          for(j = 0; j < 3; j++) {   
            if (k == 0) {
              dummySection[i*3+j] = workingBoard[i+0][j+0];
            }
            else if (k == 1) {
              dummySection[i*3+j] = workingBoard[i+3][j+0];
            }
            else if (k == 2) {
              dummySection[i*3+j] = workingBoard[i+6][j+0];
            }
            else if (k == 3) {
              dummySection[i*3+j] = workingBoard[i+0][j+3];
            }
            else if (k == 4) {
              dummySection[i*3+j] = workingBoard[i+3][j+3];
            }
            else if (k == 5) {
              dummySection[i*3+j] = workingBoard[i+6][j+3];
            }
            else if (k == 6) {
              dummySection[i*3+j] = workingBoard[i+0][j+6];
            }
            else if (k == 7) {
              dummySection[i*3+j] = workingBoard[i+3][j+6];
            }
            else {
              dummySection[i*3+j] = workingBoard[i+6][j+6];
            }          
          }
        }
      }
      
      //for(i = 0; i < 9; i++) {
      //  print(dummySection[i]);
      //  print(", ");
      //}
      //println(" ");
        
      //check dummy for 9 different numbers
      for (i = 0; i < 9; i++) {
        for(j = 0; j < 9; j++) {
          if(dummySection[j] == 9 && lIncremented == 0){
            l += 1;
            lIncremented = 1;
          }
        }
        for(j = 0; j < 9; j++) { //increment all values
          dummySection[j] += 1;
        }
        lIncremented = 0;
      }
      
      //log complete rows, columns, and boxes
      if (x == 0) { //update comlpete rows
        if(l == 9) {
          completeRows[k] = 1;
        }
        else {
          completeRows[k] = 0;
        }
      }
      else if (x == 1) { //update comlpete columns
        if(l == 9) {
          completeColumns[k] = 1;
        }
        else {
          completeColumns[k] = 0;
        }
      }
      else { //update complete boxes
        if(l == 9) {
          completeBoxes[k] = 1;
        }
        else {
          completeBoxes[k] = 0;
        }
      }
      
      //check puzzle for completion
      rowsComplete = 0;
      for(i = 0; i < 9; i++){
        if (completeRows[i] == 1) {
          rowsComplete++;
        }
      }
      columnsComplete = 0;
      for(i = 0; i < 9; i++){
        if (completeColumns[i] == 1) {
          columnsComplete++;
        }
      }
      boxesComplete = 0;
      for(i = 0; i < 9; i++){
        if (completeBoxes[i] == 1) {
          boxesComplete++;
        }
      }
      
      //DEBUG TEXT
      ////print completed rows, columns, and boxes
      //print("Complete Rows: ");
      //for( i = 0; i < 9; i++) {
      //  print(completeRows[i]);
      //  print(", ");
      //}
      //println(" ");
      //print("Complete Columns: ");
      //for( i = 0; i < 9; i++) {
      //  print(completeColumns[i]);
      //  print(", ");
      //}
      //println(" ");
      //print("Complete Boxes: ");
      //for( i = 0; i < 9; i++) {
      //  print(completeBoxes[i]);
      //  print(", ");
      //}
      //println(" ");
      //print("RC: ");
      //print(rowsComplete);
      //println(" ");
      //print("CC: ");
      //print(columnsComplete);
      //println(" ");
      //print("BC: ");
      //println(boxesComplete);
    }
  }
  
  //check win condition
  if(rowsComplete == 9 && columnsComplete == 9 && boxesComplete == 9) {
    mode = 3;    
    displayWinMessage();
        
  }
}


void updateBoard() {
  int i, j;
  for (i = 0; i < 9; i++) {
    for (j = 0; j < 9; j++) {
      if (locks[i][j] == 0) {
        shape(square, 25+50*i, 25+50*j);
      }
      else {
        shape(lock, 25+50*i, 25+50*j);
      }
    }
  }
  for (i = 0; i < 4; i++) {
    shape(hline, 24, 24+150*i); 
  }
  for (i = 0; i < 4; i++) {
    shape(vline, 24+150*i, 24); 
  }
  textSize(32);
  fill(0, 0, 0);
  for (i = 0; i < 9; i++) {
    for (j = 0; j < 9; j++) {
      if(workingBoard[i][j] > 9) {
        workingBoard[i][j] = 0;
      }
      else if(workingBoard[i][j] < 0) {
        workingBoard[i][j] = 9;
      }
      text(numbers.charAt(workingBoard[i][j]), 41 + 50*i, 63 + 50*j); 
    }
  }
}

void displayWinMessage() {
  shape(completeMessageBox, 100, 150);
  shape(button, 150, 275);
  textSize(52);
  fill(0, 0, 0);
  text("Success!", 150, 225);
  textSize(32);
  text("Menu", 205, 310);
  textSize(20);
  text("Puzzle complete!", 175, 255);
}
