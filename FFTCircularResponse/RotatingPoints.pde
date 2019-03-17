class RotatingPoints extends Shape implements IDrawable, IExpandable
/*
Creates a circle of rotating ellipses of defined radius and number of points
 */

{
  int numPoints;
  float radius;
  float inc = 0;
  float speedOfRotation = 0.0010;
  boolean clockwise = true;
  boolean drawLine = false;
  int direction = 1;
  int STROKE_WEIGHT = 5;
  float expandValue = 0;

  public RotatingPoints()
  {
    super();
    this.numPoints = 20;
    this.radius = 350;
  }

  public RotatingPoints(float radius, int numPoints)
  {
    super();
    this.radius = radius;
    this.numPoints = numPoints;
  }

  public void setSpeedOfRotation(float speedOfRotation)
  {
    this.speedOfRotation = speedOfRotation;
  }

  public void setClockwise(boolean clockwise)
  {
    this.clockwise = clockwise;
    if (clockwise) 
      this.direction = 1;
    else
    {
      this.direction = -1;
    }
  }

  public boolean isClockwise()
  {
    return this.clockwise;
  }

  public void setDrawLine(boolean drawLine)
  {
    this.drawLine = drawLine;
  }

  public boolean getDrawLine()
  {
    return this.drawLine;
  }

  public void expand(float expandValue)
  {
    this.expandValue = expandValue;
  }

  public void draw()
  {
    float angle = TWO_PI/(float)this.numPoints;
    int numColors = new Shades().getPaletteSize();
    float colorDivider = this.numPoints / numColors;
    println(colorDivider);
    println("col divider");
    if (inc == 360)
    {
      inc = 0;
    }

    for (int i = 0; i<this.numPoints; i++)
    {
      float p1x = this.radius*sin((angle*i)+inc) + width/2;
      float p1y = this.radius*cos((angle*i)+inc) + height/2;

      // divide the coloring into sectors. Number of sectors = number of colors in the shades palette
      int colSelect = int(i / colorDivider);

      strokeWeight(STROKE_WEIGHT);
      stroke(new Shades().get(colSelect+1));
      point(p1x, p1y, random(-this.expandValue, 50 + this.expandValue));

      drawLineBetweenPoints(p1x, p1y);
    }

    inc+=(this.speedOfRotation*this.direction);
  }

  void drawLineBetweenPoints(float p1x, float p1y)
  {
    if (this.getDrawLine())
    {
      smooth();
      strokeWeight(2);
      line(width/2, height/2, -this.expandValue, p1x, p1y, 20+this.expandValue);
    }
  }
}
