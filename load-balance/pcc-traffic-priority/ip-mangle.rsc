/ip firewall mangle
add action=accept chain=prerouting comment=DAC dst-address-list=rfc1918 src-address-list=rfc1918
add action=accept chain=forward dst-address-list=rfc1918 src-address-list=rfc1918


add action=mark-connection chain=input comment="LB Input Sticky" connection-mark=no-mark in-interface=ISP1Interface new-connection-mark=ISP1-IN passthrough=no
add action=mark-connection chain=input connection-mark=no-mark in-interface=ISP2Interface new-connection-mark=ISP2-IN passthrough=no

add action=mark-routing chain=output connection-mark=ISP1-IN new-routing-mark=ISP1 passthrough=no
add action=mark-routing chain=output connection-mark=ISP2-IN new-routing-mark=ISP2 passthrough=no


add action=mark-connection chain=prerouting comment="LB LAN Marking" connection-mark=no-mark in-interface=ISP1Interface new-connection-mark=ISP1 passthrough=yes
add action=mark-connection chain=prerouting connection-mark=no-mark in-interface=ISP2Interface new-connection-mark=ISP2 passthrough=yes

add action=mark-connection chain=prerouting comment="LB PCC Mark Connection" connection-mark=no-mark src-address-list=rfc1918 dst-address-list=!rfc1918 hotspot=auth new-connection-mark=ISP1 passthrough=yes per-connection-classifier=both-addresses-and-ports:2/0
add action=mark-connection chain=prerouting connection-mark=no-mark src-address-list=rfc1918 dst-address-list=!rfc1918 hotspot=auth new-connection-mark=ISP2 passthrough=yes per-connection-classifier=both-addresses-and-ports:2/1


add action=mark-routing chain=prerouting comment="LB Mark Routing ISP1" connection-mark=ISP1 in-interface-list=LAN new-routing-mark=ISP1 passthrough=no
add action=mark-routing chain=prerouting connection-mark="ISP1 ICMP" in-interface-list=LAN new-routing-mark=ISP1 passthrough=no
add action=mark-routing chain=prerouting connection-mark="ISP1 Light" in-interface-list=LAN new-routing-mark=ISP1 passthrough=no
add action=mark-routing chain=prerouting connection-mark="ISP1 Heavy" in-interface-list=LAN new-routing-mark=ISP1 passthrough=no

add action=mark-routing chain=prerouting comment="LB Mark Routing ISP2" connection-mark=ISP2 in-interface-list=LAN new-routing-mark=ISP2 passthrough=no
add action=mark-routing chain=prerouting connection-mark="ISP2 ICMP" in-interface-list=LAN new-routing-mark=ISP2 passthrough=no
add action=mark-routing chain=prerouting connection-mark="ISP2 Light" in-interface-list=LAN new-routing-mark=ISP2 passthrough=no
add action=mark-routing chain=prerouting connection-mark="ISP2 Heavy" in-interface-list=LAN new-routing-mark=ISP2 passthrough=no


add action=jump chain=forward comment="LB Mark Connection ISP1" connection-mark=ISP1 jump-target=ISP1
add action=jump chain=forward connection-mark="ISP1 Light" jump-target=ISP1
add action=mark-connection chain=ISP1 new-connection-mark="ISP1 ICMP" passthrough=no protocol=icmp
add action=mark-connection chain=ISP1 connection-rate=0-64k new-connection-mark="ISP1 Light" passthrough=yes protocol=tcp
add action=mark-connection chain=ISP1 connection-rate=0-64k new-connection-mark="ISP1 Light" passthrough=yes protocol=udp
add action=mark-connection chain=ISP1 connection-rate=64k-100M new-connection-mark=ISP1 passthrough=yes protocol=tcp
add action=mark-connection chain=ISP1 connection-rate=64k-100M new-connection-mark=ISP1 passthrough=yes protocol=udp
add action=mark-connection chain=ISP1 connection-bytes=500000-0 connection-rate=200k-100M new-connection-mark="ISP1 Heavy" passthrough=yes protocol=tcp
add action=mark-connection chain=ISP1 connection-bytes=500000-0 connection-rate=200k-100M new-connection-mark="ISP1 Heavy" passthrough=yes protocol=udp
add action=return chain=ISP1

add action=jump chain=forward comment="LB Mark Connection ISP2" connection-mark=ISP2 jump-target=ISP2
add action=jump chain=forward connection-mark="ISP2 Light" jump-target=ISP2
add action=mark-connection chain=ISP2 new-connection-mark="ISP2 ICMP" passthrough=no protocol=icmp
add action=mark-connection chain=ISP2 connection-rate=0-64k new-connection-mark="ISP2 Light" passthrough=yes protocol=tcp
add action=mark-connection chain=ISP2 connection-rate=0-64k new-connection-mark="ISP2 Light" passthrough=yes protocol=udp
add action=mark-connection chain=ISP2 connection-rate=64k-100M new-connection-mark=ISP2 passthrough=yes protocol=tcp
add action=mark-connection chain=ISP2 connection-rate=64k-100M new-connection-mark=ISP2 passthrough=yes protocol=udp
add action=mark-connection chain=ISP2 connection-bytes=500000-0 connection-rate=200k-100M new-connection-mark="ISP2 Heavy" passthrough=yes protocol=tcp
add action=mark-connection chain=ISP2 connection-bytes=500000-0 connection-rate=200k-100M new-connection-mark="ISP2 Heavy" passthrough=yes protocol=udp
add action=return chain=ISP2


add action=mark-packet chain=forward comment="LB Mark Packet ISP1" connection-mark="ISP1 ICMP" new-packet-mark="ISP1 ICMP" passthrough=yes
add action=mark-packet chain=forward connection-mark="ISP1 Light" new-packet-mark="ISP1 Light" passthrough=yes
add action=mark-packet chain=forward connection-mark=ISP1 new-packet-mark=ISP1 passthrough=yes
add action=mark-packet chain=forward connection-mark="ISP1 Heavy" new-packet-mark="ISP1 Heavy" passthrough=yes

add action=mark-packet chain=forward comment="LB Mark Packet ISP2" connection-mark="ISP2 ICMP" new-packet-mark="ISP2 ICMP" passthrough=yes
add action=mark-packet chain=forward connection-mark="ISP2 Light" new-packet-mark="ISP2 Light" passthrough=yes
add action=mark-packet chain=forward connection-mark=ISP2 new-packet-mark=ISP2 passthrough=yes
add action=mark-packet chain=forward connection-mark="ISP2 Heavy" new-packet-mark="ISP2 Heavy" passthrough=yes
