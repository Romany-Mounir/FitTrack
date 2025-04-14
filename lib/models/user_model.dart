class UserModel {
  final String id;
  final String email;
  final String? name;
  final String gender;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    required this.gender,
    this.createdAt,
  });

  // Convert from Supabase User Model to UserModel
  factory UserModel.fromSupabase(Map<String, dynamic>? supabaseUser) {
    return UserModel(
      id: supabaseUser?['id'] ?? '',
      email: supabaseUser?['email'] ?? '',
      name: supabaseUser?['user_metadata']['name'] ?? '',
      gender: supabaseUser?['user_metadata']['gender'] ?? '',
      createdAt:
          supabaseUser?['created_at'] != null
              ? DateTime.parse(supabaseUser!['created_at'])
              : null,
    );
  }

  // Convert from UserModel to Supabase User Model
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'email': email,
      'user_metadata': {'name': name, 'gender': gender},
      'created_at': createdAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? gender,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }
}
