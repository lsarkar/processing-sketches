package com.audioreactor.app;

import com.audioreactor.app.ui.AbstractDraw;

import processing.core.PApplet;
import processing.core.PVector;

interface IDrawable {

  void draw();
}

interface IExpandable {
  void expand(float expandVal);
}

public class Circle extends AbstractDraw implements IDrawable
{
  int strokeWeightInner = 11;
  int strokeWeightOuter = 3;

  int circleColor; 
  float topSpeed = 10;

  PVector velocity;
  PVector acceleration;

  float currentAmplitude = 0.00f;
  float maxAmplitude = 0.00f;
  float accelerationDefault = 0.0002f;
  float size;

  int colorScheme;

  Shades shades;
  
  IColorStrategy colorStrategy;
  IFadeStrategy fadeStrategy;
  
  private PApplet p;

  public Circle(PApplet p, float size)
  {
	super(p);
	this.size = size;
    this.shades = new Shades(p);

    this.velocity = new PVector(2.0f, 0);
    this.acceleration = new PVector(accelerationDefault, 0);
    this.colorScheme = 1;
    this.colorStrategy = new LightColorStrategy(p);
    this.fadeStrategy = new SlowFadeStrategy();
  }

  public void setColorScheme(int val)
  {
    this.colorScheme = val;
  }
  
  void setColorStrategy(IColorStrategy colorStrategy)
  {
     this.colorStrategy = colorStrategy; 
  }
  
  IColorStrategy getColorStrategy()
  {
     return colorStrategy; 
  }
 

  public void setFadePercentage(float percentage)
  {
    float fade = p.map(percentage, 0f, 100f, 0f, 0.5f);
    this.acceleration.x = fade;
  }

  public float getFade()
  {
    return this.acceleration.x;
  }
  
  void setFadeStrategy(IFadeStrategy fadeStrategy) {
    this.fadeStrategy = fadeStrategy;
  }

  public void update(float fftCurrent)
  {
    velocity.limit(topSpeed);
    velocity.add(acceleration);

    if (fftCurrent > this.size)
    {
      this.size = fftCurrent;
      velocity.x = 0.00f;
    }

    this.size-=(velocity.x);    
  }

  public void draw()
  {
    p.noFill();
    PVector basePos = new PVector(0, 0);
    p.translate(width/2, height/2);
      
    p.stroke(this.colorStrategy.getChoiceA());

    p.strokeWeight(strokeWeightInner);
    p.ellipse(basePos.x, basePos.y, this.size, this.size);
    
    p.stroke(this.colorStrategy.getChoiceB());
    p.strokeWeight(strokeWeightOuter);
    p.ellipse(basePos.x, basePos.y, this.size*1.2f, this.size+50f);
    p.translate(-width/2, -height/2);
  }
}
