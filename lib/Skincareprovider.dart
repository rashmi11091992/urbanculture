import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SkincareStep.dart';

class SkincareProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  int _streak = 0;

  List<SkincareStep> _routine = [
    SkincareStep(
      name: 'Cleanser',
      subname: 'Cetaphil Gentle Skin Cleanser',
      completionTime: null,
    ),
    SkincareStep(
      name: 'Toner',
      subname: 'Thayers Witch Hazel Toner',
      completionTime: null,
    ),
    SkincareStep(
      name: 'Moisturizer',
      subname: 'Kiehls Ultra Facial Cream',
      completionTime: null,
    ),
    SkincareStep(
      name: 'Sunscreen',
      subname: 'SuperGoop Unseen Sunscreen Spf40',
      completionTime: null,
    ),
    SkincareStep(
      name: 'Lip Balm',
      subname: 'Glossier Birthday Balm Dotcom',
      completionTime: null,
    ),
  ];

  void resetAllRoutines() {
    _routine = _routine.map((step) => step.reset()).toList();
    _completionTimes.clear();
    imageUrls = List.filled(5, '');
    notifyListeners();
  }

  List<SkincareStep> get routine => _routine;
  int get streak => _streak;
  SkincareProvider() {
    _loadPrefs();
  }

  void incrementStreak() {
    _streak++;
    _savePrefs();
    notifyListeners();
  }

  void resetStreak() {
    _streak = 0;
    _savePrefs();
    notifyListeners();
  }

  bool allRoutinesCompleted() {
    return _routine.every((step) => step.completed);
  }

  final Map<int, DateTime> _completionTimes = {};
  DateTime? _lastCompletionDate;
  void toggleStep(int index) {
    if (!_routine[index].completed) {
      _routine[index] = _routine[index].copyWith(
        completed: true,
        completionTime: DateTime.now(),
      );
      _completionTimes[index] = DateTime.now();
      if (allRoutinesCompleted()) {
        _calculateStreak();
        _savePrefs();
      }
    }
    notifyListeners();
  }

  void _calculateStreak() {
    DateTime today = DateTime.now();
    if (_lastCompletionDate == null ||
        _lastCompletionDate!.year != today.year ||
        _lastCompletionDate!.month != today.month ||
        _lastCompletionDate!.day != today.day) {
      _streak++;
    }
    _lastCompletionDate = today;
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _streak = _prefs?.getInt('streak') ?? 0;
    int? lastCompletionTimestamp = _prefs?.getInt('lastCompletionDate');
    _lastCompletionDate = lastCompletionTimestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(lastCompletionTimestamp)
        : null;
  }

  Future<void> _savePrefs() async {
    await _prefs?.setInt('streak', _streak);
    await _prefs?.setInt(
        'lastCompletionDate', _lastCompletionDate!.millisecondsSinceEpoch);
  }

  String getCompletionTime(int index) {
    if (_completionTimes.containsKey(index)) {
      final time = _completionTimes[index];
      final formattedTime = DateFormat('h:mm a').format(time!);
      return formattedTime;
    }
    return '';
  }

  bool _messageShown = false;
  void showMessage() {
    _messageShown = true;
  }

  bool allRoutinesCompletedForToday() {
    if (_messageShown) {
      return false;
    }
    DateTime today = DateTime.now();
    return _lastCompletionDate != null &&
        _lastCompletionDate!.year == today.year &&
        _lastCompletionDate!.month == today.month &&
        _lastCompletionDate!.day == today.day;
  }

  String? imageUrl;
  File? image;
  List<String> imageUrls = List.filled(5, '');
  List<bool> isUploading = List.filled(5, false);
  final picker = ImagePicker();

  Future<void> getImageFromCamera(BuildContext context, int index) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      try {
        isUploading[index] = true; // Set upload flag to true for selected index
        notifyListeners();

        // Upload to Firebase
        await storage
            .ref()
            .child('images/image_$index')
            .putFile(image)
            .then((firebase_storage.TaskSnapshot snapshot) async {
          imageUrls[index] = await snapshot.ref.getDownloadURL();
          isUploading[index] = false; // Reset upload flag
          notifyListeners();
        }).catchError((e) {
          print('Error uploading image: $e');
          isUploading[index] = false; // Reset upload flag on error
          notifyListeners();
        });
      } catch (e) {
        print('Error uploading image: $e');
        isUploading[index] = false; // Reset upload flag on error
        notifyListeners();
      }
    } else {
      print('No Image Path Received');
    }
  }
}
