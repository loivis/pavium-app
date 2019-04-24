# pavium

mobile app with Flutter

# generate files

```
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

# vscode launch configuration

to launch from different `main()` function

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Flutter",
            "request": "launch",
            "type": "dart",
            "program": "/${workspaceFolder}/lib/debug.dart"
        }
    ]
}
```
