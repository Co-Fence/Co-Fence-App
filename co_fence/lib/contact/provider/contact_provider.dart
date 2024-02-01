import 'package:co_fence/contact/model/contact_detail_model.dart';
import 'package:co_fence/contact/model/contact_model.dart';
import 'package:co_fence/contact/repository/contact_repository.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactProvider =
    StateNotifierProvider<ContactStateNotifier, ContactModel>(
  (ref) {
    final repository = ref.watch(contactRepositoryProvider);
    final notifier = ContactStateNotifier(
      repository: repository,
    );

    return notifier;
  },
);

class ContactStateNotifier extends StateNotifier<ContactModel> {
  ContactStateNotifier({
    required this.repository,
  }) : super(ContactModel(
          userId: 0,
          userName: '',
          profileImageUrl: '',
          roleType: Role.USER,
        ));

  final ContactRepository repository;

  void updateContact({
    int? userId,
    String? userName,
    String? profileImageUrl,
    Role? roleType,
  }) {
    state = state.copyWith(
      userId: userId,
      userName: userName,
      profileImageUrl: profileImageUrl,
      roleType: roleType,
    );
  }

  //getContactList
  Future<List<ContactModel>?> getContactList() async {
    try {
      final response = await repository.getContactList();
      print(response);
      return response;
    } catch (e) {
      return null;
    }
  }

  //searchContactList
  Future<List<ContactModel>?> searchContactList({
    required String userName,
  }) async {
    try {
      final response = await repository.searchContactList(
        userName: userName,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  //getContactDetail
  Future<ContactDetailModel?> getContactDetail({
    required int userId,
  }) async {
    try {
      final response = await repository.getContactDetail(
        userId: userId,
      );
      return response;
    } catch (e) {
      return null;
    }
  }
}
