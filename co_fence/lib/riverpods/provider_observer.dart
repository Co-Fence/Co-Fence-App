import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  // 프로바이더가 업데이트 될 때마다 호출됨
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print(
        '[Provider Updated] provider: $provider / previousValue: $previousValue / newValue: $newValue');
  }

  @override
  // 프로바이더가 추가될 때마다 호출됨
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    print('[Provider Added] provider: $provider / value: $value');
  }

  @override
  // 프로바이더가 삭제될 때마다 호출됨
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    print('[Provider Disposed] provider: $provider');
  }
}
