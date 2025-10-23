# تحديث نظام تسجيل الدخول مع API الجديد

## ✅ التحديثات المطبقة

### 1. **نموذج البيانات الجديد**

#### LoginRequestModel

```dart
class LoginRequestModel {
  final String username;  // رقم الجوال
  final String password;
  final String grantType; // 'password'
}
```

#### LoginResponseModel

```dart
class LoginResponseModel {
  final String accessToken;
  final String tokenType;
}
```

### 2. **تحديث SignInState**

- ✅ تغيير `email` إلى `phoneNumber`
- ✅ تحديث جميع الدوال والخصائص
- ✅ تحديث التحقق من المساواة

### 3. **تحديث SignInCubit**

- ✅ إضافة `LoginRepository` كتبعية
- ✅ تحديث `updateEmail` إلى `updatePhoneNumber`
- ✅ تحديث دالة `login()` لاستخدام API الجديد
- ✅ إضافة التحقق من صحة رقم الجوال السعودي
- ✅ حفظ التوكن الحقيقي من API

### 4. **تحديث SignInView**

- ✅ تغيير حقل الإيميل إلى رقم الجوال
- ✅ إضافة `keyboardType: TextInputType.phone`
- ✅ تحديث النص التوضيحي إلى "رقم الجوال (+966)"
- ✅ إزالة BlocProvider المكرر

### 5. **تحديث Routes**

- ✅ إضافة `LoginRepository` كـ RepositoryProvider
- ✅ تمرير Repository إلى SignInCubit

## 🔧 **API الجديد**

### **Endpoint:**

```
POST /api/v1/auth/login
```

### **Request Body:**

```json
{
  "username": "+966500000000",
  "password": "admin_password_123",
  "grant_type": "password"
}
```

### **Response:**

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

## 📱 **التحسينات المضافة**

### 1. **التحقق من صحة رقم الجوال**

```dart
bool _isValidSaudiPhoneNumber(String phoneNumber) {
  final phoneRegex = RegExp(r'^\+966[0-9]{9}$');
  return phoneRegex.hasMatch(phoneNumber);
}
```

### 2. **معالجة الأخطاء المحسنة**

- رسائل خطأ باللغة العربية
- معالجة أخطاء الشبكة
- معالجة أخطاء الخادم

### 3. **حفظ التوكن الحقيقي**

- حفظ `access_token` من API
- حفظ بيانات المستخدم
- إدارة انتهاء صلاحية التوكن

## 🎯 **الميزات الجديدة**

### 1. **تسجيل الدخول برقم الجوال**

- ✅ دعم أرقام الجوال السعودية
- ✅ التحقق من صحة التنسيق
- ✅ رسائل خطأ واضحة

### 2. **تكامل API كامل**

- ✅ استدعاء API حقيقي
- ✅ معالجة الاستجابة
- ✅ حفظ التوكن

### 3. **تحسين تجربة المستخدم**

- ✅ لوحة مفاتيح رقمية
- ✅ تنسيق تلقائي لرقم الجوال
- ✅ رسائل خطأ واضحة

## 🔄 **تدفق العمل الجديد**

1. **إدخال البيانات:**

   - المستخدم يدخل رقم الجوال (+966)
   - المستخدم يدخل كلمة المرور

2. **التحقق من صحة البيانات:**

   - التحقق من وجود البيانات
   - التحقق من صحة تنسيق رقم الجوال

3. **استدعاء API:**

   - إرسال طلب POST إلى `/api/v1/auth/login`
   - معالجة الاستجابة

4. **حفظ البيانات:**

   - حفظ `access_token`
   - حفظ بيانات المستخدم
   - تعيين انتهاء الصلاحية

5. **الانتقال:**
   - الانتقال إلى صفحة البروفايل
   - تسجيل الدخول التلقائي

## 🛡️ **الأمان**

### 1. **التحقق من صحة البيانات**

- تنسيق رقم الجوال السعودي
- التحقق من وجود البيانات

### 2. **حفظ آمن للتوكن**

- استخدام FlutterSecureStorage
- إدارة انتهاء الصلاحية

### 3. **معالجة الأخطاء**

- رسائل خطأ آمنة
- عدم كشف معلومات حساسة

## 📋 **الملفات المحدثة**

1. **lib/views/auth/login/data/login_request_model.dart** - جديد
2. **lib/views/auth/login/data/login_response_model.dart** - جديد
3. **lib/views/auth/login/data/login_repository.dart** - جديد
4. **lib/views/auth/login/ui/logic/cubit/sign_in_state.dart** - محدث
5. **lib/views/auth/login/ui/logic/cubit/sign_in_cubit.dart** - محدث
6. **lib/views/auth/login/ui/sign_in_view.dart** - محدث
7. **lib/core/routing/routes.dart** - محدث

## 🎉 **النتيجة النهائية**

تم تحديث نظام تسجيل الدخول بالكامل ليتوافق مع:

- ✅ API الجديد
- ✅ رقم الجوال بدلاً من الإيميل
- ✅ حفظ التوكن الحقيقي
- ✅ التحقق من صحة البيانات
- ✅ معالجة الأخطاء المحسنة
- ✅ تجربة مستخدم محسنة

النظام جاهز الآن للعمل مع API الحقيقي! 🚀
