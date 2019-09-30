package com.audioreactor.app;

import com.audioreactor.app.ui.AbstractDraw;

import processing.core.PApplet;

class StaticPoints extends AbstractDraw implements IDrawable {
/*
 Draw static points
*/
  int numPoints;
  int offset = 40;
  int strokeWeight = 3;
  int radius;

  public StaticPoints(PApplet p, int numPoints, int radius)
  {
	super(p);
    this.numPoints = numPoints;
    this.radius = radius;
  }

  public void draw()
  {

    float angle=p.TWO_PI/(float) this.numPoints;

    for (int i=0; i<numPoints; i++)
    {

      float p1x = radius*p.sin(angle*i) + width/2;
      float p1y = radius*p.cos(angle*i) + height/2;
      float p2x = (radius+offset)*p.sin(angle*i) + width/2;
      float p2y = (radius+offset)*p.cos(angle*i) + height/2;

      p.strokeWeight(strokeWeight);
      p.point(p1x, p1y);  
      p.point(p2x, p2y);
    }
  }
}
