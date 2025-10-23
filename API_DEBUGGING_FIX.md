# إصلاح مشكلة API - تسجيل الدخول

## 🚨 **المشكلة:**

```
Response Data: {detail: [{type: missing, loc: [body, username], msg: Field required, input: null}, {type: missing, loc: [body, password], msg: Field required, input: null}]}
```

## 🔍 **تحليل المشكلة:**

الـ API يتوقع البيانات في `body` لكن يبدو أن البيانات لا تصل بشكل صحيح أو تكون `null`.

## 🛠️ **الحلول المطبقة:**

### 1. **تحسين Headers:**

```dart
options: Options(
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
),
```

### 2. **إضافة LogInterceptor للـ Debugging:**

```dart
_dio.interceptors.add(LogInterceptor(
  requestBody: true,
  responseBody: true,
  requestHeader: true,
  responseHeader: true,
  logPrint: (obj) => print('🌐 Dio Log: $obj'),
));
```

### 3. **تحسين Validation:**

```dart
// Additional validation
if (state.phoneNumber.trim().isEmpty) {
  emit(state.copyWith(error: 'رقم الجوال فارغ', isLoading: false));
  return;
}

if (state.password.trim().isEmpty) {
  emit(state.copyWith(error: 'كلمة المرور فارغة', isLoading: false));
  return;
}
```

### 4. **إضافة المزيد من Debugging:**

```dart
// في SignInCubit
print('📱 بيانات تسجيل الدخول:');
print('رقم الجوال: "${state.phoneNumber}"');
print('كلمة المرور: "${state.password}"');
print('طول رقم الجوال: ${state.phoneNumber.length}');
print('طول كلمة المرور: ${state.password.length}');

// في LoginRepository
print('🔍 التحقق من البيانات:');
print('username: "${requestData['username']}"');
print('password: "${requestData['password']}"');
print('grant_type: "${requestData['grant_type']}"');
```

## 🔧 **خطوات التشخيص:**

### 1. **شغل التطبيق:**

```bash
flutter run
```

### 2. **افتح صفحة تسجيل الدخول**

### 3. **أدخل البيانات:**

- رقم الجوال: `+966500000000`
- كلمة المرور: `admin_password_123`

### 4. **راقب Console:**

ستظهر الآن معلومات مفصلة:

```
📱 بيانات تسجيل الدخول:
رقم الجوال: "+966500000000"
كلمة المرور: "admin_password_123"
طول رقم الجوال: 13
طول كلمة المرور: 19
Request Model: {username: +966500000000, password: admin_password_123, grant_type: password}
Request Model Type: _Map<String, dynamic>
=====================================

🔵 البيانات المرسلة للـ API:
URL: http://127.0.0.1:8000/api/v1/auth/login
Headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
Request Data: {username: +966500000000, password: admin_password_123, grant_type: password}
Data Type: _Map<String, dynamic>
=====================================

🔍 التحقق من البيانات:
username: "+966500000000"
password: "admin_password_123"
grant_type: "password"
=====================================

🌐 Dio Log: --> POST http://127.0.0.1:8000/api/v1/auth/login
🌐 Dio Log: --> Headers:
🌐 Dio Log: content-type: application/json
🌐 Dio Log: accept: application/json
🌐 Dio Log: --> Body:
🌐 Dio Log: {"username":"+966500000000","password":"admin_password_123","grant_type":"password"}
```

## 🎯 **النتيجة المتوقعة:**

بعد هذه التحسينات، يجب أن تظهر البيانات بشكل صحيح في الـ API. إذا استمرت المشكلة، فستظهر في console معلومات مفصلة تساعد في تحديد السبب:

### **إذا كانت البيانات تصل بشكل صحيح:**

```
🟢 الاستجابة من الـ API:
Status Code: 200
Response Data: {access_token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..., token_type: bearer}
```

### **إذا استمرت المشكلة:**

ستظهر معلومات مفصلة عن:

- البيانات المرسلة
- Headers المستخدمة
- استجابة الـ API
- أي أخطاء في الشبكة

## 🔍 **أسباب محتملة للمشكلة:**

1. **البيانات فارغة** - سيظهر في console
2. **مشكلة في Headers** - سيظهر في Dio Log
3. **مشكلة في الـ API** - سيظهر في الاستجابة
4. **مشكلة في الشبكة** - سيظهر في Dio Log

## 📋 **الخطوات التالية:**

1. **شغل التطبيق** واختبر تسجيل الدخول
2. **راقب Console** لرؤية البيانات المطبوعة
3. **تحقق من Dio Log** لرؤية الطلب الفعلي
4. **أرسل النتائج** إذا استمرت المشكلة

هذا سيساعد في تحديد السبب الدقيق للمشكلة! 🚀
