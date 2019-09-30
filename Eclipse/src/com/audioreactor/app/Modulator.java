package com.audioreactor.app;

public class Modulator extends BaseModulator {

	boolean modAddition;
	float modCounter;
	int FRAME_RATE = 30;

	public Modulator() {
		this.modAddition = true;

		this.modMax = 1.0f;
		this.modMin = -1.0f;
		this.modCounter = 0;
		this.modIncrRate = 0.3f;
	}

	void calculateFr() {
		// frames per second
		int fRate = FRAME_RATE;
	}

	void run() {
		if (modCounter >= modMax) {
			modAddition = false;
		}

		if (modCounter <= modMin) {
			modAddition = true;
		}

		if (modAddition) {
			modCounter += modIncrRate;
		} else if (!modAddition) {
			modCounter -= modIncrRate;
		}
	}

	float getSize() {
		return this.modCounter;
	}
}
