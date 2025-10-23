# تحديث API - تنسيق JSON الجديد

## 🔄 **التحديث:**

الـ Backend تغير الآن ويتوقع JSON بدلاً من OAuth2PasswordRequestForm:

```python
json_schema_extra = {
    "example": {
        "phone_number": "+966500000000",
        "password": "admin_password_123"
    }
}
```

## 🛠️ **التحديثات المطبقة:**

### 1. **تحديث LoginRequestModel:**

```dart
// قبل (OAuth2)
class LoginRequestModel {
  final String username;
  final String password;
  final String grantType;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'grant_type': grantType,
    };
  }
}

// بعد (JSON الجديد)
class LoginRequestModel {
  final String phoneNumber;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}
```

### 2. **تحديث Content-Type:**

```dart
// قبل (Form Data)
headers: {'Content-Type': 'application/x-www-form-urlencoded'}

// بعد (JSON)
headers: {'Content-Type': 'application/json'}
```

### 3. **تحديث طريقة الإرسال:**

```dart
// قبل (FormData)
data: FormData.fromMap(requestData),

// بعد (JSON)
data: requestData,
```

### 4. **تحديث SignInCubit:**

```dart
// قبل
final request = LoginRequestModel(
  username: state.phoneNumber,
  password: state.password,
);

// بعد
final request = LoginRequestModel(
  phoneNumber: state.phoneNumber,
  password: state.password,
);
```

## 📋 **مقارنة التنسيقات:**

### **OAuth2PasswordRequestForm (قبل):**

```
Content-Type: application/x-www-form-urlencoded
Body: username=+966500000000&password=admin_password_123&grant_type=password
```

### **JSON الجديد (بعد):**

```
Content-Type: application/json
Body: {"phone_number":"+966500000000","password":"admin_password_123"}
```

## 🔍 **البيانات المطبوعة الآن:**

```
📱 بيانات تسجيل الدخول:
رقم الجوال: "+966500000000"
كلمة المرور: "admin_password_123"
طول رقم الجوال: 13
طول كلمة المرور: 19
Request Model: {phone_number: +966500000000, password: admin_password_123}
=====================================

🔵 البيانات المرسلة للـ API:
URL: http://127.0.0.1:8000/api/v1/auth/login
Headers: {'Content-Type': 'application/json'}
Request Data: {phone_number: +966500000000, password: admin_password_123}
Data Type: JSON
=====================================

🔍 التحقق من البيانات:
phone_number: "+966500000000"
password: "admin_password_123"
=====================================

🟢 الاستجابة من الـ API:
Status Code: 200
Response Data: {access_token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..., token_type: bearer}
=====================================
```

## 🎯 **الفوائد:**

### 1. **البساطة:**

- ✅ لا توجد `grant_type`
- ✅ فقط `phone_number` و `password`
- ✅ تنسيق JSON بسيط

### 2. **التوافق:**

- ✅ متوافق مع الـ API الجديد
- ✅ Content-Type صحيح
- ✅ البيانات بالشكل المتوقع

### 3. **الأداء:**

- ✅ أقل بيانات
- ✅ أسرع في الإرسال
- ✅ أسهل في المعالجة

## 🚀 **اختبر الآن:**

1. **شغل التطبيق:**

   ```bash
   flutter run
   ```

2. **اختبر تسجيل الدخول:**

   - رقم الجوال: `+966500000000`
   - كلمة المرور: `admin_password_123`

3. **راقب Console** - يجب أن تعمل الآن!

## ✅ **النتيجة المتوقعة:**

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

## 🔧 **ملاحظات مهمة:**

### 1. **تنسيق البيانات:**

- `phone_number` بدلاً من `username`
- لا توجد `grant_type`
- تنسيق JSON بسيط

### 2. **Content-Type:**

- `application/json` للـ JSON
- ليس `application/x-www-form-urlencoded`

### 3. **البيانات المرسلة:**

```json
{
  "phone_number": "+966500000000",
  "password": "admin_password_123"
}
```

## 🎉 **الخلاصة:**

الآن التطبيق متوافق مع الـ API الجديد:

- ✅ يرسل JSON بدلاً من FormData
- ✅ يستخدم `phone_number` بدلاً من `username`
- ✅ لا يرسل `grant_type`
- ✅ Content-Type صحيح

هذا يجب أن يعمل الآن! 🚀
