# Model Test Generation using Mason
## Getting Started
To get started, follow these steps:

### Step 1: Create a Dart Package
Use the [very_good_cli](https://pub.dev/packages/very_good_cli) to create a Dart package (or other preferred method):

```bash
very_good create dart_package example
```

Replace `example` with your desired package name.

### Step 2: Create a Simple Model
Create a simple Dart model inside the `lib` folder. For example, create a `person.dart` file with the following content:

```dart
class Person {
  const Person(this.name);

  final String name;
}
```

### Step 3: Initialize Mason
Initialize [mason](https://pub.dev/packages/mason) within your Dart package:

```bash
mason init
```

### Step 4: Add the Model Test Brick
Edit the `mason.yaml` file and add the following configuration to include the Mason brick for generating tests:

```yaml
bricks:
  model_test_brick:
    path: <path_to_brick>
```

Replace `<path_to_brick>` with the relative path to your Mason brick.

### Step 5: Generate Tests with Mason
Run the following command to generate tests using the Mason brick:

```bash
mason make model_test_brick
```

Mason will prompt you to provide the path to the file you want to test and the name of the class.

### Step 6: Review Generated Test
After running the above command, you will have a newly generated test file. The generated test should look similar to this:

```dart
void main() {
  group('Person', () {
    test('can instantiate', () {
      expect(
        Person('name'),
        isNotNull,
      );
    });
  });
}
```