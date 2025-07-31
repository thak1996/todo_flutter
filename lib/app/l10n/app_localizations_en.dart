// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get titleApp => 'Todo App';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get login => 'login';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get requiredField => 'Required Field';

  @override
  String get invalidEmail => 'Invalid E-mail';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters long';

  @override
  String get switchToDarkMode => 'Dark Mode';

  @override
  String get switchToLightMode => 'Light Mode';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get name => 'Nome';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get passwordsDoNotMatch => 'Passowrds do Not Match';

  @override
  String get confirmPassword => ' Confirm Password';

  @override
  String get register => 'Register';

  @override
  String get nameMinLength => 'Name required 3 characters';

  @override
  String get errorNotFound => 'Resource not found';

  @override
  String get errorUnauthorized => 'Unauthorized access';

  @override
  String get errorNetwork => 'Network error';

  @override
  String get errorValidation => 'Invalid data';

  @override
  String get errorUnknown => 'Unknown error';

  @override
  String get errorUserNotFound => 'User Not Found';

  @override
  String get addTask => 'Add Task';

  @override
  String get title => 'Title';

  @override
  String get titleRequired => 'Title Required';

  @override
  String get description => 'Description';

  @override
  String get group => 'Group';

  @override
  String get priorityLow => 'Priority Low';

  @override
  String get priorityMedium => 'Priority Medium';

  @override
  String get priorityHigh => 'Priority Hight';

  @override
  String get priority => 'Prority';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get todo => 'Todo';

  @override
  String get noTasksFound => 'No tasks found.';

  @override
  String get newTask => 'New Task';

  @override
  String get user => 'User';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String get confirmDeleteTask => 'Are you sure you want to delete this task?';

  @override
  String get delete => 'Delete';

  @override
  String get editTask => 'Edit Task';

  @override
  String get taskDeleted => 'Task deleted!';

  @override
  String get taskEdited => 'Task edited!';

  @override
  String get errorGoogleUserNotFound => 'User google not found!';

  @override
  String get loginWithGoogle => 'Login With Google';

  @override
  String get groups => 'Groups';

  @override
  String get createGroup => 'Create Group';

  @override
  String get newGroup => 'New Group';

  @override
  String get groupName => 'Group name';

  @override
  String get create => 'Create';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get todoOptions => 'Todo Options';

  @override
  String get chooseAction => 'Choose an action';

  @override
  String get edit => 'Edit';

  @override
  String get noGroupsFound => 'No groups found.';

  @override
  String get authUserNotFound => 'User not found';

  @override
  String get authWrongPassword => 'Incorrect password';

  @override
  String get authEmailAlreadyInUse => 'This email is already in use';

  @override
  String get authWeakPassword => 'The password is too weak';

  @override
  String get authInvalidEmail => 'Invalid email';

  @override
  String get authTooManyRequests => 'Too many attempts. Try again later';

  @override
  String get authUserDisabled => 'This account has been disabled';

  @override
  String get authOperationNotAllowed => 'Operation not allowed';

  @override
  String get authInvalidCredential => 'Invalid credentials';

  @override
  String get authNetworkRequestFailed =>
      'Connection error. Check your internet';

  @override
  String get authRequiresRecentLogin => 'This operation requires recent login';

  @override
  String authUnknown(Object message) {
    return 'Authentication error: $message';
  }
}
