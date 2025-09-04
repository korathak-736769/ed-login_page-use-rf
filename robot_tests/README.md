# Robot Framework Test Suite for Login System

ชุด Test Case สำหรับทดสอบระบบ Login, Register และ Profile ที่มีช่องโหว่ SQL Injection

## โครงสร้างไฟล์

```
robot_tests/
├── resource.robot         # ไฟล์ resources และ keywords สำหรับใช้งานร่วมกัน
├── login_tests.robot      # test case สำหรับทดสอบการ login
├── sql_injection_tests.robot  # test case สำหรับทดสอบช่องโหว่ SQL Injection
├── registration_tests.robot   # test case สำหรับทดสอบการลงทะเบียน
├── profile_tests.robot    # test case สำหรับทดสอบหน้าโปรไฟล์
└── run_all_tests.robot    # ไฟล์สำหรับรันทดสอบทั้งหมด
```

## การติดตั้ง

1. ติดตั้ง Robot Framework:
```
pip install robotframework
```

2. ติดตั้งไลบรารีที่จำเป็น:
```
pip install robotframework-seleniumlibrary
pip install robotframework-databaselibrary
pip install pymysql
```

3. ติดตั้ง WebDriver สำหรับ Chrome หรือ Firefox

## การรัน Test Case

1. รัน test case เฉพาะกลุ่ม:
```
robot login_tests.robot
robot sql_injection_tests.robot
robot registration_tests.robot
robot profile_tests.robot
```

2. รันทั้งหมด:
```
robot run_all_tests.robot
```

## Test Case ที่มี

### 1. Login Tests
- ทดสอบ login ด้วยข้อมูลที่ถูกต้อง
- ทดสอบ login ด้วยรหัสผ่านไม่ถูกต้อง
- ทดสอบ login ด้วยผู้ใช้ที่ไม่มีในระบบ
- ทดสอบฟิลด์ว่าง
- ทดสอบ login และ logout

### 2. SQL Injection Tests
- ทดสอบ bypass login ด้วย SQL Injection
- ทดสอบ login เป็นผู้ใช้เฉพาะด้วย SQL Injection
- ทดสอบ SQL Injection ด้วย multiple statements

### 3. Registration Tests
- ทดสอบการลงทะเบียนปกติ
- ทดสอบการลงทะเบียนด้วยชื่อผู้ใช้ที่มีอยู่แล้ว
- ทดสอบการลงทะเบียนด้วยฟิลด์ว่าง

### 4. Profile Tests
- ทดสอบการเข้าถึงหน้าโปรไฟล์โดยไม่ได้ login
- ทดสอบการแสดงข้อมูลผู้ใช้ถูกต้อง
- ทดสอบ SQL Injection ในหน้าโปรไฟล์

## หมายเหตุ

- ต้องมีการรัน server และฐานข้อมูลก่อนทำการทดสอบ
- URL ในไฟล์ resource.robot อาจต้องแก้ไขให้ตรงกับ environment
- credentials สำหรับฐานข้อมูลในไฟล์ resource.robot อาจต้องแก้ไข
