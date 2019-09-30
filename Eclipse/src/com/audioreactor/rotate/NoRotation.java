package com.audioreactor.rotate;

public class NoRotation implements IRotatingStrategy {

	public float getRotation(float initial) {
		return initial;
	}
}
