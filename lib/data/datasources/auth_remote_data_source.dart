import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journal_cubit/core/errors/exception.dart';
import 'package:journal_cubit/domain/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();
  Future<void> forgotPassword(String email);

  Future<String> getCurrentUserId();

  /// always use the the model not the enitity
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String name,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final storage = const FlutterSecureStorage();
  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Message',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;

      if (user == null) {
        throw const ServerException(
            message: 'Please try again later', statusCode: 'Unknown Error');
      }
      print('getting token');
      final token = await user.getIdToken();
      storage.write(key: 'auth_token', value: token);
      var userData = await _getUserData(user.uid);
      return UserModel.fromJson(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Message',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> signUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCred.user?.updateDisplayName(name);
      await _setUserData(_authClient.currentUser!, email);
      final token = await userCred.user!.getIdToken();
      storage.write(key: 'auth_token', value: token);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Message',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData(
      String uid) async {
    return _cloudStoreClient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallBackEmail) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          UserModel(
                  uid: user.uid,
                  email: user.email ?? fallBackEmail,
                  name: user.displayName ?? '')
              .toJson(),
        );
  }
  
  @override
  Future<String> getCurrentUserId() async {
    try{
      return  _authClient.currentUser!.uid;
    }catch(e){
      throw 'Not Logged in';
    }
  }
}
