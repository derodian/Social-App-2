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
  static const String isVerifiedSignIn = 'Already Verified? try';

  // Home page
  static const String homePage = 'Home Page';

  // News page
  static const String news = 'News';
  static const String noNewsAvailable = 'Stay tuned for more news.';
  static const String newsDetail = 'News Detail';
  static const String addNews = 'Add News';
  static const String editNews = 'Edit News';
  static const String deleteNews = 'Delete News';

  // Events page
  static const String events = 'Events';
  static const String noUpcomingEvents = 'Stay tuned for upcoming events!';
  static const String eventDetail = 'Event Detail';
  static const String pastEvents = 'Past Events';
  static const String addEvent = 'Add Events';
  static const String editEvent = 'Edit Events';
  static const String deleteEvent = 'Delete Events';

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
  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';

  // auth strings

  static const getStarted = 'Get Started';
  static const appLogo = 'SRBS of Houston logo';

  static const noCoverImage =
      'No image to display. Tap here to update your cover image';
  static const noProfileImage =
      'No image to display. Tap here to update your profile image';

  // Email And Password View Strings
  static const emailPassword = 'Email and Password';
  static const password8Characters = "Password (8+ characters)";
  static const password = "Password";
  static const email = "Email";
  static const fullName = "Full name";
  static const phoneNumber = "Phone";
  static const primaryAccountEmail = "Primary Account Email";
  static const street = "Street";
  static const city = "City";
  static const state = "State";
  static const zip = "Zip";
  static const country = "Country";
  static const testEmail = "test@email.com";
  static const createAnAccount = "Create an account";
  static const register = "Register";
  static const haveAnAccountSignIn = "Have an account? Sign in";
  static const needAnAccountRegister = "Need an account? Register";
  static const registrationFailed = "Registration failed";
  static const passwordResetFailed = "Password reset failed";
  static const error = "Error";

  static const logoutButton = "Log out";
  static const note = "Note";
  static const yes = "Yes";
  static const sharing = "Sharing";
  static const login = "Login";
  static const submit = "Submit";
  static const verifyEmail = "Verify email";
  static const verified = "Verified";
  static const restart = "Restart";
  static const nameCantBeEmpty = "Name can't be empty";
  static const invalidName = "Invalid name";
  static const phoneNumberCantBeEmpty = "Phone number can't be empty'";
  static const invalidNamePhoneNumber = "Invalid phone number";
  static const emailCantBeEmpty = "Email can't be empty";
  static const invalidEmail = "Invalid email";
  static const passwordCantBeEmpty = "Password can't be empty";
  static const passwordIsTooShort = "Password is too short";
  static const weakPassword = "Password is too weak";
  static const wrongPassword = "Wrong password";

  static const sendResetLink = 'Send Reset Link';
  static const sendVerificationLink = 'Send Verification Link';
  static const emailSent = 'Sent - check your email and verify your account';
  static const backToSignIn = 'Back to sign in';
  static const resetLinkSentTitle = 'Reset link sent';
  static const resetLinkSentMessage = 'Check your email to reset your password';

  static const userNotFound = 'User not found';
  static const userNotLoggedIn = 'User not logged in';
  static const emailAlreadyInUse = 'Email already in use';
  static const invalidEmailErrorText = 'Email is invalid';
  static const invalidFullNameEmpty = 'Full name can\'t be empty';
  static const invalidPasswordTooShort = 'Password is too short';

  static const passwordReset = "Password reset";
  static const passwordResetDialogPrompt =
      "We have now sent you a password reset link. Please check your email for more information.";

  static const loginErrorCannotFindUser =
      "Cannot find a user with the entered credentials!";
  static const loginErrorWrongCredentials = "Wrong credentials";
  static const loginErrorAuthError = "Authentication error";

  static const loginViewPrompt = "Please log in to your account!";

  static const loginViewForgotPassword = "I forgot my password";
  static const loginViewNotRegisteredYet = "Not registered yet? Register here!";

  static const emailTextFieldPlaceholder = "Enter your email here";
  static const passwordTextFieldPlaceholder = "Enter your password here";

  static const forgotPassword = "Forgot Password";
  static const forgotPasswordViewGenericError =
      "We could not process your request. Please make sure that you are a registered user, or if not, register a user now by going back one step.";
  static const forgotPasswordViewPrompt =
      "If you forgot your password, simply enter your email and we will send you a password reset link.";
  static const forgotPasswordViewSendMeLink = "Send me password reset link";
  static const forgotPasswordViewBackToLogin = "Back to login page";

  static const registerErrorWeakPassword =
      "This password is not secure enough. Please choose another password!";
  static const registerErrorEmailAlreadyInUse =
      "This email is already registered to another user. Please choose another email!";
  static const registerErrorGeneric =
      "Failed to register. Please try again later!";
  static const registerErrorInvalidEmail =
      "The email address you entered appears to be invalid. Please try another email address!";
  static const registerViewPrompt =
      "Enter your email and password to see your notes!";
  static const registerViewAlreadyRegistered =
      "Already registered? Login here!";

  static const verifyEmailViewPrompt =
      "We've sent you an email verification. Please open it to verify your account. If you haven't received a verification email yet, press the button below!";
  static const verifyEmailSendEmailVerification = "Send email verification";
  static const ifVerifiedSignOutSignIn =
      "If you have already verified your email, please sign out and sign in again";

  static const logIntoYourAccount =
      'Log into your account using one of the options below.';

  static const newsDetails = 'News Details';
  static const eventsDetails = 'Events Details';
  static const pastEventsDetails = 'Past Events Details';

  static const signUpOn = 'Sign up on ';
  static const orCreateAnAccountOn = ' or create an account on ';

  // ui strings

  static const areYouSureToDeleteAccountAndData =
      'Account and any data associated with it?';

  // log out
  static const logOut = 'Log out';
  static const areYouSureThatYouWantToLogOutOfTheApp =
      'Are you sure that you want to log out of the app?';

  // Alert dialog
  static const notImplemented = 'Not implemented';

  // Dummy Images
  static const assetProfileImage =
      'assets/images/profile_image_placeholder.png';
  static const dummyProfileImageURL =
      "https://firebasestorage.googleapis.com/v0/b/srbs-of-houston.appspot.com/o/profile_image_placeholder.png?alt=media&token=2acdb9fb-0033-40a5-94fa-c7a7be8dbe9c";
  static const dummyProfileBannerImageURL =
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

  const Strings._();
}
