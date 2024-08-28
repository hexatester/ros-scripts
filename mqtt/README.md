# MQTT Scripts

> Requirements: IoT Package Instaled & a MQTT Broker

## PoE Control with MQTT

> Note: MQTT Broker name IoT

Example simple poe control via mqtt for hEX PoE `hex-poe-via-mqtt.rsc`
Subscribe topic `mikrotik/poe/HEXPOE/ether5` to get poe info, possible value `on` `off` `auto-on`.
To set poe-out send mqtt with topic `mikrotik/poe/HEXPOE/ether5/set` and possible value `on` `off` `auto-on`
