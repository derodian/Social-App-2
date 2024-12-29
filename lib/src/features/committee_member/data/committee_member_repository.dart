import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/constants/firebase_field_name.dart';
import 'package:social_app_2/src/features/committee_member/domain/committee_member.dart';
import 'package:social_app_2/src/features/committee_member/domain/committee_member_payload.dart';
import 'package:social_app_2/src/features/committee_member/typedefs/committee_member_id.dart';

part 'committee_member_repository.g.dart';

class CommitteeMemberRepository {
  const CommitteeMemberRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String committeeMemberPath() => 'committe';
  static String singleCommitteeMemberPath(CommitteeMemberID id) =>
      'committe/$id';

  Future<List<CommitteeMember>> fetchCommitteeMemberList() async {
    final ref = _committeeMemberRef();
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<CommitteeMember>> watchCommitteeMemberList() {
    final ref = _committeeMemberRef();
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<CommitteeMember?> fetchCommitteeMember(String id) async {
    final ref = _singleCommitteeMemberRef(id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<CommitteeMember?> watchCommitteeMember(String id) {
    final ref = _singleCommitteeMemberRef(id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  // Future<void> addNews({})

  Future<void> createCommitteeMember({
    required CommitteeMemberID committeeMemberId,
    required CommitteeMember committeeMember,
  }) async {
    try {
      // first check if committee member already exist
      final committeeMemberInfo = await _firestore
          .collection(committeeMemberPath())
          .where(FirebaseFieldName.committeeMemberId,
              isEqualTo: committeeMemberId)
          .limit(1)
          .get();
      // if Committee Member exist then update old info
      if (committeeMemberInfo.docs.isNotEmpty) {
        // committee member is already there, update with new data
        await committeeMemberInfo.docs.first.reference.set(
          {
            // FirebaseFieldName.committeeMemberId: committeeMember.committeeId,
            FirebaseFieldName.committeeMemberName: committeeMember.name,
            FirebaseFieldName.committeeMemberEmail: committeeMember.email,
            FirebaseFieldName.committeeMemberPhoneNumber:
                committeeMember.phoneNumber,
            FirebaseFieldName.committeeMemberTitle: committeeMember.title,
            FirebaseFieldName.committeeMemberTitleId: committeeMember.titleId,
            FirebaseFieldName.committeeMemberPhotoUrl: committeeMember.photoUrl,
            FirebaseFieldName.committeeMemberPhotoFileName:
                committeeMember.photoFileName,
            FirebaseFieldName.committeeMemberPostedBy: committeeMember.postedBy,
            FirebaseFieldName.committeeMemberSince:
                committeeMember.memberSince.millisecondsSinceEpoch,
            FirebaseFieldName.committeeMemberPostDate:
                DateTime.now().millisecondsSinceEpoch,
            FirebaseFieldName.committeeMemberUpdateDate:
                DateTime.now().millisecondsSinceEpoch,
            FirebaseFieldName.committeeMemberStreet: committeeMember.street,
            FirebaseFieldName.committeeMemberCity: committeeMember.city,
            FirebaseFieldName.committeeMemberState: committeeMember.state,
            FirebaseFieldName.committeeMemberZip: committeeMember.zip,
          },
          SetOptions(merge: true),
        );
        return;
      }
      // if committee does not exist then save new committee member
      final payload = CommitteeMemberPayload(
        // id: committeeMember.id,
        committeeMemberId: committeeMember.committeeMemberId,
        userId: committeeMember.userId,
        name: committeeMember.name,
        email: committeeMember.email,
        phoneNumber: committeeMember.phoneNumber,
        titleId: committeeMember.titleId,
        title: committeeMember.title,
        memberSince: committeeMember.memberSince,
        photoUrl: committeeMember.photoUrl,
        photoFileName: committeeMember.photoFileName,
        postedBy: committeeMember.postedBy,
        postDate: committeeMember.postDate,
        street: committeeMember.street,
        city: committeeMember.city,
        state: committeeMember.state,
        zip: committeeMember.zip,
      );
      await _firestore
          .collection(FirebaseCollectionName.committee)
          .doc(committeeMemberId)
          .set(
            payload,
            SetOptions(merge: true),
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCommitteeMember(CommitteeMember committeeMember) {
    final ref = _singleCommitteeMemberRef(committeeMember.committeeMemberId);
    return ref.set(committeeMember);
  }

  Future<void> deleteCommitteeMember(CommitteeMemberID id) async {
    final committeeMemberImageRef = FirebaseStorage.instance
        .ref()
        .child(FirebaseCollectionName.committee)
        .child(id);
    try {
      await committeeMemberImageRef.delete();
    } on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      // ignore: avoid_print
      print("Failed with error '${e.code}': ${e.message}");
    }

    // finally delete the news itself

    final committeeMemberInCollection = await _firestore
        .collection(FirebaseCollectionName.committee)
        .where(
          FirebaseFieldName.id,
          isEqualTo: id,
        )
        .limit(1)
        .get();
    if (committeeMemberInCollection.docs.isNotEmpty) {
      for (final committeeMember in committeeMemberInCollection.docs) {
        await committeeMember.reference.delete();
      }
    } else {
      // ignore: avoid_print
      print("NO COMMITTEE RECORD FOUND TO DELETE");
    }

    // return _firestore.doc(singleNewsPath(id)).delete();
  }

  DocumentReference<CommitteeMember> _singleCommitteeMemberRef(String id) =>
      _firestore.doc(singleCommitteeMemberPath(id)).withConverter(
            fromFirestore: (doc, _) => CommitteeMember.fromMap(doc.data()!),
            toFirestore: (CommitteeMember committeeMember, options) =>
                committeeMember.toMap(),
          );

  Query<CommitteeMember> _committeeMemberRef() => _firestore
      .collection(committeeMemberPath())
      .withConverter(
        fromFirestore: (doc, _) => CommitteeMember.fromMap(doc.data()!),
        toFirestore: (CommitteeMember committeeMember, options) =>
            committeeMember.toMap(),
      )
      .orderBy('title_id', descending: true);

  // * Temporary search implementation
  // * Note: this is quite inefficient as it pulls the
  // * entire news list and then filters the data on
  // * the client
  Future<List<CommitteeMember>> search(String query) async {
    // 1. Get all news from firebase
    final committeeMemberList = await fetchCommitteeMemberList();
    // 2. Perform client-side filtering
    return committeeMemberList
        .where((committeeMember) =>
            committeeMember.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
CommitteeMemberRepository committeeMemberRepository(
    CommitteeMemberRepositoryRef ref) {
  return CommitteeMemberRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<CommitteeMember>> committeeMemberListStream(
    CommitteeMemberListStreamRef ref) {
  final committeeMemberRepository =
      ref.watch(committeeMemberRepositoryProvider);
  return committeeMemberRepository.watchCommitteeMemberList();
}

@riverpod
Future<List<CommitteeMember>> committeeMemberListFuture(
    CommitteeMemberListFutureRef ref) {
  final committeeMemberRepository =
      ref.watch(committeeMemberRepositoryProvider);
  return committeeMemberRepository.fetchCommitteeMemberList();
}

@riverpod
Stream<CommitteeMember?> committeeMemberStream(
    CommitteeMemberStreamRef ref, CommitteeMemberID id) {
  final committeeMemberRepository =
      ref.watch(committeeMemberRepositoryProvider);
  return committeeMemberRepository.watchCommitteeMember(id);
}

@riverpod
Future<CommitteeMember?> committeeMemberFuture(
    CommitteeMemberFutureRef ref, CommitteeMemberID id) {
  final committeeMemberRepository =
      ref.watch(committeeMemberRepositoryProvider);
  return committeeMemberRepository.fetchCommitteeMember(id);
}
