import 'package:social_app_2/src/enum/file_type.dart';

extension CollectionName on FileType {
  String get collectionName {
    switch (this) {
      case FileType.image:
        return 'images';
      case FileType.video:
        return 'videos';
    }
  }
}
