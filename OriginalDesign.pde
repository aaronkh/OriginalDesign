float mouseV;
int oldMX; //the mouse coords from before
int oldMY;

class Strings{
	int fret;
	float velocity;
	int yPos;
	int sound;
	Strings(int y, int pitch){
		fret=0;
		velocity=0;
		yPos=y;
		sound=pitch;
	}
	void display(){
		line(0, yPos, fret*50, yPos);
 		bezier(fret*50, yPos, fret*50+((width-fret*50)*0.5), yPos+velocity,fret*50+((width-fret*50)*0.5), yPos+velocity, width, yPos);
 		velocity=velocity*-0.93;
	}
	void update(float newV){
		velocity=newV;
	}
}
Strings[] instrument= new Strings[6];
void setup()
{
	for (int i=0; i<instrument.length; i++){
		instrument[i] = new Strings(i*50+80, i);
	}
  size(1600,800);
  rectMode(CENTER);
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
	fill(139,69,19);
	ellipse(mouseX, mouseY, (100-mouseV)*0.5, (100-mouseV)*0.5);
	println(mouseV);
	//
	stroke(156);
	strokeWeight(3);
	noFill();
  	
  	for (int i=0; i<instrument.length; i++){
  		instrument[i].display();
  		if (abs(mouseV)>10){
  		instrument[i].update(mouseV*0.5);
  		}
  	}
}



