import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tutorial_2/Models/brew.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData (String sugars,String name,int strength) async{
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name' : name,
      'strength' : strength,
    });
  }

  // brew list from snapshots
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.docs.map((doc){
  //     return Brew(
  //       name: doc.get('name') ?? "",
  //       strength: doc.get('strength') ?? 100,
  //       sugars: doc.get('sugars') ?? "0",
  //     );
  //   }).toList();
  // }
  //
  // // get brews collection
  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots()
  //       .map(_brewListFromSnapshot);
  // }
}