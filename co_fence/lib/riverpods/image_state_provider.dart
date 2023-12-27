import 'package:co_fence/services/image_picker_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

final imageStateProvider = StateNotifierProvider<ImageState, List<XFile?>>(
  (ref) => ImageState(),
);

class ImageState extends StateNotifier<List<XFile?>> {
  ImageState() : super(<XFile>[]);
  final ImagePickerService picker = ImagePickerService();

  @override
  set state(List<XFile?> value) {
    super.state = value;
  }

  // 사진 삭제
  void delImage(XFile image) {
    var list = [...super.state];
    list.remove(image);
    state = list;
  }

  // 한 장의 사진만 추가 가능
  void addImage(List<XFile?> value) {
    var list = [...super.state];
    if (list.isEmpty) {
      // 리스트가 비어있으면
      state = value; // 리스트 업데이트
    } else {
      state = [value.first];
    }
  }

  Future getSingleImage() async {
    picker.pickSingleImage().then((value) => addImage([value])).catchError(
          (onError) => Fluttertoast.showToast(
            msg: '사진을 가져오는데 실패했습니다.',
          ),
        );
  }

  Future getImages() async {
    picker.pickImage().then((value) => addImage(value)).catchError((onError) {
      Fluttertoast.showToast(
        msg: '사진을 가져오는데 실패했습니다.',
      );
    });
  }
}
