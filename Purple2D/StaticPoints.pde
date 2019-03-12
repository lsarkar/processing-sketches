class StaticPoints {

  int numPoints;
  int offset = 40;
  int strokeWeight = 3;

  StaticPoints(int numPoints)
  {
    this.numPoints = numPoints;
  }

  public void drawPoints(int radius)
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
