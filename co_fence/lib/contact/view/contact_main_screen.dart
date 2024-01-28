import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/search_button.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/contact/model/contact_model.dart';
import 'package:co_fence/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ContactMainScreen extends ConsumerStatefulWidget {
  const ContactMainScreen({super.key});

  @override
  ConsumerState<ContactMainScreen> createState() => _ContactMainScreenState();
}

class _ContactMainScreenState extends ConsumerState<ContactMainScreen> {
  FocusNode focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    fetchContactList();
  }

  Future<List<ContactModel>> fetchContactList() async {
    final contactList =
        await ref.read(contactProvider.notifier).getContactList();
    return contactList!;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      context: context,
      appBarTitle: 'Contact',
      drawer: const MyDrawer(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchText = value;
                              });
                              print(_searchText);
                            },
                            focusNode: focusNode,
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                              hintText: 'Search',
                              hintStyle: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      SearchButton(
                        onSearchPressed: () {
                          print('search');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
