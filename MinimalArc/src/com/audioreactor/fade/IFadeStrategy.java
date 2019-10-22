package com.audioreactor.fade;

import java.util.ArrayList;
import java.util.List;

import com.audioreactor.app.MaxValueListener;

public interface IFadeStrategy {

	float fade(float value);

	void registerMaxValueListener(MaxValueListener listener);

	void unregisterMaxValueListener(MaxValueListener listener);
}

abstract class AbstractFade implements IFadeStrategy {

	// listener pattern:
	// https://dzone.com/articles/the-observer-pattern-using-modern-java
	List<MaxValueListener> listeners = new ArrayList<MaxValueListener>();

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
