class Urls {
  static const String baseUrl = 'https://ricardina10-backend.vercel.app/api/v1';
  static const String login = '$baseUrl/auth/login';
  static const String getProfile = '$baseUrl/auth/profile';
  static const String getCategories = '$baseUrl/category';

  static const String signUp = '$baseUrl/users/register';
  static const String setupProfile = '$baseUrl/users/profile';
  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String logout = '$baseUrl/auth/logout';
  static const String forgotPass = '$baseUrl/auth/forgot-password';
  static const String pickUpLocation = '$baseUrl/user/pickup-locations';
  static String getCalendar(String date, String locationUuid) =>
      '$baseUrl/calendar?date=$date&pickup_location_uuid=$locationUuid';
}
