package com.audioreactor.app.main;

import java.util.ArrayList;

import com.audioreactor.app.ExpandingCircle;
import com.audioreactor.app.Shades;
import com.audioreactor.audio.AudioLibWrapper;
import com.audioreactor.audio.MultibandAnalyzer;
import com.audioreactor.fade.IFadeStrategy;
import com.audioreactor.fade.SlowFadeStrategy;
import com.audioreactor.rotate.NoRotationStrategy;

import processing.core.PApplet;

public class AudioSketch extends PApplet {

	public static final String APP_NAME = "com.audioreactor.app.main.AudioSketch";
	public static final int FRAME_RATE = 30;
	public static final int NUM_EXPANDING_CIRCLES = 8;
	public static final String SONG_TITLE = "bensound-allthat.mp3";
	public final int backgroundColor = color(37, 38, 39);

	private AudioLibWrapper audioLibWrapper;
	private MultibandAnalyzer multiBand;

	private Shades colorShade;
	private ArrayList<ExpandingCircle> circles = new ArrayList<>();

	public static void main(String[] args) {
		PApplet.main(APP_NAME);
	}

	@Override
	public void settings() {
		size(displayWidth, displayHeight, P3D);
		smooth(8);
	}

	@Override
	public void setup() {

		// audio track must exist inside the 'data' folder, otherwise Minim cannot load
		// the file
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

	@Override
	public void draw() {
		background(backgroundColor);

		audioLibWrapper.forward();

		for (int j = 0; j < circles.size(); j++) {

			// int invertedIdx = NUM_EXPANDING_CIRCLES - j;
			int invertedIdx = j;

			// high frequencies typically have smaller average amplitude than the lower
			// frequencies, so apply scaled weighting on the higher bands
			float cScaleFactor = (j * 0.3f) + 1.0f;

			// return the color from the color wheel (8 colors in visual, 16 in wheel)
			final int selectedColor = colorShade.getFromList(j * 2);

			circles.get(j).setColor(selectedColor);
			circles.get(j).updateCircleSize(multiBand.getBandAvg(invertedIdx) * (invertedIdx * cScaleFactor));
			circles.get(j).draw();
		}

	}

}
