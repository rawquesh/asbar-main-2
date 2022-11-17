import 'package:fluttertoast/fluttertoast.dart';

import '../Constants/colors.dart';

class CommonServices {
  showToast(String text) {
    Fluttertoast.showToast(
        msg: "  $text  ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kDarkBlue,
        textColor: kWhite,
        fontSize: 16.0);
  }
}
