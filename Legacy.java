/*PVector location1 = new PVector(0, 0, 0);
      PVector location2 = new PVector(0, -1, -2);   
      PVector d = PVector.sub(location2, location1);
      //println("vector from location1 to location2 : " + d);    
      PVector polar = cartesianToPolar(d);


for (float i=-100;i<=100;i+=0.5){
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
    
float fn(float i){
   float a =2.0/3.0;
   return(-scale*(float)(pow(i,2)));
   //return(-1*10*i/3);
   //return(-scale*pow((float)Math.E,i));
   //return(-scale*(cos(2*i)+sin(i)));
   //return(-scale);
   //return(-scale*i);
   //return(-scale*pow(2,cos(i)));
   //return(-scale*pow(1-pow(i/10,2),0.5));
   //return(-scale*(0.1/i));
   //return(-scale*(float)(pow(abs(i),a)));
   //return(-scale*(float)sin(i));
   //return(-scale*(float)(pow(i,3)));
}

void drawFlat(float i){
  line(i,fn(i/10),0,i+1,fn((i+1)/10),0);
}

void drawCircles(float i){
    float temp=-fn(i/10);
    for (int j=0;j<timer;j+=5){
         if(mode==0){
         line(i,fn(i/10)*cos(j*PI/180),fn(i/10)*sin(j*PI/180),i,fn(i/10)*cos((j+5)*PI/180),fn(i/10)*sin((j+5)*PI/180));}
         else{
              line(i*cos(j*PI/180),fn(i/10),i*sin(j*PI/180),i*cos((j+5)*PI/180),fn(i/10),i*sin((j+5)*PI/180));}
    }
}

void drawRotations(float i,float limit){
  if(i<limit){
      float temp=fn(i/10);
      float temp2=fn((i+1)/10);
      for (float j=0;j<timer;j+=5){
          pushMatrix();
          if(mode==0){
          rotateX(j*PI/180);}
          else{rotateY(j*PI/180);}
          line(i,temp,0,i+1,temp2,0);
          popMatrix();
      }
  }
}


PVector cartesianToPolar(PVector theVector) {
  PVector res = new PVector();
  res.x = theVector.mag();
  if (res.x > 0) {
    res.y = -atan2(theVector.z, theVector.x);
    res.z = asin(theVector.y / res.x);
  } 
  else {
    res.y = 0;
    res.z = 0;
  }
  return res;
}*/