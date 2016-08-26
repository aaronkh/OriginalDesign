float mouseV;
int oldMX; //the mouse coords from before
int oldMY;
float rootPitch = 329.63;
float halfStepRatio = 1/1.059463094359295264561825294946341700779204317494185628559;
int frets[]={0, 0, 0, 0, 0, 0};

void getMouseV(){
	//int dX=(oldMX-mouseX);
	//oldMX=mouseX;
	int dY=(oldMY-mouseY)*-1;
	oldMY=mouseY;
	//mouseV=sqrt(sq(dX)+sq(dY))*2;
	mouseV=dY;
}

class Strings{
	int fret;
	float velocity;
	int yPos;
	float baseSound;
	float sound;
	Strings(int y, float pitch){
		fret=0;
		velocity=0;
		yPos=y;
		baseSound=pitch;
		sound=baseSound;
	}
	void display(){
		stroke(127);
		strokeWeight(2);
		line(0, yPos, fret*50, yPos);
 		bezier(fret*50, yPos, fret*50+((width-fret*50)*0.5), yPos+velocity,fret*50+((width-fret*50)*0.5), yPos+velocity, width, yPos);
 		velocity=velocity*-0.9;
 		fill(100);
 		text(round(sound)+" Hz", 5, yPos-5);
	}
	void update(float n){
		if (abs(mouseY-yPos)<abs(mouseV)){
		velocity=n*0.33;
		}
	}
}
Strings[] instrument= new Strings[6];

void setup()
{	
	for (int i=0; i<instrument.length; i++){
		if (i==0){
			instrument[i] = new Strings(i*50+80, rootPitch);
		}
		else if (i==2){
			instrument[i] = new Strings(i*50+80, instrument[1].sound*pow(halfStepRatio, 4));
		}
		else{
			instrument[i] = new Strings(i*50+80, instrument[i-1].sound*pow(halfStepRatio, 5));
		}} 				//creates each string
  size(1400,375);
  textSize(20);
}

void draw()
{
	background(256, 256, 256);
	//draws the fretbox
	noStroke();
	fill(127, 127, 127, 50);
	rect(0, 0, 800, 500);

	strokeWeight(3);
	//
  	for (int i=1; i<8; i++){
  		noFill();										//draws the fret lines
  		stroke(200);
  		line(i*100+20, 0, i*100+20, 800);
  	}
  	for (int i=0; i<frets.length; i++){					//draws the fret boxes
  		fill(127, 127, 127, 127);
  		noStroke();
  		ellipse(frets[i]*100+67, i*50+50, 15, 15);
  	}
  	//
  	getMouseV();										//documents mouse movements
	fill(159,89,39, 150);
	noStroke();
	ellipse(mouseX, mouseY, (75-mouseV*3)*0.5, (75-mouseV*3)*0.5);
  	noFill();
  	for (int i=0; i<instrument.length; i++){
  		instrument[i].display();
  		if (abs(mouseV)>5){
  			instrument[i].update(mouseV);
  		}
  		instrument[i].sound=instrument[i].baseSound+instrument[i].baseSound*pow(halfStepRatio, frets[i]);
  	}
}


void mousePressed(){
	if (get(mouseX, mouseY)== -4353162 && round((mouseY-25)/50)<6){
		frets[round((mouseY-25)/50)]=(mouseX-20)/100;
	}
}