public class RippleManager {
  ArrayList<PVector> locations = new ArrayList<PVector>();
  ArrayList<PVector> scales = new ArrayList<PVector>();
  void addRipple(PVector loc) {
    locations.add(loc);
    scales.add(new PVector(0, 0));
  }
  void update() {
    ArrayList<Integer> removes = new ArrayList<Integer>();

    for (int i = 0; i < scales.size (); i++) {
      PVector scaleSize = scales.get(i);
      scaleSize.add(new PVector(5, 5));
     if (scaleSize.x > width & scaleSize.y > height ) {
        removes.add(i);
      }
    }    
    for (Integer i : removes) {
      locations.remove(locations.get(i));
      scales.remove(scales.get(i));
    }
  }
  void display() {
    for (int i = 0; i < locations.size (); i++) {
      noFill();
      stroke(140, 215, 245, (255 - max(scales.get(i).x / 3, 0)) );
      ellipse(locations.get(i).x, locations.get(i).y, scales.get(i).x, scales.get(i).y);
    }
  }
}
class Kingyo {
  //const
  final float MAX_ACCELERATION = 0.5;

  //tail
  private boolean tail_dir = false;
  private float radian = 0;
  private float delta = 0.5;

  //property
  PVector location = new PVector();
  PVector scaleSize = new PVector();
  PVector destination = new PVector();
  PVector acceleration = new PVector();
  PVector velocity = new PVector();
  color c =  color(200, 0, 0);

  Kingyo() {
    location = new PVector(0, 0);
    scaleSize = new PVector(1, 1);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    int x = int(random(width -50 * scaleSize.x) + 50 * scaleSize.x);
    int y = int(random(height -50 * scaleSize.y) + 50 * scaleSize.y);
    destination = new PVector(x, y);
  }
  Kingyo(PVector location, PVector scaleSize) {
    this();
    this.location =location;
    this.scaleSize = scaleSize;
  }

  void update() {
    if (location.dist(destination) < 5) {
      int x = int(random(width -50 * scaleSize.x) + 50 * scaleSize.x);
      int y = int(random(height -50 * scaleSize.y) + 50 * scaleSize.y);
      destination = new PVector(x, y);
    }

    //tail animation
    radian += delta;
    if (radian < -5) {
      delta = 0.2;
    }
    if (radian > 5) {
      delta = -0.2;
    }
     if ((int)random(500) == 0) {
        rippleManager.addRipple(this.location);
     }

    PVector dir = PVector.sub(destination, location);
    dir.normalize();
    acceleration = PVector.mult(dir, MAX_ACCELERATION);
    velocity.add(acceleration); 
    location.add(velocity);
    velocity.mult(0);
  }
  void display() {
    pushMatrix(); //(0, 0)を原点とする座標軸をスタックに格納
    translate(location.x, location.y);
    Float theta = atan2(location.y - destination.y, location.x - destination.x);
    rotate(theta - PI / 2);
    //tail
    pushMatrix(); //(200, 200)を原点とする座標軸をスタックに格納
    scale(scaleSize.x, scaleSize.y); // 座標を 幅2.0倍, 高さ4.0倍に拡大
    noStroke();
    fill(c);
    translate(10, -10); // 座標軸を 右に60px, 下に20px移動

    rotate(radians(radian));

    beginShape();
    vertex(0, 0);
    bezierVertex(0.2, 1.1, 39.9, 23.4, 15.3, 52.2);
    bezierVertex(15.3, 52.2, 21.5, 31.4, 7.5, 26.7);
    bezierVertex(7.5, 26.7, 19.4, 53.4, 3.7, 72.1);
    bezierVertex(4.3, 69.7, 6.3, 52.5, -1.7, 58.7);
    bezierVertex(-2.6, 53.4, -3.9, 46, -7.6, 48);
    bezierVertex(-7.6, 48, -6.4, 24.6, -9.7, 26.4);
    bezierVertex(-9.7, 26.4, -16.5, 56.7, -26.3, 60.8);
    bezierVertex(-27.2, 55.8, -21, 49.5, -23.8, 36.8);
    bezierVertex(-16.2, 29, -14.1, 21, -22.5, 24);
    bezierVertex(-33.7, 42.7, -37.9, 42.4, -40, 48.3);
    bezierVertex(-41.8, 30.5, -36, 8.6, -10.2, 0.5);
    endShape();
    popMatrix(); //座標軸の位置をスタックから取り出すし設定する ... この場合(200,200)

    //head
    pushMatrix(); //(200, 200)を原点とする座標軸をスタックに格納
    scale(scaleSize.x, scaleSize.y); // 座標を 幅2.0倍, 高さ4.0倍に拡大
    noStroke();
    fill(c);
    rotate(radians(-radian+10));

    beginShape();
    vertex(0, 0);
    bezierVertex(-2, -1.9, -3.4, -2, -12.6, -9);
    bezierVertex(-20.3, -14.2, -24.8, -22.8, -30.7, -29.7);
    bezierVertex(-31, -23.3, -32.7, -23.8, -34.3, -23.2);
    bezierVertex(-35.1, -22.8, -35.4, -18.1, -36.4, -17.8);
    bezierVertex(-38.9, -17.1, -40.3, -16.3, -41.1, -12.8);
    bezierVertex(-44.4, -10.1, -39.9, -33.6, -31.9, -39.2);
    bezierVertex(-33.7, -49, -34.9, -71.6, -30.7, -72.7);
    bezierVertex(-28.6, -76.5, -6.4, -62.9, -1.3, -52.9);
    bezierVertex(-1.3, -52.9, 14.4, -56.1, 25, -39.8);
    bezierVertex(17.7, -42.6, 15.6, -45.2, 12, -44.4);
    bezierVertex(11.3, -44.2, 10.5, -44.3, 9.8, -44.5);
    bezierVertex(8.9, -44.8, 7.3, -45.2, 4.9, -44.8);
    bezierVertex(8.8, -38.6, 10.8, -11.3, 6.7, -0.3);

    endShape();
    popMatrix(); 
    popMatrix(); //座標軸の位置をスタックから取り出すし設定する ... この場合(0, 0)
  }
}

class Waterweed {
  PVector location;

  //tail
  private float radian = 0;
  private float delta = 0.05;


  Waterweed() {    
    location = new PVector(0, 0);
  }
  Waterweed(PVector location) {    
    this();
    this.location = location;
  }
  void update() {
    //tail animation
    radian += delta;
    if (radian < -5) {
      delta = 0.05;
    }
    if (radian > 5) {
      delta = -0.05;
    }
  }
  void display() {
     
    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(radian));
    noFill();
    strokeWeight(2);
    stroke(0, 200, 0);
    //(80,250)を起点にする
    beginShape();
    vertex(-54.4, -250.0);
    bezierVertex(-54.4, -242.7, -51.9, -236.7, -48.8, -236.7);
    endShape();
    //2//
    beginShape();
    vertex(-59.5, -238.6);
    bezierVertex(-59.5, -237.6, -54.8, -236.7, -48.8, -236.7);
    endShape();

    //2//
    beginShape();
    vertex(-36.4, -244.9);
    bezierVertex(-36.4, -240.4, -42.0, -236.7, -48.8, -236.7);
    endShape();

    //2//
    beginShape();
    vertex(-35.0, -235.4);
    bezierVertex(-35.0, -236.2, -41.2, -236.7, -48.8, -236.7);
    endShape();

    //2//
    beginShape();
    vertex(-48.8, -236.7);
    bezierVertex(-48.8, -232.4, -44.6, -228.9, -39.3, -228.9);
    endShape();

    //2//
    beginShape();
    vertex(-56.3, -207.7);
    bezierVertex(-56.3, -205.1, -61.8, -202.9, -68.6, -202.9);
    endShape();

    //2//
    beginShape();
    vertex(-56.3, -207.7);
    bezierVertex(-56.3, -202.3, -55.3, -197.9, -54.2, -197.9);
    endShape();

    //2//
    beginShape();
    vertex(-57.0, -206.4);
    bezierVertex(-57.0, -203.5, -53.1, -201.1, -48.2, -201.1);
    endShape();

    //2//
    beginShape();
    vertex(-47.0, -216.3);
    bezierVertex(-47.0, -211.6, -51.1, -207.7, -56.3, -207.7);
    endShape();

    //2//
    beginShape();
    vertex(-44.7, -208.6);
    bezierVertex(-44.7, -208.1, -49.9, -207.7, -56.3, -207.7);
    endShape();

    //2//
    beginShape();
    vertex(-60.4, -218.1);
    bezierVertex(-60.4, -212.4, -58.6, -207.7, -56.3, -207.7);
    endShape();

    //2//
    beginShape();
    vertex(-68.6, -213.8);
    bezierVertex(-68.6, -210.5, -63.1, -207.7, -56.3, -207.7);
    endShape();

    //2//
    beginShape();
    vertex(-69.6, -184.2);
    bezierVertex(-69.6, -177.9, -66.5, -172.7, -62.7, -172.7);
    endShape();

    //2//
    beginShape();
    vertex(-53.5, -181.1);
    bezierVertex(-53.5, -176.5, -57.6, -172.7, -62.7, -172.7);
    endShape();

    //2//
    beginShape();
    vertex(-76.7, -178.5);
    bezierVertex(-76.7, -175.3, -70.5, -172.7, -62.7, -172.7);
    endShape();

    //2//
    beginShape();
    vertex(-50.5, -172.7);
    bezierVertex(-50.5, -172.7, -56.0, -172.7, -62.7, -172.7);
    endShape();

    //2//
    beginShape();
    vertex(-62.7, -172.7);
    bezierVertex(-62.7, -172.3, -70.4, -171.9, -80.0, -171.9);
    endShape();

    //2//
    beginShape();
    vertex(-62.7, -172.7);
    bezierVertex(-62.7, -168.9, -57.8, -165.7, -51.6, -165.7);
    endShape();

    //2//
    beginShape();
    vertex(-62.7, -172.7);
    bezierVertex(-62.7, -168.9, -68.6, -165.7, -75.9, -165.7);
    endShape();

    //2//
    beginShape();
    vertex(-62.7, -172.7);
    bezierVertex(-62.7, -166.7, -61.7, -161.8, -60.4, -161.8);
    endShape();

    //2//
    beginShape();
    vertex(-73.9, -114.1);
    bezierVertex(-73.9, -108.6, -68.2, -104.2, -61.3, -104.2);
    endShape();

    //2//
    beginShape();
    vertex(-56.5, -112.5);
    bezierVertex(-56.5, -107.9, -58.6, -104.2, -61.3, -104.2);
    endShape();

    //2//
    beginShape();
    vertex(-78.3, -107.3);
    bezierVertex(-78.3, -104.3, -70.9, -101.9, -61.8, -101.9);
    endShape();

    //2//
    beginShape();
    vertex(-49.7, -107.3);
    bezierVertex(-49.7, -104.3, -55.1, -101.9, -61.8, -101.9);
    endShape();

    //2//
    beginShape();
    vertex(-61.8, -101.9);
    bezierVertex(-61.8, -98.5, -66.8, -95.6, -73.0, -95.6);
    endShape();

    //2//
    beginShape();
    vertex(-61.8, -101.9);
    bezierVertex(-61.8, -100.2, -57.0, -98.8, -51.1, -98.8);
    endShape();

    //2//
    beginShape();
    vertex(-61.3, -104.2);
    bezierVertex(-61.3, -97.8, -58.8, -92.6, -55.8, -92.6);
    endShape();

    //2//
    beginShape();
    vertex(-64.7, -78.8);
    bezierVertex(-64.7, -74.5, -60.4, -71.0, -55.0, -71.0);
    endShape();

    //2//
    beginShape();
    vertex(-49.7, -80.3);
    bezierVertex(-49.7, -75.2, -52.1, -71.0, -55.0, -71.0);
    endShape();

    //2//
    beginShape();
    vertex(-67.6, -72.4);
    bezierVertex(-67.6, -70.5, -61.6, -69.0, -54.3, -69.0);
    endShape();

    //2//
    beginShape();
    vertex(-39.5, -77.2);
    bezierVertex(-39.5, -72.7, -46.1, -69.0, -54.3, -69.0);
    endShape();

    //2//
    beginShape();
    vertex(-64.7, -63.0);
    bezierVertex(-64.7, -66.3, -60.1, -69.0, -54.3, -69.0);
    endShape();

    //2//
    beginShape();
    vertex(-54.3, -69.0);
    bezierVertex(-54.3, -66.3, -49.8, -64.1, -44.2, -64.1);
    endShape();

    //2//
    beginShape();
    vertex(-54.3, -69.0);
    bezierVertex(-54.3, -64.3, -56.8, -60.6, -59.8, -60.6);
    endShape();

    //2//
    beginShape();
    vertex(-51.2, -44.1);
    bezierVertex(-51.2, -41.0, -46.0, -38.4, -39.5, -38.4);
    endShape();

    //2//
    beginShape();
    vertex(-37.4, -49.699997);
    bezierVertex(-37.4, -43.5, -38.4, -38.399994, -39.5, -38.399994);
    endShape();

    //2//
    beginShape();
    vertex(-39.5, -38.4);
    bezierVertex(-39.5, -37.0, -45.8, -35.8, -53.6, -35.8);
    endShape();

    //2//
    beginShape();
    vertex(-27.5, -46.2);
    bezierVertex(-27.5, -41.9, -32.9, -38.4, -39.5, -38.4);
    endShape();

    //2//
    beginShape();
    vertex(-39.5, -38.4);
    bezierVertex(-39.5, -33.8, -44.1, -30.1, -49.7, -30.1);
    endShape();

    //2//
    beginShape();
    vertex(-24.5, -39.2);
    bezierVertex(-24.5, -38.8, -31.2, -38.3, -39.5, -38.4);
    endShape();

    //2//
    beginShape();
    vertex(-39.1, -37.1);
    bezierVertex(-39.1, -31.5, -40.4, -27.0, -42.1, -27.0);
    endShape();

    //2//
    beginShape();
    vertex(-39.1, -37.1);
    bezierVertex(-39.1, -34.3, -33.9, -32.1, -27.5, -32.1);
    endShape();

    //2//

    //2///
    beginShape();
    vertex(-46.2, -247.0);
    bezierVertex(-54.8, -212.4, -70.2, -167.4, -62.7, -111.7);
    bezierVertex(-58.3, -46.1, -20.5, -10.7, -1.3, 5.1);
    endShape();
    popMatrix();//座標軸の位置をスタックから取り出すし設定する...この場合(200,200)
  }
}


Kingyo[] kingyos = new Kingyo[10];
RippleManager rippleManager;

Waterweed waterweeds[];

void setup() {
  size(window.innerWidth, 400);

  rippleManager = new RippleManager();
  waterweeds = new Waterweed[3];
  waterweeds[0] = new Waterweed(new PVector(100, height));    
  waterweeds[0].radian = 0;
  waterweeds[1] = new Waterweed(new PVector(130, height));    
  waterweeds[1].radian = 2;
  waterweeds[2] = new Waterweed(new PVector(180, height));    
  waterweeds[2].radian = 3;

  for (int i = 0; i < kingyos.length; i++) {
    float size = random(0.2, 1.2);
    int x = int(random(width -50 * size) + 50 * size);
    int y = int(random(height -50 * size) + 50 * size);
    kingyos[i] =  new Kingyo(new PVector(x, y), new PVector(size, size));
    if (i % 2 == 0) {
      kingyos[i].c = color(200, 0, 0);
    } else {
      kingyos[i].c = color(0);
    }
  }
}

void draw() {
  background(255);
  rippleManager.update();
  rippleManager.display();
  for(Waterweed waterweed :waterweeds){
    waterweed.update();
    waterweed.display();
  }
  for (Kingyo kingyo : kingyos) {
    kingyo.update();
    kingyo.display();
  }
}

