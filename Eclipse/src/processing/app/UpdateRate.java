package processing.app;

class UpdateRate {

	UpdateRate() {

	}

	boolean isUpdateable(int frameCount, int frameInterval) {
		if (frameCount % frameInterval == 0)
			return true;
		else
			return false;
	}

}
