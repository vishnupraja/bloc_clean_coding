
/// An abstract class defining the contract for API services.
///
/// This class provides a blueprint for making network requests. Concrete
/// implementations will handle the specifics of the HTTP client (e.g., http, dio).
abstract class BaseApiServices{

  /// Performs a GET request to the specified [url].
  ///
  /// Returns a [Future] that completes with the response body.
  Future<dynamic> getData(String url);

  /// Performs a POST request to the specified [url] with the given [data].
  ///
  /// Returns a [Future] that completes with the response body.
  Future<dynamic> postData(String url,var data);

}