import 'dart:async';

import 'package:firebase/firebase.dart' as fb;
import 'package:universal_html/html.dart' as html;
Future<Uri> uploadImageFile(html.File image,
    {required String imageName}) async {
  fb.StorageReference storageRef = fb.storage().ref('images/$imageName');
  fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(image).future;

  Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
  return imageUri;
}