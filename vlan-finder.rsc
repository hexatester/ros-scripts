# Use this as a script to find switch access port's vlan id from trunk port
# Not tested

# Interface to the trunk port
:local interface "ether1"

# Device with ip gateway as address on access port
:local gateway "192.168.1.1"

# address of vlan interface must be the same subnet with gateway address
:local address "192.168.1.2/24"

# start vlan
:local vlanid (1)
:local endvlan (4094)

# set up vlan interface
/interface vlan
remove vlanfinder
add name=vlanfinder vlan-id=$vlanid interface=$interface

# add address to vlan interface
/ip address add address=$address interface=vlanfinder

:while ( $vlanid<=$endvlan ) do={

:if ([:tobool [/tool/ping 10.255.255.222 count=1]]) do={
:log info "Found vlan-id=$vlanid"
} else={
:log debug "No result vlan-id=$vlanid"
};

:set vlanid ($vlanid + 1)
/interface vlan set vlanfinder vlan-id=$vlanid
:delay 500ms
};