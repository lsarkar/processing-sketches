interface IColorStrategy {
  color getChoiceA();

  color getChoiceB();
}

class LightColorStrategy implements IColorStrategy {

  Shades shades = new Shades();

  LightColorStrategy()
  {
  }

  color getChoiceA()
  {
    return this.shades.getFifth();
  }

  color getChoiceB()
  {
    return this.shades.getSecondary();
  }
  
}

class DarkColorStrategy implements IColorStrategy {

  Shades shades = new Shades();

  DarkColorStrategy()
  {
  }

  color getChoiceA()
  {
    return this.shades.getFourth();
  }

  color getChoiceB()
  {
    return this.shades.getPrimary();
  }
}
