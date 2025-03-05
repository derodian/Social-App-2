import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_app_2/src/constants/firebase_collection_name.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
import 'package:social_app_2/src/features/comments/domain/comment.dart';
import 'package:social_app_2/src/features/comments/typedefs/comment_id.dart';

part 'comments_repository.g.dart';

// Define content types as constants
class ContentType {
  static const String news = 'news';
  static const String photos = 'photos';
  static const String insta = 'insta';
  static const String event = 'event';
  // Add more content types as needed
}

@riverpod
class CommentsRepository extends _$CommentsRepository {
  late final FirebaseFirestore _firestore;
  
  @override
  Future<void> build() async {
    _firestore = FirebaseFirestore.instance;
  }
  
  // Get comments collection reference
  CollectionReference<Map<String, dynamic>> _commentsCollection() {
    return _firestore.collection(FirebaseCollectionName.comments);
  }
  
  // Add a comment
  Future<CommentID> addComment({
    required String contentId,
    required String contentType,
    required UserID userId,
    required String text,
    required String userName,
    String? userProfileImage,
    CommentID? parentId,
  }) async {
    final commentRef = _commentsCollection().doc();
    final comment = Comment.create(
      id: commentRef.id,
      contentId: contentId,
      contentType: contentType,
      userId: userId,
      text: text,
      userName: userName,
      userProfileImage: userProfileImage,
      parentId: parentId,
    );
    
    await commentRef.set(comment.toFirestore());
    
    // Also update the comment count on the content item
    await _updateCommentCount(contentId, contentType, 1);
    
    return commentRef.id;
  }
  
  // Get comments for content
  Stream<List<Comment>> getCommentsForContent(
    String contentId, 
    String contentType,
    {
      int limit = 20,
      CommentID? startAfter,
    }
  ) {
    Query<Map<String, dynamic>> query = _commentsCollection()
        .where('content_id', isEqualTo: contentId)
        .where('content_type', isEqualTo: contentType)
        .where('parent_id', isNull: true) // Only top-level comments
        .where('is_deleted', isEqualTo: false)
        .orderBy('created_at', descending: true)
        .limit(limit);
        
    if (startAfter != null) {
      query = query.startAfterDocument(
        await _commentsCollection().doc(startAfter).get()
      );
    }
    
    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Comment.fromFirestore(doc.data(), doc.id))
        .toList());
  }
  
  // Get replies for a comment
  Stream<List<Comment>> getRepliesForComment(CommentID parentId) {
    return _commentsCollection()
        .where('parent_id', isEqualTo: parentId)
        .where('is_deleted', isEqualTo: false)
        .orderBy('created_at')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Comment.fromFirestore(doc.data(), doc.id))
            .toList());
  }
  
  // Update a comment
  Future<void> updateComment(Comment comment) async {
    final updatedComment = comment.copyWith(
      updatedAt: DateTime.now(),
      isEdited: true,
    );
    
    await _commentsCollection()
        .doc(comment.id)
        .update(updatedComment.toFirestore());
  }
  
  // Delete a comment (soft delete)
  Future<void> deleteComment(CommentID commentId) async {
    final commentDoc = await _commentsCollection().doc(commentId).get();
    if (!commentDoc.exists) return;
    
    final comment = Comment.fromFirestore(commentDoc.data()!, commentDoc.id);
    
    // Soft delete
    await _commentsCollection().doc(commentId).update({'is_deleted': true});
    
    // Update comment count
    await _updateCommentCount(comment.contentId, comment.contentType, -1);
  }
  
  // Like a comment
  Future<void> likeComment(CommentID commentId) async {
    await _commentsCollection()
        .doc(commentId)
        .update({'likes': FieldValue.increment(1)});
  }
  
  // React to a comment
  Future<void> reactToComment(
    CommentID commentId,
    String reaction,
  ) async {
    await _commentsCollection()
        .doc(commentId)
        .update({
          'reactions.$reaction': FieldValue.increment(1)
        });
  }
  
  // Remove a reaction
  Future<void> removeReaction(
    CommentID commentId,
    String reaction,
  ) async {
    await _commentsCollection()
        .doc(commentId)
        .update({
          'reactions.$reaction': FieldValue.increment(-1)
        });
  }
  
  // Get comment count for content
  Stream<int> getCommentCount(String contentId, String contentType) {
    return _commentsCollection()
        .where('content_id', isEqualTo: contentId)
        .where('content_type', isEqualTo: contentType)
        .where('is_deleted', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
  
  // Helper to update comment count on content items
  Future<void> _updateCommentCount(
    String contentId, 
    String contentType, 
    int increment
  ) async {
    // Each content type might have a different collection
    late final DocumentReference contentRef;
    
    switch (contentType) {
      case ContentType.news:
        contentRef = _firestore.collection(FirebaseCollectionName.news).doc(contentId);
        break;
      case ContentType.photos:
        contentRef = _firestore.collection(FirebaseCollectionName.photos).doc(contentId);
        break;
      case ContentType.insta:
        contentRef = _firestore.collection(FirebaseCollectionName.insta).doc(contentId);
        break;
      case ContentType.event:
        contentRef = _firestore.collection(FirebaseCollectionName.events).doc(contentId);
        break;
      default:
        return; // Unknown content type
    }
    
    await contentRef.update({
      'comment_count': FieldValue.increment(increment)
    });
  }
}