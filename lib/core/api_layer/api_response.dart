// this is an api response class,
// every api will return this class
// it handles data and exceptions

class ApiResponse<T> {
  final T? _data;
  final String? _error;

  const ApiResponse({
    T? data,
    String? error,
  })  : _data = data,
        _error = error;

  T? get getData => _data;

  String? get getException => _error;

  bool get hasData => _data != null;

  bool get hasException => _error != null;

  @override
  String toString() => 'ApiResponse(_data: $_data, _error: $_error)';
}
