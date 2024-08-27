# MQTT Scripts

## PoE Control with MQTT

Example simple poe control via mqtt for hEX PoE `hex-poe-via-mqtt.rsc`
Subscribe to `mikrotik/poe/HEXPOE/ether5` to get poe info, possible value `on` `off` `auto-on`.
To set poe-out send mqtt with topic `mikrotik/poe/HEXPOE/ether5/set` and possible value `on` `off` `auto-on`
