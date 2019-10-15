package com.audioreactor.app.main;

import java.util.ArrayList;

import com.audioreactor.app.ExpandingCircle;
import com.audioreactor.app.Shades;
import com.audioreactor.audio.AudioLibWrapper;
import com.audioreactor.audio.MultibandAnalyzer;
import com.audioreactor.fade.IFadeStrategy;
import com.audioreactor.fade.SlowFadeStrategy;
import com.audioreactor.modulate.Modulator;
import com.audioreactor.rotate.NoRotationStrategy;

import processing.core.PApplet;

public class AudioSketch extends PApplet {

	public static final String APP_NAME = "com.audioreactor.app.main.AudioSketch";

	public static final int FRAME_RATE = 30;
	public static final int NUM_EXPANDING_CIRCLES = 8;
	AudioLibWrapper audioLibWrapper;

	MultibandAnalyzer multiBand;

	Modulator modu = new Modulator();

	Shades colorShade;

	ArrayList<ExpandingCircle> circles = new ArrayList<>();

	public static void main(String[] args) {
		PApplet.main(APP_NAME);
	}

	public void settings() {
		size(displayWidth, displayHeight, P3D);
		smooth(8);
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
		int strokeWeight = 25;

		for (int i = 0; i < NUM_EXPANDING_CIRCLES; i++) {

			ExpandingCircle expandCircle = new ExpandingCircle(this, baseRadius + (i * circleSpacing),
					360.0f / (i + 1f));
			expandCircle.setRotationStrategy(new NoRotationStrategy());
			expandCircle.setStrokeWeight(strokeWeight);
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
			final int selectedColor = colorShade.getFromList(j * 2);

			circles.get(j).setColor(selectedColor);
			circles.get(j).draw();
		}
	}

	boolean randomBool() {
		return random(1) > 0.5;
	}
}
