package com.audioreactor.app;

import com.audioreactor.app.ui.AbstractDraw;

import processing.core.PApplet;

interface IColorStrategy {
	int getChoiceA();

	int getChoiceB();
}

class LightColorStrategy extends AbstractDraw implements IColorStrategy {

	Shades shades;

	LightColorStrategy(PApplet p) {
		super(p);
		this.shades = new Shades(p);
	}

	public int getChoiceA() {
		return this.shades.getFifth();
	}

	public int getChoiceB() {
		return this.shades.getSecondary();
	}

}

class DarkColorStrategy extends AbstractDraw implements IColorStrategy {

	Shades shades;

	DarkColorStrategy(PApplet p) {
		super(p);
		this.shades = new Shades(p);
	}

	public int getChoiceA() {
		return this.shades.getFourth();
	}

	public int getChoiceB() {
		return this.shades.getPrimary();
	}
}
