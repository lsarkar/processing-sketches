package com.audioreactor.app;

import com.audioreactor.app.ui.AbstractDraw;
import com.audioreactor.app.ui.IDrawable;

import processing.core.PApplet;

class RotatingPoints extends AbstractDraw implements IDrawable, IExpandable
/*
 * Creates a circle of rotating ellipses of defined radius and number of points
 */

{
	int numPoints;
	float inc = 0;
	float speedOfRotation = 0.0010f;
	boolean clockwise = true;
	boolean drawLine = false;
	int direction = 1;
	float expandValue = 0;
	int radiusModulationCounter = 0;
	boolean addFlag = true;
	int expandOffset = 50;
	int alpha = 255;
	int strokeWeight;
	private float radius;

	public RotatingPoints(PApplet p) {
		super(p);
		this.radius = 350;
		this.numPoints = 20;
		this.strokeWeight = 5;
	}

	RotatingPoints(PApplet p, float radius, int numPoints) {
		super(p);
		this.radius = radius;
		this.numPoints = numPoints;
	}

	void setSpeedOfRotation(float speedOfRotation) {
		this.speedOfRotation = speedOfRotation;
	}

	void setClockwise(boolean clockwise) {
		this.clockwise = clockwise;
		if (clockwise)
			this.direction = 1;
		else {
			this.direction = -1;
		}
	}

	void addRadiusModulation(float modulation) {
		this.radius += modulation;
	}

	boolean isClockwise() {
		return this.clockwise;
	}

	void setDrawLine(boolean drawLine) {
		this.drawLine = drawLine;
	}

	boolean getDrawLine() {
		return this.drawLine;
	}

	void setAlpha(int alpha) {
		this.alpha = alpha;
	}

	int getAlpha() {
		return this.alpha;
	}

	public void expand(float expandValue) {
		this.expandValue = expandValue;
	}

	void setExpandOffset(int offset) {
		this.expandOffset = offset;
	}

	void setStrokeWeight(int strokeWeight) {
		this.strokeWeight = strokeWeight;
	}

	void resetIncrement() {
		if (inc == 360) {
			inc = 0;
		}
	}

	public void draw() {
		float angle = PApplet.TWO_PI / (float) this.numPoints;
		int numColors = new Shades(this.p).getPaletteSize();
		float colorDivider = this.numPoints / (float) numColors;

		resetIncrement();

		for (int i = 0; i < this.numPoints; i++) {
			float p1x = this.radius * p.sin((angle * i) + inc) + p.width / 2;
			float p1y = this.radius * p.cos((angle * i) + inc) + p.height / 2;

			// divide the coloring into sectors. Number of sectors = number of colors in the
			// shades palette
			int colSelect = (int) (i / colorDivider);

			p.strokeWeight(strokeWeight);
			p.stroke(new Shades(this.p).get(colSelect + 1), alpha);
			p.point(p1x, p1y, p.random(-this.expandValue, this.expandOffset + this.expandValue));
			drawLineBetweenPoints(p1x, p1y);
		}

		inc += (this.speedOfRotation * this.direction);
	}

	void drawLineBetweenPoints(float p1x, float p1y) {
		if (this.getDrawLine()) {
			p.smooth();
			p.strokeWeight(2);
			p.line(p.width / 2, p.height / 2, -this.expandValue, p1x, p1y, 20 + this.expandValue);
		}
	}
}
