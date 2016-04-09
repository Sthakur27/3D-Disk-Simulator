boolean rotate=false;
FloatList xvals=new FloatList();
FloatList yvals=new FloatList();
float rx=0; float rz=0;
boolean line=true;
boolean axis=true;
int rchoose=1;
int timer=1;
int timer2=1;
float scale=1;
int mode=2;
float maxval=0;
float ry=0;
int funcnum=5;
int totalP=11;
boolean paused=false;
void setup(){
      size(500, 450,P3D);
      TestParser.str="3+x*4";
      //TestParser.test();
      TestParser.interpret(2);
      calculate();
      //surface.setResizable(true);
}

void draw(){
    background(255,255,255);
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
        text("Y="+maxval,0,-105,0);
        
        //z
        line(0,0,-150,0,0,150);
        //line(0,0,-height/2,0,0,height/2); 
        
        if(mode==0){
        text("Z="+maxval,0,0,105);}
        else{text("Z="+10,0,0,105);}
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
  if (scale==0){scale=200; print(scale); }
}

float fn(float i){
   float a =2.0/3.0;
   if (funcnum==0){return(-scale*(float)(pow(i,2)));}     //parabola
   if (funcnum==1){return(-1*10*i/3);}
   if (funcnum==2){return(-scale*pow((float)Math.E,i));} 
   if (funcnum==3){return(-scale);} 
   if (funcnum==4){return(-scale*i);} 
   if (funcnum==5){return(-scale*pow(2,cos(i)));    }        //fav
   if (funcnum==6){return(-scale*pow(1-pow(i/10,2),0.5)); }   //circle
   if (funcnum==7){return(-scale*(0.1/i));} 
   if (funcnum==8){return(-scale*(float)(pow(abs(i),a)));} 
   if (funcnum==9){return(-scale*(float)sin(i));} 
   if (funcnum==10){return(-scale*(float)(pow(i,3)));}
   if(funcnum==11){return(-scale*(float)(pow(i,2)+20));}
   return(-scale*i);
}


void drawFlat(int i){
  line(xvals.get(i),yvals.get(i),0,xvals.get(i+1),yvals.get(i+1),0);  
}

void drawCircles(int i){
   for (int j=0;j<timer;j+=5){
         if(mode==0){
         line(xvals.get(i),yvals.get(i)*cos(j*PI/180),yvals.get(i)*sin(j*PI/180),xvals.get(i),yvals.get(i)*cos((j+5)*PI/180),yvals.get(i)*sin((j+5)*PI/180));}
         else{
              line(xvals.get(i)*cos(j*PI/180),yvals.get(i),xvals.get(i)*sin(j*PI/180),xvals.get(i)*cos((j+5)*PI/180),yvals.get(i),xvals.get(i)*sin((j+5)*PI/180));}
    } 
}


void drawRotations(int i,float limit){
  if(i<xvals.size()-1){;
      for (float j=0;j<timer;j+=5){
          pushMatrix();
          if(mode==0){
          rotateX(j*PI/180);}
          else{rotateY(j*PI/180);}
          line(xvals.get(i),yvals.get(i),0,xvals.get(i+1),yvals.get(i+1),0);  
          popMatrix();
      }
  } 
}

void rotate(){
  rotateX(rx);
  rotateZ(rz);
}

double simpsons(){
   return(0.0);
  
}

void keyPressed(){
   /*if(key=='c'||key=='C'){
     rchoose=1;
   }
   if(key=='z'||key=='Z'){
     rchoose=2;
   }*/
   if(key=='f'||key=='F'){
     if(rchoose==3){ if(mode==1){rchoose=2;} else{rchoose=1;}}
     else{
     rchoose=3;}
   }
   if(key=='t'){
     rotate=true;
   }
   if(key=='.'){
     funcnum++; if (funcnum>totalP){funcnum=0;}  calculate(); mode=2;  
   }
   if(key==','){
     funcnum-=1; if (funcnum<0){funcnum=totalP;}  calculate(); mode=2;  
   }
   
   if(key=='a'||key=='A'){   if(axis){axis=false;} else{axis=true;}   }
   if(key=='d'){
     if(mode!=0){mode=0; rx=0; rz=0;  timer=0;  rchoose=1;}
   }
   if(key=='l'){
     mode=2;     
   }
   if(key=='s'){
     if(mode!=1){mode=1;   rx=0; rz=0;  timer=0; rchoose=2;}
   }
   if(key=='r'||key=='R'){
      rx=0; rz=0;  timer2=0;
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
    if(e>0){ scale=scale/1.1;}
    else{scale=scale*1.1;}
    //maxval=maxval*scale;
    calculate();
    //scale-=e*1.0/180;    
  }
}