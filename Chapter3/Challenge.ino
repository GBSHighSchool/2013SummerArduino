void setup(){

 size(500, 500);
}

void draw() {

 fill (227,227,227);
 smooth();

 rectMode(CORNER);
 rect (50, 50, 20, 200);
 ellipse (60, 270, 40, 40);

 fill(255, 0, 0);
 ellipse (60, 270, 20, 20);

 rect(57, 57, 6, 200);

 stroke (255,0,0);
 strokeWeight(2);

}