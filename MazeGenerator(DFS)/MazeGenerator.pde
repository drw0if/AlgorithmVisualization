//Maze Generator
//Coded by DrW0if
//Github : https://github.com/DrW0if
import java.util.Stack;

static final int w = 10;              //lenght of the cell

static int larghezza;    //Width of the maze
static int altezza;      //height of the maze

//Declaration of stack and maze matrix
Stack stack = new Stack();
static Cell mat[][];
Cell current;
int debug =0;

void setup(){
  //Change dimensions to make screen bigger or smaller
  size(400,400);
  background(255);
  
  larghezza = width/w;
  altezza = height/w;
  
  mat = new Cell[larghezza][altezza];
  
  //Maze initialization
  for(int i=0;i<mat.length;i++)
    for(int j=0;j<mat[0].length;j++)
      mat[i][j] = new Cell(i*w,j*w);
  
  //current = mat[0][0];
  current = mat[0][0];
}

void draw(){
  //saveFrame("output/frame######.png");
  frameRate(25);
  drawMaze();
  
  //Fill rectangle of current Cell
  fill(0,255,0,100);
  rect(current.x,current.y,w,w);
  noFill();
  
  //Mark current as visited
  current.visited = true;
  
  //Pick randomly the next cell
  Cell next = current.pickNeighbour();
  
  if(next==null && stack.empty()){
    return;
  }
  else if(next==null){
    current = (Cell)stack.pop();
  }
  else{
    stack.push(current);
    if(current.x/w==mat.length-1 && current.y/w==mat[0].length-1)
      printRoad();
    //Remove Wall between current and next cell
    removeWall(current,next);
    current = next;
  }
}

void drawMaze(){
  background(255);
  for(int i=0;i<mat.length;i++)
    for(int j=0;j<mat[0].length;j++)
      mat[i][j].draw();
}

//Remove wall between two cells
void removeWall(Cell current, Cell next){
  int app = current.x-next.x;
  if(app>0)
    {current.left=false; next.right=false;}
  else if(app<0)
    {current.right=false; next.left=false;}
  
  app = current.y-next.y;
  if(app>0)
    {current.top=false; next.bottom=false;}
  if(app<0)
    {current.bottom=false; next.top=false;}
}

//Print the actual stack (road from start to the actual cell)
void printRoad(){
  for(int k=0;k<stack.size();k++)
    print("["+((Cell)stack.elementAt(k)).x/w+","+((Cell)stack.elementAt(k)).y/w+"]"+" ");
    
  println();
}

//Create file with maze characteristics
void memorizeMaze(){
  java.io.File file = new File("maze.mze");
  
  if(!file.exists()){
    try{
      file.createNewFile();
    }
    catch(Exception e){
      println("Impossibile creare il file");
    }
  }
  
  try{
  java.io.FileWriter fw = new java.io.FileWriter(file);
  for(int indice1=0;indice1<mat.length;indice1++)
    for(int indice2=0;indice2<mat[0].length;indice2++)
      fw.write(mat[indice1][indice2].serialize());
  fw.close();
  println("Memorizzazione effettuata sul file "+file.getAbsolutePath());
  }
  catch(Exception e){
    println("Impossibile scrivere sul file");
  }
}

void keyPressed(){
  if(keyCode==UP){
    memorizeMaze();
  }
}
