class ApiUrls {
  ApiUrls._();

  static const baseUrlApi = "https://ahio.roomcodetraining.com/api/v1/";

  static const account = "${baseUrlApi}account/";
  static const postCreateAccount = "${account}create";
  static const postVerifyAccount = "${account}verify";
  static const postUpdateAccount = "${account}update";
  static const postUpdatePasswordAccount = "${account}update-password";

  static const auth = "${baseUrlApi}auth/";
  static const postLoginAuth = "${auth}login";
  static const postVerifyOtpAuth = "${auth}verify-otp";
  static const getInfoAuth = "${auth}me";
  static const postLogoutAuth = "${auth}logout";

  static const otp = "${baseUrlApi}otp/";
  static const postVerifyOtp = "${otp}verify";
  static const postGeneOtp = "${otp}resend";

  static const getListReservation = "${baseUrlApi}reservations";
  static const postCreateReservation = "${baseUrlApi}reservations";
  static const putUpdateReservation = "${baseUrlApi}reservations/";
  static const deleteReservation = "${baseUrlApi}reservations/";

  static const getListTypeResidence = "${baseUrlApi}residence-types";
  static const getListResidence = "${baseUrlApi}residences";
  static const getListMyResidence = "$getListResidence/my-residences";
  static const postCreateResidence = "${baseUrlApi}residences";
  static const postUpdateResidence = "${baseUrlApi}residences/";
  static const deleteResidence = "${baseUrlApi}residences/";

  static const statistic = "${baseUrlApi}statistics/";
  static const getNbrTotalReservation = "${statistic}reservations";
  static const getNbrTotalReservationCompleted = "${statistic}reservations/completed";
  static const getNbrTotalReservationCancelled = "${statistic}reservations/cancelled";
  static const getNbrTotalResidence = "${statistic}residences";
  static const getNbrTotalResidenceCompleted = "${statistic}residences/active";
  static const getNbrTotalResidenceCancelled = "${statistic}residences/inactive";

  static const getListEquipments = "${baseUrlApi}equipments";
}