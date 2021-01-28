// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(value) => "${value} Days";

  static m1(value) => "Enter the code before ${value}";

  static m2(value) => "Enter the code sent to ${value}";

  static m3(value) => "Logged in with ${value}?";

  static m4(value) => "Are you sure want to change the language into ${value}?";

  static m5(value) => "Are you sure want to change to ${value}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "ERR_400" : MessageLookupByLibrary.simpleMessage("Bad Request"),
    "ERR_401" : MessageLookupByLibrary.simpleMessage("Unauthorized"),
    "ERR_403" : MessageLookupByLibrary.simpleMessage("Access Denied"),
    "ERR_404" : MessageLookupByLibrary.simpleMessage("Not Found"),
    "ERR_500" : MessageLookupByLibrary.simpleMessage("Internal Server Error"),
    "ERR_504" : MessageLookupByLibrary.simpleMessage("Timeout Server"),
    "ERR_CANCELLED" : MessageLookupByLibrary.simpleMessage("Request was cancelled"),
    "ERR_LOAD_FILE" : MessageLookupByLibrary.simpleMessage("Failed to load file"),
    "about" : MessageLookupByLibrary.simpleMessage("About"),
    "account" : MessageLookupByLibrary.simpleMessage("Account"),
    "address" : MessageLookupByLibrary.simpleMessage("Address"),
    "alquran" : MessageLookupByLibrary.simpleMessage("Al-Qur\'an"),
    "badCredentials" : MessageLookupByLibrary.simpleMessage("Incorrect Username or Password"),
    "badgeExerciseSubtitle" : MessageLookupByLibrary.simpleMessage("UI Widgets (Components)\nAPI calls\nAccessibility & i18n"),
    "badgeExerciseTitle" : MessageLookupByLibrary.simpleMessage("Next workout"),
    "buttonCancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "buttonSubmit" : MessageLookupByLibrary.simpleMessage("Submit"),
    "changePassword" : MessageLookupByLibrary.simpleMessage("Change Password"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "dark" : MessageLookupByLibrary.simpleMessage("Dark"),
    "darkMode" : MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "dateOfBirth" : MessageLookupByLibrary.simpleMessage("Date of Birth"),
    "days" : m0,
    "deactivateAccount" : MessageLookupByLibrary.simpleMessage("Deactivate Account"),
    "deactivateAccountWarning" : MessageLookupByLibrary.simpleMessage("Once you deactivated account, there is no going back. Please be certain."),
    "defaultMode" : MessageLookupByLibrary.simpleMessage("Default Mode"),
    "editProfile" : MessageLookupByLibrary.simpleMessage("Profile"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "errorAddress" : MessageLookupByLibrary.simpleMessage("Address is required!"),
    "errorConfirmPassword" : MessageLookupByLibrary.simpleMessage("New Password and Confirm Password not match"),
    "errorDateOfBirth" : MessageLookupByLibrary.simpleMessage("Date of Birth is required!"),
    "errorDioCancel" : MessageLookupByLibrary.simpleMessage("Request was cancelled"),
    "errorDioConnectTimeout" : MessageLookupByLibrary.simpleMessage("Connection timeout"),
    "errorDioDefault" : MessageLookupByLibrary.simpleMessage("Connection failed due to internet connection"),
    "errorDioReceiveTimeout" : MessageLookupByLibrary.simpleMessage("Receive timeout in connection"),
    "errorDioSendTimeout" : MessageLookupByLibrary.simpleMessage("Receive timeout in send request"),
    "errorEmail" : MessageLookupByLibrary.simpleMessage("Email is required!"),
    "errorFullname" : MessageLookupByLibrary.simpleMessage("Fullname is required!"),
    "errorNewPassword" : MessageLookupByLibrary.simpleMessage("Make sure it\'s at least 8 characters\nincluding a number, a lowercase, and uppercase letter"),
    "errorPassword" : MessageLookupByLibrary.simpleMessage("Password is required!"),
    "errorPhoneNumber" : MessageLookupByLibrary.simpleMessage("Phone Number is invalid!"),
    "errorPlaceOfBirth" : MessageLookupByLibrary.simpleMessage("Place of Birth is required!"),
    "errorUsername" : MessageLookupByLibrary.simpleMessage("Username is required!"),
    "exercise" : MessageLookupByLibrary.simpleMessage("Exercise"),
    "female" : MessageLookupByLibrary.simpleMessage("Female"),
    "forgotPassword" : MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "forgotPasswordVerification" : MessageLookupByLibrary.simpleMessage("Forgot Password Verification"),
    "fullname" : MessageLookupByLibrary.simpleMessage("Fullname"),
    "gender" : MessageLookupByLibrary.simpleMessage("Gender"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hello,"),
    "hintSearchQuran" : MessageLookupByLibrary.simpleMessage("Type surah & ayat number"),
    "hintUsernameEmail" : MessageLookupByLibrary.simpleMessage("Username / Email"),
    "internalServerError" : MessageLookupByLibrary.simpleMessage("Internal Server Error"),
    "labelBackToLogin" : MessageLookupByLibrary.simpleMessage("Back to Login"),
    "labelFooterLoginOther" : MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
    "labelFooterLoginSocial" : MessageLookupByLibrary.simpleMessage("or enter with"),
    "labelForgotPassword" : MessageLookupByLibrary.simpleMessage("Enter your new password"),
    "labelForgotPasswordRequest" : MessageLookupByLibrary.simpleMessage("Enter your email address and we’ll send the code to reset your password"),
    "labelForgotPasswordResend" : MessageLookupByLibrary.simpleMessage("Didn\'t receive the code?"),
    "labelForgotPasswordTimer" : m1,
    "labelForgotPasswordVerification" : m2,
    "labelLogin" : MessageLookupByLibrary.simpleMessage("Hello! Login with your username or email."),
    "labelLoginSocial" : m3,
    "labelTermsRegister" : MessageLookupByLibrary.simpleMessage("Agree to"),
    "labelUsernameEmail" : MessageLookupByLibrary.simpleMessage("Username or email"),
    "language" : MessageLookupByLibrary.simpleMessage("Language"),
    "light" : MessageLookupByLibrary.simpleMessage("Light"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "male" : MessageLookupByLibrary.simpleMessage("Male"),
    "newPassword" : MessageLookupByLibrary.simpleMessage("New Password"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "pdob" : MessageLookupByLibrary.simpleMessage("Place / Date of Birth"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "photoProfile" : MessageLookupByLibrary.simpleMessage("Photo Profile"),
    "placeOfBirth" : MessageLookupByLibrary.simpleMessage("Place of Birth"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "promptDeactivateAccountSubtitle" : MessageLookupByLibrary.simpleMessage("This action cannot be undone. This will permanently disable your account.\nI understand the consequences"),
    "promptDeactivateAccountTitle" : MessageLookupByLibrary.simpleMessage("Deactivate Account"),
    "promptLanguageSubtitle" : m4,
    "promptLanguageTitle" : MessageLookupByLibrary.simpleMessage("Change Language"),
    "promptSearchQuranDescription" : MessageLookupByLibrary.simpleMessage("Search the quran anything you like.\nSome tips: baqarah 25, ikhlas, 1:5, 3 10"),
    "promptSearchQuranTitle" : MessageLookupByLibrary.simpleMessage("Search Surah & Ayat"),
    "promptThemeSubtitle" : m5,
    "promptThemeTitle" : MessageLookupByLibrary.simpleMessage("Change Theme"),
    "promptTwoFactorAuthenticationDisableSubtitle" : MessageLookupByLibrary.simpleMessage("Are you sure want to disable 2-Step Verification?"),
    "promptTwoFactorAuthenticationEnableSubtitle" : MessageLookupByLibrary.simpleMessage("Are you sure want to enable 2-Step Verification?"),
    "promptTwoFactorAuthenticationTitle" : MessageLookupByLibrary.simpleMessage("2-Step Verification"),
    "qibla" : MessageLookupByLibrary.simpleMessage("Qibla"),
    "register" : MessageLookupByLibrary.simpleMessage("Register"),
    "resend" : MessageLookupByLibrary.simpleMessage("Resend"),
    "retry" : MessageLookupByLibrary.simpleMessage("Retry"),
    "security" : MessageLookupByLibrary.simpleMessage("Security"),
    "send" : MessageLookupByLibrary.simpleMessage("Send"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shalat" : MessageLookupByLibrary.simpleMessage("Shalat"),
    "template" : MessageLookupByLibrary.simpleMessage("Template"),
    "termsAndConditions" : MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
    "titleWidgetProfileSubtitle" : MessageLookupByLibrary.simpleMessage("Customize"),
    "titleWidgetProfileTitle" : MessageLookupByLibrary.simpleMessage("Your Profile"),
    "twoFactorAuthentication" : MessageLookupByLibrary.simpleMessage("2-Step Verification"),
    "twoFactorAuthenticationSubtitle" : MessageLookupByLibrary.simpleMessage("Send a verification code every time you login"),
    "update" : MessageLookupByLibrary.simpleMessage("Update"),
    "userAccountHasExpired" : MessageLookupByLibrary.simpleMessage("Account has been expired"),
    "userAccountIsLocked" : MessageLookupByLibrary.simpleMessage("Account has been locked"),
    "userCredentialsHaveExpired" : MessageLookupByLibrary.simpleMessage("Account credentials has been expired"),
    "userIsDisabled" : MessageLookupByLibrary.simpleMessage("Account has been deactivated"),
    "username" : MessageLookupByLibrary.simpleMessage("Username"),
    "verify" : MessageLookupByLibrary.simpleMessage("Verify")
  };
}
