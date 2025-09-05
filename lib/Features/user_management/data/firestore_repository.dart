import 'package:cloud_firestore/cloud_firestore.dart';

import '../../authentication/domain/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_repository.g.dart';
class FirestoreRepository{

  FirestoreRepository(this._firestore);

  final FirebaseFirestore _firestore ;

  Stream<List<AppUser>> loadDonors(){
    return _firestore
        .collection('users')
        .where('type',isEqualTo: 'Donor')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) =>AppUser.fromMap(doc.data()) )
        .toList());
  }
  Stream<List<AppUser>> loadSpecificBloodGroupDonors(String bloodGroup){
    return _firestore
        .collection('users')
        .where('type',isEqualTo: 'Donor')
        .where('bloodGroup',isEqualTo: bloodGroup)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) =>AppUser.fromMap(doc.data()) )
        .toList());
  }

  Stream<List<AppUser>>loadSimilarBloodGroups(String bloodGroup){
    return _firestore
        .collection('emails')
        .where('type', isEqualTo: 'Donor')
        .where('bloodGroup', isEqualTo: bloodGroup)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) =>AppUser.fromMap(doc.data()) )
        .toList());

  }
}

@riverpod
FirestoreRepository firestoreRepository(FirestoreRepositoryRef ref){
  return FirestoreRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<AppUser>> loadDonors(LoadDonorsRef ref){
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadDonors();
}
@riverpod
Stream<List<AppUser>>loadSpecificBloodGroupDonors(
    LoadSpecificBloodGroupDonorsRef ref, String bloodGroup){
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadSpecificBloodGroupDonors(bloodGroup);
}

@riverpod
Stream<List<AppUser>>loadSimilarBloodGroups(
    LoadSimilarBloodGroupsRef ref, String bloodGroup){
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadSimilarBloodGroups(bloodGroup);
}

