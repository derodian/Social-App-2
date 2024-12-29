class FirebaseErrorHandler {
  static String getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'The credentials provided are invalid or expired.';
      case 'email-already-in-use':
        return 'This email address is already in use.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  static String getFirestoreErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'permission-denied':
        return 'You do not have permission to access this resource.';
      case 'unavailable':
        return 'The service is temporarily unavailable. Please try again later.';
      default:
        return 'An unexpected error occurred with Firestore.';
    }
  }

  static String getStorageErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'storage/object-not-found':
        return 'The requested file was not found.';
      case 'storage/unauthorized':
        return 'You are not authorized to perform this action.';
      default:
        return 'An unexpected error occurred with Storage.';
    }
  }
}
