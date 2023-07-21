
class Student{
   final String email;
   final String uid;


   const Student({
      required this.email,
      required this.uid,

   });

  Map<String,dynamic> toJson()=>{
     "uid":uid,
     "email":email,
  };

}