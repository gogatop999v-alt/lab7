# Lab 7 (без Firebase)

Flutter-приложение: форма регистрации -> данные сохраняются локально
(`shared_preferences`) -> показывается локальное push-уведомление
(`flutter_local_notifications`).

## Запуск
1. Установите Flutter SDK.
2. В папке проекта выполните:
   ```
   flutter create .
   flutter pub get
   ```
3. Настройте Android (см. ниже), затем `flutter run`.

## Настройка Android
`android/app/build.gradle(.kts)`:
- в `compileOptions` добавить `coreLibraryDesugaringEnabled = true`
- в `dependencies` добавить
  `coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")`

`android/app/src/main/AndroidManifest.xml` (внутри `<manifest>`, перед `<application>`):
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```
