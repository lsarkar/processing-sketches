interface IDrawable {

  void draw();
}

interface IExpandable {
  void expand(float expandVal);
}

public class Shape
{
   Shape()
   {
     
   }
}


public class AbstractCircle
{
  float size;
  PVector pos;

  public AbstractCircle(float size)
  {
    this.size = size;
    pos = new PVector(width/2, height/2);
  }

  public void setSize(float size)
  {
    this.size = size;
  }

  float getSize()
  {
    return this.size;
  }
}

public class Circle extends AbstractCircle implements IDrawable
{
  int strokeWeightInner = 11;
  int strokeWeightOuter = 3;

  color circleColor; 
  float topSpeed = 10;

  PVector velocity;
  PVector acceleration;

  float currentAmplitude = 0.00;
  float maxAmplitude = 0.00;
  float accelerationDefault = 0.0002;

  int colorScheme;

  Shades shades;

  public Circle(float size)
  {
    super(size);

    this.shades = new Shades();

    this.velocity = new PVector(2.0, 0);
    this.acceleration = new PVector(accelerationDefault, 0);
    this.colorScheme = 1;
  }

  public void setColorScheme(int val)
  {
    this.colorScheme = val;
  }

  public void setFadePercentage(float percentage)
  {
    float fade = map(percentage, 0, 100, 0, 0.5);
    this.acceleration.x = fade;
  }

  public float getFade()
  {
    return this.acceleration.x;
  }

  public void update(float fftCurrent)
  {
    velocity.limit(topSpeed);
    velocity.add(acceleration);

    if (fftCurrent > this.size)
    {
      this.size = fftCurrent;
      velocity.x = 0.00;
    }

    this.size-=(velocity.x);
  }

  public void draw()
  {
    noFill();
    PVector basePos = new PVector(0, 0);
    translate(width/2, height/2);

    if (this.colorScheme == 1) {
      stroke(this.shades.getFifth());
    } else
    {
      stroke(this.shades.getFourth());
    }

    strokeWeight(strokeWeightInner);
    ellipse(basePos.x, basePos.y, this.size, this.size);

    if (this.colorScheme == 1)
    {
      stroke(this.shades.getSecondary());
    } else
    {
      stroke(this.shades.getPrimary());
    }

    strokeWeight(strokeWeightOuter);
    ellipse(basePos.x, basePos.y, this.size*1.2, this.size+50);
    translate(-width/2, -height/2);
  }
}
