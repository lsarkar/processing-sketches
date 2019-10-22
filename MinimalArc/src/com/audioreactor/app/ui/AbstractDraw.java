package com.audioreactor.app.ui;

import processing.core.PApplet;

public class AbstractDraw {

	protected PApplet p;
	protected float centerX;
	protected float centerY;
	protected float width;
	protected float height;

	public AbstractDraw(PApplet p) {
		this.p = p;
		this.centerX = p.width / 2.0f;
		this.centerY = p.height / 2.0f;
		this.width = p.width;
		this.height = p.height;
	}

}
