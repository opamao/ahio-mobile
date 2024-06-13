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
  static const postUpdateStatusReservation = "${putUpdateReservation}update-state";

  static const getListTypeResidence = "${baseUrlApi}residence-types";
  static const getListResidence = "${baseUrlApi}residences";
  static const getListMyResidence = "$getListResidence/my-residences";
  static const postCreateResidence = "${baseUrlApi}residences";
  static const postUpdateResidence = "${baseUrlApi}residences/";
  static const deleteResidence = "${baseUrlApi}residences/";

  static const getStatistic = "${baseUrlApi}statistics";
  static const getNbrTotalReservation = "$getStatistic/residences/gains";

  static const getListEquipments = "${baseUrlApi}equipments";

  static const getListPays = "${baseUrlApi}countries";
  static const getListVille = "${baseUrlApi}countries/";

  static const getListFavourites = "${baseUrlApi}favourites";
  static const postAddFavourites = "${baseUrlApi}favourites";
  static const deleteFavourites = "${baseUrlApi}favourites/";
}