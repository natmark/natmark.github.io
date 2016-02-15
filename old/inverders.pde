class Node{
  String _name;
  int _age;
  int _xSize;
  int _ySize;
  int _bitSize;
  int _xScale;
  int _yScale;
  int _xPosition =0;
  int _yPosition =0;
  int _bitMask[][];
  int _R = 0;
  int _G = 0;
  int _B = 0;
  
  void setName(String name){
    _name = name;
  }
  String getName(){
    return _name;
  }
  void setBitSize(int bitSize){
    _bitSize = bitSize;
  }
  void setColor(int r,int g,int b){
    _R = r;
    _G = g;
    _B = b;
  }
  int getXscale(){
    return _xSize * _bitSize;
  }
  int getYscale(){
    return _ySize * _bitSize;
  }
  void setXposition(int xPosition){
    _xPosition = xPosition;
  }
  void setYposition(int yPosition){
    _yPosition = yPosition;
  }
  int getXposition(){
    return _xPosition;
  }
  int getYposition(){
    return _yPosition;
  }
  void update(int x,int y){
  }
}

class Inverder extends Node{
 int _hp;
 int _diedCount = 0;
 int _bitMask[][] = {{0,0,0,1,0,0,0,0,0,1,0,0,0},
                     {0,0,0,0,1,0,0,0,1,0,0,0,0},
                     {0,0,0,1,1,1,1,1,1,1,0,0,0},
                     {0,0,1,1,0,1,1,1,0,1,1,0,0},
                     {0,1,1,1,1,1,1,1,1,1,1,1,0},
                     {0,1,0,1,1,1,1,1,1,1,0,1,0},
                     {0,1,0,1,0,0,0,0,0,1,0,1,0},
                     {0,0,0,0,1,1,0,1,1,0,0,0,0},
                     {0,0,0,0,0,0,0,0,0,0,0,0,0}};

  int _diedMask[][] = {{0,0,0,0,0,0,0,0,0,0,0,0,0},
                       {0,1,0,0,1,0,0,0,1,0,0,1,0},
                       {0,0,1,0,0,1,0,1,0,0,1,0,0},
                       {0,0,0,1,0,0,0,0,0,1,0,0,0},
                       {0,1,1,0,0,0,0,0,0,0,1,1,0},
                       {0,0,0,1,0,0,0,0,0,1,0,0,0},
                       {0,0,1,0,0,1,0,1,0,0,1,0,0},
                       {0,1,0,0,1,0,0,0,1,0,0,1,0},
                       {0,0,0,0,0,0,0,0,0,0,0,0,0}};
                       
  Inverder(){
   _xSize = _bitMask[0].length;
   _ySize = _bitMask.length;
  }
  void setHP(int hp){
    _hp = hp;
  }
  int getHP(){
    return _hp;
  }
   void update(int x,int y){
    for(int i = 0;i < _ySize;i++){
      for(int j = 0;j < _xSize;j++){
        if(_bitMask[i][j] == 1){
          noStroke();
          fill(_R,_G,_B);
          rect(x + _bitSize * j,y + _bitSize * i,_bitSize,_bitSize);
       }
     }
    }
  }
  int died(int x,int y){
    for(int i = 0;i < _ySize;i++){
      for(int j = 0;j < _xSize;j++){
        if(_diedMask[i][j] == 1){
          noStroke();
          fill(_R,_G,_B);
          rect(x + _bitSize * j,y + _bitSize * i,_bitSize,_bitSize);
       }
     }
    }
    _diedCount++;
    return _diedCount;
  }
  Bullet fire(){
    Bullet bullet = new Bullet();
    bullet.setName("enemyBullet");
    bullet.setColor(255,0,255);
    bullet.setBitSize(bulletSize);
    bullet.setXposition(this.getXposition() + this.getXscale() / 2 -  bullet.getXscale() / 2);
    bullet.setYposition(this.getYposition() + bullet.getYscale());
    return bullet;
  }
}

class Player extends Node{
    Boolean _isDied = false;
    int _bitMask[][]  = {{0,0,0,1,1,1,0,0,0},
                         {0,0,0,1,1,1,0,0,0},
                         {0,1,1,1,1,1,1,1,0},
                         {0,1,1,1,1,1,1,1,0},
                         {0,1,1,1,1,1,1,1,0},
                         {0,1,1,1,1,1,1,1,0}};
   Player(){
   _xSize = _bitMask[0].length;
   _ySize = _bitMask.length;
  }
   void update(int x,int y){
    for(int i = 0;i < _ySize;i++){
      for(int j = 0;j < _xSize;j++){
        if(_bitMask[i][j] == 1){
          noStroke();
          fill(_R,_G,_B);
          rect(x + _bitSize * j,y + _bitSize * i,_bitSize,_bitSize);
       }
     }
    }
  }
  void died(){
    this._bitSize = 0;
    update(0,0);
    this._isDied = true;
  }
  Boolean isDied(){
    return _isDied;
  }
  Bullet fire(){
    Bullet bullet = new Bullet();
    bullet.setName("playerBullet");
    bullet.setColor(255,255,0);
    bullet.setBitSize(bulletSize);
    bullet.setXposition(this.getXposition() + this.getXscale() / 2 -  bullet.getXscale() / 2);
    bullet.setYposition(this.getYposition() - bullet.getYscale());
    return bullet;
  }

}
class Bullet extends Node{
    int _bitMask[][]  = {{0,1,0},
                         {0,1,0},
                         {0,1,0},
                         {0,1,0},
                         {0,1,0}};
   Bullet(){
   _xSize = _bitMask[0].length;
   _ySize = _bitMask.length;
  }
  void update(int x,int y){
    for(int i = 0;i < _ySize;i++){
      for(int j = 0;j < _xSize;j++){
        if(_bitMask[i][j] == 1){
          noStroke();
          fill(_R,_G,_B);
          rect(x + _bitSize * j,y + _bitSize * i,_bitSize,_bitSize);
       }
     }
    }
  }
}

class StageLevels{
 final int fireLevel1 = 5000;
 final int fireLevel2 = 3000;
 final int fireLevel3 = 2000;
 final int fireLevel4 = 500;
 final int fireLevel5 = 400;
 
 final int speedLevel1 = 20;
 final int speedLevel2 = 18;
 final int speedLevel3 = 15;
 final int speedLevel4 = 10;
 final int speedLevel5 = 5;
 
 int getFireLevel(int level){
   switch(level){
     case 1:{
       return fireLevel1;
     }
     case 2:{
       return fireLevel2;
     }
     case 3:{
       return fireLevel3;
     }
     case 4:{
       return fireLevel4;
     }
     case 5:{
       return fireLevel5;
     }
     default:{
       return 0;
     }     
   } 
 }
 int getSpeedLevel(int level){
      switch(level){
     case 1:{
       return speedLevel1;
     }
     case 2:{
       return speedLevel2;
     }
     case 3:{
       return speedLevel3;
     }
     case 4:{
       return speedLevel4;
     }
     case 5:{
       return speedLevel5;
     }
     default:{
       return 0;
     }     
   } 
 }
}

final int inverderCountHorizontal = 8;
final int inverderCountVertical = 4;
final int horizontalSpace = 30;
final int verticalSpace = 20;
final int inverderSize = 4;
final int playerSize = 4;
final int bulletSize = 4;
final int inverderHP = 3;
Player player;
StageLevels stage;
Boolean left = false,right = false,space = false;
Boolean flg1 = true;
Boolean firstTurn = true;
int coolTime = 0;
int stageLevel = 5;
int count = 0;
int playerPoint = 0;
ArrayList bulletArray = new ArrayList();
ArrayList inverderList = new ArrayList();
ArrayList diedList = new ArrayList();

void setup(){
  bulletArray = new ArrayList();
  inverderList = new ArrayList();
 
  size(inverderCountHorizontal*inverderSize*13 + horizontalSpace * 2,300);
  frameRate(100);
  
  
  int inverderNumber = 0;
  
  for(int i = 0; i < inverderCountVertical; i++){
    for(int j = 0; j < inverderCountHorizontal;j++){
      Inverder inverder1 = new Inverder();
      inverder1.setName("inverder" + inverderNumber);
      inverder1.setBitSize(inverderSize);
      inverder1.setColor(255,0,100);
      inverder1.setHP(inverderHP);
      inverder1.setXposition(j * inverder1.getXscale()+horizontalSpace);
      inverder1.setYposition(i * inverder1.getYscale()+verticalSpace);
      inverder1.update(inverder1.getXposition(),inverder1.getYposition());
      inverderList.add(inverder1);
      inverderNumber++;
    }  
  }
  
  player = new Player();
  player.setName("player");
  player.setColor(255,255,255);
  player.setBitSize(playerSize);
  player.setXposition(width / 2 - player.getYscale() /2 );
  player.setYposition(height - player.getYscale() - verticalSpace);
  player.update(player.getXposition(),player.getYposition());
  
  stage = new StageLevels();
 }
void draw(){
  if(inverderList.size() == 0){
    //TODO:game clear
    setup();
    return;
  }
  
  coolTime--;
  
    if(space){
      if(coolTime <= 0){
        if(!player.isDied()){
          Bullet bullet = player.fire();
          bullet.update(bullet.getXposition(),bullet.getYposition()); 
          bulletArray.add(bullet);
          coolTime = 30;
        }
      }
      space = false;
    }
    if(left){
      leftPressed();
    }
    if(right){
      rightPressed();
    }   
    background(0);   
    player.update(player.getXposition(),player.getYposition());
    textSize(20);
    fill(0,255,0);
    text("Stage:" + stageLevel,10,30);
    text("Score:" + playerPoint,width - 150,30);
   
   
     for(int i = 0; i < inverderList.size();i++){
          Inverder inverder1 = (Inverder)inverderList.get(i);
          //TODO:enemy atack  
          if((int)random(stage.getFireLevel(stageLevel)) == 0){
            Bullet bullet = inverder1.fire();
            bullet.update(bullet.getXposition(),bullet.getYposition()); 
            bulletArray.add(bullet);
          }
          inverder1.update(inverder1.getXposition(),inverder1.getYposition());  
     } 
  
  ArrayList removeList = new ArrayList();

  for(int i = 0; i < bulletArray.size();i++){
    Bullet bullet = (Bullet)bulletArray.get(i);
    if(bullet.getName() == "playerBullet"){
        bullet.setYposition(bullet.getYposition() -1);
        bullet.update(bullet.getXposition(),bullet.getYposition());
        for(int j = 0; j < inverderList.size();j++){
              Inverder inverder1 = (Inverder)inverderList.get(j);    
              if(inverder1.getXposition() < bullet.getXposition() && inverder1.getXposition() + inverder1.getXscale() > bullet.getXposition() + bullet.getXscale() && inverder1.getYposition() < bullet.getYposition() && inverder1.getYposition() + inverder1.getYscale() > bullet.getYposition()){  
                bulletArray.remove(bullet);
                inverder1.setHP(inverder1.getHP() - 1);
                if(inverder1.getHP() == 2){
                  inverder1.setColor(0,0,255);
                  playerPoint += 100;
                }else if(inverder1.getHP() == 1){
                  inverder1.setColor(0,255,0);
                  playerPoint += 300;
                }else if(inverder1.getHP() < 1){
                  removeList.add(inverder1);
                  playerPoint += 500;
                }
              inverder1.update(inverder1.getXposition(),inverder1.getYposition());
              }  
        } 
    }else{
        bullet.setYposition(bullet.getYposition() + 1);
        bullet.update(bullet.getXposition(),bullet.getYposition());    
        if(player.getXposition() < bullet.getXposition() && player.getXposition() + player.getXscale() > bullet.getXposition() + bullet.getXscale() && player.getYposition() < bullet.getYposition() + bullet.getYscale()  && player.getYposition() + player.getYscale() > bullet.getYposition() + bullet.getYscale()){
          bulletArray.remove(bullet);
          player.died();
          println("Game Over");           
        }
    }   
  }  
  for(int i = 0;i < removeList.size();i++){
     Inverder inverder1 = (Inverder)removeList.get(i);
     diedList.add(inverder1);
     inverderList.remove(inverder1);
  }
  
ArrayList removeList2 = new ArrayList();
  for(int i = 0;i < diedList.size();i++){
    Inverder inverder1 = (Inverder)diedList.get(i);
    int count = inverder1.died(inverder1.getXposition(),inverder1.getYposition());
    if(count > 10){
      removeList2.add(inverder1);
    }
  }
  for(int i = 0;i < removeList2.size();i++){
     Inverder inverder1 = (Inverder)removeList2.get(i);
     diedList.remove(inverder1);
  }


 
  count++;
  
  int moveTime = 0;
  if(firstTurn){
    moveTime = 25;
  }else{
    moveTime = 50;
  }
  
  if(count % 5 == 0){
    if(count % 100 == 0){
      firstTurn = false;
      count = 0;
      flg1 = !flg1;
      Boolean downFlg = true;
      for(int i = 0; i < inverderList.size();i++){
          Inverder inverder1 = (Inverder)inverderList.get(i);   
          if(inverder1.getYposition() + inverder1.getYscale() + 5 >= player.getYposition()){
            downFlg = false;
          }
      } 
      if(downFlg){
        for(int i = 0; i < inverderList.size();i++){
          Inverder inverder1 = (Inverder)inverderList.get(i);   
          inverder1.setYposition(inverder1.getYposition()+5);
        } 
      }
    }  
     for(int i = 0; i < inverderList.size();i++){
          Inverder inverder1 = (Inverder)inverderList.get(i);   
          if(flg1){
            inverder1.setXposition(inverder1.getXposition()+1);
          }else{
            inverder1.setXposition(inverder1.getXposition()-1);
          }
     } 
  }
}
void keyPressed() {
   switch(keyCode){
      case 32 :{
        space = true;
        break; 
      }
      case 37:{
        left = true;
        break;
      }
      case 39:{
        right = true;
        break; 
      }
      default:{
      break;
      }
   }
}

void keyReleased(){
   switch(keyCode){
      case 32 :{
        space = false;
        break; 
      }
      case 37:{
        left = false;
        break;
      }
      case 39:{
        right = false;
        break; 
      }
      default:{
      break;
      }
   }
}

void rightPressed(){
  if(player.getXposition() + player.getXscale() < width){
   player.setXposition(player.getXposition()+1);
   player.update(player.getXposition(),player.getYposition());
  }
}
void leftPressed(){
   if(player.getXposition() > 0){
     player.setXposition(player.getXposition()-1);
     player.update(player.getXposition(),player.getYposition());
   }
}

