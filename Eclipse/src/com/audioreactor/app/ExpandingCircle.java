package com.audioreactor.app;

import java.util.ArrayList;
import java.util.List;

import com.audioreactor.app.ui.AbstractDraw;

import processing.core.PApplet;

/*
Expanding Circle class that uses 2 arcs to form a symmetrical expanding circle
 */

class ExpandingCircle extends AbstractDraw implements IDrawable, MaxValueListener {

  IColorStrategy colorStrategy;
  float size = 200;
  float i;
  float startPos = 90;
  float circleSize = 180;
  float initialStartPos = 0;
  int col;
  int strokeWeight = 10;

  IRotatingStrategy rotation;
  IFadeStrategy fadeStrategy;

  private List<MaxValueListener> listeners = new ArrayList<MaxValueListener>();

  ExpandingCircle(PApplet p, float size)
  {
	super(p);
	col = p.color(255, 0, 0);
    this.size = size;
    this.colorStrategy = new LightColorStrategy(p);
    this.rotation = new LinearRotationStrategy();
    this.fadeStrategy = new SlowFadeStrategy();
  }

  ExpandingCircle(PApplet p, float size, float initialStartPos)
  {
    this(p, size);
    this.initialStartPos = initialStartPos;
  }

  void setRotationStrategy(IRotatingStrategy rotation)
  {
    this.rotation = rotation;
  }

  void setFadeStrategy(IFadeStrategy fadeStrategy) {
    this.fadeStrategy = fadeStrategy;
  }

  void updateCircleSize(float size)
  {
    //this.circleSize = size;
    this.circleSize = fadeStrategy.fade(size);
  }

  void setStrokeWeight(int strokeWeight) {
    this.strokeWeight = strokeWeight;
  }

  void setColor(int col) {
    this.col = col;
  }

  @Override
    public void onMaxValueReached() {
    p.noFill();
    p.stroke(255, 14);
    p.strokeWeight(2);
    p.ellipse(width/2, height/2, size+5, size+5);
  }

  public void draw()
  {
    startPos = this.rotation.getRotation(this.initialStartPos);
    dualArc(centerX, centerY, size, size, startPos, circleSize, col);
  }

  void dualArc(float x, float y, float width, float height, float start, float circleSize, int col)
  {

    float splitSize = circleSize /2;

    float arc1End = p.radians(start + splitSize);
    float arc1Start = p.radians(start);

    float arc2Start = p.radians(start - splitSize);
    float arc2End = arc1Start;

    p.noFill();
    p.strokeWeight(strokeWeight);
    p.strokeCap(p.SQUARE);
    p.ellipseMode(p.CENTER);
    p.smooth();

    // Form: arc(x, y, width, height, start, stop)
    p.stroke(col);
    p.arc(x, y, width, height, arc1Start, arc1End);
    p.arc(x, y, width, height, arc2Start, arc2End);
  }
}
