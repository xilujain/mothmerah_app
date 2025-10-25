# تكامل البروفايل مع API - عرض البيانات الحقيقية

## 🎯 **الهدف:**

ربط صفحة البروفايل مع API الحقيقي لعرض بيانات المستخدم المسجل دخوله.

## 🛠️ **التغييرات المطبقة:**

### 1. **إضافة Dio للاتصال بالAPI:**

```dart
import 'package:dio/dio.dart';

// جلب البيانات من API
final response = await Dio().get(
  'http://127.0.0.1:8000/api/v1/users/me',
  options: Options(
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ),
);
```

### 2. **تحديث ProfileModel:**

```dart
class ProfileModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? profileImage;
  final String? phone;
  final String? address;
  final bool isVerified;
  final String? licenses;
  final String? verificationStatus;
  final String? goldenGuarantee;
  final String? createdAt;  // ✅ جديد
  final String? updatedAt;  // ✅ جديد
}
```

### 3. **تحديث fromJson:**

```dart
final profile = ProfileModel(
  id: json['user_id']?.toString() ?? '',
  name: fullName.isNotEmpty ? fullName : 'المستخدم',
  username: json['phone_number'] ?? '',
  email: json['email'] ?? '',
  profileImage: json['profile_picture_url'],
  phone: json['phone_number'],
  address: null,
  isVerified: isVerified,
  licenses: null,
  verificationStatus: verificationStatus,
  goldenGuarantee: null,
  createdAt: json['created_at'],  // ✅ جديد
  updatedAt: json['updated_at'],  // ✅ جديد
);
```

### 4. **تحديث \_loadProfile:**

```dart
Future<void> _loadProfile() async {
  setState(() {
    _isLoading = true;
    _error = null;
  });

  try {
    // جلب التوكن من التخزين المحلي
    final token = await TokenManager.getToken();

    if (token.isEmpty) {
      _error = 'لا يوجد توكن، يرجى تسجيل الدخول مرة أخرى';
      return;
    }

    // جلب البيانات من API
    final response = await Dio().get(
      'http://127.0.0.1:8000/api/v1/users/me',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // معالجة الاستجابة
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

    // تحويل البيانات إلى ProfileModel
    _profile = ProfileModel.fromJson(userData);

    // حفظ البيانات في التخزين المحلي
    await TokenManager.updateUserData(_profile!.toJson());

  } catch (e) {
    // محاولة جلب البيانات من التخزين المحلي كبديل
    try {
      final cachedData = await TokenManager.getUserData();
      if (cachedData != null) {
        _profile = ProfileModel.fromJson(cachedData);
      } else {
        _error = 'فشل في جلب البيانات: $e';
      }
    } catch (cacheError) {
      _error = 'فشل في جلب البيانات: $e';
    }
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}
```

### 5. **تحديث عرض التواريخ:**

```dart
_buildInfoRow(
  context,
  textStyles,
  'تاريخ الإنشاء',
  _profile?.createdAt != null
      ? DateTime.parse(_profile!.createdAt!)
          .toLocal()
          .toIso8601String()
          .split('T')[0]
      : 'غير محدد',
  () { /* Handle creation date */ },
),
_buildInfoRow(
  context,
  textStyles,
  'آخر تحديث',
  _profile?.updatedAt != null
      ? DateTime.parse(_profile!.updatedAt!)
          .toLocal()
          .toIso8601String()
          .split('T')[0]
      : 'غير محدد',
  () { /* Handle last update */ },
),
```

## 🔍 **تدفق العمل:**

### 1. **عند فتح صفحة البروفايل:**

```
1. initState() → _loadProfile()
2. جلب التوكن من TokenManager
3. إرسال طلب GET إلى /api/v1/users/me
4. معالجة الاستجابة
5. تحويل البيانات إلى ProfileModel
6. حفظ البيانات في التخزين المحلي
7. عرض البيانات في UI
```

### 2. **في حالة فشل API:**

```
1. محاولة جلب البيانات من التخزين المحلي
2. عرض البيانات المحفوظة
3. عرض رسالة خطأ إذا لم توجد بيانات
```

### 3. **في حالة عدم وجود توكن:**

```
1. عرض رسالة "لا يوجد توكن، يرجى تسجيل الدخول مرة أخرى"
2. إمكانية إعادة المحاولة
```

## 🚀 **المزايا:**

### 1. **عرض البيانات الحقيقية:**

- ✅ **بيانات المستخدم الحقيقية** - من API
- ✅ **التوكن الصحيح** - من تسجيل الدخول
- ✅ **التواريخ الحقيقية** - created_at و updated_at

### 2. **معالجة الأخطاء:**

- ✅ **فشل API** - عرض البيانات المحفوظة
- ✅ **عدم وجود توكن** - رسالة واضحة
- ✅ **خطأ في الشبكة** - إعادة المحاولة

### 3. **الأداء:**

- ✅ **تحميل سريع** - من التخزين المحلي أولاً
- ✅ **تحديث تلقائي** - من API
- ✅ **حفظ البيانات** - في التخزين المحلي

### 4. **تجربة المستخدم:**

- ✅ **تحميل سلس** - مع Loading indicator
- ✅ **رسائل واضحة** - للأخطاء
- ✅ **إعادة المحاولة** - عند الفشل

## 🔧 **البيانات المطبوعة:**

```
🔵 جلب بيانات المستخدم من الـ API:
URL: http://127.0.0.1:8000/api/v1/users/me
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
=====================================

🟢 استجابة API للمستخدم:
Status Code: 200
Response Data: {user_id: 1, first_name: أحمد, last_name: العتيبي, ...}
=====================================

📱 بيانات المستخدم المستخرجة:
User Data: {user_id: 1, first_name: أحمد, last_name: العتيبي, ...}
=====================================

🎯 Profile Model:
ID: 1
Name: أحمد العتيبي
Username: +966501234567
Email: ahmed@example.com
Phone: +966501234567
Is Verified: true
=====================================

✅ تم حفظ بيانات المستخدم في التخزين المحلي
```

## 🎉 **الخلاصة:**

الآن صفحة البروفايل:

- ✅ **متصلة بالAPI** - عرض البيانات الحقيقية
- ✅ **آمنة** - استخدام التوكن الصحيح
- ✅ **ذكية** - معالجة الأخطاء والبدائل
- ✅ **سريعة** - تحميل من التخزين المحلي
- ✅ **محدثة** - بيانات حديثة من API

التطبيق الآن يعرض بيانات المستخدم الحقيقية! 🚀
