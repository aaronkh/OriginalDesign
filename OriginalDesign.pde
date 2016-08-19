float mouseV;
int oldMX; //the mouse coords from before
int oldMY;

void setup()
{
  size(800,800);
  rectMode(CENTER);

}
void getMouseV(){
	int dX=abs(oldMX-mouseX);
	oldMX=mouseX;
	int dY=abs(oldMY-mouseY);
	oldMY=mouseY;
	mouseV=sqrt(sq(dX)+sq(dY))*2;

}
void draw()
{
	background(256, 256, 256);
	//documents mouse movements
	getMouseV();
	fill(139,69,19);
	ellipse(mouseX, mouseY, 100-mouseV, 100-mouseV);
	//
	stroke(156);
	strokeWeight(3);
	noFill();
	for (int i=0; i<4; i++){
		bezier(0.0, 325.0+50*i, 9.0, 900.0, 9.0, 900.0, 800.0, 325.0+50*i);
	}
  
}



