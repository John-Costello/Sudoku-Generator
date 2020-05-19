// Programmed by John Costello  10/02/2019
//
import javax.swing.*;
float sudokuDatumX=150;
float sudokuDatumY=150;
float cellLength=60;
int cellPressedX=10, cellPressedY=10;
int cursorClock=0; 
int clockCycle=50;                    // used for displaying the flash cursor.
float rectButtonDatumX=850;           // The visual display datum in the x-axis of the rectangular buttons.
float rectButtonDatumY=130;           // The visual display datum in the y-axis of the rectangular buttons.
float rectButtonWidth=145;            // The visual display length in the x-axis of the rectangular buttons.
float rectButtonHeight=40;            // The visual display height in the y-axis of the rectangular buttons.
byte buttonPrimed,buttonHoovering, buttonReleased, buttonSelected;  // Conditions relating to pressing the buttons
boolean mouseLongTimePressed;      // Conditions relating to pressing the buttons such that the buttons does not activate until mouse is released
boolean keyLongTimePressed;
byte sudokuTrySolveStatus;
boolean displaySolution=true;
boolean doNotDisplaySolution=false;
boolean sudokuSpoiltStatus;
int[][] cellNumber=new int[9][9];
int[][] trySolveSudoku=new int[9][9];
int[] tempColumn=new int[9];
int[] tempThreeByThree=new int[9];
int[][] sudokuExOne={{0,0,6,4,5,0,0,0,0},{0,0,1,0,0,8,0,0,0},{0,0,4,0,7,0,9,5,8},{6,1,0,3,0,2,0,8,4},
{3,0,5,0,0,0,2,0,9},{8,9,0,1,0,5,0,7,6},{4,2,9,0,1,0,8,0,0},{0,0,0,2,0,0,7,0,0},{0,0,0,0,3,4,6,0,0}};
int[][] sudokuExTwo={{0,0,0,0,2,7,0,3,9},{0,9,0,1,0,0,2,0,0},{2,0,6,8,0,0,0,0,0,},{9,0,0,0,7,0,1,0,2},
{0,8,1,0,5,0,3,9,0},{3,0,2,0,9,0,0,0,5},{0,0,0,0,0,3,5,0,4},{0,0,7,0,0,4,0,2,0},{1,4,0,2,8,0,0,0,0}};
int[][] sudokuExThree={{0,0,6,0,9,0,1,0,0},{0,7,2,6,0,3,4,9,0},{0,0,0,1,2,4,0,0,0,},{0,1,0,0,0,0,0,2,0},
{0,0,3,0,0,0,5,0,0},{0,6,0,0,0,0,0,4,0},{0,0,0,9,8,7,0,0,0},{0,4,7,3,0,5,8,6,0},{0,0,5,0,4,0,3,0,0}};
int[][] sudokuPrimative={{1,2,3,4,5,6,7,8,9},{4,5,6,7,8,9,1,2,3},{7,8,9,1,2,3,4,5,6},{2,3,4,5,6,7,8,9,1},
{5,6,7,8,9,1,2,3,4},{8,9,1,2,3,4,5,6,7},{3,4,5,6,7,8,9,1,2},{6,7,8,9,1,2,3,4,5},{9,1,2,3,4,5,6,7,8}};
int[][] sudokuBase={{9,8,6,4,5,3,1,2,7},{7,5,1,9,2,8,4,6,3},{2,3,4,6,7,1,9,5,8},{6,1,7,3,9,2,5,8,4},
{3,4,5,8,6,7,2,1,9},{8,9,2,1,4,5,3,7,6},{4,2,9,7,1,6,8,3,5},{5,6,3,2,8,9,7,4,1},{1,7,8,5,3,4,6,9,2}};
//================================================================================
void setup()
{
  size(1050,880);
}
//================================================================================
void draw()
{ 
   background(212);
   fill(0);
   textSize(40);
   text("Sudoku",350,60);
   drawButtons();
   cursorClock++;cursorClock%=clockCycle;   // use for displaying the flash cursor.
   if(mousePressed==true && mouseLongTimePressed==false)
   {  
      if(mouseX>=rectButtonDatumX && mouseX<=rectButtonDatumX+rectButtonWidth)
      {
         if(mouseY>=rectButtonDatumY && mouseY<=rectButtonDatumY+rectButtonHeight){buttonPrimed=1;}
         else if(mouseY>=rectButtonDatumY+2*rectButtonHeight && mouseY<=rectButtonDatumY+3*rectButtonHeight){buttonPrimed=2;}
         else if(mouseY>=rectButtonDatumY+4*rectButtonHeight && mouseY<=rectButtonDatumY+5*rectButtonHeight){buttonPrimed=3;}
         else if(mouseY>=rectButtonDatumY+6*rectButtonHeight && mouseY<=rectButtonDatumY+7*rectButtonHeight){buttonPrimed=4;}
         else if(mouseY>=rectButtonDatumY+8*rectButtonHeight && mouseY<=rectButtonDatumY+9*rectButtonHeight){buttonPrimed=5;}
         else if(mouseY>=rectButtonDatumY+10*rectButtonHeight && mouseY<=rectButtonDatumY+11*rectButtonHeight){buttonPrimed=6;}
         else if(mouseY>=rectButtonDatumY+12*rectButtonHeight && mouseY<=rectButtonDatumY+13*rectButtonHeight){buttonPrimed=7;}
         else if(mouseY>=rectButtonDatumY+14*rectButtonHeight && mouseY<=rectButtonDatumY+15*rectButtonHeight){buttonPrimed=8;}
      }
      mouseLongTimePressed=true;
   }
   if(mousePressed==true && mouseLongTimePressed==true) 
   {
      buttonHoovering=0;
      if(mouseX>=rectButtonDatumX && mouseX<=rectButtonDatumX+rectButtonWidth)
      {
         if(mouseY>=rectButtonDatumY && mouseY<=rectButtonDatumY+rectButtonHeight){buttonHoovering=1;}
         else if(mouseY>=rectButtonDatumY+2*rectButtonHeight && mouseY<=rectButtonDatumY+3*rectButtonHeight){buttonHoovering=2;}
         else if(mouseY>=rectButtonDatumY+4*rectButtonHeight && mouseY<=rectButtonDatumY+5*rectButtonHeight){buttonHoovering=3;}
         else if(mouseY>=rectButtonDatumY+6*rectButtonHeight && mouseY<=rectButtonDatumY+7*rectButtonHeight){buttonHoovering=4;}
         else if(mouseY>=rectButtonDatumY+8*rectButtonHeight && mouseY<=rectButtonDatumY+9*rectButtonHeight){buttonHoovering=5;}
         else if(mouseY>=rectButtonDatumY+10*rectButtonHeight && mouseY<=rectButtonDatumY+11*rectButtonHeight){buttonHoovering=6;}
         else if(mouseY>=rectButtonDatumY+12*rectButtonHeight && mouseY<=rectButtonDatumY+13*rectButtonHeight){buttonHoovering=7;}
         else if(mouseY>=rectButtonDatumY+14*rectButtonHeight && mouseY<=rectButtonDatumY+15*rectButtonHeight){buttonHoovering=8;}
      }
      strokeWeight(2);
      stroke(0);
      fill(225,255,0);
      if(buttonPrimed==1 && buttonHoovering==1){rect(rectButtonDatumX,rectButtonDatumY,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==2 && buttonHoovering==2){rect(rectButtonDatumX,rectButtonDatumY+2*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==3 && buttonHoovering==3){rect(rectButtonDatumX,rectButtonDatumY+4*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==4 && buttonHoovering==4){rect(rectButtonDatumX,rectButtonDatumY+6*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==5 && buttonHoovering==5){rect(rectButtonDatumX,rectButtonDatumY+8*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==6 && buttonHoovering==6){rect(rectButtonDatumX,rectButtonDatumY+10*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==7 && buttonHoovering==7){rect(rectButtonDatumX,rectButtonDatumY+12*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==8 && buttonHoovering==8){rect(rectButtonDatumX,rectButtonDatumY+14*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      strokeWeight(4);
      stroke(255,150,50);
      fill(212);
      if(buttonPrimed==1 && buttonHoovering!=1){rect(rectButtonDatumX+3,rectButtonDatumY+3,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==2 && buttonHoovering!=2){rect(rectButtonDatumX+3,rectButtonDatumY+3+2*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==3 && buttonHoovering!=3){rect(rectButtonDatumX+3,rectButtonDatumY+3+4*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==4 && buttonHoovering!=4){rect(rectButtonDatumX+3,rectButtonDatumY+3+6*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==5 && buttonHoovering!=5){rect(rectButtonDatumX+3,rectButtonDatumY+3+8*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==6 && buttonHoovering!=6){rect(rectButtonDatumX+3,rectButtonDatumY+3+10*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==7 && buttonHoovering!=7){rect(rectButtonDatumX+3,rectButtonDatumY+3+12*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==8 && buttonHoovering!=8){rect(rectButtonDatumX+3,rectButtonDatumY+3+14*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      drawButtonText();
   }
   buttonReleased=0;
   buttonSelected=0;
   if(mousePressed==false && mouseLongTimePressed==true)
   {   
      if(mouseX>=rectButtonDatumX && mouseX<=rectButtonDatumX+rectButtonWidth)
      {
         if(mouseY>=rectButtonDatumY && mouseY<=rectButtonDatumY+rectButtonHeight){if(buttonPrimed==1){buttonSelected=1;}}
         else if(mouseY>=rectButtonDatumY+2*rectButtonHeight && mouseY<=rectButtonDatumY+3*rectButtonHeight){if(buttonPrimed==2){buttonSelected=2;}}
         else if(mouseY>=rectButtonDatumY+4*rectButtonHeight && mouseY<=rectButtonDatumY+5*rectButtonHeight){if(buttonPrimed==3){buttonSelected=3;}}
         else if(mouseY>=rectButtonDatumY+6*rectButtonHeight && mouseY<=rectButtonDatumY+7*rectButtonHeight){if(buttonPrimed==4){buttonSelected=4;}}
         else if(mouseY>=rectButtonDatumY+8*rectButtonHeight && mouseY<=rectButtonDatumY+9*rectButtonHeight){if(buttonPrimed==5){buttonSelected=5;}}
         else if(mouseY>=rectButtonDatumY+10*rectButtonHeight && mouseY<=rectButtonDatumY+11*rectButtonHeight){if(buttonPrimed==6){buttonSelected=6;}}
         else if(mouseY>=rectButtonDatumY+12*rectButtonHeight && mouseY<=rectButtonDatumY+13*rectButtonHeight){if(buttonPrimed==7){buttonSelected=7;}}
         else if(mouseY>=rectButtonDatumY+14*rectButtonHeight && mouseY<=rectButtonDatumY+15*rectButtonHeight){if(buttonPrimed==8){buttonSelected=8;}}
      }
      mouseLongTimePressed=false;
      drawButtons();
   }
   if(mousePressed==false)
   {
      mouseLongTimePressed=false;
      buttonPrimed=0;
   }
   if(buttonSelected==1)
   {  
      reset();
   }
   if(buttonSelected==2)
   {  
      sudokuExOne();
   }
   if(buttonSelected==3)
   {  
      sudokuExTwo();
   }
   if(buttonSelected==4)
   {  
      sudokuExThree();
   }
   if(buttonSelected==5)
   {  
      scramble();   
   }
   if(buttonSelected==6)
   {  
      unfill();   
   }
   if(buttonSelected==7)
   {  
      generate();   
   }
   if(buttonSelected==8)
   {    
      sudokuTrySolveStatus=trySolve(displaySolution);
   }  
   if(mousePressed==true)
   {
      if(mouseX>=sudokuDatumX && mouseX<sudokuDatumX+cellLength){cellPressedX=0;}
      else if(mouseX>=sudokuDatumX+cellLength && mouseX<sudokuDatumX+2*cellLength){cellPressedX=1;}
      else if(mouseX>=sudokuDatumX+2*cellLength && mouseX<sudokuDatumX+3*cellLength){cellPressedX=2;}
      else if(mouseX>=sudokuDatumX+3*cellLength && mouseX<sudokuDatumX+4*cellLength){cellPressedX=3;}      
      else if(mouseX>=sudokuDatumX+4*cellLength && mouseX<sudokuDatumX+5*cellLength){cellPressedX=4;}       
      else if(mouseX>=sudokuDatumX+5*cellLength && mouseX<sudokuDatumX+6*cellLength){cellPressedX=5;}       
      else if(mouseX>=sudokuDatumX+6*cellLength && mouseX<sudokuDatumX+7*cellLength){cellPressedX=6;}       
      else if(mouseX>=sudokuDatumX+7*cellLength && mouseX<sudokuDatumX+8*cellLength){cellPressedX=7;}       
      else if(mouseX>=sudokuDatumX+8*cellLength && mouseX<sudokuDatumX+9*cellLength){cellPressedX=8;}
      else {cellPressedX=10;}
      if(mouseY>=sudokuDatumY && mouseY<sudokuDatumY+cellLength){cellPressedY=0;}
      else if(mouseY>=sudokuDatumY+cellLength && mouseY<sudokuDatumY+2*cellLength){cellPressedY=1;}
      else if(mouseY>=sudokuDatumY+2*cellLength && mouseY<sudokuDatumY+3*cellLength){cellPressedY=2;}
      else if(mouseY>=sudokuDatumY+3*cellLength && mouseY<sudokuDatumY+4*cellLength){cellPressedY=3;}      
      else if(mouseY>=sudokuDatumY+4*cellLength && mouseY<sudokuDatumY+5*cellLength){cellPressedY=4;}       
      else if(mouseY>=sudokuDatumY+5*cellLength && mouseY<sudokuDatumY+6*cellLength){cellPressedY=5;}       
      else if(mouseY>=sudokuDatumY+6*cellLength && mouseY<sudokuDatumY+7*cellLength){cellPressedY=6;}       
      else if(mouseY>=sudokuDatumY+7*cellLength && mouseY<sudokuDatumY+8*cellLength){cellPressedY=7;}       
      else if(mouseY>=sudokuDatumY+8*cellLength && mouseY<sudokuDatumY+9*cellLength){cellPressedY=8;}
      else {cellPressedY=10;}      
   }
   if(cellPressedX>=0 && cellPressedX<9 && cellPressedY>=0 && cellPressedY<9)
   {  
      if(keyPressed==true && keyLongTimePressed==false)
      {  
         if(key=='0'){cellNumber[cellPressedY][cellPressedX]=0;keyLongTimePressed=true;}
         if(key=='1'){cellNumber[cellPressedY][cellPressedX]=1;keyLongTimePressed=true;}
         if(key=='2'){cellNumber[cellPressedY][cellPressedX]=2;keyLongTimePressed=true;}
         if(key=='3'){cellNumber[cellPressedY][cellPressedX]=3;keyLongTimePressed=true;}
         if(key=='4'){cellNumber[cellPressedY][cellPressedX]=4;keyLongTimePressed=true;}
         if(key=='5'){cellNumber[cellPressedY][cellPressedX]=5;keyLongTimePressed=true;} 
         if(key=='6'){cellNumber[cellPressedY][cellPressedX]=6;keyLongTimePressed=true;}
         if(key=='7'){cellNumber[cellPressedY][cellPressedX]=7;keyLongTimePressed=true;}  
         if(key=='8'){cellNumber[cellPressedY][cellPressedX]=8;keyLongTimePressed=true;}  
         if(key=='9'){cellNumber[cellPressedY][cellPressedX]=9;keyLongTimePressed=true;}    
         if(key==DELETE){cellNumber[cellPressedY][cellPressedX]=0;keyLongTimePressed=true;}
         if(key==BACKSPACE){cellNumber[cellPressedY][cellPressedX]=0;keyLongTimePressed=true;}
         if(keyCode==UP && cellPressedY>0){cellPressedY--;keyLongTimePressed=true;}
         if(keyCode==DOWN && cellPressedY<8){cellPressedY++;keyLongTimePressed=true;}
         if(keyCode==LEFT && cellPressedX>0){cellPressedX--;keyLongTimePressed=true;}
         if(keyCode==RIGHT && cellPressedX<8){cellPressedX++;keyLongTimePressed=true;}         
      }
      if(keyPressed==false)
      {
         keyLongTimePressed=false;
      }  
   } 
   drawSudoku();
}
//============================================================================================
void drawButtons()
{
  strokeWeight(2);
   stroke(0);
   fill(212);
   rect(rectButtonDatumX,rectButtonDatumY,rectButtonWidth,rectButtonHeight);   
   rect(rectButtonDatumX,rectButtonDatumY+2*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+4*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+6*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+8*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+10*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+12*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+14*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   drawButtonText();
}
//============================================================================================
void drawButtonText()
{
   textSize(18);
   fill(0);
   text("Clear",rectButtonDatumX+13,rectButtonDatumY+27);
   text("Sudoku One",rectButtonDatumX+13,rectButtonDatumY+27+2*rectButtonHeight);
   text("Sudoku Two",rectButtonDatumX+13,rectButtonDatumY+27+4*rectButtonHeight);
   text("Sudoku Three",rectButtonDatumX+13,rectButtonDatumY+27+6*rectButtonHeight);
   text("Scramble",rectButtonDatumX+13,rectButtonDatumY+27+8*rectButtonHeight);
   text("Unfill",rectButtonDatumX+13,rectButtonDatumY+27+10*rectButtonHeight);
   text("Generate",rectButtonDatumX+13,rectButtonDatumY+27+12*rectButtonHeight);
   text("Try Solve",rectButtonDatumX+13,rectButtonDatumY+27+14*rectButtonHeight);
}  
//============================================================================================
void drawSudoku()
{  
  stroke(0);
  strokeWeight(1);
  for(int j=0;j<9;j++)
  {
     for(int i=0;i<9;i++)
     {  
        stroke(0);
        fill(212);
        rect(sudokuDatumX+i*cellLength,sudokuDatumY+j*cellLength,cellLength,cellLength);
        if(cellNumber[j][i]!=0)
        {  
           textSize(30);
           fill(0);
           text(cellNumber[j][i],sudokuDatumX+(i+0.35)*cellLength,sudokuDatumY+(j+0.7)*cellLength);
        }
        stroke(212);
        fill(212);
        rect(sudokuDatumX+i*cellLength+15,sudokuDatumY+j*cellLength+50,cellLength-30,cellLength-57);
     }   
  }
  if(cellPressedX>=0 && cellPressedX<9 && cellPressedY>=0 && cellPressedY<9 && cursorClock>clockCycle*0.5)
  {
        stroke(0);
        fill(0);
        rect(sudokuDatumX+cellPressedX*cellLength+15,sudokuDatumY+cellPressedY*cellLength+50,cellLength-30,cellLength-57);     
  };
  noFill();
  stroke(0);
  strokeWeight(2);
  for(int j=0;j<3;j++)
  {
     for(int i=0;i<3;i++)
     {
        rect(sudokuDatumX+(i*3)*cellLength,sudokuDatumY+(j*3)*cellLength,3*cellLength,3*cellLength);
     }
  }
  strokeWeight(1);
}
//=================================================================================
void reset()
{
   for(int i=0;i<9;i++)
   {
      for(int j=0;j<9;j++)
      {
         cellNumber[i][j]=0;
      }
   }   
}     
//=================================================================================
void sudokuExOne()
{
   for(int i=0;i<9;i++)
   {
      for(int j=0;j<9;j++)
      {
         cellNumber[i][j]=sudokuExOne[i][j];
      }
   } 
}
//=================================================================================
void sudokuExTwo()
{
   for(int i=0;i<9;i++)
   {
      for(int j=0;j<9;j++)
      {
         cellNumber[i][j]=sudokuExTwo[i][j];
      }
   }
} 
//=================================================================================
void sudokuExThree()
{
   for(int i=0;i<9;i++)
   {
      for(int j=0;j<9;j++)
      {
         cellNumber[i][j]=sudokuExThree[i][j];
      }
   }
} 
//=================================================================================
void sudokuPrimative()
{
   for(int j=0;j<9;j++)
   {
      for(int i=0;i<9;i++)
      {
         cellNumber[j][i]=sudokuPrimative[j][i];
      }
   } 
}
//============================================================================================
void sudokuBase()
{
   for(int j=0;j<9;j++)
   {
      for(int i=0;i<9;i++)
      {
         cellNumber[j][i]=sudokuBase[j][i];
      }
   } 
}
//============================================================================================
byte trySolve(boolean outputSolution)
{  
   int iStart=0, jStart=0;
   int numCouldBeHoriCounter,numCouldBeVertCounter,numCouldBeThreeByThreeCounter;
   int[] oneToNine={1,2,3,4,5,6,7,8,9};
   int[][] cellValue=new int[9][9];
   int[][][] cellCouldBe=new int[9][9][9];
   int sudokuCheckCounter;
   boolean sudokuCheckCompleteCorrectStatus;
   //--- 
   for(int i=0;i<9;i++)
   {
      for(int j=0;j<9;j++)
      {
         trySolveSudoku[j][i]=cellNumber[j][i];
         cellValue[j][i]=trySolveSudoku[j][i];
      }
   }   
   //--- initialising "cellCouldBe"
   for(int j=0;j<9;j++)
   {
      for(int i=0;i<9;i++)
      {         
          for(int k=0;k<9;k++)
          {
             cellCouldBe[j][i][k]=oneToNine[k];
          }   
      }
   } 
   //---------------------------------------------------------
   for(int t=0;t<200;t++)
   {  
      sudokuSpoiltStatus=false;
      for(int num=1;num<=9;num++)
      {
         for(int j=0;j<9;j++)
         {
            if(elementTimesInSet(num,cellValue[j])>1){sudokuSpoiltStatus=true;}
         }
         for(int i=0;i<9;i++)
         {
            for(int j=0;j<9;j++)
            {
               tempColumn[j]=cellValue[j][i];
            }
            if(elementTimesInSet(num,tempColumn)>1){sudokuSpoiltStatus=true;}
         }
         for(int i=0;i<3;i++)
         {
            for(int j=0;j<3;j++)
            {
               for(int m=0;m<3;m++)
               {
                  for(int n=0;n<3;n++)
                  {
                     tempThreeByThree[3*m+n]=cellValue[j*3+n][i*3+m];
                  }
               }
               if(elementTimesInSet(num,tempThreeByThree)>1){sudokuSpoiltStatus=true;}
            }
         }
      } 
      if(sudokuSpoiltStatus==true)
      {
         JOptionPane.showMessageDialog(null,"This Sudoku has been spoilt.");
         return(2);
      }
      else //----------------------------
      {      
         int cellFilledCounter=0;
         for(int j=0;j<9;j++)
         {
            for(int i=0;i<9;i++)
            {
               if(cellValue[j][i]==0)
               {   
                  if(howManyZeros(cellCouldBe[j][i])==8)
                  {
                      cellValue[j][i]=numberNotZero(cellCouldBe[j][i]);
                  }
                  for(int num=1;num<=9;num++)
                  {
                     if(elementOfSet(num,cellCouldBe[j][i])==true)
                     {  
                        numCouldBeHoriCounter=0;
                        numCouldBeVertCounter=0;
                        for(int k=0;k<9;k++)
                        {
                           if(elementOfSet(num,cellCouldBe[j][k])==true)
                           {
                              numCouldBeHoriCounter++; 
                           }
                           if(elementOfSet(num,cellCouldBe[k][i])==true)
                           {
                              numCouldBeVertCounter++; 
                           }
                        }
                        numCouldBeThreeByThreeCounter=0;
                        if(i<=2){iStart=0;}
                        else if(i>=3 && i<=5){iStart=3;}
                        else if(i>=6){iStart=6;}
                        if(j<=2){jStart=0;}
                        else if(j>=3 && j<=5){jStart=3;}
                        else if(j>=6){jStart=6;}              
                        for(int n=jStart;n<jStart+3;n++)
                        {
                           for(int m=iStart;m<iStart+3;m++)
                           {
                              if(elementOfSet(num,cellCouldBe[n][m])==true)
                              {
                                 numCouldBeThreeByThreeCounter++;
                              }  
                           }
                        }
                        if(numCouldBeHoriCounter==1 || numCouldBeVertCounter==1 || numCouldBeThreeByThreeCounter==1)
                        {
                           cellValue[j][i]=num;
                        } 
                     }  
                  }  
               }
               if(cellValue[j][i]!=0)
               {
                  cellFilledCounter++;
                  if(cellFilledCounter==81){t=201;}
                  for(int k=0;k<9;k++)
                  {
                     if(cellValue[j][i]!=k+1)
                     {
                        cellCouldBe[j][i][k]=0;
                     }  
                     if(j!=k)
                     {
                        cellCouldBe[k][i][cellValue[j][i]-1]=0;
                     }
                     if(i!=k)
                     {
                        cellCouldBe[j][k][cellValue[j][i]-1]=0;
                     }                  
                  }  
                  if(i<=2){iStart=0;}
                  else if(i>=3 && i<=5){iStart=3;}
                  else if(i>=6){iStart=6;}
                  if(j<=2){jStart=0;}
                  else if(j>=3 && j<=5){jStart=3;}
                  else if(j>=6){jStart=6;}              
                  for(int n=jStart;n<jStart+3;n++)
                  {
                     for(int m=iStart;m<iStart+3;m++)
                     {
                        if(m!=i && n!=j)
                        {
                           cellCouldBe[n][m][cellValue[j][i]-1]=0;
                        }  
                     }
                  }
               }  
            }
         }
      }
   }  
   //--------------------------------------
   sudokuCheckCompleteCorrectStatus=false;
   sudokuCheckCounter=0;
   for(int num=1;num<=9;num++)
   {
      for(int j=0;j<9;j++)
      {
         if(elementOfSet(num,cellValue[j])==true){sudokuCheckCounter++;}
      }
      for(int i=0;i<9;i++)
      {
         for(int j=0;j<9;j++)
         {
            tempColumn[j]=cellValue[j][i];
         }
         if(elementOfSet(num,tempColumn)==true){sudokuCheckCounter++;}
      }
      for(int i=0;i<3;i++)
      {
         for(int j=0;j<3;j++)
         {
            for(int m=0;m<3;m++)
            {
               for(int n=0;n<3;n++)
               {
                  tempThreeByThree[3*m+n]=cellValue[j*3+n][i*3+m];
               }
            }
            if(elementOfSet(num,tempThreeByThree)==true){sudokuCheckCounter++;}
         }
      }   
   }
   if(sudokuCheckCounter==243)
   {
      sudokuCheckCompleteCorrectStatus=true;
   }   
   //------------------------------------------------------------ 
   if(outputSolution==true)
   {
      for(int j=0;j<9;j++)
      {
         for(int i=0;i<9;i++)
         {   
            cellNumber[j][i]=cellValue[j][i];
         }
      }
   }
   if(sudokuCheckCompleteCorrectStatus==true)
   {
      return(1);
   }
   else
   {
      return(0);
   }   
}
//=================================================================================
int howManyZeros(int[] array)
{
   int zeroCount=0;
   for(int k=0;k<array.length;k++)
   {
      if(array[k]==0){zeroCount++;};
   }
   return(zeroCount);
}
//=================================================================================
int numberNotZero(int[] array)
{
   for(int k=0;k<array.length;k++)
   {
      if(array[k]!=0)
      {
         return(array[k]);
      }
   }
   return(0);
}   
//=================================================================================
boolean elementOfSet(int element, int[] set)
{ 
  boolean elementOfSetValue=false;
  for(int ii=0; ii<set.length;ii++)
  {
     if(set[ii]==element){elementOfSetValue=true; return(true);}
  }
  return(elementOfSetValue);
} 
//=================================================================================
int elementTimesInSet(int element, int[] set)
{ 
  int elementTimesInSetValue=0;
  for(int ii=0; ii<set.length;ii++)
  {
     if(set[ii]==element){elementTimesInSetValue++;}
  }
  return(elementTimesInSetValue);
} 
//================================================================================
void scramble()
{  
   int randomNumber;
   sudokuTrySolveStatus=trySolve(doNotDisplaySolution);
   if(sudokuTrySolveStatus==2)
   {
      sudokuSpoiltStatus=true;
   }
   else
   {
      sudokuSpoiltStatus=false;
   }
   //---------------------------------------------------------
   if(sudokuSpoiltStatus==false)
   {
      for(int scrambleIndex=0; scrambleIndex<=200; scrambleIndex++)
      {
         randomNumber=int(1+random(24));
         switch(randomNumber)
         {  
            case(1):{swapRows(0,1);break;}
            case(2):{swapRows(0,2);break;}
            case(3):{swapRows(1,2);break;}         
            case(4):{swapRows(3,4);break;}
            case(5):{swapRows(3,5);break;}
            case(6):{swapRows(4,5);break;}   
            case(7):{swapRows(6,7);break;}
            case(8):{swapRows(6,8);break;}
            case(9):{swapRows(7,8);break;}
            case(10):{swapRows(0,3);swapRows(1,4);swapRows(2,5);break;}
            case(11):{swapRows(0,6);swapRows(1,7);swapRows(2,8);break;}
            case(12):{swapRows(3,6);swapRows(4,7);swapRows(5,8);break;}         
            case(13):{swapColumns(0,1);break;}
            case(14):{swapColumns(0,2);break;}
            case(15):{swapColumns(1,2);break;}         
            case(16):{swapColumns(3,4);break;}
            case(17):{swapColumns(3,5);break;}
            case(18):{swapColumns(4,5);break;}   
            case(19):{swapColumns(6,7);break;}
            case(20):{swapColumns(6,8);break;}
            case(21):{swapColumns(7,8);break;}   
            case(22):{swapColumns(0,3);swapColumns(1,4);swapColumns(2,5);break;}
            case(23):{swapColumns(0,6);swapColumns(1,7);swapColumns(2,8);break;}
            case(24):{swapColumns(3,6);swapColumns(4,7);swapColumns(5,8);break;}
         }
         randomNumber=int(1+random(36));
         switch(randomNumber)
         {
            case(1):{swapDigits(1,2);break;}
            case(2):{swapDigits(1,3);break;}
            case(3):{swapDigits(1,4);break;}
            case(4):{swapDigits(1,5);break;}
            case(5):{swapDigits(1,6);break;}
            case(6):{swapDigits(1,7);break;}
            case(7):{swapDigits(1,8);break;}
            case(8):{swapDigits(1,9);break;}  
            case(9):{swapDigits(2,3);break;}
            case(10):{swapDigits(2,4);break;}
            case(11):{swapDigits(2,5);break;}
            case(12):{swapDigits(2,6);break;}
            case(13):{swapDigits(2,7);break;}
            case(14):{swapDigits(2,8);break;}
            case(15):{swapDigits(2,9);break;}   
            case(16):{swapDigits(3,4);break;}
            case(17):{swapDigits(3,5);break;}
            case(18):{swapDigits(3,6);break;}
            case(19):{swapDigits(3,7);break;}
            case(20):{swapDigits(3,8);break;}
            case(21):{swapDigits(3,9);break;}
            case(22):{swapDigits(4,5);break;}
            case(23):{swapDigits(4,6);break;}
            case(24):{swapDigits(4,7);break;}
            case(25):{swapDigits(4,8);break;}
            case(26):{swapDigits(4,9);break;}      
            case(27):{swapDigits(5,6);break;}
            case(28):{swapDigits(5,7);break;}
            case(29):{swapDigits(5,8);break;}
            case(30):{swapDigits(5,9);break;}
            case(31):{swapDigits(6,7);break;}
            case(32):{swapDigits(6,8);break;}
            case(33):{swapDigits(6,9);break;}         
            case(34):{swapDigits(7,8);break;}
            case(35):{swapDigits(7,9);break;}  
            case(36):{swapDigits(8,9);break;}           
         }  
      }
   }
}  
//=================================================================================
void swapRows(int rowA, int rowB)
{
   int[] tempRow=new int[9];
   for(int i=0;i<9;i++)
   {
      tempRow[i]=cellNumber[rowB][i];
      cellNumber[rowB][i]=cellNumber[rowA][i];
      cellNumber[rowA][i]=tempRow[i];
   }  
}
//=================================================================================
void swapColumns(int columnA, int columnB)
{
   int[] tempColumn=new int[9];
   for(int j=0;j<9;j++)
   {
      tempColumn[j]=cellNumber[j][columnB];
      cellNumber[j][columnB]=cellNumber[j][columnA];
      cellNumber[j][columnA]=tempColumn[j];
   }  
}
//=================================================================================
void swapDigits(int digitA, int digitB)
{
   for(int j=0;j<9;j++)
   {
      for(int i=0;i<9;i++)
      {
         if(cellNumber[j][i]==digitA)
         {
            cellNumber[j][i]=digitB;
         }
         else if(cellNumber[j][i]==digitB)
         {
            cellNumber[j][i]=digitA;
         }         
      }
   }   
}
//=================================================================================
void unfill()
{
   int[] listOfCells=new int[81];
   int[] nextListOfCells;
   int randomNumber;
   int nn;
   int valueBeforeUnfilling;
   int tryUnfillCell,tryUnfillI,tryUnfillJ;
   sudokuTrySolveStatus=trySolve(doNotDisplaySolution);
   if(sudokuTrySolveStatus==2)
   {
      sudokuSpoiltStatus=true;
   }
   else
   {
      sudokuSpoiltStatus=false;
   }
   //---------------------------------------------------------
   if(sudokuSpoiltStatus==false)
   {
      for(int k=1;k<=81;k++)
      {
         listOfCells[k-1]=k;
      }
      for(int kk=1;kk<=81;kk++)
      {  
         randomNumber=int(random(listOfCells.length));
         tryUnfillCell=listOfCells[randomNumber];
         listOfCells[randomNumber]=0; 
         //----------------------------------------------------
         nextListOfCells=new int[listOfCells.length-1];
         nn=0;
         for(int m=0;m<listOfCells.length;m++)
         {
            if(listOfCells[m]!=0)
            {
               nextListOfCells[nn]=listOfCells[m];
               nn++;
            }
         }
         listOfCells=new int[nextListOfCells.length];
         for(int m=0;m<listOfCells.length;m++)
         {
            listOfCells[m]=nextListOfCells[m];
         }  
         //-----------------------------------------------------
         tryUnfillI=(tryUnfillCell-1)%9;
         tryUnfillJ=(tryUnfillCell-tryUnfillI)/9;
         valueBeforeUnfilling=cellNumber[tryUnfillJ][tryUnfillI];
         cellNumber[tryUnfillJ][tryUnfillI]=0;
         sudokuTrySolveStatus=trySolve(doNotDisplaySolution);
         if(sudokuTrySolveStatus==0)
         {
            cellNumber[tryUnfillJ][tryUnfillI]=valueBeforeUnfilling;
         }  
      }
   }
}
//=================================================================================
void generate()
{
   sudokuBase();
   scramble();
   unfill();
}
//=================================================================================
