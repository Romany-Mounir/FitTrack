import 'package:fit_track/common_libs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserModel? user;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  bool isNotificationEnabled = true;
  String? selectedGender;

  // List of genders for the dropdown
  final List<String> genderList = ['Male', 'Female'];

  Future<void> getUser() async {
    user = UserManager.user;
    if (user != null) {
      nameController.text = user?.name ?? '';
      emailController.text = user?.email ?? '';
      selectedGender = user?.gender;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFf9f9f9),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0XFFf9f9f9),
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 45,
                      child: Icon(
                        CupertinoIcons.profile_circled,
                        size: 56,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          CustomTextField(
                            label: 'Name',
                            icon: Icons.person,
                            controller: nameController,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: 'Email',
                            icon: Icons.email_outlined,
                            enabled: false,
                            controller: emailController,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Gender",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                            items:
                                genderList
                                    .map(
                                      (gender) => DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      ),
                                    )
                                    .toList(),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PrimaryButton(
              text: 'Update User',
              onPressed: () {
                UserManager.instance.updateUserMetadata(
                  user: user!.copyWith(
                    name: nameController.text,
                    gender: selectedGender,
                  ),
                  context: context,
                );
              },
            ),
            const SizedBox(height: 24),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              tileColor: Colors.white,
              title: const Text("App Settings"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: const Text("Notifications"),
                value: isNotificationEnabled,
                onChanged: (val) {
                  setState(() {
                    isNotificationEnabled = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            _buildConnectGoogleFit(),
            const SizedBox(height: 12),
            _buildLogOutTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectGoogleFit() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: const Text(
          "Connect Google Fit",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        ),
        onTap: () {
          // Todo: do install health connect after succeed do authorization
        },
      ),
    );
  }

  Widget _buildLogOutTile() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: const Text(
          "Log Out",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
        onTap: () {
          UserManager.instance.signOut(context);
          AppNavigator.pushReplacement(context, AppRoutes.login);
        },
      ),
    );
  }
}
