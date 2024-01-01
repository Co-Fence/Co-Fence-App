import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

final imageStateProvider =
    StateNotifierProvider<ImageState, List<String>>((ref) => ImageState());

class ImageState extends StateNotifier<List<String>> {
  ImageState() : super([]);

  final ImagePickerService picker = ImagePickerService();

  // 선택한 이미지 삭제
  void deleteImage(String imageUrl) {
    state = [...state]..remove(imageUrl);
  }

  // 전체 리스트 삭제
  void deleteAllImages() {
    state = [];
  }

  // 한 장의 이미지 추가
  void addImage(String imageUrl) {
    state = [...state, imageUrl];
  }

  // 프로필 이미지 카메라에서 추가
  Future<void> getProfileImageFromCamera() async {
    try {
      final String? imageUrl = await picker.pickProfileImageFromCamera();
      if (imageUrl != null) {
        deleteAllImages();
        state = [imageUrl];
      } else {
        Fluttertoast.showToast(msg: '프로필 이미지를 가져오는데 실패했습니다.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '프로필 이미지를 가져오는데 실패했습니다.');
    }
  }

  // 프로필 이미지 갤러리에서 추가
  Future<void> getProfileImageFromGallery() async {
    try {
      final String? imageUrl = await picker.pickProfileImageFromGallery();
      if (imageUrl != null) {
        deleteAllImages();
        state = [imageUrl];
      } else {
        Fluttertoast.showToast(msg: '프로필 이미지를 가져오는데 실패했습니다.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '프로필 이미지를 가져오는데 실패했습니다.');
    }
  }

  // 사진첩에서 이미지 추가
  Future<void> getImagesFromGallery() async {
    try {
      final List<String> pickedImages = await picker.pickImages();
      if (pickedImages.isNotEmpty) {
        state = [...state, ...pickedImages];
      } else {
        Fluttertoast.showToast(msg: '이미지를 가져오는데 실패했습니다.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '이미지를 가져오는데 실패했습니다.');
    }
  }
}

class ImagePickerService {
  static final ImagePickerService _imagePickerService = ImagePickerService._();

  factory ImagePickerService() {
    return _imagePickerService;
  }

  ImagePickerService._();

  final ImagePicker _picker = ImagePicker();

  Future<List<String>> pickImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      return pickedFiles.map((pickedFile) => pickedFile.path).toList();
    } catch (e) {
      print('ImagePickerService: $e');
    }
    throw Exception('이미지를 선택하지 않았습니다.');
  }

  Future<String?> pickProfileImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return pickedFile.path;
      }
    } catch (e) {
      print('ImagePickerService: $e');
    }
    throw Exception('이미지를 선택하지 않았습니다.');
  }

  Future<String?> pickProfileImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return pickedFile.path;
      }
    } catch (e) {
      print('ImagePickerService: $e');
    }
    throw Exception('이미지를 선택하지 않았습니다.');
  }
}
