
class StaticPoints extends Shape implements IDrawable {
/*
 Draw static points
*/
  int numPoints;
  int offset = 40;
  int strokeWeight = 3;
  int radius;

  StaticPoints(int numPoints, int radius)
  {
    this.numPoints = numPoints;
    this.radius = radius;
  }

  void draw()
  {

    float angle=TWO_PI/(float) this.numPoints;

    for (int i=0; i<numPoints; i++)
    {

      float p1x = radius*sin(angle*i) + width/2;
      float p1y = radius*cos(angle*i) + height/2;
      float p2x = (radius+offset)*sin(angle*i) + width/2;
      float p2y = (radius+offset)*cos(angle*i) + height/2;

      strokeWeight(strokeWeight);
      point(p1x, p1y);  
      point(p2x, p2y);
    }
  }
}
