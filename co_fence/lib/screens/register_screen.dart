import 'package:co_fence/common/components/my_textfield.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/common/model/gender.dart';
import 'package:co_fence/common/model/nation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  // 텍스트필드 컨트롤러
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 국적과 성별 초기화
    final nationState = ref.watch(nationProvider);
    final genderState = ref.watch(genderProvider);
    return DefaultLayout(
      title: '프로필 등록',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(10),
          // 유저 프로필 이미지

          Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage('assets/images/user_profile.png'),
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_a_photo),
                ),
              ),
            ],
          ),
          const Gap(10),
          const SizedBox(
            width: 200,
            child: Text('이름'),
          ),
          const Gap(10),
          MyTextField(
            controller: _nameController,
            hintText: '이름을 입력해주세요.',
            obscureText: false,
          ),
          // 외국인 여부 선택 드롭다운, 추후 수정 필요

          DropdownButton<Nation>(
            value: nationState,
            onChanged: (newValue) {
              ref.read(nationProvider.notifier).update((state) => newValue!);
            },
            items: Nation.values.map(
              (Nation nation) {
                return DropdownMenuItem<Nation>(
                  value: nation,
                  child: Text(
                    nation == Nation.korean ? '한국인' : '외국인',
                  ),
                );
              },
            ).toList(),
          ),

          // 성별 선택 드롭다운
          DropdownButton<Gender>(
            value: genderState,
            onChanged: (newValue) {
              ref.read(genderProvider.notifier).update((state) => newValue!);
            },
            items: Gender.values.map(
              (Gender gender) {
                return DropdownMenuItem<Gender>(
                  value: gender,
                  child: Text(
                    gender == Gender.male ? '남자' : '여자',
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
