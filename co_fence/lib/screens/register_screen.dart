import 'package:co_fence/common/components/my_textfield.dart';
import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/model/gender.dart';
import 'package:co_fence/common/model/nation.dart';
import 'package:co_fence/common/model/role.dart';
import 'package:co_fence/riverpods/image_state_provider.dart';
import 'package:co_fence/riverpods/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'dart:io';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _passwordCheckController.dispose();
    _phoneNumberController.dispose();
    _birthController.dispose();
    super.dispose();
  }

  // 텍스트필드 컨트롤러
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext contex) {
    final roleState = ref.watch(roleProvider);
    final imagesState = ref.watch(imageStateProvider);
    final nationState = ref.watch(nationProvider);
    final genderState = ref.watch(genderProvider);

    return DefaultLayout(
      title: 'Register',
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(10),
              // 유저 프로필 이미지
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: ref.read(imageStateProvider).isEmpty
                        ? const AssetImage('assets/images/user_profile.png')
                        : FileImage(
                            File(ref.read(imageStateProvider).first!.path),
                          ) as ImageProvider<Object>,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        ref.read(imageStateProvider.notifier).getSingleImage();
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              const Text('Name'),
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
              // 외국인 여부 선택 드롭다운, 추후 수정 필요
              const Gap(10),
              const Text('Nation'),
              DropdownButton<Nation>(
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
                        nation == Nation.korean ? 'Korean' : 'Foreigner',
                      ),
                    );
                  },
                ).toList(),
              ),
              const Gap(10),
              const Text('Sex'),
              // 성별 선택 드롭다운
              DropdownButton<Gender>(
                value: genderState,
                onChanged: (newValue) {
                  ref
                      .read(genderProvider.notifier)
                      .update((state) => newValue!);
                },
                items: Gender.values.map(
                  (Gender gender) {
                    return DropdownMenuItem<Gender>(
                      value: gender,
                      child: Text(
                        gender == Gender.male ? 'Male' : 'Female',
                      ),
                    );
                  },
                ).toList(),
              ),
              const Gap(10),
              const Text('Birth'),
              const Gap(10),
              // 생일 입력 필드
              Stack(
                children: [
                  MyTextFormField(
                    controller: _birthController,
                    hintText: 'Enter your birth',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Birthdate cannot be empty';
                      }

                      // 생일 날짜 형식 확인 (예시: YYYY-MM-DD)
                      final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                      if (!dateRegex.hasMatch(value)) {
                        return 'Enter a valid birthdate (YYYY-MM-DD)';
                      }

                      // 여기서 날짜의 유효성을 더욱 엄격하게 확인할 수도 있습니다.
                      // 예를 들어, DateTime.parse를 사용하여 실제로 유효한 날짜인지 확인할 수 있습니다.
                      // 하지만 정규식만으로도 간단한 형식 확인은 가능합니다.

                      return null;
                    },
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      iconSize: 30,
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                            _birthController.text = _selectedDate!
                                .toLocal()
                                .toString()
                                .split(' ')[0];
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              // 이메일 입력 필드
              const Text('Email'),
              const Gap(10),
              MyTextFormField(
                controller: _emailController,
                hintText: 'Enter your email',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  // 이메일 형식 확인
                  final emailRegex =
                      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const Gap(10),
              // 비밀번호 입력 필드
              const Text('Password'),
              const Gap(10),
              MyTextFormField(
                controller: _passwordController,
                hintText: 'Enter your password',
                obscureText: true,
              ),
              const Gap(10),
              // 비밀번호 확인 입력 필드
              const Text('Password Check'),
              const Gap(10),
              MyTextFormField(
                controller: _passwordCheckController,
                hintText: 'Enter your password again',
                obscureText: true,
                validator: (value)
                    // 비밀번호 확인 필드의 값이 비밀번호 필드의 값과 같은지 확인
                    =>
                    value != _passwordController.text
                        ? 'Password does not match'
                        : null,
              ),
              const Gap(10),
              // 휴대폰 번호 입력 필드
              const Text('Phone Number'),
              const Gap(10),
              MyTextFormField(
                controller: _phoneNumberController,
                hintText: 'Enter your phone number',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number cannot be empty';
                  }
                  // 전화번호 정규식 확인 (예시: 숫자만 허용)
                  final phoneRegex = RegExp(r'^[0-9]+$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              const Gap(10),
              const Text('Role'),
              // 역할군 선택 드롭다운
              DropdownButton<Role>(
                value: roleState,
                onChanged: (newValue) {
                  ref.read(roleProvider.notifier).update((state) => newValue!);
                },
                items: Role.values.map(
                  (Role role) {
                    return DropdownMenuItem<Role>(
                      value: role,
                      child: Text(
                        role == Role.worker ? 'Worker' : 'Manager',
                      ),
                    );
                  },
                ).toList(),
              ),
              const Gap(30),
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
                        // 폼 유효성 검사 통과 후, 서버로 회원가입 요청
                        bool success = true; // 실제 회원가입 로직을 구현해야 합니다.

                        if (success) {
                          // 회원가입이 성공하면 상태 업데이트
                          ref.read(userProvider.notifier).updateUser(
                                name: _nameController.text,
                                email: _emailController.text,
                                nation: nationState,
                                gender: genderState,
                                birth: _birthController.text,
                                phoneNumber: _phoneNumberController.text,
                                profileImage: imagesState.isNotEmpty
                                    ? imagesState.first
                                    : null,
                              );
                          // print('회원가입 성공');
                          // // 유저의 정보 출력
                          // print('유저 정보:');
                          // print('이름: ${_nameController.text}');
                          // print('이메일: ${_emailController.text}');
                          // print('국가: $nationState');
                          // print('성별: $genderState');
                          // print('생일: ${_birthController.text}');
                          // print('전화번호: ${_phoneNumberController.text}');
                          // print(
                          //     '프로필 이미지: ${imagesState.isNotEmpty ? imagesState.first : '없음'}');
                        }
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
    );
  }
}
