# Exported from hEX PoE
# Please ajust accordingly
# DONT forget to execute script MQTT-PoE with scheduler

/system script
add dont-require-permissions=no name=MQTT-PoE owner=tik-script policy=read,write,test,sniff,sensitive source="# Required packages: iot\r\
    \n\r\
    \n################################ Configuration ################################\r\
    \n# Name of an existing MQTT broker that should be used for publishing\r\
    \n:local broker \"IoT\"\r\
    \n\r\
    \n# MQTT topic where the message should be published\r\
    \n:local topic \"mikrotik/poe/HEXPOE\"\r\
    \n\r\
    \n\r\
    \n#################################### MQTT #####################################\r\
    \n/iot mqtt\r\
    \npublish broker=\$broker topic=\"\$topic/ether2\" message=[/interface ethernet get ether2 poe-out ]\r\
    \npublish broker=\$broker topic=\"\$topic/ether3\" message=[/interface ethernet get ether3 poe-out ]\r\
    \npublish broker=\$broker topic=\"\$topic/ether4\" message=[/interface ethernet get ether4 poe-out ]\r\
    \npublish broker=\$broker topic=\"\$topic/ether5\" message=[/interface ethernet get ether5 poe-out ]"

/iot mqtt subscriptions
add broker=IoT on-message=":if ([/interface/ethernet/get ether2 poe-out]!=\$msgData) do={\r\
    \n/interface/ethernet/set ether2 poe-out=\$msgData\r\
    \n}\r\
    \n/iot mqtt publish broker=IoT topic=\"mikrotik/poe/HEXPOE/ether2\" message=[/interface ethernet get ether2 poe-out ]" topic=mikrotik/poe/HEXPOE/ether2/set
add broker=IoT on-message=":if ([/interface/ethernet/get ether3 poe-out]!=\$msgData) do={\r\
    \n/interface/ethernet/set ether3 poe-out=\$msgData\r\
    \n}\r\
    \n/iot mqtt publish broker=IoT topic=\"mikrotik/poe/HEXPOE/ether3\" message=[/interface ethernet get ether3 poe-out ]" topic=mikrotik/poe/HEXPOE/ether3/set
add broker=IoT on-message=":if ([/interface/ethernet/get ether4 poe-out]!=\$msgData) do={\r\
    \n/interface/ethernet/set ether4 poe-out=\$msgData\r\
    \n}\r\
    \n/iot mqtt publish broker=IoT topic=\"mikrotik/poe/HEXPOE/ether4\" message=[/interface ethernet get ether4 poe-out ]" topic=mikrotik/poe/HEXPOE/ether4/set
add broker=IoT on-message=":if ([/interface/ethernet/get ether5 poe-out]!=\$msgData) do={\r\
    \n/interface/ethernet/set ether5 poe-out=\$msgData\r\
    \n}\r\
    \n/iot mqtt publish broker=IoT topic=\"mikrotik/poe/HEXPOE/ether5\" message=[/interface ethernet get ether5 poe-out ]" topic=mikrotik/poe/HEXPOE/ether5/set
