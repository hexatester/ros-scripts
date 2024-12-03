
/system scheduler
add interval=1d name=AutoUpdate on-event="/system package update check-for-updates\
    \n:if ([/system package update get installed-version] != [/system package update g\
    et latest-version]) do={\
    \n/system package update install\
    \n}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-01-01 start-time=03:00:00
