## Chat app Project

## Please read carefully before coding and make sure you understood. Let me know if any questions

## ===================== CODING CONVENTION =====================

# Naming rules

1. UpperCamelCase: Classes, enums and types

2. lowercase_with_underscore: directories, libraries, packages, import prefixes

3. lowerCamelCase: class member, variables, parameters, constants, function

# Import Ordering

1. Dart import before other imports

2. “package” imports before relative imports

3. External package import before other imports

# Booleans

```dart
Use ?? to convert null to a boolean value

// DO
optionalThing?.isEnabled ?? false;

// DONT
optionalThing?.isEnabled == true;
```

# Strings

1. Use adjacent to concatenate the strings

```dart
// DO
message(
'If message is too long '
'please use adjacent to concatenate the strings');

// DONT
message(
'If message is too long ' +
'please use adjacent to concatenate the strings');
```

2. Prefer interpolation to compose

```dart
// DO
'I want to display amount \$amount';

// DONT
'I want to display amount' + amount.toString();
```

# Collections

1. List and Map

```dart
// DO
var lists = [];
var maps = {};
var genericLists = <Student>[];
var genericMap = <String, Student>{};

// DONT
var lists = List();
var maps = Map();
var genericLists = List<Student>();
var genericMap = Map<String, Student>();
```

2. Don’t use Length function

```dart
// DO
if (lunchBox.isEmpty) return 'so hungry...';

// DONT
if (lunchBox.length == 0) return 'so hungry...';
```

# Functions

1. Use tear-off, takes same parameters and invoke the function

```dart
// DO
names.forEach(print);

// DONT
names.forEach((name) {
   print(name);
});
```

2. Don’t use explicit default value of null

```dart
// DO
void error([String message]) {
   stderr.write(message ?? '\n');
}

// DONT
void error([String message = null]) {
   stderr.write(message ?? '\n');
}
```

# Variables

1. Don’t explicitly initialise value to null

```dart
// DO
var data;

// DONT
var data = null;
```

2. Avoid storing what you can calculate

```dart
// DO
class Circle {
   num radius;

   Circle(this.radius);

   num get area => pi _ radius _ radius;
}

// DONT

class Circle {
   num radius;
   num area;

   Circle(num radius)
      : radius = radius,
        area = pi _ radius _ radius,
}
```

3. Prefer final to make read only property

4. Consider using expression =>

5. Don’t use this if not needed. Try switch case

## ===================== WIDGETS =====================

- If the custom widget is used **in one feature**, it should be inside `/lib/features/authentication/presentation/widgets/`

- If the custom widget is used **in more than one feature**, it should be in `/lib/common/widgets/`

- Should use `NUM.w` to make adaptation with horizontal distance.

- Should use `NUM.h` to make adaptation with vertical distance

```dart
import 'package:chat_app/common/extensions/screen_utils_extensions.dart';
...
...
Container(
 height: 400.h,
 width:  100.w,
 child:  child,
);
```

## ===================== TEXT STYLE =====================

- Should use `NUM.sp` to make adaptation font size

```dart
import 'package:chat_app/common/extensions/screen_utils_extensions.dart';
...
...
Text('data', style: TextStyle(fontSize: 18.sp));
```

- We set default Muli font family in our app. Please reference in pubspec.yaml for more
  In Zeplin, designers defined typeface for text style. But you shouldn't use fontFamily name.
  So, you should use fontWeight. If you want style italic, you should use fontStyle: FontStyle.italic

# | Typeface | fontWeight |

# | Avenir-Bold | 700 |

# | Avenir-SemiBold | 600 |

# | Avenir-Medium | 500 |

# | Avenir-Regular | 400 |

Currently, We defined some common styles in `lib/common/themes/text_theme.dart`.
If you just change fontSize or color, please use copyWith func
Ex:

```dart
AppTextTheme().textStyleLabel.copyWith(fontSize: 20.sp)

```

## ===================== BLOC =====================

Our application is using flutter_bloc for state management [https://pub.dev/packages/flutter_bloc]

- Every screen has its own bloc, and should reside close to screen.
- Every widget maybe has its own bloc.
- There will be global scoped bloc e.g LoadingBloc which will decide the first screen of the app. It should be in `/lib/common/blocs/`
- Every bloc should have its own folder, include: bloc, event, state

## ===================== MULTIPLE LANGUAGES SUPPORT =====================

- We used lib [https://pub.dev/packages/flutter_translate] to transalte text by locale. Currently, we support 2 locales: `['en', 'vi']`

- Note: Every text should be defined, dont hard code. Please follow example

* Vietnamese text should be in `assets/i18n/vi.json`
* English text should be in `assets/i18n/en.json`

# Step to follow

1. Define key and values in all .json file. Key is unique for all languages
2. Define constant in `lib/common/constants/string_constants.dart`
3. Restart app

## ===================== DEPENDENCY INJECTION =====================

We're using Kiwi to implement DI [https://pub.dev/packages/kiwi]
and kiwi_generator to auto generate DI [https://pub.dev/packages/kiwi_generator]

Every module has separate methods for:

- Registering factories (if any): Factories get called every time the dependencies get resolved.
- Registering singletons (if any): Singletons get called only the first time the dependency resolution is kicked off.

# Step to follow:

1. Add your dependency(bloc, use case, repository, data source or common dependency) in `injector.dart` as follows:

```dart
   @Register.singleton(LoadingBloc)
   void _configureBlocs();
```

2. Auto generate the dependency graph code by running command

```
   flutter packages pub run build_runner build --delete-conflicting-outputs
```

- Note: `--delete-conflicting-outputs` is optional to override the conflict graph.

3. You will get a dependency graph generated in `lib/common/injector/injector.g.dart`

4. As use cases belong to domain layer and takes abstract Repository class as dependency hence in the file the`injector.g.dart`
   add the postfix `Impl` to all the repository dependency

5. In your screen or anywhere else resolve the dependency as follows:

```dart
  final loadingBloc = Injector.resolve<LoadingBloc>()
```

6. Restart app

## ===================== CLEAN ARCHITECTURE =====================

In order to keep code clean, easy to debug and maintain, our project structure follows Clean Architecture
For more information, you can follow tutorial: [https://resocoder.com/category/tutorials/flutter/tdd-clean-architecture/]

# Step to follow

- Domain Layer

1. Define Entity class
2. Define abstract Repository class.
3. Define UseCases class. An UseCase maybe have more than one Repository.

- Data Layer

1. Define models. An model should be extended from Entity
2. Define datasource. Data source maybe remote datasoure or local data source
3. Define Repository Implementation. An Repository Implementation maybe have more than one Data source

- Presentation Layer

1. Make UI for page
2. Define blocs. An bloc maybe have more than one UseCase. Also, bloc can contain other bloc, ex: LoadingBloc, AlertBloc

The last step, Make Dependency Injection. Please follow **DEPENDENCY INJECTION**

## ===================== LOGGING =====================

Use application logging instead of print statements

How to use:

```dart
LOG.verbose('Api Response'); // Verbose - Grey Color

LOG.debug('Debugging $info'); // Debug - White Color

LOG.info('Check selected data: $data'); // Info - Purple Color

LOG.warn('Receive Event', error); // Warn - Orange Color

LOG.error('Result Error', e); // Error - Red Color
```

## ===================== MERGE REQUEST TEMPLATE =====================

- Note: Each MR is not match template, you have pay 10.000 VND

1. Before creating MR, you should run

```
flutter analyze
```

This command will analyze all lint rules. It looks good if no issues found. Or else, please fix

2. Coding convention for Merge Request:

- `feature/Young-12-login`
- `bug/Young-12-fix-incorrect-label`
- `hotfix/Young-12-fix-crash`
- `improvement/Young-12-change-text`

3. In your MR, please write description:

# Ticket Links

- Ticket 1 link in Tempo

# What problem does this MR solve?

(Please summarize what's in the ticket or specification.)

# Screenshots or GIFs

(Taking a few seconds to provide images will likely save you explanation time in code-review... )
