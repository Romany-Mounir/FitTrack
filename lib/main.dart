import 'package:fit_track/app/app.dart';
import 'common_libs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xmqavodnyzlqwecuhips.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhtcWF2b2RueXpscXdlY3VoaXBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ1NzQ3ODksImV4cCI6MjA2MDE1MDc4OX0.aiGrYKOJcYHGfb8EhwVBubNzy9qxggT1IHlAV1369ig',
  );
  runApp(const FitTrackApp());
}
