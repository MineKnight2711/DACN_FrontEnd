class ApiUrl {
  //ip khi ở trường - 10.10.116.60
  //ip LAN nhà - 192.168.1.44
  //ip Coffee House NTT 172.16.3.8//172.16.2.242/172.16.2.89
  //ip mạng ảo của giả lập - 10.0.2.2
  //ip wifi nhà - 192.168.0.106
  //ip mobile hostspot - 192.168.29.192/192.168.191.192s
  //ip debug lan - 192.168.93.160/192.168.93.111
  //ip radmin vpn - 26.196.143.193

  // static const baseUrl =
  //     'https://testjava-fooddelivery-07101b5575c7.herokuapp.com/api/';

  static const baseUrl = "http://26.196.143.193:6969/api/";
  // static const apiGetAllAccount = '${baseUrl}account/all';
  static const apiGoongMapBaseUrl = "https://rsapi.goong.io/";
  ///// Api của Đạt-------------------------------------------------
  static const apiCreateAccount = '${baseUrl}account';
  static const apiAccountVoucher = '${baseUrl}voucher-account';
  // static const apiCreateAccount = '${baseUrl}account';
  static const apiUpdateAccount = '${baseUrl}account/update-account';
  static const apiGetAccountWithEmail = '${baseUrl}account/get-by-email';
  static const apiSignUpWithFireBase = '${baseUrl}account/create-user';
  static const apiSignInWithFireBase = '${baseUrl}account/sign-in';
  static const apiSignOut = '${baseUrl}account/sign-out';
  static const apiVerifiedEmail = '${baseUrl}account/get-user-info';
  static const apiChangeEmail = '${baseUrl}account/change-email';
  static const apiGetAllCategory = '${baseUrl}category';
  static const apiDish = '${baseUrl}dish/with-favorite';
  static const apiGetDishesByCategoryID = '${baseUrl}dish/get-by-categoryId';
  static const apiSearchDish = '${baseUrl}dish/search-dish-by-name';
  static const apiPayment = '${baseUrl}payment';
  static const apiTransaction = '${baseUrl}transaction';
  static const apiTransactionVietQR = '$apiTransaction/VietQR-PAYOS';
  static const apiTransactionCOD = '$apiTransaction/COD';
  static const apiTransactionUpdate = '$apiTransaction/update';
  static const apiTransactionCancel = '$apiTransaction/cancel';
  static const apiFavorite = '${baseUrl}favorite';
  static const apiGetListFavorite = '$apiFavorite/get-by-accountId';
  static const apiVoucher = '${baseUrl}voucher';
  static const apiGetAllVoucher = '$apiVoucher/all';
  // static const apiFindAccountById = '${baseUrl}account';
  // static const apiChangePassword = '${baseUrl}account';
  // static const apiForgotPassword = '${baseUrl}account/reset-password';
  // static const apiGetProductById = '${baseUrl}product/getById';
  // static const apiGetProductDetailsById = '${baseUrl}productDetail/getById';
  static const apiOrder = '${baseUrl}order';
  static const apiOrderByStatus = '$apiOrder/get-by-orderState';
  static const apiRateOrder = '$apiOrder/rate';
  static const apiCart = '${baseUrl}cart';
  static const apiClearCart = '$apiCart/delete-many-cart';

  // static const apiUpdateCart = '${baseUrl}cart/update';

  // static const apiUpdateFingerPrintAuthen = '${baseUrl}account/fingerprint';
  static const apiAddress = '${baseUrl}address';

  // static const apiDeleteAddress = '${baseUrl}address/delete';
  // static const apiGetAllReview = '${baseUrl}review';
  // static const apiCreateReview = '${baseUrl}review/create';
  static const apiChangeImage = '${baseUrl}account/update-image';
  // static const apiGetAndFetchAllOrder = '${baseUrl}order/testGetOrder';
}
