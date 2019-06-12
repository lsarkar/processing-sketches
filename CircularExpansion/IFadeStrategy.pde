interface IFadeStrategy {

  float fade(float value);
}

class PassThroughFadeStrategy implements IFadeStrategy {

  float fade(float value)
  {
    return value;
  }
}

class LinearFadeStrategy {

  float alpha;
  float maxTempValue = 0.0;

  void setAlpha(float alpha) {
    this.alpha = alpha;
  }

  float getAlpha() {
    return alpha;
  }

  float fade(float value)
  {
    if (value > maxTempValue) {
      maxTempValue = value;
    }

    maxTempValue-=alpha;
    return maxTempValue;
  }
}

class SlowFadeStrategy extends LinearFadeStrategy implements IFadeStrategy {

  SlowFadeStrategy() {
    super();
    this.alpha = 5.0;
  }
}
