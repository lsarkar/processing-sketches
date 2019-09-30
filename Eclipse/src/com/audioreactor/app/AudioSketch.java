package com.audioreactor.app;

import java.util.ArrayList;

import com.audioreactor.audio.AudioLibWrapper;
import com.audioreactor.audio.MultibandAnalyzer;

import processing.core.PApplet;

public class AudioSketch extends PApplet {

	public static final String appName = "com.audioreactor.app.AudioSketch";

	int FRAME_RATE = 30;
	int NUM_EXPANDING_CIRCLES = 8;
	AudioLibWrapper audioLibWrapper;

	MultibandAnalyzer multiBand;

	Modulator modu = new Modulator();

	Shades colorShade;

	ArrayList<ExpandingCircle> circles = new ArrayList<ExpandingCircle>();

	public static void main(String[] args) {
		PApplet.main(appName);
	}

	public void settings() {
		size(displayWidth, displayHeight, P3D);
	}

	public void setup() {
		// audio track must exist inside the 'data' folder, otherwise Minim cannot load
		// the file
		// assumes test.mp3 is in 'data' folder
		String songTitle = "bensound-endlessmotion.mp3";

		rectMode(CORNERS);
		noCursor();

		// set Frame Rate
		frameRate(FRAME_RATE);

		// add expanding circles
		int circleSpacing = 80;
		int baseRadius = 200;

		for (int i = 0; i < NUM_EXPANDING_CIRCLES; i++) {
			LinearRotationStrategy lin = new LinearRotationStrategy();
			lin.setSpeed(0.5f);
			lin.setIsClockwise(true);

			ExpandingCircle expandCircle = new ExpandingCircle(this, baseRadius + (i * circleSpacing),
					360.0f / (i + 1f));
			// expandCircle.setRotationStrategy(lin);
			expandCircle.setRotationStrategy(new NoRotation());
			expandCircle.setStrokeWeight(20);
			// IFadeStrategy fade = new CustomLinearStrategy(NUM_EXPANDING_CIRCLES-i);
			IFadeStrategy fade = new SlowFadeStrategy();
			expandCircle.setFadeStrategy(fade);
			fade.registerMaxValueListener(expandCircle);

			circles.add(expandCircle);
		}

		// audio configuration
		audioLibWrapper = new AudioLibWrapper(songTitle, this);
		multiBand = audioLibWrapper.getAnalyzer();

		colorShade = new Shades(this);
	}

	public void draw() {
		background(37, 38, 39);
		smooth();

		audioLibWrapper.forward();

		for (int j = 0; j < circles.size(); j++) {
			circles.get(j).updateCircleSize(multiBand.getBandAvg(j) * (j * 1.5f));

			// return the color from the color wheel (8 colors in visual, 16 in wheel)
			int selectedColor = colorShade.getFromList(j * 2);

			circles.get(j).setColor(selectedColor);
			circles.get(j).draw();
		}
	}

	boolean randomBool() {
		return random(1) > 0.5;
	}
}
