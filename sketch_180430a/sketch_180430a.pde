
import java.util.*;
PrintWriter output;
PrintWriter output2;
PrintWriter output3;
PrintWriter output4;
BufferedReader read;
BufferedReader read2;
BufferedReader read3;
int[][] points=new int[50][50];
int[][] spoints=new int[50][50];
int[][] ipoints=new int[50][50];
int l=0, m=0, n=0;
static int col=10;
void setup() 
{
  size(640, 640);
  output = createWriter("positions.txt");
  output2 = createWriter("strategic.txt");
  output3 = createWriter("Ipositions.txt");
  output4 = createWriter("Intersection.txt");
  read2 = createReader("strategic.txt");
  read = createReader("positions.txt");
  read3 = createReader("Ipositions.txt");
  frameRate(10);
}
void writeIcords()
{
  if (mousePressed) {
    strokeWeight(4);
    point(mouseX, mouseY);
    println(mouseX+""+mouseY);
    output3.println(mouseX + "\t" + mouseY);
  }
}

void writeStrats()
{
  if (mousePressed) {
    point(mouseX, mouseY);
    println(mouseX+""+mouseY);
    output2.println(mouseX + "\t" + mouseY);
  }
}
void writeCords()
{
  if (mousePressed) {
    strokeWeight(10);
    point(mouseX,mouseY);
    output.println(mouseX + "\t" + mouseY);
  }
}
int leftOf(int spointx, int spointy, int pointx1, int pointy1, int pointx2, int pointy2)
{
  int a=0, b=0, c=0, d=0, f=0;
  a=spointx-pointx1;
  b=spointy-pointy1;
  c=pointy2-pointy1;
  d=pointx2-pointx1;
  f=(a*c)-(b*d);
  return(f);
}
boolean lineLineIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4 ) {
  boolean over = false;
  float a1 = (y2) - (y1);
  float b1 = (x1) - (x2);
  float c1 = a1*x1 + b1*y1;

  float a2 = y4 - y3;
  float b2 = x3 - x4;
  float c2 = a2*x3 + b2*y3;

  float det = a1*b2 - a2*b1;
  if (det == 0) {
    // Lines are parallel
  } else {
    float x = (b2*c1 - b1*c2)/det;
    float y = (a1*c2 - a2*c1)/det;
    if (x > min(x1, x2) && x < max(x1, x2) && 
      x > min(x3, x4) && x < max(x3, x4) &&
      y > min(y1, y2) && y < max(y1, y2) &&
      y > min(y3, y4) && y < max(y3, y4)) {
      over = true;
    }
  }
  return over;
}

void intersect(int[][] pos)
{
  int[][] arr=new int[50][50];
  int[] arr1=new int[50];
  int[] arr2=new int[50];
  int k=0, i, j, h;
  Set<Integer> s1 =new HashSet<Integer>();
  Set<Integer> s2 =new HashSet<Integer>();
  Set<Integer> temp =new HashSet<Integer>();
  for (i=0; pos[0][i]!=100; i++)
  {
    s1.add(pos[0][i]);
  }
  for (i=1; i<n; i++)
  {
    println("S1: ", s1);
    s2.clear();
    println("S2: ", s2);
    for (j=0; pos[i][j]!=100; j++)
    {
      s2.add(pos[i][j]);
    }
    println(s1+" "+s2);
    temp.addAll(s1);
    s1.retainAll(s2);
    println("s1: "+s1);
    if (!s1.isEmpty())//There is always an intersection
    {
      println(s1);
    }
     else//There is not necessarily an intersection
    {
      println("Here");
      h=0;
      for(Integer s: temp)
      {
        println("To colorize: ",s);
        arr1[h++]=s;
      }
      colorize(arr1,temp.size());
  
      k++;
      
      s1.addAll(s2);
      
      if(i==(n-1))
      {
        h=0;
        for(Integer s: s2)
        {
          println("To colorize: ",s);
          arr1[h++]=s;
        }
        colorize(arr1,s2.size());
      }
    }
    
  }
  
   h=0;
      for(Integer s: s1)
        arr1[h++]=s;
      colorize(arr1,s1.size());
  k=k+1;
  println("Minimum number of guards: "+k);
}
int[] intersect(int[][] pos, int xx)
{
  int[] arr=new int[50];
  
  int k=0, i, j, h,hh;
  Set<Integer> s1 =new HashSet<Integer>();
  Set<Integer> s2 =new HashSet<Integer>();
  Set<Integer> temp =new HashSet<Integer>();
  if(xx>0)
  {
    for (i=0; pos[0][i]!=100; i++)
    {
      s1.add(pos[0][i]);
    }
    for (i=1; i<xx; i++)
    {
      println("S1: ", s1);
      s2.clear();
      println("S2: ", s2);
      for (j=0; pos[i][j]!=100; j++)
      {
        s2.add(pos[i][j]);
      }
      println(s1+" "+s2);
      
      s1.retainAll(s2);
      println("s1: "+s1);
      if (!s1.isEmpty())//There is always an intersection
      {
        println(s1);
      }
       else//There is not necessarily an intersection
      {
        
        temp.addAll(s1);
        println("Set value:"+temp);
        k++;
        println("No. of sets: ", k);
        
        s1.addAll(s2);
        println("s1 after copy: "+ s1);
      }
      
    }
    println("Set value:"+temp);
    println("k value: ", k);
    
    k=k+1;
        
  }

      h=0;
        for(Integer s: s1)
        {
          arr[h++]=s;
        }
        arr[h]=100;
        
        colorize(arr,s1.size());
  println("Minimum number of guards: "+k);
  return arr;
}
void colorize(int[] pos, int p)
{

  for (int i=0; i<p; i++)
  {
    stroke(160, 0, 0);
    int k=pos[i];
    point(points[k][0], points[k][1]);
  }
}

void colorize(int[][] pos, int p, int c)
{

  for (int i=0; i<p; i++)
  {
    
    stroke(126, 0, 0);
    int k=pos[c][i];
    point(points[k][0], points[k][1]);
  }
}
void readStrats()
{
  String line=null;
  int i=0, j=0, f=0, prev=0, k=0, p=0, pp=0;
  float ax, ay, bx, by, cx, cy, dx, dy;
  boolean flag=false;
  int[][] pos=new int[50][50];
  try {
    while ((line=read2.readLine())!=null) {
      String[] pieces=split(line, "\t");
      if (i>=(m+l))
      {
        
        spoints[j][0]=int(pieces[0]);
        spoints[j][1]=int(pieces[1]);
        j++;
      }
      i++;
    }
    read2.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  n=j;
  println("l: "+l+" m: "+m+" n: "+n);
  if (m==0)//Hole is not present
  {
    for (i=0; i<n; i++)
    {
      cx=spoints[i][0];
      cy=spoints[i][1];
      pp=p;
      p=0;
      
      for (j=0; j<l; j++)
      {
        dx=points[j][0];
        dy=points[j][1];
        for (k=0; k<l; k++)
        {

          ax=points[k][0];
          ay=points[k][1];
          bx=points[k+1][0];
          by=points[k+1][1];
          
          if (lineLineIntersect(ax, ay, bx, by, cx, cy, dx, dy) == true) {
            flag=true;
            break;
          }
        }
        if (flag==false)
        {
          
          pos[i][p]=j;
          p++;
        } else {
          //println("Here");
          flag=false;
        }
      }
      pos[i][p]=100;
    }
    
    intersect(pos);
  }
   else//Hole is present
  {
    int[][] lvertex=new int[50][50];
    int[][] lstrats=new int[50][50];
    int[] arr=new int[50];
    //println("M & L values: ",m,l);
    for (int g=0; g<m; g++)
    {
      int o=0,oo=0;
      for (int h=0; h<l; h++)
      {
        //println("Values given to leftt: ", points[h][0], points[h][1], ipoints[g][0], ipoints[g][1], ipoints[g+1][0], ipoints[g+1][1]);
        f=leftOf(points[h][0], points[h][1], ipoints[g][0], ipoints[g][1], ipoints[g+1][0], ipoints[g+1][1]);
        //println("f value "+f);
        if (f>0)
        {
          lvertex[o][0]=points[h][0];
          lvertex[o][1]=points[h][1];
          o++;
        }
      }
      for (int h=0; h<n; h++)
      {
        //println("Strats given to left: ", spoints[h][0], spoints[h][1], ipoints[g][0], ipoints[g][1], ipoints[g+1][0], ipoints[g+1][1]);
        f=leftOf(spoints[h][0], spoints[h][1], ipoints[g][0], ipoints[g][1], ipoints[g+1][0], ipoints[g+1][1]);
        //println("f value "+f);
        if (f>0)
        {
          lstrats[oo][0]=spoints[h][0];
          lstrats[oo][1]=spoints[h][1];
          oo++;
        }
      }
      println("O value: "+o);
      println("Vertices of subpolygon: "+g);
      for (int gg=0; gg<o; gg++)
      {
        //println("here");
        println(lvertex[gg][0]+" " +lvertex[gg][1]);
      }
      println("OO value: "+oo);
      println("Strats of subpolygon: "+g);
      for (int gg=0; gg<oo; gg++)
      {
        //println("here");
        println(lstrats[gg][0]+" " +lstrats[gg][1]);
      }
      for (i=0; i<oo; i++)
      {
        cx=lstrats[i][0];
        cy=lstrats[i][1];
        p=0;
        //println("For point "+spoints[i][0]+" "+spoints[i][1]);
        for (j=0; j<o; j++)
        {
          dx=lvertex[j][0];
          dy=lvertex[j][1];
          for (k=0; k<l; k++)
          {

            ax=lvertex[k][0];
            ay=lvertex[k][1];
            bx=lvertex[k+1][0];
            by=lvertex[k+1][1];
            //println(points[j][0]+" "+points[j][1]+" "+points[j+1][0]+" "+points[j+1][1]);
            if (lineLineIntersect(ax, ay, bx, by, cx, cy, dx, dy) == true) {
              flag=true;
              break;
            }
          }
          if (flag==false)
          {
            //println(points[j][0]+" "+points[j][1]+" is visible");
            pos[i][p]=j;
            p++;
          } else {
            //println("Here");
            flag=false;
          }
        }
        pos[i][p]=100;
        
        }
    println("oo: "+oo);
    arr=intersect(pos,oo);
    for(int ii=0;arr[ii]!=100;ii++)
      println("Returned value: "+ arr[ii]);
    
    }
  } 
  
}
void readIcords()
{
  String line=null;
  int i=0, j=0;
  //println("Here");
  try {
    while ((line=read3.readLine())!=null) {
      String[] pieces=split(line, "\t");
      //println("Here");
      if (i>=l)
      {
        ipoints[j][0]=int(pieces[0]);
        ipoints[j][1]=int(pieces[1]);
        j++;
      }
      i++;
    }
    read3.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  //println(j);
  m=j;
  if (m>0)
  {
    //println("m value "+m);
    ipoints[m][0]=ipoints[0][0];
    ipoints[m][1]=ipoints[0][1];
    for (j=0; j<m; ) {
      //println(points[j][0]+" "+points[j][1]);
      strokeWeight(1);
      line(ipoints[j][0], ipoints[j][1], ipoints[j+1][0], ipoints[j+1][1]);
      
      j=j+1;
    }
    
  }
}
void readCords()
{
  String line=null;
  int i=0;
  try {
    while ((line=read.readLine())!=null) {
      String[] pieces=split(line, "\t");
      points[i][0]=int(pieces[0]);
      points[i][1]=int(pieces[1]);
      i++;
    }
    read.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  l=i;
  points[l][0]=points[0][0];
  points[l][1]=points[0][1];
  for (i=0; i<l; ) {
    strokeWeight(1);
    //println(points[i][0]+" "+points[i][1]);
    line(points[i][0], points[i][1], points[i+1][0], points[i+1][1]);
    
    i=i+1;
  }
  
}
void draw() 
{
  writeCords();
  writeIcords();
  writeStrats();
}

void keyPressed() {// Press a key to save the data
  if (key=='1') {
    output.flush(); // Write the remaining data
    output.close(); // Finish the file
    readCords();
    // Stop the program
  }
  if (key=='2')
  {
    output3.flush();
    output3.close();
    readIcords();
    //exit();
  }
  if (key=='3')
  {
    output2.flush();
    output2.close();
    readStrats();
    //exit();
  }
}