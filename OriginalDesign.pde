float mouseV;
int oldMX; //the mouse coords from before
int oldMY;
float rootPitch = 329.63;
float halfStepRatio = 1/1.059463094359295264561825294946341700779204317494185628559;
class notStrings{
	int fret;
	float velocity;
	int yPos;
	float sound;
	notStrings(int y, float pitch){
		fret=0;
		velocity=0;
		yPos=y;
		sound=pitch;
	}
	void notdisplay(){
		stroke(127);
		line(0, yPos, fret*50, yPos);
 		bezier(fret*50, yPos, fret*50+((width-fret*50)*0.5), yPos+velocity,fret*50+((width-fret*50)*0.5), yPos+velocity, width, yPos);
 		velocity=velocity*-0.9;
 		fill(100);
 		text(String.format("%.2f",sound)+" Hz", 5, yPos-5);
	}
	void notupdate(float n){
		if (abs(mouseY-yPos)<abs(mouseV)){
		velocity=n*0.5;}
	}
}
notStrings[] instrument= new notStrings[6];

void setup()
{	
	for (int i=0; i<instrument.length; i++){
		if (i==0){
			instrument[i] = new notStrings(i*50+80, rootPitch);
		}
		else if (i==2){
			instrument[i] = new notStrings(i*50+80, instrument[1].sound*pow(halfStepRatio, 4));
		}
		else{
			instrument[i] = new notStrings(i*50+80, instrument[i-1].sound*pow(halfStepRatio, 5));
		}} 				//creates each string
  size(1400,400);
  textSize(20);

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
  		instrument[i].notdisplay();
  		if (abs(mouseV)>5){
  			instrument[i].notupdate(mouseV);
  		}
  	}
}
/*
void mousePressed(){
	if (get(mouseX, mouseY)== -4614272){
		println(round((mouseY-25)/50));
		println((mouseX-20)/100);
	}

}
*/