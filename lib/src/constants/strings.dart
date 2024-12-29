import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  // App Name
  static const String appName = 'Social App';
  static const String welcomeToAppName = 'Welcome to ${Strings.appName}';
  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String or = 'or';
  static const String loading = 'loading...';
  static const String save = 'Save';
  static const String delete = 'delete';
  static const String areYouSureYouWantToDeleteThis =
      'Are you sure you want to delete this';

  // Onboarding
  static const String onboardingMessage =
      'See what\'s happening in the world around you.';

  // Account page
  static const String account = 'Account';
  static const String accountPage = 'Account Page';
  static const String deleteAccount = 'Delete Account';
  static const String reauthenticateAccount =
      "Please Re-enter your credentials";

  // Google
  static const String google = 'Google';
  static const String googleSignupUrl = 'http://accounts.google.com/signup';
  static const String signInWithGoogle = 'Sign in with Google';
  static const googleLogo = 'assets/images/g_logo.png';

  // Facebook
  static const String facebook = 'Facebook';
  static const String facebookSignupUrl = 'http://www.facebook.com/signup';
  static const String signInWithFacebook = 'Sign in with Facebook';

  // Apple
  static const String apple = 'Apple';
  static const String appleSignupUrl = '';
  static const String signInWithApple = 'Sign in with Apple';

  // Logout
  static const String logout = 'Logout';
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';
  static const String logoutFailed = 'Logout failed';

  // Sign In Page
  static const String signIn = 'Sign in';
  static const String signInWithEmailPassword = 'Sign in with email & password';
  static const String goAnonymous = 'Go anonymous';
  static const String signInFailed = 'Sign in failed';
  static const String dontHaveAnAccount = "Don't have an account?\n";
  static const String signUp = 'Sign up';

  // Email Not Verified Screen
  static const String pleaseVerifyEmail = 'Please verify your email';
  static const String emailNotVerified =
      'Your email has not yet been verified, please check your inbox or spam and verify your account. You can click on button bellow to re-send verification link.';
  static const String sendEmailVerification = 'Send verification email';
  static const String isVerifiedSignIn = 'Already Verified?';

  // Home page
  static const String homePage = 'Home Page';

  // News page
  static const String news = 'News';
  static const String noNewsAvailable = 'Stay tuned for more news.';
  static const String newsDetail = 'News Detail';
  static const String addNews = 'Add News';
  static const String editNews = 'Edit News';
  static const String deleteNews = 'Delete News';
  static const String newsDetails = 'News Details';
  static const String newsNotFound = 'News not found';
  static const String newsDeleted = 'News Deleted';
  static const String newsAdded = 'News Added';
  static const String newsUpdated = 'News Updated';

  // Events page
  static const String events = 'Events';
  static const String noUpcomingEvents = 'Stay tuned for upcoming events!';
  static const String eventDetail = 'Event Detail';
  static const String pastEvents = 'Past Events';
  static const String addEvent = 'Add Events';
  static const String editEvent = 'Edit Events';
  static const String deleteEvent = 'Delete Events';
  static const String editEvents = 'Edit Events';
  static const String eventsDetails = 'Events Details';
  static const String eventNotFound = 'Events not found';
  static const String eventDeleted = 'Event Deleted';
  static const String pastEventsDetails = 'Past Events Details';
  static const String eventAdded = 'Event Added';
  static const String eventUpdated = 'Event Updated';
  static const String noEventAvailable = 'Stay tuned for upcoming events';
  static const String noPastEventAvailable = 'No past events';

  // Photos page
  static const String photos = 'Photos';

  // Post
  static const String youHaveNoPosts =
      'You have not made a post yet. Press either the video-upload or the photo-upload buttons to the top of the screen in order to upload your first post';
  static const String noPostsAvailable =
      "Nobody seems to have made any posts yet. Why don't you take the first step and upload your first post";
  static const String checkOutThisPost = 'Check out this post';
  static const String postDetails = 'Post Details';
  static const String post = 'post';
  static const String createNewPost = 'Create New Post';
  static const String pleaseWriteYourMessageHere =
      'Please write your message here';

  // Comments
  static const String comments = 'Comments';
  static const String comment = 'comment';
  static const String writeYourCommentHere = 'Write your comment here...';
  static const String noCommentsYet =
      'Nobody has commented on this post yet. You can change that though, and be the first person who comments!';

  // Search
  static const String enterYourSearchTerm =
      'Enter your search term in order to get started. You can search in the description of all posts available in the system';
  static const String enterYourSearchTermHere = 'Enter your search term here';

  // Culture page
  static const String culture = 'Culture';

  // Insta_Post
  static const String instaPost = 'Insta Post';
  static const String allowLikesTitle = 'Allow likes';
  static const String allowLikesDescription =
      'By allowing likes, users will be able to press the like button on your post.';
  static const String allowLikesStorageKey = 'allow_likes';
  static const String allowCommentsTitle = 'Allow comments';
  static const String allowCommentsDescription =
      'By allowing comments, users will be able to comment on your post';
  static const String allowCommentsStorageKey = 'allow_comments';
  static const String person = 'person';
  static const String people = 'people';
  static const String likedThis = 'liked this';

  // auth strings

  static const String getStarted = 'Get Started';
  static const String appLogo = 'SRBS of Houston logo';

  static const String noCoverImage =
      'No image to display. Tap here to update your cover image';
  static const String noProfileImage =
      'No image to display. Tap here to update your profile image';

  // Email And Password View Strings
  static const String emailPassword = 'Email and Password';
  static const String password8Characters = "Password (8+ characters)";
  static const String password = "Password";
  static const String email = "Email";
  static const String fullName = "Full name";
  static const String phoneNumber = "Phone";
  static const String primaryAccountEmail = "Primary Account Email";
  static const String address = "Address";
  static const String location = "Location";
  static const String street = "Street";
  static const String city = "City";
  static const String state = "State";
  static const String zip = "Zip";
  static const String country = "Country";
  static const String testEmail = "test@email.com";
  static const String createAnAccount = "Create an account";
  static const String register = "Register";
  static const String haveAnAccountSignIn = "Have an account? Sign in";
  static const String needAnAccountRegister = "Need an account? Register";
  static const String registrationFailed = "Registration failed";
  static const String passwordResetFailed = "Password reset failed";
  static const String error = "Error";

  static const String logoutButton = "Log out";
  static const String note = "Note";
  static const String yes = "Yes";
  static const String sharing = "Sharing";
  static const String login = "Login";
  static const String submit = "Submit";
  static const String verifyEmail = "Verify email";
  static const String verified = "Verified";
  static const String restart = "Restart";
  static const String nameCantBeEmpty = "Name can't be empty";
  static const String invalidName = "Invalid name";
  static const String phoneNumberCantBeEmpty = "Phone number can't be empty'";
  static const String invalidNamePhoneNumber = "Invalid phone number";
  static const String emailCantBeEmpty = "Email can't be empty";
  static const String invalidEmail = "Invalid email";
  static const String passwordCantBeEmpty = "Password can't be empty";
  static const String passwordIsTooShort = "Password is too short";
  static const String weakPassword = "Password is too weak";
  static const String wrongPassword = "Wrong password";

  static const String sendResetLink = 'Send Reset Link';
  static const String sendVerificationLink = 'Send Verification Link';
  static const String emailSent =
      'Sent - check your email and verify your account';
  static const String backToSignIn = 'Back to sign in';
  static const String resetLinkSentTitle = 'Reset link sent';
  static const String resetLinkSentMessage =
      'Check your email to reset your password';

  static const String userNotFound = 'User not found';
  static const String userNotLoggedIn = 'User not logged in';
  static const String emailAlreadyInUse = 'Email already in use';
  static const String invalidEmailErrorText = 'Email is invalid';
  static const String invalidFullNameEmpty = 'Full name can\'t be empty';
  static const String invalidPasswordTooShort = 'Password is too short';

  static const String passwordReset = "Password reset";
  static const String passwordResetDialogPrompt =
      "We have now sent you a password reset link. Please check your email for more information.";

  static const String loginErrorCannotFindUser =
      "Cannot find a user with the entered credentials!";
  static const String loginErrorWrongCredentials = "Wrong credentials";
  static const String loginErrorAuthError = "Authentication error";

  static const String loginViewPrompt = "Please log in to your account!";

  static const String loginViewForgotPassword = "I forgot my password";
  static const String loginViewNotRegisteredYet =
      "Not registered yet? Register here!";

  static const String emailTextFieldPlaceholder = "Enter your email here";
  static const String passwordTextFieldPlaceholder = "Enter your password here";

  static const String forgotPassword = "Forgot Password";
  static const String forgotPasswordViewGenericError =
      "We could not process your request. Please make sure that you are a registered user, or if not, register a user now by going back one step.";
  static const String forgotPasswordViewPrompt =
      "If you forgot your password, simply enter your email and we will send you a password reset link.";
  static const String forgotPasswordViewSendMeLink =
      "Send me password reset link";
  static const String forgotPasswordViewBackToLogin = "Back to login page";

  static const String registerErrorWeakPassword =
      "This password is not secure enough. Please choose another password!";
  static const String registerErrorEmailAlreadyInUse =
      "This email is already registered to another user. Please choose another email!";
  static const String registerErrorGeneric =
      "Failed to register. Please try again later!";
  static const String registerErrorInvalidEmail =
      "The email address you entered appears to be invalid. Please try another email address!";
  static const String registerViewPrompt =
      "Enter your email and password to see your notes!";
  static const String registerViewAlreadyRegistered =
      "Already registered? Login here!";

  static const String verifyEmailViewPrompt =
      "We've sent you an email verification. Please open it to verify your account. If you haven't received a verification email yet, press the button below!";
  static const String verifyEmailSendEmailVerification =
      "Send email verification";
  static const String ifVerifiedSignOutSignIn =
      "If you have already verified your email, please sign out and sign in again";

  static const String logIntoYourAccount =
      'Log into your account using one of the options below.';

  static const String signUpOn = 'Sign up on ';
  static const String orCreateAnAccountOn = ' or create an account on ';

  // ui strings

  static const String areYouSureToDeleteAccountAndData =
      'Account and any data associated with it?';

  // log out
  static const String logOut = 'Log out';
  static const String areYouSureThatYouWantToLogOutOfTheApp =
      'Are you sure that you want to log out of the app?';

  // Alert dialog
  static const String notImplemented = 'Not implemented';

  // Dummy Images
  static const String assetImage = 'assets/images/app_logo.png';
  static const String assetImageLarge = 'assets/images/app_logo.png';
  static const String assetProfileImage =
      'assets/images/profile_image_placeholder.png';
  static const String dummyProfileImageURL =
      "https://firebasestorage.googleapis.com/v0/b/srbs-of-houston.appspot.com/o/profile_image_placeholder.png?alt=media&token=2acdb9fb-0033-40a5-94fa-c7a7be8dbe9c";
  static const String dummyProfileBannerImageURL =
      "https://images.unsplash.com/photo-1546587348-d12660c30c50?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2074&q=80";

  // Sign In Page

  static const String signInWithEmailLink = 'Sign in with email link';

  // Email & Password page
  static const String forgotPasswordQuestion = 'Forgot password?';
  static const String needAnAccount = 'Need an account? Register';
  static const String haveAnAccount = 'Have an account? Sign in';
  static const String nameLabel = 'Name';
  static const String nameHint = 'Firstname Lastname';
  static const String emailLabel = 'Email';
  static const String emailHint = 'test@test.com';
  static const String password8CharactersLabel = 'Password (8+ characters)';
  static const String passwordLabel = 'Password';
  static const String invalidNameErrorText = 'Name is invalid';
  static const String invalidNameEmpty = 'Name can\'t be empty';
  static const String invalidEmailEmpty = 'Email can\'t be empty';
  static const String invalidPasswordEmpty = 'Password can\'t be empty';

  // Email link page
  static const String submitEmailAddressLink =
      'Submit your email address to receive an activation link.';
  static const String checkYourEmail = 'Check your email';
  static String activationLinkSent(String email) =>
      'We have sent an activation link to $email';
  static const String errorSendingEmail = 'Error sending email';
  static const String sendActivationLink = 'Send activation link';
  static const String activationLinkError = 'Email activation error';
  static const String submitEmailAgain =
      'Please submit your email address again to receive a new activation link.';
  static const String userAlreadySignedIn =
      'Received an activation link but you are already signed in.';
  static const String isNotSignInWithEmailLinkMessage =
      'Invalid activation link';

  // AutoGenerated documentId
  static String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  // Delete dialog
  static const String deleteAreYouSure =
      'Are you sure that you want to delete?';
  static const String deleteFailed = 'Delete failed';

  // Members
  static const String members = 'Members';

  // Committee
  static const String committee = 'Committee';
  static const String committeeUpdated = 'Committee Info Updated';
  static const String committeeAdded = 'Committee Member Added';

  // App Users
  static const String appUsers = 'Users';

  // Directory
  static const String directory = 'Directory';

  // User
  static const String phoneLabel = "Phone Number";
  static const String phoneHint = "XXXXXXXXXX";
  static const String streetLabel = "Street";
  static const String streetHint = "1 Infinite Loop";
  static const String cityLabel = "City";
  static const String cityHint = "Houston";
  static const String stateLabel = "State";
  static const String stateHint = "TX";
  static const String zipcodeLabel = "Zipcode";
  static const String zipcodeHint = "00000";
  static const String countryLabel = "Country";
  static const String countryHint = "US";

  // Auth Constants
  static const String accountExistsWithDifferentCredentialError =
      'account-exists-with-different-credential';
  static const String googleCom = 'google.com';
  static const String emailScope = 'email';

  // User Settings Constants
  static const String isAdminTitle = 'Is Admin';
  static const String isAdminDescription =
      'Give user admin level authorization in the application.';
  static const String isAdminStorageKey = 'is_admin';
  static const String allowChatTitle = 'Allow chat';
  static const String allowChatDescription =
      'By allowing chat, user will be able to do chat within the app.';
  static const String allowChatStorageKey = 'allow_chat';
  static const String shareInfoTitle = 'Share Information';
  static const String shareInfoDescription =
      'Users of the app will be able to see your information.';
  static const String shareInfoStorageKey = 'share_info';
  static const String primaryAccountTitle = 'Primary Account';
  static const String primaryAccountDescription =
      'Is your email registered as primary account?';
  static const String primaryAccountStorageKey = 'primary_account';

  // for photos and videos
  static const imageThumbnailWidth = 150;
  static const videoThumbnailMaxWidth = 250;
  static const videoThumbnailMaxHeight = 400;
  static const videoThumbnailQuality = 75;

  static const assetImagePlaceholder = 'assets/images/placeholder_image.png';
  static const String firebaseProjectURL =
      'https://srbs-of-houston.firebaseapp.com/';
  static const String defaultProfilePictureURL =
      'https://firebasestorage.googleapis.com/v0/b/srbs-of-houston.appspot.com/o/profile_image_placeholder.png?alt=media&token=7a42a871-227e-4122-aef1-3ceaa4aae340';
  static const String defaultProfilePictureName = "profile_image_placeholder";
  static const String newsFolder = 'news';
  static const String committeeFolder = 'committee';
  static const String eventsFolder = 'events';
  static const String membersFolder = 'members';

  // Photos page
  static const String noImage =
      'No image to display, Tap here to upload image.';

  // Committee Member
  static const String noCommitteeMembersAvailable =
      "Committee members list coming soon.";
  static const String addCommitteeMember = "Add Committee Member";
  static const String editCommitteeMember = "Edit Committee Member";
  static const String uploadImage = 'Tap here to upload image';

  static const String noDataAvailable =
      'No data available. Please try again later';

  const Strings._();
}
