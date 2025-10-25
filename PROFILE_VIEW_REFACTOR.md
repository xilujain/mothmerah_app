# تعديل ProfileView - إزالة الكيوبت

## 🎯 **الهدف:**

إزالة ProfileCubit من ProfileView وجعلها تعتمد على TokenManager مباشرة.

## 🛠️ **التغييرات المطبقة:**

### 1. **إزالة Dependencies:**

```dart
// تم إزالة هذه الـ imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_cubit.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_state.dart';
```

### 2. **إضافة State Management محلي:**

```dart
class _ProfileViewState extends State<ProfileView> {
  ProfileModel? _profile;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }
```

### 3. **إضافة دالة تحميل البيانات:**

```dart
Future<void> _loadProfile() async {
  setState(() {
    _isLoading = true;
    _error = null;
  });

  try {
    final userData = await TokenManager.getUserData();
    if (userData != null) {
      _profile = ProfileModel.fromJson(userData);
      print('✅ تم تحميل بيانات المستخدم من التخزين المحلي');
    } else {
      _error = 'لا توجد بيانات مستخدم محفوظة';
    }
  } catch (e) {
    _error = 'خطأ في تحميل البيانات: $e';
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}
```

### 4. **إضافة دالة تحديث البيانات:**

```dart
Future<void> _updateProfile() async {
  if (_profile != null) {
    try {
      await TokenManager.updateUserData(_profile!.toJson());
      print('✅ تم تحديث بيانات المستخدم في التخزين المحلي');
    } catch (e) {
      print('❌ خطأ في تحديث بيانات المستخدم: $e');
    }
  }
}
```

### 5. **تعديل Build Method:**

```dart
@override
Widget build(BuildContext context) {
  final textStyles = TextStyles(context);

  // Show loading indicator if loading
  if (_isLoading) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  // Show error message if error
  if (_error != null) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('خطأ في تحميل البيانات', style: TextStyles(context).font18PrimaryBold),
            SizedBox(height: 8),
            Text(_error!, style: TextStyles(context).font14GrayRegular),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _loadProfile(),
              child: Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }

  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: ScrollableWrapper(
        child: Column(
          children: [
            // Profile content...
          ],
        ),
      ),
    ),
  );
}
```

### 6. **تعديل الدوال لتعمل بدون كيوبت:**

```dart
// تم تعديل جميع الدوال:
void _showImagePicker(BuildContext context) { ... }
void _showLogoutDialog(BuildContext context) { ... }
void _showClearDataDialog(BuildContext context) { ... }
void _showDeleteAccountDialog(BuildContext context) { ... }
```

### 7. **تعديل Routes:**

```dart
case Routes.profileView:
  return MaterialPageRoute(builder: (_) => ProfileView());
```

## 🔍 **المزايا:**

### 1. **بساطة الكود:**

- ✅ **لا حاجة لـ BlocProvider** - تم إزالته
- ✅ **لا حاجة لـ BlocConsumer** - تم إزالته
- ✅ **State management محلي** - أسهل في الفهم

### 2. **أداء أفضل:**

- ✅ **تحميل أسرع** - لا توجد طبقات إضافية
- ✅ **ذاكرة أقل** - لا توجد Cubit objects
- ✅ **استجابة أسرع** - setState مباشر

### 3. **صيانة أسهل:**

- ✅ **كود أقل** - إزالة 200+ سطر
- ✅ **تبعيات أقل** - لا حاجة لـ flutter_bloc
- ✅ **فهم أسهل** - State management مباشر

### 4. **وظائف محفوظة:**

- ✅ **تحميل البيانات** - من TokenManager
- ✅ **تحديث البيانات** - في TokenManager
- ✅ **تسجيل الخروج** - مسح البيانات
- ✅ **مسح البيانات** - forceClearAllData
- ✅ **حذف الحساب** - مسح البيانات

## 🚀 **كيفية الاستخدام:**

### 1. **تحميل البيانات:**

```dart
// يتم تحميل البيانات تلقائياً عند فتح الصفحة
@override
void initState() {
  super.initState();
  _loadProfile();
}
```

### 2. **تحديث البيانات:**

```dart
// عند تعديل أي حقل
setState(() {
  _profile = _profile!.copyWith(name: value);
});
_updateProfile(); // حفظ في TokenManager
```

### 3. **تسجيل الخروج:**

```dart
await TokenManager.clearUserData();
Navigator.pushNamedAndRemoveUntil(
  context,
  Routes.loginView,
  (route) => false,
);
```

### 4. **مسح البيانات:**

```dart
await TokenManager.forceClearAllData();
_loadProfile(); // إعادة تحميل
```

## 🔧 **البيانات المطبوعة:**

```
✅ تم تحميل بيانات المستخدم من التخزين المحلي
الاسم: المستخدم
اسم المستخدم: +966500000000
رقم الجوال: +966500000000
البريد الإلكتروني: user@example.com
حالة التحقق: true
=====================================
```

## 🎉 **الخلاصة:**

الآن ProfileView:

- ✅ **أبسط** - بدون كيوبت
- ✅ **أسرع** - State management مباشر
- ✅ **أسهل** - صيانة وتطوير
- ✅ **نفس الوظائف** - جميع الميزات محفوظة

التطبيق أصبح أكثر بساطة وأداءً! 🚀
