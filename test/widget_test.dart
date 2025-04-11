
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:user_repository/user_repository.dart';
import 'package:video_and_audio_call_using_send_invitation/app/view/app.dart';
import 'package:video_and_audio_call_using_send_invitation/app/view/app_view.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('App', () {
    late UserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      when(() => userRepository.user).thenAnswer(
        (_) => Stream.value(
          const User(id: '123', email: 'test@gmail.com', name: 'test'),
        ),
      );
    });

    testWidgets('renders AppView', (WidgetTester tester) async {
      await tester.pumpWidget(
        App(
          userRepository: userRepository,
          user: await userRepository.user.first,
        ),
      );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
