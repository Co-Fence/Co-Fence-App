import 'dart:io';

import 'package:co_fence/common/components/my_richtext.dart';
import 'package:co_fence/common/components/my_textfield.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:co_fence/common/provider/image_state_provider.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:co_fence/common/const/data.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // 텍스트필드 컨트롤러
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String defaultImageUrl =
      'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg';

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    final imageState = ref.watch(imageStateProvider);
    _emailController.text = ref.read(userProvider).email;
    _nameController.text = ref.read(userProvider).name;
    final roleState = ref.watch(roleProvider);
    final nationState = ref.watch(nationProvider);
    return DefaultLayout(
      context: context,
      appBarTitle: 'Register',
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(20),
                  const Text(
                    'Required Input',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(10),
                  const Text('Profile Image'),
                  // 유저 프로필 이미지
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          imageState.isNotEmpty
                              // 이미지가 있을 경우 선택한 이미지로 대체
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage:
                                      FileImage(File(imageState.first)),
                                )

                              // 이미지가 없을 경우 기본 이미지로 대체
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                    defaultImageUrl,
                                  ),
                                ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: () {
                                ref
                                    .read(imageStateProvider.notifier)
                                    .getProfileImageFromGallery();
                              },
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(10),
                  // 이름 입력 필드
                  const MyRichText(
                    text1: 'Name',
                    text2: ' *',
                    isRequired: true,
                  ),
                  const Gap(10),
                  MyTextFormField(
                    controller: _nameController,
                    hintText: 'Enter your name',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                  ),

                  const Gap(10),
                  // 역할 선택 드롭다운
                  const MyRichText(
                    text1: 'Role',
                    text2: ' *',
                    isRequired: false,
                  ),
                  DropdownButton<Role>(
                    isExpanded: true,
                    value: roleState,
                    onChanged: (newValue) {
                      ref
                          .read(roleProvider.notifier)
                          .update((state) => newValue!);
                    },
                    items: Role.values.map(
                      (Role role) {
                        return DropdownMenuItem<Role>(
                          value: role,
                          child: Text(
                            role == Role.USER ? 'User' : 'Admin',
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const Gap(10),
                  // 외국인 여부 선택 드롭다운, 추후 수정 필요
                  const MyRichText(
                    text1: 'Nation',
                    text2: ' *',
                    isRequired: false,
                  ),
                  DropdownButton<Nation>(
                    isExpanded: true,
                    value: nationState,
                    onChanged: (newValue) {
                      ref
                          .read(nationProvider.notifier)
                          .update((state) => newValue!);
                    },
                    items: Nation.values.map(
                      (Nation nation) {
                        return DropdownMenuItem<Nation>(
                          value: nation,
                          child: Text(
                            nation == Nation.KR ? 'Korean' : 'Foreigner',
                          ),
                        );
                      },
                    ).toList(),
                  ),

                  const Gap(10),
                  const MyRichText(
                    text1: 'Phone Number(without - )',
                    text2: ' *',
                    isRequired: true,
                  ),
                  const Gap(10),
                  MyTextFormField(
                    controller: _phoneNumberController,
                    hintText: 'Enter your phone number',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number cannot be empty';
                      }
                      // 전화번호 정규식 확인 (숫자만 허용)
                      final phoneRegex = RegExp(r'^[0-9]+$');
                      if (!phoneRegex.hasMatch(value)) {
                        return 'Please Enter without -';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  // 회원가입 버튼
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 50),
                          foregroundColor: Colors.white,
                          backgroundColor: PRIMARY_COLOR,
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await register(roleState, nationState, imageState,
                                storage, context);
                          }
                        },
                        child: const Text("Join"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register(
      Role roleState,
      Nation nationState,
      List<String> imageState,
      FlutterSecureStorage storage,
      BuildContext context) async {
    Dio dio = Dio();
    // 폼 유효성 검사 통과 후, 서버로 회원가입 요청
    try {
      Response response = await dio.post(
        '$ip/v1/auth/signUp',
        data: {
          "name": _nameController.text,
          "email": _emailController.text,
          "roleType": roleState.toString().split('.').last,
          "nationality": nationState.toString().split('.').last,
          "phoneNumber": _phoneNumberController.text,
          "profileImageUrl":
              imageState.isNotEmpty ? imageState.first : defaultImageUrl,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final refreshToken = response.data['refreshToken'];
        final accessToken = response.data['accessToken'];
        await storage.write(
          key: REFRESH_TOKEN_KEY,
          value: refreshToken,
        );
        await storage.write(
          key: ACCESS_TOKEN_KEY,
          value: accessToken,
        );
        // 회원가입이 성공하면 상태 업데이트
        List<String>? images = ref.read(imageStateProvider);
        if (images != null && images.isNotEmpty) {
          ref.read(userProvider.notifier).updateUser(
                name: _nameController.text,
                email: _emailController.text,
                role: roleState,
                nation: nationState,
                phoneNumber: _phoneNumberController.text,
                profileImageUrl: images[0],
              );
          // 유저 정보 출력
          print('User Information:');
          print('Name: ${ref.read(userProvider).name}');
          print('Email: ${ref.read(userProvider).email}');
          print('Role: ${ref.read(userProvider).role}');
          print('Nation: ${ref.read(userProvider).nation}');
          print('Phone Number: ${ref.read(userProvider).phoneNumber}');
          print('Profile Image: ${ref.read(userProvider).profileImageUrl}');

          // 회원가입 성공 후, 홈 화면으로 이동
          context.go('/workspace');
        } else {
          // 사진을 등록해야 넘어갈 수 있음을 사용자에게 알리는 처리를 추가할 수 있습니다.
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
