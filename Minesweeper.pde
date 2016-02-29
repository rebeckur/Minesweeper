

import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20; //Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < NUM_ROWS; i++)
    {
        for (int j = 0; j < NUM_COLS; j++)
        {
            buttons[i][j] = new MSButton(i, j);
        }
    }
    for (int i = 0; i < 23; i++)
    {
        setBombs();
    }
    //System.out.println(bombs.size());
}
public void setBombs()
{
    //your code
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    if(bombs.contains(buttons[row][col]))
    {
        row = (int)(Math.random()*20);
        col = (int)(Math.random()*20);
    }
    bombs.add(buttons[row][col]);
    //System.out.println("ROW: " + row + " COL:" + col);
}

public void draw ()
{
    background(0);
    if(isWon())
    {
        displayWinningMessage();
        noLoop();
    }   
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    for (MSButton bomb : bombs)
    {
        bomb.setClicked(true);
    }
    fill(150, 150, 150, 400);
    rect(170, 185, 60, 30);
    //noLoop();
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if (mouseButton == LEFT)
        {
            clicked = true;
        }
        //your code here
        if (mouseButton == RIGHT)
        {
            marked = !marked;
        }
        else if (bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if (countBombs(r, c) > 0)
        {
            label = "" + countBombs(r, c);
        }
        else
        {
            if (isValid(r,c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();
            if (isValid(r,c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                buttons[r-1][c-1].mousePressed();
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                buttons[r+1][c-1].mousePressed();
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                buttons[r+1][c+1].mousePressed();
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                buttons[r-1][c+1].mousePressed();
        }
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if (isValid(row+1, col) && bombs.contains(buttons[row+1][col])){numBombs++;}
        if (isValid(row-1, col) && bombs.contains(buttons[row-1][col])){numBombs++;}
        if (isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1])){numBombs++;}
        if (isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1])){numBombs++;}
        if (isValid(row, col+1) && bombs.contains(buttons[row][col+1])){numBombs++;}
        if (isValid(row, col-1) && bombs.contains(buttons[row][col-1])){numBombs++;}
        if (isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1])){numBombs++;}
        if (isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1])){numBombs++;}
        return numBombs;
    }
    public void setClicked(boolean c)
    {
        clicked = c;
    }
}



