# Proper detect internet setup

/interface list
add name=LAN
add name=WAN
add name=Internet
add name=Uplink

# Change the ether1 to interface of ISP side
/interface list member
add interface=ether1 list=Uplink
# add interface=PPPoE-Client list=Uplink

/interface detect-internet
set detect-interface-list=Uplink internet-interface-list=Internet lan-interface-list=LAN wan-interface-list=WAN

# Get detect internet status with scripting example bellow
# :if ([/interface/detect-internet/state/get ether1 state]="internet") do={}
