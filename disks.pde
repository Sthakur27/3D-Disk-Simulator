boolean rotate=false;
FloatList xvals=new FloatList();
FloatList yvals=new FloatList();
FloatList rvals=new FloatList();
FloatList thetavals=new FloatList();
boolean cartesian=true;
float rx=0; float rz=0;
boolean line=true;
boolean axis=true;
int rchoose=1;
boolean scaleon=true;
int timer=1;
int timer2=1;
float scale=1;
float scale2=1;
boolean typing=false;
int mode=2;   //0:disk 1: shell 2:line
float maxval=0;
float ry=0;
int funcnum=0;
int totalP=11;
double volume=0;
boolean paused=false;
String exp=("4.64-(x^2^(1/3))");
String tempexp="";
void setup(){
      size(500, 450,P3D);
      //parse.test();
      calculate();
      //surface.setResizable(true);
}

void draw(){
    background(255,255,255);
    fill(0);
    if(mode==2){
    text("Area ="+(float)volume,330,20,0);}
    else{text("Volume ="+(float)volume,330,20,0);}
    text("Exp: y=("+exp+")",10,20,0);
    translate(width/2,height/2,0);
    rotateY(timer2*PI/180);
    rotateY(ry);
    if(!paused){
       timer2++;}
    if(timer2>360){timer2=0;}
    rotate();
    stroke(0,0,0);   
    //draw axis
    if(axis){
        textSize(15); fill(0);
        
        //x axis
        line(-150,0,0,150,0,0);
        //line(-width/2,0,0,width/2,0,0);
        text("X=10",105,0,0);
        
        //y
        line(0,-150,0,0,150,0);
        //line(0,-height/2,0,0,height/2,0);        
        text("Y="+maxval,0,-105*scale2,0);
        
        //z
        line(0,0,-150,0,0,150);
        //line(0,0,-height/2,0,0,height/2); 
        
        if(mode==0){
        text("Z="+maxval,0,0,scale2*105);}
        else{text("Z="+10,0,0,scale2*105);}
    }
    
    stroke(#aa03eb);
    //stroke(#eb03b8);
    
    //Arraylistmode
    for (int i=0;i<xvals.size()-1;i++){
        if(mode==2){
          drawFlat(i);          
        }
        else{
           if(i%25==0){
              drawCircles(i);               
            }
           drawRotations(i,100);     
       }
    }
    if(mode!=2){
    drawCircles(xvals.size()-1);}
    if(timer<360){timer+=3;}
}

void calculate(){
  xvals.clear(); yvals.clear(); 
  rescale();
  for (float i=-100;i<=100;i+=0.5){
      xvals.append(i); yvals.append(fn(i/10));
  }
  //volume=simpsons();
  volume=abs((float)integrate(-10,10));
}

void rescale(){
  maxval=0;
  scale=1;
  for (float i=-100;i<=100;i+=0.5){
         if (abs(fn(i/10))>maxval){
            maxval=abs(fn(i/10));
         }
      }

  scale=100/maxval;
  if (scale==0){scale=200; }
}

float fn(float i){
   String tempeval=exp.replaceAll("x","("+Float.toString(i)+")");
   return(-scale*(float)parse.interp(tempeval));
}


void drawFlat(int i){
  line(xvals.get(i),scale2*yvals.get(i),0,xvals.get(i+1),scale2*yvals.get(i+1),0);  
}

void drawCircles(int i){
   for (int j=0;j<timer;j+=5){
         if(mode==0){
         line(xvals.get(i),scale2*yvals.get(i)*cos(j*PI/180),scale2*yvals.get(i)*sin(j*PI/180),xvals.get(i),scale2*yvals.get(i)*cos((j+5)*PI/180),scale2*yvals.get(i)*sin((j+5)*PI/180));}
         else{
              line(xvals.get(i)*cos(j*PI/180),scale2*yvals.get(i),xvals.get(i)*sin(j*PI/180),xvals.get(i)*cos((j+5)*PI/180),scale2*yvals.get(i),xvals.get(i)*sin((j+5)*PI/180));}
    } 
}


void drawRotations(int i,float limit){
  if(i<xvals.size()-1){;
      for (float j=0;j<timer;j+=5){
          pushMatrix();
          if(mode==0){
          rotateX(j*PI/180);}
          else{rotateY(j*PI/180);}
          line(xvals.get(i),scale2*yvals.get(i),0,xvals.get(i+1),scale2*yvals.get(i+1),0);  
          popMatrix();
      }
  } 
}

void rotate(){
  rotateX(rx);
  rotateZ(rz);
}

double integrate(double a, double b) {
      if (mode==2){
          int N = 10000;                    // precision parameter
          double h = (b - a) / (N - 1);     // step size 
          // 1/3 terms
          double sum = 1.0 / 3.0 * (fn((float)a)/-scale + fn((float)b)/-scale);
          // 4/3 terms
          for (int i = 1; i < N - 1; i += 2) {
             double x = a + h * i;
             sum += 4.0 / 3.0 * fn((float)x)/-scale;
          }
          // 2/3 terms
          for (int i = 2; i < N - 1; i += 2) {
             double x = a + h * i;
             sum += 2.0 / 3.0 * fn((float)x)/-scale;
          }
          if(abs((float)(sum*h))<0.1){return(0);}
          return sum * h;
      }
      if (mode==1){
          a=0;
          int N = 10000;                    // precision parameter
          double h = (b - a) / (N - 1);     // step size 
          // 1/3 terms
          double sum = 1.0 / 3.0 * (abs((float)(fn((float)a)*a/-scale)) + abs((float)(fn((float)b)*b/-scale)));
          // 4/3 terms
          for (int i = 1; i < N - 1; i += 2) {
             double x = a + h * i;
             sum += 4.0 / 3.0 * abs((float)(fn((float)x)*x/-scale));
          }
          // 2/3 terms
          for (int i = 2; i < N - 1; i += 2) {
             double x = a + h * i;
             sum += 2.0 / 3.0 * abs((float)(fn((float)x)*x/-scale));
          }
          if(abs((float)(sum*h*2*PI))<0.1){return(0);}
          return sum * h*2*PI;
      }
      if(mode==0){
           int N = 10000;                    // precision parameter
          double h = (b - a) / (N - 1);     // step size 
          // 1/3 terms
          double sum = (1.0 / 3.0)*(1/(scale*scale)) * ((fn((float)a)*fn((float)a)) + (fn((float)b)*fn((float)b)));
          // 4/3 terms
          for (int i = 1; i < N - 1; i += 2) {
             double x = a + h * i;
             sum += (4.0 / 3.0)*(1/(scale*scale)) * (fn((float)x)*fn((float)x));
          }
          // 2/3 terms
          for (int i = 2; i < N - 1; i += 2) {
             double x = a + h * i;
             sum += (2.0 / 3.0)*(1/(scale*scale)) * fn((float)x)*fn((float)x);
          }
          return sum * h * PI;      
      }     
      return(0.0);
}


void keyPressed(){
   if(key=='f'||key=='F'){
     if(rchoose==3){ if(mode==1){rchoose=2;} else{rchoose=1;}}
     else{
     rchoose=3;}
   }
   
   if((key=='a'||key=='A')&& !typing){   if(axis){axis=false;} else{axis=true;}   }
   if(key=='d' && !typing){
     if(mode!=0){mode=0; 
      rx=0; rz=0;  
      timer=0;  rchoose=1; volume=integrate(-10,10);}
   }
   if(key=='l' && !typing){
     mode=2;     volume=integrate(-10,10);
   }
   if(key=='g'){if(scaleon){scaleon=false;}else{scaleon=true;}}
   if(key=='s' && !typing){
     if(mode!=1){mode=1;   
     rx=0; rz=0;  
      timer=0; rchoose=2; volume=integrate(-10,10);}
   }
   if(key=='r'||key=='R'){
      rx=0; rz=0;  timer2=0; scale2=1;
   }
   if(key=='p'||key=='P'){
     if(!paused){paused=true;}else{   paused=false;}
   }
   if(keyCode==LEFT){
      ry-=5*PI/180;
   }
   if(keyCode==RIGHT){
      ry+=5*PI/180;
   }
   if(keyCode==ENTER){
       if(typing){typing=false; 
       //println("");println("processing "+exp); 
      rx=0; rz=0; timer2=0; mode=2;  calculate();} 
       else{typing=true;exp=new String("");
       //println("");println("--Start typing expression: y=");
       }
   }
   if(typing){
      if(keyCode!=SHIFT && keyCode!=ENTER && keyCode!=BACKSPACE && keyCode!=DELETE){
      exp=exp+Character.toString(key);
      //print(key);
      }
   }
   if(typing && (keyCode==DELETE||keyCode==BACKSPACE)){
      exp=exp.substring(0,exp.length()-1);
   }
}
void mouseClicked(){
  if(!paused){paused=true;}else{   paused=false;}
}
void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  if(rchoose==2){
    rx-=5*e*PI/180;
    
  }
  if(rchoose==1){
    rz-=5*e*PI/180;    
  }
  if(rchoose==3){
    if(e>0){ scale2=scale2/1.1;}
    else{scale2=scale2*1.1;}
    //maxval=maxval*scale;
    //calculate();
    //scale-=e*1.0/180;    
  }
}