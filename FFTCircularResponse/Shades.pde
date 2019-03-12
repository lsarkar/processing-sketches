public class Shades
{

  int p1;
  int p2;
  int p3;
  int p4;
  int p5;
  
  ArrayList colors;
  
  int[] cols = new int[5];
  
  int MAX_SHADES = 5;
  
  public Shades()
  {
     colors = new ArrayList();
     colors.add(p1);
     colors.add(p2);
     colors.add(p3);
     colors.add(p4);
     colors.add(p5);
     
    // Material Palette 300
    // https://material.io/tools/color/#!/?view.left=0&view.right=0
    this.p1 = color(255, 128, 101);
    this.p2 = color(255, 183, 77);
    this.p3 = color(255, 213, 79);
    this.p4 = color(255, 241, 118);
    this.p5 = color(220, 231, 117);
    
  }
  
  public int get(int colorNumber)
  {
       return (int) this.colors.get(colorNumber);  
  }
  
  public int getPrimary()
  {
    return this.p1;
  }

  public int getSecondary()
  {
    return this.p2;
  }

  public int getThird()
  {
    return this.p3;
  }
  
  public int getFourth()
  {
    return this.p4; 
  }
  
  public int getFifth()
  {
     return this.p5; 
  }
}
