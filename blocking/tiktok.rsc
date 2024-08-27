/ip/firewall/raw
add chain=prerouting dst-address-list=tiktok action=drop comment="drop: tiktok"

/ip/firewall/address-list
add list=tiktok address=www.tiktok.com comment="drop: tiktok"

/ip/dns/static
add address-list=tiktok forward-to=1.1.1.1 match-subdomain=yes name=tiktokcdn.com type=FWD comment="drop: tiktok"
add address-list=tiktok forward-to=1.1.1.1 match-subdomain=yes name=tiktokv.com type=FWD comment="drop: tiktok"
