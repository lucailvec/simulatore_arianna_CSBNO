/*
  Arc Length parametrization of curves by Jakub Valtar

  This example shows how to divide a curve into segments
  of an equal length and how to move along the curve with
  constant speed.

  To demonstrate the technique, a cubic Bézier curve is used.
  However, this technique is applicable to any kind of
  parametric curve.
*/

BezierPath path = new BezierPath();

PVector[] points;
PVector[] equidistantPoints;

float t = 0.0;
float tStep = 0.004;

final int POINT_COUNT = 80;

int borderSize = 40;
  
  PVector a = new PVector(   100, 300);
  PVector b = new PVector( 150,   280);
  PVector c = new PVector( 120,   20);
  PVector d = new PVector( 170, 100);
  PVector e = new PVector( 170, 100);
  PVector f = new PVector( 200, 100);
  PVector g = new PVector( 340, 220);
  PVector centro = new PVector(240,280);
  PVector h = new PVector( 240 + 30 , 280);//centro in 240 280
  PVector i = new PVector( 240 + 30 , 280 + 0.552284749831 * 30);
  PVector j = new PVector( 240+ 0.552284749831 * 30, 280 + 30 );
  PVector k = new PVector( 240, 280 + 30 );
void setup() {
  
  size(640, 640, P2D);
  
  frameRate(60);
  smooth(8);
  textAlign(CENTER);
  textSize(16);
  strokeWeight(2);

   path.add(new BezierCurve(a,b,c,d));
   path.add(new BezierCurve(e,f,g,h));
   path.add(new BezierCurve(h,i,j,k));
   path.addCircle(centro,h,k,true);//true è orario false è antiorario
   path.addCircle(centro,new PVector( 240 - 30 , 280),k,true);//true è orario false è antiorario
  points = path.points();
  equidistantPoints = path.equidistantPoints();
}

void drawControlPoint(){
  controlPointStyle();
    int sizeControlPoint=6;
    ellipse(a.x, a.x, sizeControlPoint, sizeControlPoint);
    ellipse(c.x, c.x, sizeControlPoint, sizeControlPoint);
}
void draw() {
 // drawControlPoint();
  // Show static value when mouse is pressed, animate otherwise
  if (mousePressed) {
    int a = constrain(mouseX, borderSize, width - borderSize);
    t = map(a, borderSize, width - borderSize, 0.0, 1.0);
  } else {
    t += tStep;
    if (t > 1.0) t = 0.0;
  }
  background(255);
  
  
  // draw curve and circle using standard parametrization
  pushMatrix();
    translate(borderSize, -50);
    
    labelStyle();
    text("STANDARD\nPARAMETRIZATION", 120, 310);
    
    curveStyle();
   beginShape(LINES);
      for (int i = 0; i < points.length - 1; i += 2) {
        vertex(points[i].x, points[i].y);
        vertex(points[i+1].x, points[i+1].y);
      }
    endShape();
    
    circleStyle(); 
    PVector pos1 = path.pointAtParameter(t);
    ellipse(pos1.x, pos1.y, 12, 12);
    
  popMatrix();
  
  
  // draw curve and circle using arc length parametrization
  pushMatrix();
    translate(width/2 + borderSize, -50);
    
    labelStyle();
    text("ARC LENGTH\nPARAMETRIZATION", 120, 310);
    
    curveStyle();
    beginShape(LINES);
      for (int i = 0; i < equidistantPoints.length - 1; i += 2) {
        vertex(equidistantPoints[i].x, equidistantPoints[i].y);
        vertex(equidistantPoints[i+1].x, equidistantPoints[i+1].y);
      }
    endShape();
    
    circleStyle();
    PVector pos2 = path.pointAtFraction(t);
    ellipse(pos2.x, pos2.y, 12, 12);
    
  popMatrix();
  
  
  // draw seek bar
  pushMatrix();
    translate(borderSize, height - 45);
    
    int barLength = width - 2 * borderSize;
  
    barBgStyle();
    line(0, 0, barLength, 0);
    line(barLength, -5, barLength, 5);
    
    barStyle();
    line(0, -5, 0, 5);
    line(0, 0, t * barLength, 0);
    
    barLabelStyle();
    text(nf(t, 0, 2), barLength/2, 25);
  popMatrix();
  
}


// Styles -----

void curveStyle() {
  stroke(170);
  noFill();
}

void labelStyle() {
  noStroke();
  fill(120);
}

void circleStyle() {
  noStroke();
  fill(0);
}
void controlPointStyle() {
  noStroke();
  fill(255,0,0);
}
void barBgStyle() {
  stroke(220);
  noFill();
}

void barStyle() {
  stroke(50);
  noFill();
}

void barLabelStyle() {
  noStroke();
  fill(120);
}