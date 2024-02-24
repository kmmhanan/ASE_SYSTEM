import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonMethods {
  checkConnectivity(context) async {
    // wifi, sim data
    var connectionResult = await Connectivity().checkConnectivity();

    if (connectionResult != ConnectivityResult.mobile && connectionResult != ConnectivityResult.wifi) {
      if (!context.mounted) return;
      Fluttertoast.showToast(msg: "Your Internet is not Working. Check your connection and Try Again");
    }
  }
}
