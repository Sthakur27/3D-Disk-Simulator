boolean rotate=false;
FloatList xvals=new FloatList();
FloatList yvals=new FloatList();
FloatList rvals=new FloatList();
FloatList thetavals=new FloatList();
float rx=0; float rz=0;
boolean line=true;
boolean axis=true;
int rchoose=1;
int timer=1;
int timer2=1;
float scale=1;  //auto y scaling
float scale2=1;  //user yscale control
float xscale=1;  // auto x scaling
float xscale2=1; //user xscale control
boolean typing=false;
int mode=2;   //0:disk 1: shell 2:line
float maxval=0;
float maxdom=0;
float ry=0;
int funcnum=0;
int totalP=11;
double volume=0;
boolean paused=false;
boolean cartesian=true;
//sin@*cos@    s*s*c  c^2 donut         x+sinx      cos(@*1.5) 2.5      sin@*cos1.5@    
//String exp=("1-sin@"); 
//String exp=("(sin@*(cos@^2^0.25)/(sin@+1.4))-(2*sin@)+2");
//String exp=("1-2*sin@");
//String exp=("4.64-(x^2^(1/3))");
//String exp=("x^2");
//String exp=("4*cos((10)*cos@)");
String exp=("x/(1+x^2)");   //volcano.  sinx/(1+x^2)   optional *x
//String exp=("5+sin(8*3.14*@)");
//String exp=("1-(sin(6*@-6)^2^0.5)+2*(cos(2*@-2))");
//String exp=("3*sin(@-2)^2+4*cos(2*@-5)");
//String exp=("10-3*(1/cos(@))");
//String exp=("log@");
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
    
    //VOLUME/AREA
    /*if(mode==2){
    text("Area ="+(float)volume,330,20,0);}
    else{text("Volume ="+(float)volume,330,20,0);}*/
    
    if(mode==2){
    text("2D Mode",380,20,0);}
    else if(mode==0){text("Disk Mode",380,20,0);}
    else{text("Shell Mode",380,20,0);}
    
    if (typing){fill(#f42121);}
    if(cartesian){
    text("Exp: y="+exp,10,20,0);}
    else{text("Exp: r="+exp,10,20,0);}
    fill(#000000);
    
    if(rchoose==3){
      text("Scroll Mode Y axis stretch",10,40,0);
    }
    else if(rchoose==4){
      text("Scroll Mode X axis stretch",10,40,0);
    }
    else{
      text(" X-Y axis Tilt",10,40,0);
    }
    translate(width/2,height/2,0);
    //user left or right buttons
    rotateY(ry);
    //auto 3d rotation
    rotateY(timer2*PI/180);
    if(!paused){
       timer2++;}       
    if(timer2>360){timer2=0;}
    
    
    rotate();
    stroke(0,0,0);   
    //draw axis
    if(axis){
        textSize(15); fill(0);
        
        //x axis
        line(-150*xscale2,0,0,150*xscale2,0,0);
        text("X="+maxdom,105*xscale2,0,0);
        
        //y
        line(0,-150*scale2,0,0,150*scale2,0);     
        text("Y="+maxval,0,-105*scale2,0);
        
        //z
        
        if(mode==0){
        text("Z="+maxval,0,0,scale2*105);
        line(0,0,-150*scale2,0,0,150*scale2);  
        }
        else if(mode==1){text("Z="+maxdom,0,0,xscale2*105);
        line(0,0,-150*xscale2,0,0,150*xscale2); 
        }
        else{text("Z="+10,0,0,105);
        line(0,0,-150,0,0,150); 
        }
    }
    
    stroke(#aa03eb);
    if(!cartesian){
    stroke(#0093cc);}
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
  xvals.clear(); yvals.clear(); scale=1;
  if(!cartesian){
    parse.polarinterp(exp,0,4*PI,PI/100);
    for (int i=0;i<parse.rory.size();i++){
       //print(parse.thetaorx.get(i).floatValue()); print("    "); println(parse.rory.get(i).floatValue());
       xvals.append(parse.thetaorx.get(i).floatValue());
       yvals.append(-1*parse.rory.get(i).floatValue());
    }
  }
  else{
    for (float i=-100;i<=100;i+=0.5){
        xvals.append(i); yvals.append(fn(i/10));
    }
  }
  //volume=simpsons();
  rescale();
  //volume=abs((float)integrate(-10,10));
}

void rescale(){
  maxval=0;
  scale=1;
  for (int i=0;i<yvals.size();i++){
         if (abs(yvals.get(i))>maxval){
            maxval=abs(yvals.get(i));
         }
      }

  scale=100/maxval;
  if (scale==0){scale=200; }
  for (int i=0;i<yvals.size();i++){
     yvals.set(i,yvals.get(i)*scale);
  }
  maxdom=0;
  xscale=1;
  if(!cartesian){
  for (int i=0;i<xvals.size();i++){
         if (abs(xvals.get(i))>maxdom){
            maxdom=abs(xvals.get(i));
         }
  }
  xscale=100/maxdom;}
  else{maxdom=10;}
  if (xscale==0){xscale=10; }
  for (int i=0;i<xvals.size();i++){
     xvals.set(i,xvals.get(i)*xscale);
  }
}

float fn(float i){
   String tempeval=exp.replaceAll("x","("+Float.toString(i)+")");
   //tempeval=tempeval.replaceAll("@","("+Float.toString(i)+")");
   return(-scale*(float)parse.interp(tempeval));
}


void drawFlat(int i){
  line(xvals.get(i)*xscale2,scale2*yvals.get(i),0,xvals.get(i+1)*xscale2,scale2*yvals.get(i+1),0);  
}

void drawCircles(int i){
   for (int j=0;j<timer;j+=5){
         if(mode==0){
         line(xvals.get(i)*xscale2,scale2*yvals.get(i)*cos(j*PI/180),scale2*yvals.get(i)*sin(j*PI/180),xscale2*xvals.get(i),scale2*yvals.get(i)*cos((j+5)*PI/180),scale2*yvals.get(i)*sin((j+5)*PI/180));}
         else{
              line(xvals.get(i)*cos(j*PI/180)*xscale2,scale2*yvals.get(i),xvals.get(i)*sin(j*PI/180)*xscale2,xvals.get(i)*cos((j+5)*PI/180)*xscale2,scale2*yvals.get(i),xvals.get(i)*sin((j+5)*PI/180)*xscale2);}
    } 
}


void drawRotations(int i,float limit){
  if(i<xvals.size()-1){;
      for (float j=0;j<timer;j+=5){
          pushMatrix();
          if(mode==0){
          rotateX(j*PI/180);}
          else{rotateY(j*PI/180);}
          line(xvals.get(i)*xscale2,scale2*yvals.get(i),0,xvals.get(i+1)*xscale2,scale2*yvals.get(i+1),0);  
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
     if(rchoose==3){rchoose=4;}
     else if(rchoose==4){ if(mode==1){rchoose=2;} else{rchoose=1;}}
     else{
     rchoose=3;}
   }
   
   if((key=='a'||key=='A')&& !typing){   if(axis){axis=false;} else{axis=true;}   }
   if((key=='d'||key=='D') && !typing){
     if(mode!=0){mode=0; 
      rx=0; rz=0;  
      timer=0;  rchoose=1; //volume=integrate(-10,10);
     }
   }
   if((key=='l'||key=='L') && !typing){
     mode=2;     //volume=integrate(-10,10);
   }

   if((key=='s'||key=='S') && !typing){
     if(mode!=1){mode=1;   
      rx=0; rz=0;  
      timer=0; rchoose=2; //volume=integrate(-10,10);
     }
   }
   if(key=='r'||key=='R' && !typing){
      rx=0; rz=0; ry=0; timer2=0; scale2=1;  xscale2=1;
   }
   if((key=='p'||key=='P') && !typing){
     cartesian=false; 
     calculate();
   }
   if((key=='c'||key=='C') && !typing){
     cartesian=true; 
     calculate();
   }
   if(keyCode==LEFT){
      ry-=5*PI/180;
   }
   if(keyCode==RIGHT){
      ry+=5*PI/180;
   }
   if((keyCode==BACKSPACE||keyCode==DELETE)&&!typing){if(!paused){paused=true;}else{   paused=false;}}
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
      if(exp.length()>0){
      exp=exp.substring(0,exp.length()-1);}
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
  }
  if(rchoose==4){
    if(e>0){ xscale2=xscale2/1.1;}
    else{xscale2=xscale2*1.1;} 
  }
}