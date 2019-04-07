public class Shades
{

  int p1;
  int p2;
  int p3;
  int p4;
  int p5;

  int NUM_COLORS = 5;

  public Shades()
  {

    // Material Palette 300
    // https://material.io/tools/color/#!/?view.left=0&view.right=0
    this.p1 = color(255, 128, 101);
    this.p2 = color(255, 183, 77);
    this.p3 = color(255, 213, 79);
    this.p4 = color(255, 241, 118);
    this.p5 = color(220, 231, 117);
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
