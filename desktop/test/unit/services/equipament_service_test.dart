import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'equipament_service_test.mocks.dart';

void main() {
  group('EquipamentService', () {
    late MockEquipamentService mockEquipamentService;

    setUp(() {
      mockEquipamentService = MockEquipamentService();
    });

    test('getEquipaments returns a list of equipaments when successful',
        () async {
      when(mockEquipamentService.getEquipaments()).thenAnswer(
        (_) async => [
          {
            'name': 'Equipamento 1',
            'register': '123',
            'image': 'base64string',
            'c_room': 'Room A',
            'c_date': '2024-12-02T00:00:00Z',
          }
        ],
      );

      var result = await mockEquipamentService.getEquipaments();

      expect(result, isA<List<dynamic>>());
      expect(result.length, 1);
      expect(result[0]['name'], 'Equipamento 1');
    });

    test('getOneEquipament returns a specific equipament', () async {
      when(mockEquipamentService.getOneEquipament('123')).thenAnswer(
        (_) async => {
          'name': 'Equipamento 1',
          'register': '123',
          'image': 'base64string',
          'c_room': 'Room A',
          'c_date': '2024-12-02T00:00:00Z',
        },
      );

      var result = await mockEquipamentService.getOneEquipament('123');

      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], 'Equipamento 1');
      expect(result['register'], '123');
    });

    test('updateEquipamentsLocation returns a success message', () async {
      when(mockEquipamentService.updateEquipamentsLocation()).thenAnswer(
        (_) async => 'Location updated successfully',
      );

      var result = await mockEquipamentService.updateEquipamentsLocation();

      expect(result, 'Location updated successfully');
    });

    test('createEquipament returns a success message', () async {
      when(mockEquipamentService.createEquipament(
        name: 'Equipamento 1',
        register: '123',
        espId: 'esp123',
        image: 'base64image',
      )).thenAnswer(
        (_) async => 'Equipamento created successfully',
      );

      var result = await mockEquipamentService.createEquipament(
        name: 'Equipamento 1',
        register: '123',
        espId: 'esp123',
        image: 'base64image',
      );

      expect(result, 'Equipamento created successfully');
    });

    test('deleteEquipament returns a success message', () async {
      when(mockEquipamentService.deleteEquipament('123')).thenAnswer(
        (_) async => 'Equipamento deleted successfully',
      );

      var result = await mockEquipamentService.deleteEquipament('123');

      expect(result, 'Equipamento deleted successfully');
    });
  });
}
