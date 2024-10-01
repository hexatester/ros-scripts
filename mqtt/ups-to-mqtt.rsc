# Dont forget to install UPS package
# Pleas change UPS name
/system scheduler
add interval=30s name=UPS-MQTT on-event=":local RUNTIMELEFT\
    \n:local batteryCharge\
    \n:local batteryVoltage\
    \n:local pwrLoad\
    \n:local runtime\
    \n\
    \n/system/ups/monitor MyUPS once do={\
    \n:set runtime \$\"runtime-left\"\
    \n:set batteryCharge \$\"battery-charge\"\
    \n:set batteryVoltage \$\"battery-voltage\"\
    \n:set pwrLoad \$load\
    \n}\
    \n:local message \"{\\\"load\\\":\$pwrLoad,\\\"charge\\\":\$batteryCharge,\\\"voltage\\\":\$batteryVoltage,\\\"runtime\\\":\\\"\$runtime\\\"}\"\
    \n/iot mqtt publish broker=\"BUMDes\" topic=\"ups/MyUPS/status\" message=\$message" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup