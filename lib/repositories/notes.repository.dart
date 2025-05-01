import 'dart:convert';

import 'package:flutter_application_1/entities/notes-entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesRepository {
  Future<List<Note>> getNotes() async {
    try {
      final data = await supabaseClient.from(Entities.NOTE.dbName).select('*').eq("user_id", userId);
      return data.map((note) => Note.fromJson(note)).toList();
    } catch (e) {
      throw Exception("Error getting notes!");
    }
  }

  Future<Note> createNote(Map<String, dynamic> note) async {
    print('Creating note: $note');
    try {
      final response =
          await supabaseClient.from(Entities.NOTE.dbName).insert({
            'title': note['title'],
            'notes': jsonEncode(note['notes']),
            'user_id': note['user_id'],
            'color': note['color'],
          }).select();

      final data = await supabaseClient.from(Entities.NOTE.dbName).select('*');

      final lastItem = data[data.length - 1];
      // final data =
      //     await supabaseClient
      //         .from(Entities.NOTE.dbName)
      //         .select('*')
      //         .eq('id', note['id'])
      //         .maybeSingle();
      // print("Data: $data");
      // if (data == null || data == Null) {
      //   throw Exception("Error getting the created note!");
      // }

      print("Last Item: $lastItem");
      print("Last Item: ${lastItem.runtimeType}");

      return Note.fromJson(lastItem);
    } catch (e) {
      print(e);
      print("sssssssssssssssssssssss");
      rethrow;
    }
  }

  Future<Note> updateNote(List<Map<String, dynamic>> note, int id) async {
    try {
      final response = await supabaseClient
          .from(Entities.NOTE.dbName)
          .update({
            'title': note[0]['title'],
            'notes': jsonEncode(note[0]['notes']),
            'color': note[0]['color'],
          })
          .eq('id', id)
          .count(CountOption.exact);

      if (response.count == 0) {
        throw Exception("Error updating note!");
      }

      final data =
          await supabaseClient
              .from(Entities.NOTE.dbName)
              .select('*')
              .eq('id', id)
              .maybeSingle();
      if (data == null) {
        throw Exception("Error getting the updated note!");
      }
      return Note.fromJson(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
