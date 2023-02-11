class Staticfile {
  static String uid="",name="",type="",phn="",email="",photo="",mission="",location="",upiId="",accNo="",ifsc="",accName="";
  static List<String> impact = ["AnimalWelfare","EducationSector","FarmerEmpowerment","MedicalSector","WomenWelfare"],selectedImpact=[];
  static int navIndex=0;
  void reset(){
    uid="";
    name="";
    type="";
    phn="";
    email="";
    location="";
    photo="";
    mission="";
    selectedImpact.clear();
    upiId="";
    accNo="";
    ifsc="";
    accName="";
  }
}