package com.audioreactor.app;

import com.audioreactor.app.ui.AbstractDraw;

import processing.core.PApplet;

class RandomPoints extends AbstractDraw implements IDrawable {

  private PApplet p;	
	
  RandomPoints(PApplet p)
  {
	  super(p);
  }

  public void  draw(float addWeight)
  {
    for (int i=0; i<=200+(addWeight*50); i++)
    {
      p.strokeWeight(1 + (int)((addWeight/3)+0.5));
      p.noFill();
      p.stroke(255, 127);
      p.point(p.random(0, width), p.random(0, height), 0);
    }
  }
  
  public void draw()
  {
    for (int i=0; i<=200+(1*50); i++)
    {
      p.strokeWeight(1 + (int)((1/5)+0.5));
      p.noFill();
      p.stroke(255, 127);
      p.point(p.random(0, width), p.random(0, height), 0);
    }
  }
  
}
