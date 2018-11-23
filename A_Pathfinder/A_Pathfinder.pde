//A* Pathfinder
//Coded by DrW0if
//Github : https://github.com/DrW0if

import java.util.PriorityQueue;
import java.util.Comparator;

//Width of each cell
static int w = 10;

static int W,H;
           
boolean save = false;

Cell nodes[][];
Cell current = null;

PriorityQueue<Cell> queue = new PriorityQueue<Cell>(new Comparator<Cell>(){
  public int compare(Cell a, Cell b){
    if(a.fx < b.fx)
      return -1;
    if(a.fx == b.fx)
      return 0;
      
    return 1;
  }
});


void setup(){
  //Size of the window
  size(400, 400);
  
  W = width/w;
  H = height/w;
   
  nodes = new Cell[H][W];
 
  //Creo la matrice di nodi
  for(int i = 0; i < H; i++)
    for(int j = 0; j < W; j++){
      if(random(1) < 0.2 && ((i != 0 && j != 0) || (i!=H-1 && j!=W-1)))
        nodes[i][j] = new Cell(i, j, width/W, true);
      else{
        nodes[i][j] = new Cell(i, j, width/W);
      
        if(i>0 && !nodes[i-1][j].ostacolo){
          nodes[i][j].adiacenti.add(nodes[i-1][j]);
          nodes[i-1][j].adiacenti.add(nodes[i][j]);
        }
        if(j%W > 0 && !nodes[i][j-1].ostacolo){
          nodes[i][j].adiacenti.add(nodes[i][j-1]);
          nodes[i][j-1].adiacenti.add(nodes[i][j]);
        }
      }
  }
  
  nodes[0][0].ostacolo = false;
  nodes[H-1][W-1].ostacolo = false;
  
  nodes[0][0].gx = 0;
  
  queue.add(nodes[0][0]);
  //frameRate(10);
}

void draw(){
  //Draw all the cells
  background(255);
  stroke(255);
  for(int i = 0; i < H; i++)
    for(int j = 0; j < W; j++)
      nodes[i][j].show();
      
  if(save)
    saveFrame("output/####.png");
  
  //Retrieve First element
  current = queue.poll();
  
  if(current == null){
    println("No available solution!");
    noLoop();
    return;
  }
  
  if(current == nodes[H-1][W-1]){
    println("Path found!");
    drawPath(current);
    noLoop();
    return;
  }
  
  //Calculate the f(x) for every neighbour and add it to the queue
  for(int i = 0; i < current.adiacenti.size(); i++){
    Cell app = current.adiacenti.get(i);
    if(app.gx > current.gx + 1){
      app.gx = current.gx + 1;
      app.hx = manhattanDistance(app.i, app.j);
      app.fx = app.gx + app.hx;
      app.father = current;
      queue.add(app);
    }
  }
  
  drawPath(current);
}

void drawPath(Cell current){
  stroke(255,0,0);
  strokeWeight(5);
  beginShape();
  while(current != null){
    vertex(current.i*current.w + current.w/2, current.j*current.w + current.w/2);
    current = current.father;
  }
  endShape();
  strokeWeight(1);
  noStroke();
  if(save)
    saveFrame("output/####.png");
}

int manhattanDistance(int x, int y){
  return (Math.abs(x-W) + Math.abs(y-H));
}

private class Cell{
  
  //f(x), g(x) 
  int fx = Integer.MAX_VALUE, gx = fx, hx = gx;
  
  int i,j;
  int w;
  boolean ostacolo;
  ArrayList<Cell> adiacenti = new ArrayList<Cell>();
  Cell father = null;
  
  public Cell(int i, int j,int w, boolean ostacolo){
    this.i = i;
    this.j = j;
    this.w = w;
    this.ostacolo = ostacolo;
  }
  
  public Cell(int i, int j, int w){
    this(i, j, w, false);
  }
  
  public void show(){
    fill(0);
    if(ostacolo)
      ellipse(i*w+w/2,j*w+w/2, w, w);
    noFill();
  }

}