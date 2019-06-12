import java.util.*;

public class Shades
{

  int p1;
  int p2;
  int p3;
  int p4;
  int p5;

  int NUM_COLORS = 5;
  
  List<Integer> colorWheel = new ArrayList<Integer>();

  public Shades()
  {

    // Material Palette 300
    // https://material.io/tools/color/#!/?view.left=0&view.right=0
    this.p1 = color(255, 128, 101);
    this.p2 = color(255, 183, 77);
    this.p3 = color(255, 213, 79);
    this.p4 = color(255, 241, 118);
    this.p5 = color(220, 231, 117);
    
    colorWheel.add(color(239,83,80)); //#ef5350
    colorWheel.add(color(236,64,122)); //#ec407a
    colorWheel.add(color(171,71,188));//#ab47bc
    colorWheel.add(color(126,87,194));//#7e57c2
    colorWheel.add(color(92, 107, 192));//#5c6bc0
    colorWheel.add(color(66,165,245));//#42a5f5
    colorWheel.add(color(41,182,246));//#29b6f6
    colorWheel.add(color(38,198,218));//#26c6da
    colorWheel.add(color(38,166,154));//#26a69a
    colorWheel.add(color(102,187,106));//#66bb6a
    colorWheel.add(color(156,204,101));//#9ccc65
    colorWheel.add(color(212,225,87));//#d4e157
    colorWheel.add(color(255,238,88));//#ffee58
    colorWheel.add(color(255,202,40));//#ffca28
    colorWheel.add(color(255,167,38));//#ffa726
    colorWheel.add(color(255,112,67));//#ff7043
  }
  
  public int getFromList(int idx) {
     return colorWheel.get(idx); 
  }

  public int get(int idx)
  {
    int shadeColor;

    switch (idx) {
    case 1:
      shadeColor = getPrimary();
      break;
    case 2:
      shadeColor = getSecondary();
      break;
    case 3:
      shadeColor = getThird();
      break;
    case 4:
      shadeColor = getFourth();
      break;
    case 5:
      shadeColor = getFifth();
      break;

    default:
      // white default
      shadeColor = color(255);
    }

    return shadeColor;
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

  public int getPaletteSize()
  {
    return NUM_COLORS;
  }
}