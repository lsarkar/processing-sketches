class SineParams {

  private float amplitude;
  private float yZero;

  SineParams(float amplitude, float yZero) {
    this.amplitude = amplitude;
    this.yZero = yZero;
  }

  float getAmplitude() {
    return amplitude;
  }

  float getYZero() {
    return yZero;
  }
}
