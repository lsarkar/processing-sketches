class Expansion
{
  
}

enum ExpansionType
{
    
}

abstract class AbstractCircularPoints extends Shape
{
    float radius;
  
    AbstractCircularPoints(float radius)
    {
       super();
       this.radius = radius;
    }
    
    void setRadius(float radius)
    {
      this.radius = radius;
    }
    
    float getRadius()
    {
      return this.radius;
    }
  
}

class RotatingPoints extends AbstractCircularPoints implements IDrawable, IExpandable
/*
Creates a circle of rotating ellipses of defined radius and number of points
 */

{
  int numPoints;
  float inc = 0;
  float speedOfRotation = 0.0010;
  boolean clockwise = true;
  boolean drawLine = false;
  int direction = 1;
  int STROKE_WEIGHT = 5;
  float expandValue = 0;
  int radiusModulationCounter = 0;
  boolean addFlag = true;
  int expandOffset = 50;

  public RotatingPoints()
  {
    super(350);
    this.numPoints = 20;
  }

  RotatingPoints(float radius, int numPoints)
  {
    super(350);
    this.radius = radius;
    this.numPoints = numPoints;
  }

  void setSpeedOfRotation(float speedOfRotation)
  {
    this.speedOfRotation = speedOfRotation;
  }

  void setClockwise(boolean clockwise)
  {
    this.clockwise = clockwise;
    if (clockwise) 
      this.direction = 1;
    else
    {
      this.direction = -1;
    }
  }

  void addRadiusModulation(float modulation)
  {
    this.radius+=modulation;
  }

  boolean isClockwise()
  {
    return this.clockwise;
  }

  void setDrawLine(boolean drawLine)
  {
    this.drawLine = drawLine;
  }

  boolean getDrawLine()
  {
    return this.drawLine;
  }

  void expand(float expandValue)
  {
    this.expandValue = expandValue;
  }
  
  void setExpandOffset(int offset)
  {
     this.expandOffset = offset; 
  }

  void draw()
  {
    float angle = TWO_PI/(float)this.numPoints;
    int numColors = new Shades().getPaletteSize();
    float colorDivider = this.numPoints / numColors;

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
      point(p1x, p1y, random(-this.expandValue, this.expandOffset + this.expandValue));
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
