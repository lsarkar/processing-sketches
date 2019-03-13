class RotatingPoints
/*
Creates a circle of rotating ellipses
 */

{
  int numPoints;
  float radius;
  float inc = 0;
  float speedOfRotation = 0.0010;
  boolean clockwise = true;
  boolean drawLine = false;
  int direction = 1;

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

  public void display()
  {
    float angle = TWO_PI/(float)this.numPoints;

    if (inc == 360)
    {
      inc = 0;
    }

    for (int i = 0; i<this.numPoints; i++)
    {
      float p1x = this.radius*sin((angle*i)+inc) + width/2;
      float p1y = this.radius*cos((angle*i)+inc) + height/2;

      strokeWeight(5);
      stroke(new Shades().getThird());
      point(p1x, p1y, 0);

      if (i==0)
      {
        stroke(new Shades().getThird());
      } else if (i == int(this.numPoints/2))
      {
        stroke(new Shades().getFourth());
      }

      if (this.getDrawLine())
      {
        smooth();
        line(width/2, height/2, p1x, p1y);
      }
    }

    inc+=(this.speedOfRotation*this.direction);
  }
}
