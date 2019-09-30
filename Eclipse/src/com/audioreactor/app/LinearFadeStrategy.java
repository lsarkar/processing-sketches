package com.audioreactor.app;

class LinearFadeStrategy extends AbstractFade {

	float alpha;
	float maxTempValue = 0.0f;
	boolean max = false;

	void setAlpha(float alpha) {
		this.alpha = alpha;
	}

	float getAlpha() {
		return alpha;
	}

	public float fade(float value) {
		if (value > maxTempValue) {
			maxTempValue = value;
			max = true;
			notifyMaxValueListeners();
		}

		max = false;

		maxTempValue -= alpha;
		return maxTempValue;
	}
}
