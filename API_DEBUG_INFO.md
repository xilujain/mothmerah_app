# معلومات تصحيح API - تسجيل الدخول

## 📱 البيانات المرسلة للـ API

### 1. **URL:**

```
POST http://127.0.0.1:8000/api/v1/auth/login
```

### 2. **Headers:**

```json
{
  "Content-Type": "application/json"
}
```

### 3. **Request Body:**

```json
{
  "username": "+966500000000",
  "password": "admin_password_123",
  "grant_type": "password"
}
```

## 🔍 **مثال على البيانات المطبوعة في Console:**

### عند إدخال البيانات:

```
📱 بيانات تسجيل الدخول:
رقم الجوال: +966500000000
كلمة المرور: admin_password_123
Request Model: {username: +966500000000, password: admin_password_123, grant_type: password}
=====================================
```

### عند إرسال البيانات للـ API:

```
🔵 البيانات المرسلة للـ API:
URL: http://127.0.0.1:8000/api/v1/auth/login
Headers: {'Content-Type': 'application/json'}
Body: {username: +966500000000, password: admin_password_123, grant_type: password}
=====================================
```

### عند نجاح تسجيل الدخول:

```
🟢 الاستجابة من الـ API:
Status Code: 200
Response Data: {access_token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..., token_type: bearer}
=====================================

🎉 تم تسجيل الدخول بنجاح!
Access Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Token Type: bearer
=====================================
```

### عند حدوث خطأ:

```
❌ خطأ في API:
DioException: HttpException: Connection refused
Status Code: null
Response Data: null
Error Message: حدث خطأ في الخادم
=====================================

❌ خطأ في تسجيل الدخول:
Error: Exception: خطأ في الخادم: حدث خطأ في الخادم
=====================================
```

## 🛠️ **كيفية رؤية البيانات:**

### 1. **تشغيل التطبيق:**

```bash
flutter run
```

### 2. **فتح صفحة تسجيل الدخول:**

- أدخل رقم الجوال: `+966500000000`
- أدخل كلمة المرور: `admin_password_123`

### 3. **اضغط على "تسجيل الدخول"**

### 4. **راقب Console:**

ستظهر جميع البيانات المطبوعة في console التطبيق

## 📋 **ملاحظات مهمة:**

### 1. **تنسيق رقم الجوال:**

- يجب أن يبدأ بـ `+966`
- يجب أن يكون 13 رقم إجمالي
- مثال: `+966500000000`

### 2. **كلمة المرور:**

- يمكن أن تكون أي كلمة مرور
- سيتم إرسالها كما هي للـ API

### 3. **grant_type:**

- دائماً `password`
- لا يمكن تغييره

## 🔧 **إزالة الـ Debug Prints:**

بعد الانتهاء من التصحيح، يمكن إزالة جميع الـ print statements من:

1. **lib/views/auth/login/data/login_repository.dart**
2. **lib/views/auth/login/ui/logic/cubit/sign_in_cubit.dart**

## 🎯 **النتيجة المتوقعة:**

عند تشغيل التطبيق واختبار تسجيل الدخول، ستظهر في console:

1. ✅ بيانات المستخدم المدخلة
2. ✅ البيانات المرسلة للـ API
3. ✅ استجابة الـ API (نجاح أو خطأ)
4. ✅ التوكن المستلم (في حالة النجاح)
5. ✅ رسائل الخطأ (في حالة الفشل)

هذا سيساعدك في فهم تدفق البيانات والتأكد من أن كل شيء يعمل بشكل صحيح! 🚀
