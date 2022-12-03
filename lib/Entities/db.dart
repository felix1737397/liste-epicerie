import 'package:liste_epicerie/Entities/item.dart';
import 'package:liste_epicerie/utils/constantes.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Item>> getDocuments() async {
    try {
      List<Item> items = [];
      await connect();
      var docs = await userCollection.find().toList();
      for (var doc in docs) {
        items.add(Item.fromMap(doc));
      }
      return items;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static insert(Item item) async {
    try {
      await connect();
      await userCollection.insert(item.toMap());
    } catch (e) {
      print(e);
    }
  }

  static update(Item item) async {
    try {
      await connect();
      await userCollection.update(
        where.id(ObjectId.parse(item.id!)),
        item.toMap(withId: false),
      );
    } catch (e) {
      print(e);
    }
  }

  static delete(Item item) async {
    try {
      await connect();
      await userCollection.remove(where.id(ObjectId.parse(item.id!)));
    } catch (e) {
      print(e);
    }
  }
}
