class ApiUrl {
  //ip khi ở trường - 10.10.116.60
  //ip LAN nhà - 192.168.1.44
  //ip Coffee House NTT 172.16.3.8//172.16.2.242
  //ip mạng ảo của giả lập - 10.0.2.2
  //ip wifi nhà - 192.168.0.106
  //ip mobile hostspot - 192.168.29.192/192.168.191.192s
  //ip debug lan - 192.168.93.160/192.168.93.111

  // static const baseUrl =
  //     'https://testjava-fooddelivery-07101b5575c7.herokuapp.com/api/';

  static const baseUrl = "http://26.196.143.193:6969/api/";
  // static const apiGetAllAccount = '${baseUrl}account/all';

  ///// Api của Đạt-------------------------------------------------
  static const apiCreateAccount = '${baseUrl}account';
  static const apiLoginWithEmail = '${baseUrl}account/login-by-email';
  static const apiGetAllCategory = '${baseUrl}category';
  static const apiGetAllDish = '${baseUrl}dish';
  static const apiMapListLocation = '${baseUrl}map';
  static const apiMapPredictLocation = '${baseUrl}map/predict';
  // static const apiFindAccountById = '${baseUrl}account';
  // static const apiChangePassword = '${baseUrl}account';
  // static const apiForgotPassword = '${baseUrl}account/reset-password';
  // static const apiGetProductById = '${baseUrl}product/getById';
  // static const apiGetProductDetailsById = '${baseUrl}productDetail/getById';
  static const apiCart = '${baseUrl}cart';
  // static const apiUpdateCart = '${baseUrl}cart/update';
  // static const apiClearCart = '${baseUrl}cart/clear-cart';
  // static const apiUpdateFingerPrintAuthen = '${baseUrl}account/fingerprint';
  // static const apiDeleteAddress = '${baseUrl}address/delete';
  // static const apiGetAllReview = '${baseUrl}review';
  // static const apiCreateReview = '${baseUrl}review/create';
  static const apiChangeImage = '${baseUrl}account/update-image';
  // static const apiGetAndFetchAllOrder = '${baseUrl}order/testGetOrder';
}
