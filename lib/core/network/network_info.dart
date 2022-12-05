// Packages
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BaseNetworkInfo {
  Future<bool> get isConnected;
}

// class NetworkInfoImpl implements BaseNetworkInfo {
//   final InternetConnectionChecker connectionChecker;
//   NetworkInfoImpl(this.connectionChecker);
//
//   @override
//   Future<bool> get isConnected => connectionChecker.hasConnection;
// }

class NetworkInfoImpl implements BaseNetworkInfo {
  @override
  Future<bool> get isConnected async {
    // ConnectivityResult.none ==> means there is no internet connection
    return await Connectivity().checkConnectivity() != ConnectivityResult.none;
  }
}
