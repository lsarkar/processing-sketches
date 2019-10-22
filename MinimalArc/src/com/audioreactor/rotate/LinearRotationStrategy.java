package com.audioreactor.rotate;

public class LinearRotationStrategy implements IRotatingStrategy {

	float start = 0;
	public static final float MAX_LIMIT = 360;
	float increment = 10;
	boolean isClockwise;
	int direction = 1;

	public LinearRotationStrategy() {
		// defaults
		setIsClockwise(false);
	}

	public void setRotationsPerMinute(int BPM) {
		// set rotation based on BPM
		// reference:
		// https://www.deviantart.com/inferno988/art/FPS-to-FPB-to-BPM-Calculator-424778748

		// framerate of 30 = 30 frames per second

	}

	public void setSpeed(float increment) {
		this.increment = increment;
	}

	public void setIsClockwise(boolean isClockwise) {
		if (isClockwise)
			direction = 1;
		else
			direction = -1;
	}

	public float getRotation(float initialPosition) {
		float summedPos = start + initialPosition;

		if (summedPos == MAX_LIMIT * direction) {
			start = 0;
		}

		start += increment * direction;
		return summedPos;
	}

}
