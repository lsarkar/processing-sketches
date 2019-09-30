package com.audioreactor.app;

import java.util.ArrayList;
import java.util.List;

interface IFadeStrategy {

  float fade(float value);

  void registerMaxValueListener(MaxValueListener listener);

  void unregisterMaxValueListener(MaxValueListener listener);
}

abstract class AbstractFade implements IFadeStrategy {

  // listener pattern: https://dzone.com/articles/the-observer-pattern-using-modern-java
  List<MaxValueListener> listeners = new ArrayList();

  public AbstractFade() {
  }

  public abstract float fade(float value);

  public void registerMaxValueListener(MaxValueListener listener) {
    // add the listener to the list of registered listeners
    this.listeners.add(listener);
  }

  public void unregisterMaxValueListener(MaxValueListener listener) {
    // remove the listener from list of registered listeners
    this.listeners.remove(listener);
  }

  protected void notifyMaxValueListeners() {
    // notify each of the listeners in the list of registered listeners
    for (MaxValueListener listener : listeners) {
      listener.onMaxValueReached();
    }
  }
}

/*
No fade
 */
class PassThroughFadeStrategy extends AbstractFade {

  public float fade(float value)
  {
    return value;
  }
}

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

  public float fade(float value)
  {
    if (value > maxTempValue) {
      maxTempValue = value;
      max = true;
      notifyMaxValueListeners();
    }

    max = false;

    maxTempValue-=alpha;
    return maxTempValue;
  }
}

class CustomLinearStrategy extends LinearFadeStrategy {

  CustomLinearStrategy(float alpha) {
    super();
    this.alpha = alpha;
  }
}

class SlowFadeStrategy extends LinearFadeStrategy {

  SlowFadeStrategy() {
    super();
    this.alpha = 2.0f;
  }
}

class FastFadeStrategy extends LinearFadeStrategy {

  FastFadeStrategy() {
    super();
    this.alpha = 10.0f;
  }
}
