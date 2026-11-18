import 'package:cloud_firestore/cloud_firestore.dart';

class CrudService {
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  // READ
  Stream<QuerySnapshot> getItems() {
    return _items.orderBy('createdAt').snapshots();
  }

  // CREATE
  Future<void> addItem(String name, int quantity) {
    return _items.add({
      'name': name,
      'quantity': quantity,
      'isFavorite': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // UPDATE
  Future<void> updateItem(String id, String name, int quantity) {
    return _items.doc(id).update({
      'name': name,
      'quantity': quantity,
    });
  }

  // FAVORITE
  Future<void> toggleFavorite(String id, bool value) {
    return _items.doc(id).update({'isFavorite': value});
  }

  // DELETE
  Future<void> deleteItem(String id) {
    return _items.doc(id).delete();
  }
}