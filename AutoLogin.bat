@echo off
::要连接的校园网名称(必须已经连接过一次)
::学生AUST_Student 教职工AUST_Faculty
set wifiName=AUST_Student
::校园网账号
set userId=2022******
::校园网密码
set Password=******
::校园网运营商入口
::电信aust 联通unicom 移动cmcc 教职工jzg
set operatorCode=****

REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v EnableActiveProbing /t REG_DWORD /d 0 /f

ping -n 1 10.255.0.19 | findstr /i "TTL" >nul
if %ERRORLEVEL% equ 7 goto POST
@echo on
netsh wlan connect name = %wifiName%
@echo off

:CHECK_CONNECTION
ping -n 1 10.255.0.19 | findstr /i "TTL" >nul
if %ERRORLEVEL% neq 0 goto CHECK_CONNECTION

:POST
@echo on
curl --max-time 5 --retry 10 -d "callback=dr1003&DDDDD=%userId%@%operatorCode%&upass=%Password%&0MKKey=123456" http://10.255.0.19/drcom/login
@echo off
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v EnableActiveProbing /t REG_DWORD /d 1 /f