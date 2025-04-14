import '../common_libs.dart';

class UserManager {
  // Private constructor to prevent instantiation
  UserManager._();

  // Singleton instance
  static final UserManager instance = UserManager._();

  static UserModel? user;

  final SupabaseClient supabase = Supabase.instance.client;
  final Logger _logger = Logger();

  // Base function to handle requests and error logging
  Future<T?> baseRequest<T>({
    required Future<dynamic> request,
    required BuildContext context,
    String? successMessage,
  }) async {
    try {
      final response = await request;
      // Optionally show success message
      if (successMessage != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(successMessage)));
        }
      }
      return response as T?;
    } catch (e) {
      // Log the error
      _logger.e('Exception: $e');

      // Show exception SnackBar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred')),
        );
      }
      return null;
    }
  }

  // Sign up function
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
    required String gender,
    required BuildContext context,
  }) async {
    final response = await baseRequest<Map<String, dynamic>>(
      request: supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name, 'gender': gender},
      ),
      context: context,
    );

    if (response == null) {
      return null;
    }

    // On successful sign-up, fetch user details
    return fetchUserFromSupabase();
  }

  // Sign in function
  Future<UserModel?> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final response = await baseRequest<Map<String, dynamic>>(
      request: supabase.auth.signInWithPassword(
        email: email,
        password: password,
      ),
      context: context,
    );

    if (response == null) {
      return null;
    }

    // On successful sign-in, fetch user details
    return fetchUserFromSupabase();
  }

  // Sign out function
  Future<void> signOut(BuildContext context) async {
    await baseRequest<void>(request: supabase.auth.signOut(), context: context);
    _logger.i('Successfully signed out');
  }

  // Fetch the user from Supabase after sign-in or sign-up
  Future<UserModel?> fetchUserFromSupabase() async {
    UserResponse? userResponse;
    try {
      userResponse = await supabase.auth.getUser();
    } catch (e) {
      _logger.e('Error fetching user: $e');
      return null;
    }

    user = UserModel.fromSupabase(userResponse.user?.toJson() ?? {});

    // Convert Supabase user to custom UserModel
    return user;
  }

  // Update user metadata (name and gender)
  Future<void> updateUserMetadata({
    required UserModel user,
    required BuildContext context,
  }) async {
    final UserResponse? response = await baseRequest<UserResponse>(
      request: supabase.auth.updateUser(
        UserAttributes(data: {'name': user.name, 'gender': user.gender}),
      ),
      context: context,
      successMessage: 'User metadata updated',
    );

    if (response?.user != null) {
      _logger.i('User metadata updated');
    }
  }
}
