import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundryku/src/utils/colors.dart';

class Toast {
  void success({String message = "Berhasil"}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.primary,
        textColor: Colors.white,
        fontAsset: "assets/fonts/Poppins-Regular.ttf",
        fontSize: 16.0);
  }

  void err({String message = "Gagal!"}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.err,
        textColor: Colors.white,
        fontAsset: "assets/fonts/Poppins-Regular.ttf",
        fontSize: 16.0);
  }
}
