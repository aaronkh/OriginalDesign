float mouseV;
int oldMX; //the mouse coords from before
int oldMY;
float rootPitch = 164.8;
class Strings{
	int fret;
	float velocity;
	int yPos;
	float sound;
	Strings(int y, float pitch){
		fret=0;
		velocity=0;
		yPos=y;
		sound=pitch;
	}
	void display(){
		stroke(127);
		line(0, yPos, fret*50, yPos);
 		bezier(fret*50, yPos, fret*50+((width-fret*50)*0.5), yPos+velocity,fret*50+((width-fret*50)*0.5), yPos+velocity, width, yPos);
 		velocity=velocity*-0.9;
 		fill(100);
 		text(String.format("%.2f",sound)+" Hz", 5, yPos-5);
	}
	void update(){
		if (abs(mouseY-yPos)<abs(mouseV)){
		velocity=mouseV*0.5;}
	}
}
Strings[] instrument= new Strings[6];
void setup()
{
	for (int i=0; i<instrument.length; i++){
		instrument[i] = new Strings(i*50+80, rootPitch*pow(1/0.70710678, i));
		println(instrument[i].sound);
	}
  size(1400,400);
  textSize(20);
  noCursor();
}
void getMouseV(){
	//int dX=(oldMX-mouseX);
	//oldMX=mouseX;
	int dY=(oldMY-mouseY)*-1;
	oldMY=mouseY;
	//mouseV=sqrt(sq(dX)+sq(dY))*2;
	mouseV=dY;
}
void draw()
{
	background(256, 256, 256);
	//documents mouse movements
	getMouseV();
	fill(159,89,39, 150);
	noStroke();
	ellipse(mouseX, mouseY, (75-mouseV*3)*0.5, (75-mouseV*3)*0.5);
	//println(mouseV);
	//
	noStroke();
	fill(127, 127, 127, 50);
	rect(0, 0, 800, 500);

	stroke(156);
	strokeWeight(3);
	noFill();
	//
  	for (int i=1; i<8; i++){							//draws the frets
  		stroke(200);
  		line(i*100+20, 0, i*100+20, 800);
  	}
  	//
  	for (int i=0; i<instrument.length; i++){
  		instrument[i].display();
  		if (abs(mouseV)>5){
  			instrument[i].update();
  		}
  	}
}

void mousePressed(){
	println(get(mouseX, mouseY));
	if (get(mouseX, mouseY)== -4614272){
		rect(mouseX, mouseY, 200, 200);
	}

}

