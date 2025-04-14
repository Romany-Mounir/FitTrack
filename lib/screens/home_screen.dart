//
// import 'package:fit_track/screens/profile_page.dart';
//
//
// import '../common_libs.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   void _signOut(BuildContext context) async {
//     await Supabase.instance.client.auth.signOut();
//     if (context.mounted) {
//       AppNavigator.push(context, AppRoutes.login);
//     }
//   }
//
//   final user = Supabase.instance.client.auth.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FitTrack Home'),
//         actions: [
//           IconButton(
//             onPressed: () => _signOut(context),
//             icon: const Icon(Icons.logout),
//           ),
//           IconButton(
//             onPressed:
//                 () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => ProfilePage()),
//                 ),
//             icon: const Icon(CupertinoIcons.person),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome, ${user?.email ?? 'User'}',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'This is your fitness dashboard. 🎯',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 40),
//             const Center(child: Text('💪 Health Connect data coming soon...')),
//           ],
//         ),
//       ),
//     );
//   }
// }
