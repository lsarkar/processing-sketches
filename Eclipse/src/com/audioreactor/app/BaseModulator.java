package com.audioreactor.app;

public class BaseModulator {
	float modMin;
	float modMax;
	float modIncrRate;

	BaseModulator() {
		this.modIncrRate = 1;
	}

	float getModMin() {
		return modMin;
	}

	float getModMax() {
		return modMax;
	}

	void setModMin(float modMin) {
		this.modMin = modMin;
	}

	void setModMax(float modMax) {
		this.modMax = modMax;
	}
}
