import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'user_service_test.mocks.dart';

void main() {
  group('UserService', () {
    late MockUserService mockUserService;

    setUp(() {
      mockUserService = MockUserService();
    });

    test('signInEmailPassword returns user ID on success', () async {
      when(mockUserService.signInEmailPassword(
              'test@example.com', 'password123'))
          .thenAnswer((_) async => 'user-id-123');

      var result = await mockUserService.signInEmailPassword(
          'test@example.com', 'password123');

      expect(result, 'user-id-123');
      verify(mockUserService.signInEmailPassword(
              'test@example.com', 'password123'))
          .called(1);
    });

    test('signInEmailPassword throws exception on failure', () async {
      when(mockUserService.signInEmailPassword(
              'test@example.com', 'wrongpassword'))
          .thenThrow(Exception('Invalid credentials'));

      expect(() async {
        await mockUserService.signInEmailPassword(
            'test@example.com', 'wrongpassword');
      }, throwsException);

      verify(mockUserService.signInEmailPassword(
              'test@example.com', 'wrongpassword'))
          .called(1);
    });

    test('createUser returns success message', () async {
      when(mockUserService.createUser(
              'John Doe', 'password123', 'john@example.com'))
          .thenAnswer((_) async => 'Success');

      var result = await mockUserService.createUser(
          'John Doe', 'password123', 'john@example.com');

      expect(result, 'Success');
      verify(mockUserService.createUser(
              'John Doe', 'password123', 'john@example.com'))
          .called(1);
    });

    test('createUser throws exception on failure', () async {
      when(mockUserService.createUser(
              'John Doe', 'password123', 'john@example.com'))
          .thenThrow(Exception('User already exists'));

      expect(() async {
        await mockUserService.createUser(
            'John Doe', 'password123', 'john@example.com');
      }, throwsException);

      verify(mockUserService.createUser(
              'John Doe', 'password123', 'john@example.com'))
          .called(1);
    });

    test('getUser returns user data on success', () async {
      final mockUserData = {
        'name': 'John Doe',
        'email': 'john@example.com',
        '_id': 'user-id-123',
      };

      when(mockUserService.getUser('valid-token'))
          .thenAnswer((_) async => mockUserData);

      var result = await mockUserService.getUser('valid-token');

      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], 'John Doe');
      expect(result['email'], 'john@example.com');
    });

    test('getUser throws exception on failure', () async {
      when(mockUserService.getUser('invalid-token'))
          .thenThrow(Exception('Failed to load user data'));

      expect(() async {
        await mockUserService.getUser('invalid-token');
      }, throwsException);

      verify(mockUserService.getUser('invalid-token')).called(1);
    });

    test('updateUserPhoto returns success message on success', () async {
      when(mockUserService.updateUserPhoto('user-id-123', 'new-photo-base64'))
          .thenAnswer((_) async => 'Success');

      var result = await mockUserService.updateUserPhoto(
          'user-id-123', 'new-photo-base64');

      expect(result, 'Success');
      verify(mockUserService.updateUserPhoto('user-id-123', 'new-photo-base64'))
          .called(1);
    });

    test('updateUserPhoto throws exception on failure', () async {
      when(mockUserService.updateUserPhoto('user-id-123', 'new-photo-base64'))
          .thenThrow(Exception('Failed to update user photo'));

      expect(() async {
        await mockUserService.updateUserPhoto(
            'user-id-123', 'new-photo-base64');
      }, throwsException);

      verify(mockUserService.updateUserPhoto('user-id-123', 'new-photo-base64'))
          .called(1);
    });

    test('deleteUser returns success message on success', () async {
      when(mockUserService.deleteUser('john@example.com'))
          .thenAnswer((_) async => null);

      await mockUserService.deleteUser('john@example.com');
      verify(mockUserService.deleteUser('john@example.com')).called(1);
    });

    test('deleteUser throws exception on failure', () async {
      when(mockUserService.deleteUser('john@example.com'))
          .thenThrow(Exception('Failed to delete user'));

      expect(() async {
        await mockUserService.deleteUser('john@example.com');
      }, throwsException);

      verify(mockUserService.deleteUser('john@example.com')).called(1);
    });
  });
}
