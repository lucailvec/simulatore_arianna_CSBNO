public class BezierPath{
  
   private PVector[] points =null;
   private PVector[] equidistantPoints = null;
   
  private ArrayList<BezierCurve> path=new ArrayList<BezierCurve>();
  
  public void add(BezierCurve c){
     path.add(c); 
  }
   public void addLine(PVector f,PVector t){
     path.add(new BezierCurve(f,f,t,t)); 
  }
  //http://stackoverflow.com/questions/1734745/how-to-create-circle-with-b%c3%a9zier-curves#27863181
  public void addCircle(PVector center,PVector from,PVector to,boolean orario){
    PVector tempF=new PVector(from.x,from.y),tempTo=new PVector(to.x,to.y);
    tempF.sub(center);
    tempTo.sub(center);
     System.out.println("Angle between:" + PVector.angleBetween(tempF,tempTo) + tempF + " " + tempTo);
  }
  public PVector pointAtParameter(float i ){
    //System.out.println("index: " + (int)Math.floor(i*path.size())+ " value" + i*path.size() + " " + Math.floor(i*path.size()) + ".");
    try{
      return path.get((int)Math.floor(i*path.size())).pointAtParameter( i*path.size() - (float)Math.floor(i*path.size()));
    }
    catch(Exception e ){
      return path.get(path.size()-1).pointAtParameter(1.0);
    }
  }
  public PVector pointAtFraction(Float i ){
        return path.get((int)Math.floor(i*path.size())).pointAtFraction(i*path.size()- (float)Math.floor(i*path.size()));
  }
  public PVector[] points(){
    ArrayList<PVector> arr = new ArrayList<PVector>();
    if(points!=null && path.size()*BezierCurve.SEGMENT_COUNT==points.length)
      return points;
     
    for(BezierCurve b : path){
        PVector [] p = b.points(100);
       for(int i = 0 ; i<p.length; i ++) {
         arr.add(p[i]);
       }
    }
    points=(arr.toArray(new PVector[0]));
    return points;
  }
  
  public PVector[] equidistantPoints(){
        ArrayList<PVector> arr = new ArrayList<PVector>();
    if(equidistantPoints!=null && path.size()*BezierCurve.SEGMENT_COUNT==equidistantPoints.length)
      return equidistantPoints;
     
    for(BezierCurve b : path){
      PVector [] p = b.equidistantPoints(100);
       for(int i = 0 ; i<p.length; i ++) {
         arr.add(p[i]);
       }
    }
    equidistantPoints=arr.toArray(new PVector[0]);
    return equidistantPoints;
  }
}