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
	public static final String SONG_TITLE = "bensound-endlessmotion.mp3";
	// public static final String SONG_TITLE = "440Hz_0dBFS.wav";

	// 165 max 220Hz
	// 96 max 440Hz

	public final int backgroundColor = color(37, 38, 39);

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
		audioLibWrapper = new AudioLibWrapper(SONG_TITLE, this);
		multiBand = audioLibWrapper.getAnalyzer();

		colorShade = new Shades(this);
	}

	public void draw() {
		background(backgroundColor);
		smooth();

		audioLibWrapper.forward();

		float cScaleFactor = 1.0f; // was 1.5f

		for (int j = 0; j < circles.size(); j++) {

			int invertedIdx = this.NUM_EXPANDING_CIRCLES - j;

			// return the color from the color wheel (8 colors in visual, 16 in wheel)
			final int selectedColor = colorShade.getFromList(j * 2);

			circles.get(j).setColor(selectedColor);
			circles.get(j).updateCircleSize(multiBand.getBandAvg(invertedIdx) * (invertedIdx * cScaleFactor));
			circles.get(j).draw();
		}
	}

}
