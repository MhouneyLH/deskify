import 'package:deskify/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo =
        NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  group('is connected', () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(() => mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = networkInfo.isConnected;
        // assert
        verify(() => mockInternetConnectionChecker.hasConnection).called(1);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
