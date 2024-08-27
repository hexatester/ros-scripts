# Internet failover multiple dhcp client using detect-Internet
# First set up detec Internet with interface/detect-interface.rsc

# Example
# dhcp client on ether1 with default route distance = 1 (as main)
# dhcp client on ether2 with default route distance = 2 (as backup)

/system scheduler
add interval=2m name=Detnet on-event=":foreach \$dhcpclient in=[/ip dhcp-client find status=bound] do={\r\
    \n:local interface [/ip dhcp-client get \$dhcpclient interface]\r\
    \n:if ([/interface/detect-internet/state/get \$interface state]=\"internet\") do={\r\
    \n/ip dhcp-client set [find interface=\$interface add-default-route=no] add-default-route=yes\r\
    \n} else={\r\
    \n/ip dhcp-client set [find interface=\$interface add-default-route=yes] add-default-route=no\r\
    \n}\r\
    \n};" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
