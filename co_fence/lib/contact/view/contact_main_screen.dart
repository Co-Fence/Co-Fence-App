import 'package:co_fence/common/components/my_drawer.dart';
import 'package:co_fence/common/components/my_elevated_button.dart';
import 'package:co_fence/common/components/search_button.dart';
import 'package:co_fence/common/layout/default_layout.dart';
import 'package:co_fence/contact/model/contact_model.dart';
import 'package:co_fence/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMainScreen extends ConsumerStatefulWidget {
  const ContactMainScreen({super.key});

  @override
  ConsumerState<ContactMainScreen> createState() => _ContactMainScreenState();
}

class _ContactMainScreenState extends ConsumerState<ContactMainScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  late Future<List<ContactModel>> contactListFuture;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    contactListFuture = fetchContactList();
  }

  Future<List<ContactModel>> fetchContactList() async {
    final list = await ref.read(contactProvider.notifier).getContactList();
    return list!;
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
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            focusNode: focusNode,
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                              hintText: 'Enter name',
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
                        onSearchPressed: () async {
                          final resp = await ref
                              .read(contactProvider.notifier)
                              .searchContactList(
                                userName: _textEditingController.text,
                              );
                          if (resp != null) {
                            setState(() {
                              contactListFuture = Future.value(resp);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: SizedBox(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                  },
                  border: TableBorder.all(
                    color: const Color.fromARGB(255, 12, 12, 12),
                  ),
                  children: const [
                    TableRow(children: [
                      SizedBox(
                        height: 50,
                        width: 60,
                        child: Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 60,
                        child: Center(
                          child: Text(
                            'Profile Image',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Text(
                            'Role',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder(
                future: contactListFuture,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return const Text('No data available');
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data[index] as ContactModel;
                        return GestureDetector(
                          onTap: () {
                            _showAdditionalInfoDialog(data.userId);
                          },
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(1),
                            },
                            border: TableBorder.all(
                              color: const Color.fromARGB(255, 12, 12, 12),
                            ),
                            children: [
                              TableRow(children: [
                                SizedBox(
                                  height: 50,
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      data.userName,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                  width: 60,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.photo_size_select_actual),
                                      Gap(10.0),
                                      Text(
                                        'Image File',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      data.roleType.displayName,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAdditionalInfoDialog(int userId) async {
    final data = await ref
        .read(contactProvider.notifier)
        .getContactDetail(userId: userId);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CircleAvatar(
            radius: 120.0,
            backgroundImage: NetworkImage(
              data!.profileImageUrl,
            ),
          ),
          content: Text(
            'User Name: ${data.name}\nNationality: Korean\nRole: ${data.roleType.displayName}\nPhone Number: ${data.phoneNumber}',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          actions: [
            MyElevatedButton(
              buttonText: 'Call',
              onPressed: () async {
                final url = Uri.parse('tel:010-5047-9453');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  context.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
