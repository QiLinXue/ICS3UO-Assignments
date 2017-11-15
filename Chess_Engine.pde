//{alive=1/dead=0 , white=1/black=-1 , xLocation, yLocation, pieceValue}
float[][] firstBoard = {

  //White Pieces
  {1,1,1,2,1},{1,1,2,2,1},{1,1,3,2,1},{1,1,4,2,1},{1,1,5,2,1},{1,1,6,2,1},{1,1,7,2,1},{1,1,8,2,1},
  {1,1,1,1,5},{1,1,2,1,3},{1,1,3,1,3},{1,1,4,1,9},{1,1,5,1,5000},{1,1,6,1,3},{1,1,7,1,3},{1,1,8,1,5},

  //Black Pieces
  {1,-1,1,8,5},{1,-1,2,8,3},{1,-1,3,8,3},{1,-1,4,8,9},{1,-1,5,8,5000},{1,-1,6,8,3},{1,-1,7,8,3},{1,-1,8,8,5},
  {1,-1,1,7,1},{1,-1,2,7,1},{1,-1,3,7,1},{1,-1,4,7,1},{1,-1,5,7,1},{1,-1,6,7,1},{1,-1,7,7,1},{1,-1,8,7,1},

};



/*float[][] firstBoard = {

  //White Pieces
  {0,1,1,2,1},{0,1,2,2,1},{0,1,3,2,1},{0,1,4,2,1},{0,1,5,2,1},{0,1,6,2,1},{0,1,7,2,1},{0,1,8,2,1},
  {0,1,1,1,5},{0,1,2,1,3},{1,1,4,4,3},{0,1,4,1,9},{0,1,5,1,0},{0,1,6,1,3},{0,1,7,1,3},{0,1,8,1,5},

  //Black Pieces
  {0,-1,1,8,5},{0,-1,2,8,3},{0,-1,3,8,3},{0,-1,4,8,9},{0,-1,5,8,0},{0,-1,6,8,3},{0,-1,7,8,3},{0,-1,8,8,5},
  {0,-1,1,7,1},{0,-1,2,7,1},{0,-1,3,7,1},{0,-1,4,7,1},{0,-1,5,7,1},{0,-1,6,7,1},{0,-1,7,7,1},{0,-1,8,7,1},

};*/



int[] pieceSelected = {0,0}; //Placeholder numbers
int startxco, startyco, endxco, endyco; //Coordinates of the start and finish when moving a piece
int selectedPieceNumber; //The number coresponding to each piece (0-31)
int turnNumber = 1; //1=white; 2=black;
int currentStance = 0; //0=Select Piece; 1=move piece;
String pieceName; //stores the piece name (P,R,N,B,Q,K)


void setup(){}

void settings(){
  size(1200,1200);}


void draw(){

  //Creates the 8x8 gridlines
  for(int i=0;i<width;i+=width/8){
    for(int j=0;j<height;j+=height/8){
      rect(i,j,width/8,height/8);
    }
  }

  //Places all the pieces onto the board
  for(int i=0;i<32;i++){
    place(i);
  }

}

//Creates the board evaluation
float evaluate(float[][] typeBoard){
  float evaluation = 0;
  if(isCheckmate()){
    evaluation = 9999;
  }
  else{
    for(int i=0; i<32; i++){
        evaluation = evaluation + typeBoard[i][0]*typeBoard[i][1]*typeBoard[i][4];
        if((i < 8 || i > 23) && (typeBoard[i][2] == 4 || typeBoard[i][2] == 5) && (typeBoard[i][3] == 4 || typeBoard[i][3] == 5)){
          evaluation = evaluation + typeBoard[i][0]*typeBoard[i][1]*0.25;
        }
        //        9/14/17/22

        if((i == 9 || i == 14 || i == 17 || i == 22) && (typeBoard[i][2] == 1 || typeBoard[i][2] == 8)){
          evaluation = evaluation + typeBoard[i][0]*typeBoard[i][1]*(-0.1);
        }

        if(
          i < 8
         && ((
            exists(typeBoard, int(typeBoard[i][2] + 1),int(typeBoard[i][3]) - 1)[0] == 1
            && exists(typeBoard, int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 1))[1] < 8)
         || (exists(typeBoard, int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 1))[0] == 1
            && exists(typeBoard, int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 1))[1] < 8))){
            evaluation = evaluation + typeBoard[i][0]*typeBoard[i][1]*(0.1);

         }

         if(
           i > 23
           && ((
              exists(typeBoard, int(typeBoard[i][2] + 1),int(typeBoard[i][3]) + 1)[0] == 1
              && exists(typeBoard, int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 1))[1] > 23)
           || (exists(typeBoard, int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 1))[0] == 1
              && exists(typeBoard, int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 1))[1] > 23))){
              evaluation = evaluation + typeBoard[i][0]*typeBoard[i][1]*(0.1);

           }


    }


  }

  return evaluation;}

//Checks if King is checkmates
boolean isCheckmate(){
  return false;}

//For the input piece number, it will plot the piece on the graph
void place(int pieceNum){
  if(firstBoard[pieceNum][0] == 1){
    if(pieceNum <= 7 || pieceNum >= 24){
      pieceName = "P";
    } else if(pieceNum == 8 || pieceNum == 15 || pieceNum == 16 || pieceNum == 23){
      pieceName = "R";
    } else if(pieceNum == 9 || pieceNum == 14 || pieceNum == 17 || pieceNum == 22){
      pieceName = "N";
    } else if(pieceNum == 10 || pieceNum == 13 || pieceNum == 18 || pieceNum == 21){
      pieceName = "B";
    } else if(pieceNum == 11 || pieceNum == 19){
      pieceName = "Q";
    } else if(pieceNum == 12 || pieceNum == 20){
      pieceName = "K";
    }

    ellipseMode(CORNER);

    if((firstBoard[pieceNum][1]) == 1){
      fill(255);
      ellipse(width/8*(firstBoard[pieceNum][2]-1),height-(firstBoard[pieceNum][3]*height/8),width/8,height/8);
      fill(50);
    } else{
      fill(50);
      ellipse(width/8*(firstBoard[pieceNum][2]-1),height-(firstBoard[pieceNum][3]*height/8),width/8,height/8);
      fill(255);
    }
    textSize(height/9);
    text(pieceName,width/8*(firstBoard[pieceNum][2]-1)+height/36,height-(firstBoard[pieceNum][3]*height/8)+height/8-height/36);
    fill(255);
  }}

//Actual Moving Around

int[] square(){
  int[] currentsquare = {(floor(mouseX/(width/8))+1),8 - (floor(mouseY/(height/8)))};
  return currentsquare; //Returns the x and y coordinates (relative to the board) of the current mouse value
}

void mousePressed(){
  if(mouseButton == RIGHT && currentStance == 1){
    currentStance = 0;
  }
  else{
  if(turnNumber == 1){ //White to Move
    if(currentStance == 0 && exists(firstBoard,square()[0],square()[1])[0] == 1 && exists(firstBoard,square()[0],square()[1])[1] < 16){
      startxco = square()[0];
      startyco = square()[1];
      selectedPieceNumber = exists(firstBoard,startxco,startyco)[1];
      currentStance = 1;
    }



    if(realmoveLegal(startxco,startyco,square()[0],square()[1]) == 1 && currentStance == 1 && (exists(firstBoard,square()[0],square()[1])[0] == 0 || (exists(firstBoard,square()[0],square()[1])[0] == 1 && exists(firstBoard,square()[0],square()[1])[1] >= 16))){
        endxco = square()[0];
        endyco = square()[1];
        if(exists(firstBoard,endxco,endyco)[1] >= 16 && exists(firstBoard,endxco,endyco)[0] == 1){
          firstBoard[exists(firstBoard,endxco,endyco)[1]][0] = 0;
        }
        firstBoard[selectedPieceNumber][2] = endxco;
        firstBoard[selectedPieceNumber][3] = endyco;
        currentStance = 0;
        turnNumber = 2;
    }
  } else if(turnNumber == 2){ //Black to move
    if(currentStance == 0 && exists(firstBoard,square()[0],square()[1])[0] == 1 && exists(firstBoard,square()[0],square()[1])[1] >= 16){
      startxco = square()[0];
      startyco = square()[1];
      selectedPieceNumber = exists(firstBoard,startxco,startyco)[1];
      currentStance = 1;
    }
    if(realmoveLegal(startxco,startyco,square()[0],square()[1]) == 1 && currentStance == 1 && (exists(firstBoard,square()[0],square()[1])[0] == 0 || (exists(firstBoard,square()[0],square()[1])[0] == 1 && exists(firstBoard,square()[0],square()[1])[1] < 16))){
        endxco = square()[0];
        endyco = square()[1];
        if(exists(firstBoard,endxco,endyco)[1] < 16 && exists(firstBoard,endxco,endyco)[0] == 1 ){
          firstBoard[exists(firstBoard,endxco,endyco)[1]][0] = 0;
        }
        firstBoard[selectedPieceNumber][2] = endxco;
        firstBoard[selectedPieceNumber][3] = endyco;
        currentStance = 0;
        turnNumber = 1;
    }

  }}}

//For the input coordinate, it will output whether that piece is occupied, and if so, what piece number it has (0-31)
int[] exists(float[][] typeBoard, int x, int y){
  pieceSelected[0] = 0;
  pieceSelected[1] = 0;
  if(x <= 0 || x > 8 || y <= 0 || y > 8){
    pieceSelected[0] = -1;
  } else{
    for(int i = 0; i<32; i++){
      if(typeBoard[i][2] == x && typeBoard[i][3] == y && typeBoard[i][0] == 1){
        pieceSelected[0] = 1;
        pieceSelected[1] = i;
      }
    }
  }
  return pieceSelected;
}


//Checks if a move is legal based off of the start coordinate and the end Coordinate
int moveLegal(){
  return 1;}

float[][] secondBoard = {

  //White Pieces
  {1,1,1,2,1},{1,1,2,2,1},{1,1,3,2,1},{1,1,4,2,1},{1,1,5,2,1},{1,1,6,2,1},{1,1,7,2,1},{1,1,8,2,1},
  {1,1,1,1,5},{1,1,2,1,3},{1,1,3,1,3},{1,1,2,7,9},{1,1,5,1,5000},{1,1,6,1,3},{1,1,7,1,3},{1,1,8,1,5},

  //Black Pieces
  {1,-1,1,8,5},{1,-1,2,8,3},{1,-1,3,8,3},{1,-1,4,8,9},{1,-1,5,8,5000},{1,-1,6,8,3},{1,-1,7,8,3},{1,-1,8,8,5},
  {1,-1,1,7,1},{0,-1,2,7,1},{1,-1,3,7,1},{1,-1,4,7,1},{1,-1,5,7,1},{1,-1,6,7,1},{1,-1,7,7,1},{1,-1,8,7,1},

};

float[][] thirdBoard = {

  //White Pieces
  {1,1,1,2,1},{1,1,2,2,1},{1,1,3,2,1},{1,1,4,2,1},{1,1,5,2,1},{1,1,6,2,1},{1,1,7,2,1},{1,1,8,2,1},
  {1,1,1,1,5},{1,1,2,1,3},{1,1,3,1,3},{1,1,3,6,9},{1,1,5,1,5000},{1,1,6,1,3},{1,1,7,1,3},{1,1,8,1,5},

  //Black Pieces
  {1,-1,1,8,5},{1,-1,2,8,3},{1,-1,3,8,3},{1,-1,4,8,9},{1,-1,5,8,5000},{1,-1,6,8,3},{1,-1,7,8,3},{1,-1,8,8,5},
  {1,-1,1,7,1},{1,-1,2,7,1},{1,-1,3,7,1},{1,-1,4,7,1},{1,-1,5,7,1},{1,-1,6,7,1},{1,-1,7,7,1},{1,-1,8,7,1},


};

//Outputs an array with length 4 (x1, y1, x2, y2, i) where i is the move number for white


float[][] getPossibleMoves_depth2(){
  int[][] treeDepth2_result = {};
  int[] treeDepthAndWhiteMoveNumber = {};

  float[][] allEvaluation_AND_MoveNumber = {};
  float[] oneEvaluation_AND_MoveNumber = {-1,-9000};

  copyPieces(firstBoard, secondBoard);

  int firstlooplength = possibleMoves(secondBoard).length;
  //copyPieces(firstlooplength);
  for(int i = 0; i < firstlooplength; i++){
    copyPieces(firstBoard, secondBoard);
    turnNumber = 1;

    int[] secondMove = possibleMoves(secondBoard)[i];
    execute(secondMove,secondBoard);
    copyPieces(secondBoard, thirdBoard);
    turnNumber = 2;

    int secondlooplength = possibleMoves(thirdBoard).length;
    //copyPieces(secondlooplength);


    for(int j = 0; j < secondlooplength; j++){
      execute(possibleMoves(thirdBoard)[j],thirdBoard);
      oneEvaluation_AND_MoveNumber[0] = i;
      oneEvaluation_AND_MoveNumber[1] = evaluate(thirdBoard);
      //println(j,evaluate(thirdBoard),oneEvaluation_AND_MoveNumber[0]);

      allEvaluation_AND_MoveNumber = (float[][])append(allEvaluation_AND_MoveNumber, oneEvaluation_AND_MoveNumber);

      //println(allEvaluation_AND_MoveNumber[0][0],allEvaluation_AND_MoveNumber[0][1]);
      //println(oneEvaluation_AND_MoveNumber);
      treeDepth2_result = (int[][])append(treeDepth2_result, append(possibleMoves(thirdBoard)[j],i));
      copyPieces(secondBoard, thirdBoard);
    }
    turnNumber = 1;
  }
  //println(allEvaluation_AND_MoveNumber[0][0]);

  for(int z = 0; z<400; z++){
    //println(allEvaluation_AND_MoveNumber[0][0]);

  }

  return allEvaluation_AND_MoveNumber;
}

/*
void getBestMove_depth2(){
  //  int[][] placeholder = {};
  //  placeholder = (int[][])expand(placeholder,getPossibleMoves_depth2().length);
  //  copyArray(getPossibleMoves_depth2(),placeholder);

  //Creates an array with all the whiteMoveNumbers from treeDepth2 and their respective highest evaluation
  float[][]  whiteMoveNumber_AND_evaluation = {};
  float[] singleMove_AND_evaluation = {-1,-9000};
  int looplength1 = possibleMoves(firstBoard).length;
  for(int i = 0; i < looplength1; i++){
    singleMove_AND_evaluation[0] = i;
    whiteMoveNumber_AND_evaluation = (float[][])append(whiteMoveNumber_AND_evaluation,singleMove_AND_evaluation);
  }


  int highestEvalScore = -9000;
  copyPieces(firstBoard,secondBoard);
  copyPieces(secondBoard,thirdBoard);
  int looplength2 = getPossibleMoves_depth2().length;
  for(int i = 0; i < looplength2; i++){
    copyPieces(firstBoard,secondBoard);
    execute(possibleMoves(firstBoard)[getPossibleMoves_depth2()[i][4]],secondBoard);

    copyPieces(secondBoard,thirdBoard);
    execute(getPossibleMoves_depth2()[i],thirdBoard);

    int moveNumberForWhite = getPossibleMoves_depth2()[i][4];
    if(evaluate(thirdBoard) > whiteMoveNumber_AND_evaluation[moveNumberForWhite][1]){
        whiteMoveNumber_AND_evaluation[moveNumberForWhite][1] = evaluate(thirdBoard);
    }
    println(i);

  }
}*/

void copyPieces(float[][] board1, float[][] board2){
  float[] buffer1d = {};

  for(int i = 0; i<board1.length; i++){
    for(int j = 0; j<board1[i].length; j++){
      buffer1d = append(buffer1d, board1[i][j]);
    }
  }

  int h = 0;
  for(int i = 0;i<32;i++){
    for(int j = 0; j<board1[i].length;j++){
      board2[i][j] = buffer1d[h];
      h++;
    }
  }
}


int[] bestBlackMove(float[][] actualBoard, float[][] theoryBoard){
  float lowestEvalScore = 9000;
  int[] lowestEvalMove = {8,8,1,3};
  copyPieces(actualBoard, theoryBoard);
  int looplength = possibleMoves(theoryBoard).length;
  for(int i = 0; i< looplength; i++){
      copyPieces(actualBoard, theoryBoard);
      int[] theMove = possibleMoves(theoryBoard)[i];
      execute(theMove,theoryBoard);
      //println(theMove[0],theMove[1],theMove[2],theMove[3],evaluate(theoryBoard));

      if(evaluate(theoryBoard) < lowestEvalScore){
        lowestEvalScore = evaluate(theoryBoard);
        lowestEvalMove = theMove;
      }
      else if((evaluate(theoryBoard) == lowestEvalScore) && random(0,4) > 1){
        lowestEvalScore = evaluate(theoryBoard);
        lowestEvalMove = theMove;

      }
      copyPieces(actualBoard, theoryBoard);
  }
  copyPieces(actualBoard, theoryBoard);

  return lowestEvalMove;

}


void keyPressed(){

  if(turnNumber == 1){
    copyPieces(firstBoard,secondBoard);
    copyPieces(secondBoard,thirdBoard);
      float highestEvalScore = -9000;
      int[] highestEvalMove = {8,8,1,5};
      copyPieces(firstBoard, secondBoard);
      int looplength = possibleMoves(secondBoard).length;
      for(int i = 0; i< looplength; i++){
          turnNumber = 1;
          copyPieces(firstBoard, secondBoard);
          int[] secondMove = possibleMoves(secondBoard)[i];

          execute(secondMove,secondBoard);
          copyPieces(secondBoard,thirdBoard);
          turnNumber = 2;

          execute(bestBlackMove(secondBoard,thirdBoard),thirdBoard);
          //println(bestBlackMove(secondBoard,thirdBoard));

          //println(thirdBoard[11]);

          //println(bestBlackMove(secondBoard,thirdBoard));
          //println(secondMove[0],secondMove[1],secondMove[2],secondMove[3],evaluate(thirdBoard));
          if(evaluate(thirdBoard) > highestEvalScore){
            highestEvalScore = evaluate(thirdBoard);
            highestEvalMove = secondMove;
          }
      }
      turnNumber = 1;

      execute(highestEvalMove,firstBoard);
      //println(highestEvalMove);
      copyPieces(firstBoard, secondBoard);
  }

  if(turnNumber == 2){
    execute(bestBlackMove(firstBoard,secondBoard),firstBoard);
  }

  if(turnNumber == 1){
    turnNumber = 2;
  }

  else if(turnNumber == 2){
    turnNumber = 1;
  }

}


//Executes a move given its 2 coordinates
void execute(int[] autoMove, float[][] typeBoard){
  int startx = autoMove[0];
  int starty = autoMove[1];
  int endx = autoMove[2];
  int endy = autoMove[3];
  int placeholderx, placeholdery;
  placeholderx = 0;
  placeholdery = 0;

  if(turnNumber == 1){ //White to move
    selectedPieceNumber = exists(typeBoard,startx,starty)[1];
    if(exists(typeBoard,startx,starty)[0] == 1 && ((exists(typeBoard,endx,endy)[0] == 0) || (exists(typeBoard,endx,endy)[0] == 1 && (exists(typeBoard,endx,endy)[1] >= 16))) && exists(typeBoard,startx,starty)[1] < 16){
      placeholderx = endx;
      placeholdery = endy;
      //turnNumber = 2;
      if(exists(typeBoard,endx,endy)[1] >= 16){
        typeBoard[exists(typeBoard,endx,endy)[1]][0] = 0;
        //println("triggered");

      }
    }
  } else if(turnNumber == 2){ //Black to move
      selectedPieceNumber = exists(typeBoard,startx,starty)[1];
      //if(exists(typeBoard,startx,starty)[0] == 1 && ((exists(typeBoard,endx,endy)[0] == 0) || (exists(typeBoard,endx,endy)[0] == 1 && (exists(typeBoard,endx,endy)[1] < 16))) && exists(typeBoard,startx,starty)[1] >= 16){

        placeholderx = endx;
        placeholdery = endy;
        //turnNumber = 1;
        //println(endx,endy);
        //println(exists(secondBoard,endx,endy));
        if(exists(typeBoard,endx,endy)[1] < 16 && exists(typeBoard,endx,endy)[1] > 0){
          typeBoard[exists(typeBoard,endx,endy)[1]][0] = 0;
        }
      //}
    }
    typeBoard[selectedPieceNumber][2] = placeholderx;
    typeBoard[selectedPieceNumber][3] = placeholdery;

  }

//Uses the current coordinates from firstBoard to generate a 2d array with all the neccessary coordinates to be executed
int[][] possibleMoves(float[][] typeBoard){

  int[] nothing = {};
  int[][] moves = {};
  int[] onemove = {};

  if(turnNumber == 1){
    for(int i=0;i<16;i++){ //All possible pieces for white
      onemove = nothing;
      if(typeBoard[i][0] == 1){

        //If piece is a pawn
        if(i < 8){

          //Check if it can move up by 1
          if(exists(typeBoard,int(typeBoard[i][2]),int((typeBoard[i][3] + 1)))[0] == 0){
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //Check if it can move up by 2
         if(typeBoard[i][3] == 2 && exists(typeBoard,int(typeBoard[i][2]),int((typeBoard[i][3] + 1)))[0] == 0 && exists(typeBoard,int(typeBoard[i][2]),int((typeBoard[i][3] + 2)))[0] == 0){
           onemove = append(onemove, int(typeBoard[i][2]));
           onemove = append(onemove, int(typeBoard[i][3]));
           onemove = append(onemove, int(typeBoard[i][2]));
           onemove = append(onemove, int(typeBoard[i][3] + 2));

            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //Check if it can capture to the right
          if(exists(typeBoard,int(typeBoard[i][2] + 1),int((typeBoard[i][3] + 1)))[0] == 1 && exists(typeBoard,int(typeBoard[i][2] + 1),int((typeBoard[i][3] + 1)))[1] >= 16){
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 1));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
           }

           //Check if it can capture to the left
           if(exists(typeBoard,int(typeBoard[i][2] - 1),int((typeBoard[i][3] + 1)))[0] == 1 && exists(typeBoard,int(typeBoard[i][2] - 1),int((typeBoard[i][3] + 1)))[1] >= 16){
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 1));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
           }
        }

        //If piece is a rook
        else if(i == 8 || i == 15){
           //Checks if it can move up;
           for(int j = 1; j<=8; j++){
             if(
               exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 0
               || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1)
                  && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] >= 16))
               )
               {
                 onemove = append(onemove, int(typeBoard[i][2]));
                 onemove = append(onemove, int(typeBoard[i][3]));
                 onemove = append(onemove, int(typeBoard[i][2]));
                 onemove = append(onemove, int(typeBoard[i][3] + j));
                 moves = (int[][])append(moves,onemove);
                 onemove = nothing;
                 if(((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] >= 16))){
                   j = 10;
                 }
             } else{
                  j = 10;
                  onemove = nothing;
             }
           }

           //Checks if it can move down;
           for(int j = -1; j>=-8; j--){
             if(
               exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 0
               || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1)
                  && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] >= 16))
               )
               {
                 onemove = append(onemove, int(typeBoard[i][2]));
                 onemove = append(onemove, int(typeBoard[i][3]));
                 onemove = append(onemove, int(typeBoard[i][2]));
                 onemove = append(onemove, int(typeBoard[i][3] + j));
                 moves = (int[][])append(moves,onemove);
                 onemove = nothing;
                 if(((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] >= 16))){
                   j = -10;
                 }
             } else{
                  j = -10;
                  onemove = nothing;
             }
           }

           //Checks if it can move right;
           for(int j = 1; j<=8; j++){
             if(
               exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 0
               || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1)
                  && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] >= 16))
               )
               {
                 onemove = append(onemove, int(typeBoard[i][2]));
                 onemove = append(onemove, int(typeBoard[i][3]));
                 onemove = append(onemove, int(typeBoard[i][2] + j));
                 onemove = append(onemove, int(typeBoard[i][3]));
                 moves = (int[][])append(moves,onemove);
                 onemove = nothing;
                 if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] >= 16))){
                    j = 10;
                 }
             } else{
                  j = 10;
                  onemove = nothing;
             }
           }

           //Checks if it can move left;
           for(int j = -1; j>=-8; j--){
             if(
               exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 0
               || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1)
                  && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] >= 16))
               )
               {
                 onemove = append(onemove, int(typeBoard[i][2]));
                 onemove = append(onemove, int(typeBoard[i][3]));
                 onemove = append(onemove, int(typeBoard[i][2] + j));
                 onemove = append(onemove, int(typeBoard[i][3]));
                 moves = (int[][])append(moves,onemove);
                 onemove = nothing;
                 if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] >= 16))){
                    j = -10;
                 }
             } else{
                  j = -10;
                  onemove = nothing;
             }
           }

        }

        //If piece is knight
        else if(i == 9 || i == 14){

          //If piece can move 1 up 2 right
          if(
            exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[1] >= 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 2));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 1 up 2 left
          if(
            exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] + 1))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] + 1))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] + 1))[1] >= 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 2));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 1 up 2 right
          if(
            exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[1] >= 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 2));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }


          //If piece can move 1 down 2 left
          if(
            exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] - 1))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] - 1))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] - 1))[1] >= 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 2));
            onemove = append(onemove, int(typeBoard[i][3] - 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 2 up 1 right
          if(
            exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 2))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 2))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 2))[1] >= 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 1));
            onemove = append(onemove, int(typeBoard[i][3] + 2));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 2 up 1 left
          if(
            exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 2))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 2))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 2))[1] >= 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 1));
            onemove = append(onemove, int(typeBoard[i][3] + 2));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 2 down 1 right
          if(
            exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 2))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 2))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 2))[1] >= 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 1));
            onemove = append(onemove, int(typeBoard[i][3] - 2));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 2 down 1 left
          if(
            exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 2))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 2))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 2))[1] >= 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 1));
            onemove = append(onemove, int(typeBoard[i][3] - 2));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

        }

        //If piece is bishop
        else if(i == 10 || i == 13){

          //If piece can move diagonally from top left to bottom right
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] - j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] >= 16))){
                j = 10;
              }

            } else{
                j = 10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from bottom right to top left
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] - j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] >= 16))){
                j = -10;
              }
            } else{
                j = -10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from bottom left to top right
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] + j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] >= 16))){
                   j = 10;
              }
            } else{
                j = 10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from top right to bottom left
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] + j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] >= 16))){
                   j = -10;
              }
            } else{
                j = -10;
                onemove = nothing;
            }
          }

        }

        //If piece is queen
        else if(i == 11){
          //Checks if it can move up;
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] >= 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] + j));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] >= 16))){
                  j = 10;
                }
            } else{
                 j = 10;
                 onemove = nothing;
            }
          }

          //Checks if it can move down;
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] >= 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] + j));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] >= 16))){
                  j = -10;
                }
            } else{
                 j = -10;
                 onemove = nothing;
            }
          }

          //Checks if it can move right;
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] >= 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] + j));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] >= 16))){
                   j = 10;
                }
            } else{
                 j = 10;
                 onemove = nothing;
            }
          }

          //Checks if it can move left;
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] >= 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] + j));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] >= 16))){
                   j = -10;
                }
            } else{
                 j = -10;
                 onemove = nothing;
            }
          }

          //If piece can move diagonally from top left to bottom right
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] - j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] >= 16))){
                j = 10;
              }

            } else{
                j = 10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from bottom right to top left
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] - j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] >= 16))){
                j = -10;
              }
            } else{
                j = -10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from bottom left to top right
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] + j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] >= 16))){
                   j = 10;
              }
            } else{
                j = 10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from top right to bottom left
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] + j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] >= 16))){
                   j = -10;
              }
            } else{
                j = -10;
                onemove = nothing;
            }
          }

        }

        //If piece is King
        else if(i == 12){
          //Checks if it can move up;
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + 1))[1] >= 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] + 1));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
            }

          //Checks if it can move down;
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] - 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] - 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] - 1))[1] >= 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] - 1));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
            }

          //Checks if it can move right;
            if(
              exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 0))[1] >= 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] + 1));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
            }

          //Checks if it can move left;
            if(
              exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 0))[1] >= 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] - 1));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
            }

          //If piece can move diagonally from top left to bottom right
            if(
              exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 1))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + 1));
              onemove = append(onemove, int(typeBoard[i][3] - 1));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;
            }

          //If piece can move diagonally from bottom right to top left
            if(
              exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 1))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] - 1));
              onemove = append(onemove, int(typeBoard[i][3] + 1));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;
            }

          //If piece can move diagonally from bottom left to top right
            if(
              exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 1))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + 1));
              onemove = append(onemove, int(typeBoard[i][3] + 1));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;
            }

          //If piece can move diagonally from top right to bottom left
            if(
              exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 1))[1] >= 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] - 1));
              onemove = append(onemove, int(typeBoard[i][3] - 1));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;
            }

        }
      }
    }
  }
  if(turnNumber == 2){
    for(int i=16;i<32;i++){ //All possible pieces for black
      onemove = nothing;
      if(typeBoard[i][0] == 1){ //Qualitative comments from black POV

        //If piece is a pawn
        if(i > 23){

          //Check if it can move up by 1
          if(exists(typeBoard,int(typeBoard[i][2]),int((typeBoard[i][3] - 1)))[0] == 0){
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3] - 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //Check if it can move up by 2
         if(typeBoard[i][3] == 7 && exists(typeBoard,int(typeBoard[i][2]),int((typeBoard[i][3] - 1)))[0] == 0 && exists(typeBoard,int(typeBoard[i][2]),int((typeBoard[i][3] - 2)))[0] == 0){
           onemove = append(onemove, int(typeBoard[i][2]));
           onemove = append(onemove, int(typeBoard[i][3]));
           onemove = append(onemove, int(typeBoard[i][2]));
           onemove = append(onemove, int(typeBoard[i][3] - 2));

            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //Check if it can capture to the right
          if(exists(typeBoard,int(typeBoard[i][2] - 1),int((typeBoard[i][3] - 1)))[0] == 1 && exists(typeBoard,int(typeBoard[i][2] - 1),int((typeBoard[i][3] - 1)))[1] < 16){
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 1));
            onemove = append(onemove, int(typeBoard[i][3] - 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
           }

           //Check if it can capture to the left
           if(exists(typeBoard,int(typeBoard[i][2] + 1),int((typeBoard[i][3] - 1)))[0] == 1 && exists(typeBoard,int(typeBoard[i][2] + 1),int((typeBoard[i][3] - 1)))[1] < 16){
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 1));
            onemove = append(onemove, int(typeBoard[i][3] - 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
           }
        }


        //If piece is a rook
        else if(i == 16 || i == 23){
          //Checks if it can move up;
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] + j));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] < 16))){
                  j = 10;
                }
            } else{
                 j = 10;
                 onemove = nothing;
            }
          }

          //Checks if it can move down;
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] + j));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] < 16))){
                  j = -10;
                }
            } else{
                 j = -10;
                 onemove = nothing;
            }
          }

          //Checks if it can move right;
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] + j));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] < 16))){
                   j = 10;
                }
            } else{
                 j = 10;
                 onemove = nothing;
            }
          }

          //Checks if it can move left;
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] + j));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] < 16))){
                   j = -10;
                }
            } else{
                 j = -10;
                 onemove = nothing;
            }
          }

        }

        //If piece is knight
        else if(i == 17|| i == 22){

          //If piece can move 1 up 2 right
          if(
            exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[1] < 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 2));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 1 up 2 left
          if(
            exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] + 1))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] + 1))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] + 1))[1] < 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 2));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 1 up 2 right
          if(
            exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] + 2),int(typeBoard[i][3] + 1))[1] < 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 2));
            onemove = append(onemove, int(typeBoard[i][3] + 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }


          //If piece can move 1 down 2 left
          if(
            exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] - 1))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] - 1))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] - 2),int(typeBoard[i][3] - 1))[1] < 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 2));
            onemove = append(onemove, int(typeBoard[i][3] - 1));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 2 up 1 right
          if(
            exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 2))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 2))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 2))[1] < 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 1));
            onemove = append(onemove, int(typeBoard[i][3] + 2));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 2 up 1 left
          if(
            exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 2))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 2))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 2))[1] < 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 1));
            onemove = append(onemove, int(typeBoard[i][3] + 2));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 2 down 1 right
          if(
            exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 2))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 2))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 2))[1] < 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] + 1));
            onemove = append(onemove, int(typeBoard[i][3] - 2));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

          //If piece can move 2 down 1 left
          if(
            exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 2))[0] == 0
            || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 2))[0] == 1)
               && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 2))[1] < 16))
            )
            {
            onemove = append(onemove, int(typeBoard[i][2]));
            onemove = append(onemove, int(typeBoard[i][3]));
            onemove = append(onemove, int(typeBoard[i][2] - 1));
            onemove = append(onemove, int(typeBoard[i][3] - 2));
            moves = (int[][])append(moves,onemove);
            onemove = nothing;
          }

        }

        //If piece is bishop
        else if(i == 18 || i == 21){

          //If piece can move diagonally from top left to bottom right
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] - j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] < 16))){
                j = 10;
              }

            } else{
                j = 10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from bottom right to top left
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] - j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] < 16))){
                j = -10;
              }
            } else{
                j = -10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from bottom left to top right
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] + j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] < 16))){
                   j = 10;
              }
            } else{
                j = 10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from top right to bottom left
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] + j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] < 16))){
                   j = -10;
              }
            } else{
                j = -10;
                onemove = nothing;
            }
          }

        }

        //If piece is queen
        else if(i == 19){
          //Checks if it can move up;
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] + j));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] < 16))){
                  j = 10;
                }
            } else{
                 j = 10;
                 onemove = nothing;
            }
          }

          //Checks if it can move down;
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] + j));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + j))[1] < 16))){
                  j = -10;
                }
            } else{
                 j = -10;
                 onemove = nothing;
            }
          }

          //Checks if it can move right;
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] + j));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] < 16))){
                   j = 10;
                }
            } else{
                 j = 10;
                 onemove = nothing;
            }
          }

          //Checks if it can move left;
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] + j));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
                if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + 0))[1] < 16))){
                   j = -10;
                }
            } else{
                 j = -10;
                 onemove = nothing;
            }
          }

          //If piece can move diagonally from top left to bottom right
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] - j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] < 16))){
                j = 10;
              }

            } else{
                j = 10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from bottom right to top left
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] - j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] - j))[1] < 16))){
                j = -10;
              }
            } else{
                j = -10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from bottom left to top right
          for(int j = 1; j<=8; j++){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] + j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] < 16))){
                   j = 10;
              }
            } else{
                j = 10;
                onemove = nothing;
            }
          }

          //If piece can move diagonally from top right to bottom left
          for(int j = -1; j>=-8; j--){
            if(
              exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + j));
              onemove = append(onemove, int(typeBoard[i][3] + j));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;

              if(((exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[0] == 1) && (exists(typeBoard,int(typeBoard[i][2] + j),int(typeBoard[i][3] + j))[1] < 16))){
                   j = -10;
              }
            } else{
                j = -10;
                onemove = nothing;
            }
          }

        }

        //If piece is King
        else if(i == 20){
          //Checks if it can move up;
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] + 1))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] + 1));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
            }

          //Checks if it can move down;
            if(
              exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] - 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] - 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2]),int(typeBoard[i][3] - 1))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3] - 1));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
            }

          //Checks if it can move right;
            if(
              exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 0))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] + 1));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
            }

          //Checks if it can move left;
            if(
              exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 0))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 0))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 0))[1] < 16))
              )
              {
                onemove = append(onemove, int(typeBoard[i][2]));
                onemove = append(onemove, int(typeBoard[i][3]));
                onemove = append(onemove, int(typeBoard[i][2] - 1));
                onemove = append(onemove, int(typeBoard[i][3]));
                moves = (int[][])append(moves,onemove);
                onemove = nothing;
            }

          //If piece can move diagonally from top left to bottom right
            if(
              exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] - 1))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + 1));
              onemove = append(onemove, int(typeBoard[i][3] - 1));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;
            }

          //If piece can move diagonally from bottom right to top left
            if(
              exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] + 1))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] - 1));
              onemove = append(onemove, int(typeBoard[i][3] + 1));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;
            }

          //If piece can move diagonally from bottom left to top right
            if(
              exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] + 1),int(typeBoard[i][3] + 1))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] + 1));
              onemove = append(onemove, int(typeBoard[i][3] + 1));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;
            }

          //If piece can move diagonally from top right to bottom left
            if(
              exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 1))[0] == 0
              || ((exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 1))[0] == 1)
                 && (exists(typeBoard,int(typeBoard[i][2] - 1),int(typeBoard[i][3] - 1))[1] < 16))
              )
              {
              onemove = append(onemove, int(typeBoard[i][2]));
              onemove = append(onemove, int(typeBoard[i][3]));
              onemove = append(onemove, int(typeBoard[i][2] - 1));
              onemove = append(onemove, int(typeBoard[i][3] - 1));
              moves = (int[][])append(moves,onemove);
              onemove = nothing;
            }

        }
      }
    }
  }
  return moves;}
int realmoveLegal(int x1, int y1, int x2, int y2){
    int[] testMove = {x1,y1,x2,y2};
    int result = 0;
    for(int i = 0; i<possibleMoves(firstBoard).length; i++){
      if(testMove[0] == possibleMoves(firstBoard)[i][0] && testMove[1] == possibleMoves(firstBoard)[i][1] && testMove[2] == possibleMoves(firstBoard)[i][2] && testMove[3] == possibleMoves(firstBoard)[i][3]){
        result = 1;
      }
    }
    return result;
  }