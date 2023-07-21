import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintApi{


  static addComplaintapi(
      String content, String title,String id) async {

    final data = {
      "content": content,
      "title": title,
      "uid": "null",
      "student": id,
      "date": Timestamp.now(),
    };

     try{
      await FirebaseFirestore.instance
        .collection("complaint")
        .add(data)
        .then((documentSnapshot) async {
      print("Added Data with ID: ${documentSnapshot.id}");
       final data2 = {
          "uid": documentSnapshot.id,
        };
        await FirebaseFirestore.instance
            .collection('complaint')
            .doc(documentSnapshot.id)
            .update(data2);

        }
        );

        return true;
     }catch(e){
       return false;
     }
   
}

}