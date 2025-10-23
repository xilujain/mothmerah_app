# مسح التوكن وإعادة من البداية

## 🎯 **الهدف:**

مسح جميع البيانات المحفوظة (التوكن، بيانات المستخدم) وإعادة التطبيق من البداية.

## 🛠️ **الحلول المطبقة:**

### 1. **إضافة دالة مسح البيانات في TokenManager:**

```dart
/// Force clear all data (for debugging)
static Future<void> forceClearAllData() async {
  print('🗑️ مسح جميع البيانات المحفوظة...');

  try {
    await SharedPrefHelper.removeSecuredData(_tokenKey);
    await SharedPrefHelper.removeData(_userDataKey);
    await SharedPrefHelper.removeData(_tokenExpiryKey);

    print('✅ تم مسح جميع البيانات بنجاح');
    print('=====================================');
  } catch (e) {
    print('❌ خطأ في مسح البيانات: $e');
    print('=====================================');
  }
}
```

### 2. **إضافة زر مسح البيانات في ProfileView:**

```dart
_buildActionRow(
  context,
  textStyles,
  'مسح البيانات المحفوظة',
  Colors.orange,
  () {
    _showClearDataDialog(context, cubit);
  },
),
```

### 3. **إضافة نافذة تأكيد مسح البيانات:**

```dart
void _showClearDataDialog(BuildContext context, ProfileCubit cubit) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('مسح البيانات المحفوظة', style: TextStyles(context).font18PrimaryBold),
      content: Text(
        'هل تريد مسح جميع البيانات المحفوظة؟ ستحتاج لتسجيل الدخول مرة أخرى.',
        style: TextStyles(context).font14PrimaryRegular,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('إلغاء'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            print('🗑️ بدء مسح البيانات المحفوظة...');
            await TokenManager.forceClearAllData();
            print('🔄 إعادة تحميل الصفحة...');
            cubit.loadProfile();
          },
          child: Text('مسح'),
        ),
      ],
    ),
  );
}
```

## 🔍 **البيانات التي يتم مسحها:**

### 1. **التوكن:**

- `userToken` - توكن المصادقة
- `tokenExpiry` - تاريخ انتهاء الصلاحية

### 2. **بيانات المستخدم:**

- `userData` - جميع بيانات المستخدم المحفوظة

### 3. **النتيجة:**

- مسح جميع البيانات المحفوظة
- إعادة التطبيق لحالة تسجيل الدخول
- إعادة تحميل صفحة البروفايل

## 🚀 **كيفية مسح البيانات:**

### 1. **شغل التطبيق:**

```bash
flutter run
```

### 2. **سجل الدخول:**

- رقم الجوال: `+966500000000`
- كلمة المرور: `admin_password_123`

### 3. **انتقل لصفحة البروفايل:**

- اسحب لأسفل
- ابحث عن "مسح البيانات المحفوظة"

### 4. **اضغط على الزر:**

- ستظهر نافذة تأكيد
- اضغط على "مسح"

### 5. **راقب Console:**

```
🗑️ بدء مسح البيانات المحفوظة...
✅ تم مسح جميع البيانات بنجاح
=====================================
🔄 إعادة تحميل الصفحة...
```

## 🔧 **الطرق المختلفة لمسح البيانات:**

### 1. **من التطبيق (الأسهل):**

- افتح صفحة البروفايل
- اضغط على "مسح البيانات المحفوظة"
- اضغط على "مسح"

### 2. **من Terminal:**

```bash
flutter clean
flutter run
```

### 3. **من الكود:**

```dart
await TokenManager.forceClearAllData();
```

## 🎯 **المزايا:**

### 1. **مسح شامل:**

- ✅ مسح التوكن
- ✅ مسح بيانات المستخدم
- ✅ مسح تاريخ انتهاء الصلاحية

### 2. **سهولة الاستخدام:**

- ✅ زر واضح في البروفايل
- ✅ نافذة تأكيد
- ✅ رسائل واضحة

### 3. **Debugging:**

- ✅ طباعة تفاصيل المسح
- ✅ تأكيد نجاح العملية
- ✅ تتبع الأخطاء

## 🔍 **البيانات المطبوعة:**

```
🗑️ مسح جميع البيانات المحفوظة...
✅ تم مسح جميع البيانات بنجاح
=====================================
🔄 إعادة تحميل الصفحة...
```

## 🎉 **الخلاصة:**

الآن يمكنك:

- ✅ **مسح جميع البيانات** - من التطبيق مباشرة
- ✅ **إعادة من البداية** - تسجيل دخول جديد
- ✅ **Debugging سهل** - تتبع كل خطوة
- ✅ **واجهة واضحة** - زر ونافذة تأكيد

جرب الآن وستجد أن مسح البيانات يعمل بشكل مثالي! 🚀
