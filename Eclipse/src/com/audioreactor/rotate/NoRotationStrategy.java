package com.audioreactor.rotate;

public class NoRotationStrategy implements IRotatingStrategy {

	public float getRotation(float initial) {
		return initial;
	}
}
