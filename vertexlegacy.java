/*if (!line){
          //#06bdf7
            fill(255,255,255, 0);
            tint(0,0);
            //stroke(#06bdf7);
            beginShape();            
            for (int j=0;j<360;j+=30){
                pushMatrix();
                //translate(0,height/2);
                if(disk){
                    //vertex(i,-50*cos(j*PI/180),-50*sin(j*PI/180));
                    vertex(i,-pow(i/8,2)*cos(j*PI/180),-pow(i/8,2)*sin(j*PI/180));
                    //vertex(i,50*sin(i*PI/90)*cos(j*PI/180),50*sin(i*PI/90)*sin(j*PI/180));
                }
                else{//rotateY(j*PI/180);
                    //vertex(i*cos(j*PI/180),-50,i*sin(j*PI/180));
                    vertex(i*cos(j*PI/180),-pow(i/8,2),i*sin(j*PI/180));
                    //vertex(i*cos(j*PI/180),50*sin(i*PI/90),i*sin(j*PI/180));
                }
                popMatrix();
                //line(i,50*sin((i)*PI/180)+height/2,100+(50*sin(j*PI/180)),i+1,50*sin((i+1)*PI/180)+height/2,100+(50*sin(j*PI/180)));
            }
            endShape(CLOSE);
        }*/
        
      
        
 /*if(i%25==0){
               for (int j=0;j<timer;j+=5){
                   if(disk){
                   line(i,2*i*cos(j*PI/180),2*i*sin(j*PI/180),i,2*i*cos((j+5)*PI/180),2*i*sin((j+5)*PI/180));}
                   else{
                   line(i*cos(j*PI/180),2*i,i*sin(j*PI/180),i*cos((j+5)*PI/180),2*i,i*sin((j+5)*PI/180));}
               }
            }*/
            
 /*for (float j=0;j<timer;j+=5){
                stroke(0,235-(j*235/360),235-(j*235/360));
                pushMatrix();
                //translate(0,height/2);
                if(disk){
                rotateX(j*PI/180);}
                else{rotateY(j*PI/180);}
                //line(i*5,-pow(i,2),0,(i+1)*5,-pow(i+1,2),0);
                //line(i,50*sin((i)*PI/90),0,i+1,50*sin((i+1)*PI/90),0);
                line(i,2*i,0,i+1,2*(i+1),0);
                popMatrix();
                //line(i,50*sin((i)*PI/180)+height/2,100+(50*sin(j*PI/180)),i+1,50*sin((i+1)*PI/180)+height/2,100+(50*sin(j*PI/180)));
            }*/