class Cell
{
  //Object characteristics
  static final int w = MazeGenerator.w;
  public int x,y;
  public boolean visited=false,
          top=true,
          bottom=true,
          right=true,
          left=true;
          
  //Constructor
  Cell(int x, int y){
    this.x=x;
    this.y=y;
  }
  
  //Draw the cell
  public void draw(){  
    if(visited){
      fill(255,0,0);
      noStroke();
      rect(x,y,w,w);
      noFill();
      stroke(1);
    }
    
    if(top)
      line(x,  y,  x+w,  y);
    if(bottom)
      line(x,  y+w,  x+w,  y+w);
    if(right)
      line(x+w,  y,  x+w,  y+w);
    if(left)
      line(x,  y,  x,  y+w);
  }
  
  //Randomly choose a neighbour cell among the accesible ones
  public Cell pickNeighbour(){
    int i=x/w, 
        j=y/w;
    Stack neighbours = new Stack();
    
      //CHECK up Cell
    if(j-1>=0 && !MazeGenerator.mat[i][j-1].visited) neighbours.push(MazeGenerator.mat[i][j-1]);
    
      //CHECK down Cell
    if(j+1<MazeGenerator.mat[0].length && !MazeGenerator.mat[i][j+1].visited) neighbours.push(MazeGenerator.mat[i][j+1]);
    
      //CHECK right Cell
    if(i+1<MazeGenerator.mat.length && !MazeGenerator.mat[i+1][j].visited) neighbours.push(MazeGenerator.mat[i+1][j]);
    
      //CHECK left Cell
    if(i-1>=0 && !MazeGenerator.mat[i-1][j].visited) neighbours.push(MazeGenerator.mat[i-1][j]);
    
    if(!neighbours.empty())
      return (Cell)neighbours.elementAt((int)random(neighbours.size()));
    else
      return null;
  }
  
  //Print the maze structure
  public String serialize(){
    String serial = "";
    serial += x+";";
    serial += y+";";
    serial += top+";";
    serial += bottom+";";
    serial += right+";";
    serial += left+";";
    return serial;
  }
}