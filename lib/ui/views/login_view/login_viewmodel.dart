import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/app/locator.dart';
import 'package:tracking_app/helpers/constants/routes_name.dart';
import 'package:tracking_app/services/app_services/auth_service.dart';

class LoginViewModel extends ReactiveViewModel implements Initialisable {
  final _authService = locator<AuthService>();
  Future<void> loginWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
    );
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          _authService.setSignInAccount(userCredential.user);
          locator<GoRouter>().go(AppRoutes.homeView);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // handle the error here
            print("Already exists");
          } else if (e.code == 'invalid-credential') {
            // handle the error here
            print("Already Invalid");
          }
        } catch (e) {
          // handle the error here
        }
      }
    } catch (e) {
      print("${e}");
    }
  }

  Future<UserCredential> signInWithGitHub() async {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }

  @override
  void initialise() {
    // _googleSignIn.onCurrentUserChanged.listen((account) {
    //   print("started here3");
    //   _authService.setSignInAccount(account);
    //   if (_authService.currentGoogleUser != null) {
    //     print("User is already Authenticated");
    //   }
    // });
    // _googleSignIn.signInSilently();
  }

  @override
  // TODO: implement reactiveServices
  List<ListenableServiceMixin> get listenableServices => [_authService];
}
