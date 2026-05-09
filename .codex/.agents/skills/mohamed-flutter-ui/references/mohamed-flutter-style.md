# Mohamed Flutter Style Reference

This is a reusable coding style for Flutter projects.

Do not copy project-specific package names from examples.
Adapt:
- package imports
- feature names
- route names
- entity names
- custom widget names
- service/repo names

Keep the structure and coding style the same.

---

# 1. Feature Structure

Preferred structure:

```text
features/<feature>/
  data/
    models/
    repos/ or repositories/
    datasources/ or services/
  domain/
    entities/
    repos/ or repositories/
  presentation/
    cubits/
      <action>/
        <action>_cubit.dart
        <action>_state.dart
    views/
      <name>_view.dart
    widgets/
      <name>_view_body_bloc_consumer.dart
      <name>_view_body.dart
```

Rules:
- Preserve existing folder names in the current project.
- If the project uses `domain/entities`, use that.
- If the project uses `doman/entites`, preserve that spelling instead of renaming.
- Do not silently restructure the whole project.

---

# 2. UI Composition Pattern

Every important screen should be split into:

```text
<Name>View
<Name>ViewBodyBlocConsumer
<Name>ViewBody
```

## View

Responsibilities:
- `StatelessWidget`
- owns `BlocProvider` when needed
- owns `Scaffold`
- owns app bar
- body points to `<Name>ViewBodyBlocConsumer` or `<Name>ViewBody`

Example:

```dart
class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static const route = "signin";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context, title: "تسجيل الدخول"),
        body: const SigninViewBodyBlocConsumer(),
      ),
    );
  }
}
```

If the project does not have `buildAppBar`, use the existing app bar style or create a small reusable helper/widget if needed.

## ViewBodyBlocConsumer

Responsibilities:
- owns `BlocConsumer`
- handles snackbars
- handles navigation
- wraps body with loading overlay/HUD if available

Example:

```dart
class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninErrorState) {
          buildsnakbar(context, state.message, Colors.red);
        } else if (state is SigninSuccessState) {
          buildsnakbar(context, 'تم تسجيل الدخول بنجاح', Colors.green);
          Navigator.pushNamed(context, HomeView.route);
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is SigninLoadingState ? true : false,
          child: const SigninViewBody(),
        );
      },
    );
  }
}
```

If `CustomProgressHUD` does not exist, create a small reusable loading wrapper or use the existing loading style.

## ViewBody

Responsibilities:
- owns the visual layout
- owns form state when needed
- uses reusable widgets
- does not handle success navigation or global side effects

Example:

```dart
class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  late String email, password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(height: 24),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                keyboardType: TextInputType.emailAddress,
                hintText: "البريد الالكتروني",
              ),
              const SizedBox(height: 16),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<SigninCubit>().signin(email, password);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: "تسجيل الدخول",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

Rules:
- Do not put `View`, `ViewBodyBlocConsumer`, and `ViewBody` in the same file.
- Prefer `onSaved` and `FormState.save()` for simple forms.
- Use controllers only when the UI needs live text access.
- Keep validation local to UI.

---

# 3. Cubit and State Pattern

Use two files:

```text
<action>_cubit.dart
<action>_state.dart
```

## Cubit

```dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '<action>_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());

  final AuthRepo authRepo;

  Future<void> signin(String email, String password) async {
    emit(SigninLoadingState());
    final result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(SigninErrorState(failure.message)),
      (user) => emit(SigninSuccessState(user)),
    );
  }
}
```

Rules:
- Use `part`.
- Cubit receives an abstract repo through constructor.
- Cubit calls repo/use case according to the current project style.
- Cubit emits loading before async work.
- Cubit uses `result.fold`.
- Cubit does not access Firebase/API/database directly.
- Cubit contains no UI code.

## State

```dart
part of '<action>_cubit.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninLoadingState extends SigninState {}

final class SigninSuccessState extends SigninState {
  SigninSuccessState(this.userEntity);

  final UserEntity userEntity;
}

final class SigninErrorState extends SigninState {
  SigninErrorState(this.message);

  final String message;
}
```

Rules:
- Use `part of`.
- Use `@immutable`.
- Use `sealed class`.
- Use `final class` for concrete states.
- State names end with `State`.
- Error state contains `message`.
- Success state contains the returned entity/data.

---

# 4. Repository Pattern

Preferred domain repo:

```dart
abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
}
```

Preferred implementation:

```dart
class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({
    required this.authService,
    required this.databaseService,
  });

  final AuthService authService;
  final DatabaseService databaseService;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log("Exception AuthRepoImpl - signInWithEmailAndPassword: $e");
      return left(ServerFailure("حدث خطأ ما. الرجاء المحاولة مرة أخرى."));
    }
  }
}
```

Rules:
- Abstract repo lives in domain.
- Implementation lives in data.
- Repo returns `Either<Failure, Entity>`.
- Repo catches known custom exceptions.
- Repo logs unknown errors.
- Repo returns Arabic fallback message for unknown errors when matching Arabic apps.
- Repo coordinates services and data conversion.
- Avoid putting UI-specific logic in repo.

---

# 5. Entity and Model Pattern

Entity:

```dart
class UserEntity {
  UserEntity({
    required this.name,
    required this.email,
    required this.uId,
  });

  final String name;
  final String email;
  final String uId;

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
    };
  }
}
```

Model:

```dart
class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.uId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      uId: json['uId'] ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      uId: user.uId,
    );
  }

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
    };
  }
}
```

Rules:
- Model extends entity.
- Use factories for conversion.
- Use `toMap()` for persistence payloads.

---

# 6. Error Pattern

```dart
class CustomException implements Exception {
  CustomException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
```

Rules:
- Services throw `CustomException`.
- Repos catch `CustomException`.
- Repos return `ServerFailure(e.message)`.
- UI receives failure message through Cubit state.
- UI shows message in snackbar/helper.

---

# 7. Custom Widgets Rule

When available, reuse existing widgets:
- `CustomButton`
- `CustomTextFormField`
- `PasswordField`
- `CustomProgressHUD`
- `buildAppBar`
- `buildsnakbar`

If they do not exist:
- create equivalent reusable widgets only if needed
- keep them small
- place them in `core` if shared across features
- place them in feature `widgets/` if feature-specific
