enum LottieAnimation {
  dataNotFound(name: 'data_not_found'),
  empty(name: 'empty'),
  loading(name: 'loading'),
  error(name: 'error'),
  smallError(name: 'small_error'),
  waitingApproval(name: 'waiting_approval'),
  emailVerification(name: 'email_verification'),
  pageNotFound(name: 'page_not_found');

  final String name;
  const LottieAnimation({required this.name});
}
