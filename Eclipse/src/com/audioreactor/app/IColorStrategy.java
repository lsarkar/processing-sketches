package com.audioreactor.app;

import com.audioreactor.app.ui.AbstractDraw;

import processing.core.PApplet;

interface IColorStrategy {
  int getChoiceA();

  int getChoiceB();
}

class LightColorStrategy extends AbstractDraw implements IColorStrategy {

  Shades shades;
  PApplet p;
  
  LightColorStrategy(PApplet p)
  {
	  super(p);
	  this.shades = new Shades(p);
  }

  public int getChoiceA()
  {
    return this.shades.getFifth();
  }

  public int getChoiceB()
  {
    return this.shades.getSecondary();
  }
  
}

class DarkColorStrategy implements IColorStrategy {

  Shades shades;

  PApplet p;
  
  DarkColorStrategy(PApplet p)
  {
	  this.p = p;
	  this.shades = new Shades(p);
  }

  public int getChoiceA()
  {
    return this.shades.getFourth();
  }

  public int getChoiceB()
  {
    return this.shades.getPrimary();
  }
}
