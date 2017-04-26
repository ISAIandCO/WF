@echo off
CLS
chcp 65001

:MENU
ECHO ------------------------------------------------------------------------------
ECHO Нажмите 1-5 для выбора задачи, или 6 для выхода.
ECHO.
ECHO 1 Задать параметры точки доступа WIFI (Далее ТДW)
ECHO 2 Запустить ТДW
ECHO 3 Остановить ТДW
ECHO 4 Перезапустить ТДW
ECHO 5 Устранение неполадок
ECHO 6 Выход
ECHO ------------------------------------------------------------------------------
SET RM=0
SET /P M=Выберите задачу и нажмите ENTER:
IF %M%==1 GOTO SET
IF %M%==2 GOTO START
IF %M%==3 GOTO STOP
IF %M%==4 GOTO REBOOT
IF %M%==5 GOTO RPS
IF %M%==6 GOTO EOF

:REBOOT
ECHO.
netsh wlan stop hostednetwork
netsh wlan start hostednetwork
GOTO MENU

:SET
ECHO ------------------------------------------------------------------------------
SET /P I=Имя ТДW:
SET /P P=Пароль ТДW:
ECHO ------------------------------------------------------------------------------
ECHO.
netsh wlan set hostednetwork mode=allow ssid=%I% key=%P% keyusage=persistent
netsh wlan start hostednetwork
IF %RM%==0 GOTO CFn
IF %RM%==1 GOTO CFk
:CFn
ECHO ------------------------------------------------------------------------------
ECHO Сейчас появятся "Сетевые подключения".
ECHO Нужно выбрать подключение по умолчанию, зайти в его свойства,
ECHO далее вкладка доступ, в ней выбераем пункт
ECHO "Разрешить другим пользователям сети использовать подключение к Интернету...",
ECHO после в пункте "Подключение домашней сети:"
ECHO выбираем "Подключение по локальной сети...".
ECHO Нажимаем ОК, закрываем окно, возвращаемся сюда.
ECHO ------------------------------------------------------------------------------
ECHO.
pause
ncpa.cpl
pause
:CFk
netsh wlan stop hostednetwork
netsh wlan start hostednetwork
GOTO MENU

:START
netsh wlan start hostednetwork
GOTO MENU

:STOP
netsh wlan stop hostednetwork
GOTO MENU

:RPS
ECHO ------------------------------------------------------------------------------
ECHO 1 Универсальный способ (Самый долгий, самый действенный)
ECHO 2 Перезапуск (Устройство не подключается к WIFI, хотя сеть видит)
ECHO 3 Смена имени (К сети подключается, но интернета нет)
ECHO ------------------------------------------------------------------------------
SET RM=1
SET /P PT=Выберите тип и нажмите ENTER:
IF %PT%==1 GOTO RP1
IF %PT%==2 GOTO REBOOT
IF %PT%==3 GOTO RP3


:RP1
netsh wlan start hostednetwork
ECHO ------------------------------------------------------------------------------
ECHO Сейчас появятся "Сетевые подключения".
ECHO Необходимо отключить "Подключение по локальной сети...", далее
ECHO нужно выбрать подключение по умолчанию, зайти в его свойства,
ECHO далее вкладка доступ, в ней выбераем пункт
ECHO "Разрешить другим пользователям сети использовать подключение к Интернету..."
ECHO и отключаем его. Нажимаем ОК, закрываем окно, возвращаемся сюда.
ECHO ------------------------------------------------------------------------------
ECHO.
pause
ncpa.cpl
pause
ECHO.
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=disallow
netsh wlan set hostednetwork mode=allow
ECHO ------------------------------------------------------------------------------
ECHO Сейчас появится "Диспетчер устройств".
ECHO В категории "Сетевые адаптеры" нужно задействовать данное устройство:
ECHO "Microsoft Hosted Network Virtual Adapter",
ECHO а далее закрыть окно.
ECHO ------------------------------------------------------------------------------
ECHO.
pause
mmc devmgmt.msc
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO Повторное задание настроек ТДW. Нужно указать другое имя сети
ECHO (Потом можно поменять обратно).
GOTO SET

:RP3
ECHO.
netsh wlan start hostednetwork
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=disallow
netsh wlan set hostednetwork mode=allow
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO Повторное задание настроек ТДW. Нужно указать другое имя сети
ECHO (Потом можно поменять обратно).
GOTO SET
