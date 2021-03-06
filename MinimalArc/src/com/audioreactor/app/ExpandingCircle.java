package com.audioreactor.app;

import com.audioreactor.app.ui.AbstractDraw;
import com.audioreactor.app.ui.IDrawable;
import com.audioreactor.fade.IFadeStrategy;
import com.audioreactor.fade.SlowFadeStrategy;
import com.audioreactor.rotate.IRotatingStrategy;
import com.audioreactor.rotate.LinearRotationStrategy;

import processing.core.PApplet;

/*
Expanding Circle class that uses 2 arcs to form a symmetrical expanding circle
 */

public class ExpandingCircle extends AbstractDraw implements IDrawable, MaxValueListener {

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

	public ExpandingCircle(PApplet p, float size) {
		super(p);
		col = p.color(255, 0, 0);
		this.size = size;
		this.colorStrategy = new LightColorStrategy(p);
		this.rotation = new LinearRotationStrategy();
		this.fadeStrategy = new SlowFadeStrategy();
	}

	public ExpandingCircle(PApplet p, float size, float initialStartPos) {
		this(p, size);
		this.initialStartPos = initialStartPos;
	}

	public void setRotationStrategy(IRotatingStrategy rotation) {
		this.rotation = rotation;
	}

	public void setFadeStrategy(IFadeStrategy fadeStrategy) {
		this.fadeStrategy = fadeStrategy;
	}

	public void updateCircleSize(float size) {

		float tempSize = size;

		if (size > 340.0f) {
			tempSize = 340.0f;
		}

		this.circleSize = tempSize;
		this.circleSize = fadeStrategy.fade(this.circleSize);
	}

	public void setStrokeWeight(int strokeWeight) {
		this.strokeWeight = strokeWeight;
	}

	public void setColor(int col) {
		this.col = col;
	}

	@Override
	public void onMaxValueReached() {
		p.noFill();
		p.stroke(255, 14);
		p.strokeWeight(2);
		p.ellipse(centerX, centerY, size + 5, size + 5);
	}

	public void draw() {
		startPos = this.rotation.getRotation(this.initialStartPos);
		dualArc(centerX, centerY, size, size, startPos, circleSize, col);
	}

	void dualArc(float x, float y, float width, float height, float start, float circleSize, int col) {

		float splitSize = circleSize / 2;

		float arc1End = p.radians(start + splitSize);
		float arc1Start = p.radians(start);

		float arc2Start = p.radians(start - splitSize);
		float arc2End = arc1Start;

		p.noFill();
		p.strokeWeight(strokeWeight);
		p.strokeCap(p.SQUARE);
		p.ellipseMode(p.CENTER);

		// Form: arc(x, y, width, height, start, stop)
		p.stroke(col);
		p.arc(x, y, width, height, arc1Start, arc1End);
		p.arc(x, y, width, height, arc2Start, arc2End);
	}
}
