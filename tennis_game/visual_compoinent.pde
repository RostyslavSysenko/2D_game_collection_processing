void randomFill(){
fill(random(150,255),random(150,255),255);
}

void counting(){
  //loss count
  textSize(height/15);
  text(totalWins + "/"+ totalPlayed,(width/2)-30,height/8);
  //level meter
  textSize(height/45);
  text("s:re-/star 1:easy 2:medium 3:difficult",width -200,0.03 * height);
  text(" current difficulty: " + level,width -200,0.06 * height);
  textSize(height/45);
  text("time left to win: " + (30 - time),width -200,0.09 * height);
  
}
