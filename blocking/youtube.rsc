/ip/firewall/raw/add dst-address-list=youtube action=drop comment="drop: youtube"
/ip/firwall/address-list
add list=youtube address=www.youtube.com comment="drop: youtube"
/ip/dns/static
add address-list=youtube forward-to=1.1.1.1 match-subdomain=yes name=googlevideo.com type=FWD comment="drop: youtube"
