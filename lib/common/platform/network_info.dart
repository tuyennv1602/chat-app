import 'dart:async';
import 'package:flutter/material.dart';

import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  static final _instance = NetworkInfoImpl._();

  factory NetworkInfoImpl() => _instance;

  final ValueNotifier<bool> notifier = ValueNotifier<bool>(false);

  DataConnectionChecker _checker = DataConnectionChecker();

  NetworkInfoImpl._() {
    _checker.onStatusChange.listen((status) {
      notifier.value = status == DataConnectionStatus.connected;
    });
  }

  Completer<bool> _checking;

  @override
  Future<bool> get isConnected {
    if (_checking?.isCompleted != false) {
      _checking = Completer<bool>();
      _checker.hasConnection.then((value) {
        notifier.value = value;
        _checking.complete(value);
      });
    }
    return _checking.future;
  }

  void dispose() {
    _checker = null;
    notifier.dispose();
  }
}
