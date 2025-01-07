// lib/global.dart

/// 전역 상태 관리 클래스 (로그인 여부 등)
class GlobalState {
  /// 로그인 여부
  static bool isLoggedIn = false;
  static dynamic loginEmail;
  static dynamic loginIdx;
}
