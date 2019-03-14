class RotatingPoints implements IDrawable, IExpandable
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
    this.numPoints = 20;
    this.radius = 350;
  }

  public RotatingPoints(float radius, int numPoints)
  {
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
    int colorDivider = this.numPoints / numColors;
    
    if (inc == 360)
    {
      inc = 0;
    }

    for (int i = 0; i<this.numPoints; i++)
    {
      float p1x = this.radius*sin((angle*i)+inc) + width/2;
      float p1y = this.radius*cos((angle*i)+inc) + height/2;

      strokeWeight(STROKE_WEIGHT);
      
      if (i==0)
      {
        stroke(new Shades().getThird());
      }
      else if (i == colorDivider*2)
      {
        stroke(new Shades().getSecondary()); 
      }
      else if (i == colorDivider*3)
      {
         stroke(new Shades().getThird()); 
      }
      else if (i == colorDivider*4)
      {
         stroke(new Shades().getFourth()); 
      }
      else if (i == colorDivider*5)
      {
         stroke(new Shades().getFifth()); 
      }
      //else if (i == int(this.numPoints/2))
      //{
      //  stroke(new Shades().getPrimary());
      //}
      //else if (i == int(colorDivider*3))
      //{
      //  stroke(new Shades().getFifth()); 
      //}
      
      point(p1x, p1y, random(0,50 + this.expandValue));

      if (this.getDrawLine())
      {
        smooth();
        line(width/2, height/2, p1x, p1y);
      }
    }

    inc+=(this.speedOfRotation*this.direction);
  }
}
