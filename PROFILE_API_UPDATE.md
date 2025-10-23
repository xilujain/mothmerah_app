# تحديث API endpoint لبيانات المستخدم

## 🎯 **الهدف:**

تحديث ProfileRepository لاستخدام الراوت الجديد `http://127.0.0.1:8000/api/v1/users/me` لجلب بيانات المستخدم.

## 🛠️ **التحديثات المطبقة:**

### 1. **تحديث ProfileRepository:**

#### **تغيير الراوت:**

```dart
// قبل
final response = await _dio.get(
  '/api/v1/me/profile',
  options: Options(
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  ),
);

// بعد
final response = await _dio.get(
  'http://127.0.0.1:8000/api/v1/users/me',
  options: Options(
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  ),
);
```

#### **معالجة البيانات المحسنة:**

```dart
// معالجة الاستجابة - قد تكون البيانات مباشرة أو داخل 'data'
Map<String, dynamic> userData;
if (response.data is Map<String, dynamic>) {
  if (response.data.containsKey('data')) {
    userData = response.data['data'];
  } else {
    userData = response.data;
  }
} else {
  throw Exception('تنسيق البيانات غير صحيح');
}
```

#### **Debugging مفصل:**

```dart
print('🔵 جلب بيانات المستخدم من الـ API:');
print('URL: http://127.0.0.1:8000/api/v1/users/me');
print('Headers: {\'Authorization\': \'Bearer $token\', \'Content-Type\': \'application/json\'}');
print('=====================================');

print('🟢 استجابة API للمستخدم:');
print('Status Code: ${response.statusCode}');
print('Response Data: ${response.data}');
print('Response Data Type: ${response.data.runtimeType}');
print('=====================================');

print('📱 بيانات المستخدم المستخرجة:');
print('User Data: $userData');
print('=====================================');

print('🎯 Profile Model:');
print('ID: ${profile.id}');
print('Name: ${profile.name}');
print('Username: ${profile.username}');
print('Email: ${profile.email}');
print('Phone: ${profile.phone}');
print('Is Verified: ${profile.isVerified}');
print('=====================================');
```

### 2. **تحديث ProfileCubit:**

#### **تحسين رسائل التحديث:**

```dart
print('🔄 محاولة تحديث البيانات من الـ API...');
final profile = await _repository.getProfile();
_currentProfile = profile;

// Update cached data
await TokenManager.updateUserData(profile.toJson());

emit(ProfileLoaded(profile));
print('✅ تم تحديث بيانات المستخدم من الـ API بنجاح');
print('الاسم الجديد: ${profile.name}');
print('اسم المستخدم الجديد: ${profile.username}');
print('رقم الجوال الجديد: ${profile.phone}');
print('البريد الإلكتروني الجديد: ${profile.email}');
print('حالة التحقق الجديدة: ${profile.isVerified}');
print('=====================================');
```

## 🔍 **البيانات المطبوعة الآن:**

### **عند جلب البيانات من الـ API:**

```
🔵 جلب بيانات المستخدم من الـ API:
URL: http://127.0.0.1:8000/api/v1/users/me
Headers: {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...', 'Content-Type': 'application/json'}
=====================================

🟢 استجابة API للمستخدم:
Status Code: 200
Response Data: {id: 1, name: المستخدم, username: +966500000000, email: user@example.com, phone: +966500000000, is_verified: true, ...}
Response Data Type: _Map<String, dynamic>
=====================================

📱 بيانات المستخدم المستخرجة:
User Data: {id: 1, name: المستخدم, username: +966500000000, email: user@example.com, phone: +966500000000, is_verified: true, ...}
=====================================

🎯 Profile Model:
ID: 1
Name: المستخدم
Username: +966500000000
Email: user@example.com
Phone: +966500000000
Is Verified: true
=====================================
```

### **عند تحديث البيانات:**

```
🔄 محاولة تحديث البيانات من الـ API...
✅ تم تحديث بيانات المستخدم من الـ API بنجاح
الاسم الجديد: المستخدم
اسم المستخدم الجديد: +966500000000
رقم الجوال الجديد: +966500000000
البريد الإلكتروني الجديد: user@example.com
حالة التحقق الجديدة: true
=====================================
```

## 🎯 **المزايا:**

### 1. **الراوت الصحيح:**

- ✅ استخدام `http://127.0.0.1:8000/api/v1/users/me`
- ✅ متوافق مع Backend API
- ✅ جلب البيانات الصحيحة

### 2. **معالجة البيانات المرنة:**

- ✅ يدعم البيانات المباشرة
- ✅ يدعم البيانات داخل `data` field
- ✅ معالجة أخطاء شاملة

### 3. **Debugging شامل:**

- ✅ طباعة URL والـ Headers
- ✅ طباعة الاستجابة الكاملة
- ✅ طباعة البيانات المستخرجة
- ✅ طباعة Profile Model النهائي

### 4. **معالجة الأخطاء:**

- ✅ معالجة 401 (انتهاء صلاحية التوكن)
- ✅ معالجة أخطاء الخادم
- ✅ معالجة أخطاء الاتصال
- ✅ رسائل خطأ واضحة

## 🚀 **كيفية الاختبار:**

### 1. **شغل التطبيق:**

```bash
flutter run
```

### 2. **سجل الدخول:**

- رقم الجوال: `+966500000000`
- كلمة المرور: `admin_password_123`

### 3. **انتقل لصفحة البروفايل:**

- ستجد البيانات المحفوظة محلياً تظهر فوراً
- ثم محاولة تحديث من الـ API الجديد

### 4. **راقب Console:**

- ستجد رسائل مفصلة عن جلب البيانات
- ستجد تفاصيل الاستجابة من الـ API
- ستجد البيانات المستخرجة والمعالجة

## 🔧 **ملاحظات مهمة:**

### 1. **الراوت الجديد:**

- `http://127.0.0.1:8000/api/v1/users/me`
- يتطلب Authorization header
- يعيد بيانات المستخدم الكاملة

### 2. **معالجة البيانات:**

- يدعم تنسيقات مختلفة للاستجابة
- يتحقق من وجود `data` field
- يستخرج البيانات بشكل صحيح

### 3. **التحديث التلقائي:**

- البيانات المحفوظة تظهر فوراً
- محاولة تحديث من الـ API في الخلفية
- حفظ البيانات المحدثة محلياً

## 🎉 **الخلاصة:**

الآن ProfileRepository:

- ✅ يستخدم الراوت الصحيح
- ✅ يجلب البيانات من الـ API الجديد
- ✅ يعالج البيانات بمرونة
- ✅ يوفر debugging شامل
- ✅ يتعامل مع الأخطاء بشكل صحيح

هذا يضمن جلب بيانات المستخدم الصحيحة من الـ API! 🚀
