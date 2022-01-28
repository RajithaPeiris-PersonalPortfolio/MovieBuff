import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationService {
  static final AuthenticationService authUtil = AuthenticationService._createInstance();
  AuthenticationService._createInstance();

  final _fbDBUtil = FirebaseDatabase.instance.reference();

  Future createIdGenerator() async {
    var idGenTbl = _fbDBUtil.child("id_generator");
    await idGenTbl.child("key_val").set({
          'sequence': 1,
          'version' : 0,
        }
    );
    idGenTbl.push();
  }

  Future updateIdGenerator(int nextVal, int version) async {
    var idGenTbl = _fbDBUtil.child("id_generator");
    await idGenTbl.child("key_val").update({
          'sequence': nextVal,
          'version' : version,
        }
    );
    idGenTbl.push();
  }

  Future createRatingIdGenerator() async {
    var idGenTbl = _fbDBUtil.child("rating_id_gen");
    await idGenTbl.child("key_val").set({
        'sequence': 1,
        'version' : 0,
      }
    );
    idGenTbl.push();
  }

  Future updateRatingIdGenerator(int nextVal, int version) async {
    var idGenTbl = _fbDBUtil.child("rating_id_gen");
    await idGenTbl.child("key_val").update({
        'sequence': nextVal,
        'version' : version,
      }
    );
    idGenTbl.push();
  }

  Future createFavoIdGenerator() async {
    var idGenTbl = _fbDBUtil.child("favo_id_gen");
    await idGenTbl.child("key_val").set({
        'sequence': 1,
        'version' : 0,
      }
    );
    idGenTbl.push();
  }

  Future updateFavoIdGenerator(int nextVal, int version) async {
    var idGenTbl = _fbDBUtil.child("favo_id_gen");
    await idGenTbl.child("key_val").update({
        'sequence': nextVal,
        'version' : version,
      }
    );
    idGenTbl.push();
  }
}