# apr/12/2019 21:24:47 by RouterOS 6.45beta27
# software id = YWI9-BU1V
#
# model = RouterBOARD 962UiGS-5HacT2HnT
# serial number = 673706ED7949
/interface bridge add arp=proxy-arp fast-forward=no name="guest infrastructure"
/interface bridge add arp=proxy-arp fast-forward=no name="ip mapping"
/interface bridge add admin-mac=6C:3B:6B:11:DA:1C arp=reply-only auto-mac=no fast-forward=no name="main infrastructure"
/interface bridge add arp=proxy-arp fast-forward=no name="ospf loopback"
/interface ethernet set [ find default-name=ether4 ] name="lan A" speed=100Mbps
/interface ethernet set [ find default-name=ether2 ] name="lan B" speed=100Mbps
/interface ethernet set [ find default-name=ether3 ] name="lan C" speed=100Mbps
/interface ethernet set [ find default-name=ether5 ] name="lan D (master)" poe-out=off speed=100Mbps
/interface ethernet set [ find default-name=sfp1 ] advertise=10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full disabled=yes name=optic
/interface ethernet set [ find default-name=ether1 ] arp=proxy-arp name=wan speed=100Mbps
/interface list add comment="Trusted networks" name=list-trusted
/interface list add comment="Semi-Trusted networks" name=list-semi-trusted
/interface list add comment="Untrusted networks" name=list-untrusted
/interface list add comment="Guest Wireless" name=list-guest-wireless
/interface list add comment="neighbors allowed interfaces" name=list-neighbors-lookup
/interface list add comment="winbox allowed interfaces" name=list-winbox-allowed
/interface list add comment="includes l2tp client interfaces when UP" name=list-2tp-dynamic-tun
/interface list add comment="firewall rule: drop invalid conn" name=list-drop-invalid-connections
/interface list add comment="LAN intefaces" name=treated-as-LAN
/interface list add comment="WAN interfaces" name=treated-as-WAN
/interface list add comment="Internet interfaces" name=treated-as-INTERNET
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/interface wireless security-profiles add authentication-types=wpa2-psk eap-methods="" management-protection=allowed mode=dynamic-keys name=private supplicant-identity=""
/interface wireless security-profiles add authentication-types=wpa-psk,wpa2-psk eap-methods="" management-protection=allowed name=public supplicant-identity=""
/interface wireless set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode antenna-gain=2 band=2ghz-onlyn basic-rates-b="" channel-width=20/40mhz-Ce country=russia disabled=no distance=indoors frequency=auto frequency-mode=regulatory-domain hw-protection-mode=rts-cts mode=ap-bridge multicast-helper=full name="wlan 2Ghz" security-profile=private ssid="WiFi 2Ghz PRIVATE" supported-rates-b="" wireless-protocol=802.11 wmm-support=enabled wps-mode=disabled
/interface wireless add default-forwarding=no disabled=no keepalive-frames=disabled mac-address=6E:3B:6B:11:DA:1F master-interface="wlan 2Ghz" multicast-buffering=disabled name="wlan 2Ghz GUEST" security-profile=public ssid="WiFi 2Ghz FREE" wds-cost-range=0 wds-default-cost=0 wps-mode=disabled
/interface wireless set [ find default-name=wlan2 ] adaptive-noise-immunity=ap-and-client-mode antenna-gain=2 band=5ghz-a/n/ac country=russia disabled=no distance=indoors frequency-mode=regulatory-domain hw-protection-mode=rts-cts mode=ap-bridge multicast-helper=full name="wlan 5Ghz" security-profile=private ssid="WiFi 5Ghz PRIVATE" wireless-protocol=802.11 wmm-support=enabled wps-mode=disabled
/interface wireless nstreme set "wlan 2Ghz" enable-polling=no
/interface wireless nstreme set "wlan 5Ghz" enable-polling=no
/ip dhcp-server add authoritative=after-2sec-delay disabled=no interface="main infrastructure" lease-time=1d name="main dhcp"
/ip dhcp-server option add code=15 name=DomainName value="s'home'"
/ip firewall layer7-protocol add name=EXE regexp=".(exe)"
/ip firewall layer7-protocol add name=RAR regexp=".(rar)"
/ip firewall layer7-protocol add name=ZIP regexp=".(zip)"
/ip firewall layer7-protocol add name=7Z regexp=".(7z)"
/ip firewall layer7-protocol add name=PDF regexp=".(pdf)"
/ip firewall layer7-protocol add name=MP3 regexp=".(mp3)"
/ip firewall layer7-protocol add name=ISO regexp=".(iso)"
/ip firewall layer7-protocol add name=BIN regexp=".(bin)"
/ip firewall layer7-protocol add name="resolve local" regexp=".home|[0-9]+.[0-9]+.168.192.in-addr.arpa"
/ip hotspot profile set [ find default=yes ] html-directory=flash/hotspot login-by=http-chap,trial
/ip ipsec policy group add name=inside-ipsec-encryption
/ip ipsec policy group add name=outside-ipsec-encryption
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=ROUTEROS
/ip ipsec peer add address=185.13.148.14/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, outer-tunnel encryption, RSA)" exchange-mode=ike2 name=CHR-external profile=ROUTEROS
/ip ipsec peer add address=10.0.0.1/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, traffic-only encryption)" local-address=10.0.0.2 name=CHR-internal profile=ROUTEROS
/ip ipsec proposal set [ find default=yes ] enc-algorithms=aes-256-cbc,aes-192-cbc,aes-128-cbc,3des lifetime=1h
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip pool add name="dhcp pool" ranges=192.168.99.100-192.168.99.200
/ip pool add name="guest pool" ranges=192.168.98.200-192.168.98.230
/ip pool add name="virtual machines pool" ranges=192.168.99.0/26
/ip dhcp-server add add-arp=yes address-pool="guest pool" authoritative=after-2sec-delay disabled=no interface="guest infrastructure" lease-script="\r\
    \n# Globals\r\
    \n#\r\
    \n:global GleaseBound;\r\
    \n:global GleaseServerName;\r\
    \n:global GleaseActMAC;\r\
    \n:global GleaseActIP;\r\
    \n\r\
    \n:set GleaseBound \$leaseBound;\r\
    \n:set GleaseServerName \$leaseServerName;\r\
    \n:set GleaseActMAC \$leaseActMAC;\r\
    \n:set GleaseActIP \$leaseActIP;\r\
    \n\r\
    \n/system script run doDHCPLeaseTrack;" lease-time=3h name="guest dhcp"
/ppp profile add address-list=l2tp-active-clients interface-list=list-2tp-dynamic-tun local-address=10.0.0.2 name=l2tp-no-encrypt-site2site only-one=no remote-address=10.0.0.1
/interface l2tp-client add allow=mschap2 connect-to=185.13.148.14 disabled=no max-mru=1418 max-mtu=1418 name=tunnel profile=l2tp-no-encrypt-site2site user=vpn-remote-mic
/queue simple add comment=dtq,54:E4:3A:B8:12:07,iPadAlx max-limit=10M/10M name="iPadAlx (54:E4:3A:B8:12:07)" target=192.168.98.224/32
/queue simple add comment=dtq,AC:61:EA:EA:CC:84,iPhoneAlx max-limit=10M/10M name="iPhoneAlx (AC:61:EA:EA:CC:84)" target=192.168.98.225/32
/queue simple add comment=dtq,B0:34:95:2D:D6:85,ATV max-limit=10M/10M name="ATV (B0:34:95:2D:D6:85)" target=192.168.99.190/32
/queue simple add comment=dtq,78:31:C1:CF:9E:70,MbpAlx max-limit=10M/10M name="MbpAlx (78:31:C1:CF:9E:70)" target=192.168.99.160/32
/queue simple add comment=dtq,38:C9:86:51:D2:B3,MbpAlx max-limit=10M/10M name="MbpAlx (38:C9:86:51:D2:B3)" target=192.168.99.170/32
/queue simple add comment=dtq,08:00:27:17:3A:80, max-limit=10M/10M name=" (08:00:27:17:3A:80)" target=192.168.99.20/32
/queue simple add comment=dtq,00:CD:FE:EC:B5:52,iPhoneGl max-limit=10M/10M name="iPhoneGl (00:CD:FE:EC:B5:52)" target=192.168.98.230/32
/queue simple add comment=dtq,98:22:EF:26:FE:6E, max-limit=10M/10M name="asusGl (98:22:EF:26:FE:6E)" target=192.168.98.210/32
/queue simple add comment=dtq,88:53:95:30:68:9F,miniAlx max-limit=10M/10M name="miniAlx (88:53:95:30:68:9F)" target=192.168.98.228/32
/queue simple add comment=dtq,10:DD:B1:9E:19:5E,miniAlx max-limit=10M/10M name="miniAlx (10:DD:B1:9E:19:5E)" target=192.168.99.180/32
/queue simple add comment=dtq,94:C6:91:94:98:DC,DESKTOP-ELCNKHP max-limit=10M/10M name="DESKTOP-ELCNKHP (94:C6:91:94:98:DC)" target=192.168.99.88/32
/queue simple add comment=dtq,C4:B3:01:75:EE:FB,iPhone-88 max-limit=10M/10M name="iPhone-88 (C4:B3:01:75:EE:FB)" target=192.168.98.229/32
/queue tree add comment="FILE download control" name="Total Bandwidth" parent=global queue=default
/queue tree add name=PDF packet-mark=pdf-mark parent="Total Bandwidth" queue=default
/queue tree add name=RAR packet-mark=rar-mark parent="Total Bandwidth" queue=default
/queue tree add name=ISO packet-mark=iso-mark parent="Total Bandwidth" queue=default
/queue tree add name=MP3 packet-mark=mp3-mark parent="Total Bandwidth" queue=default
/queue tree add name=EXE packet-mark=exe-mark parent="Total Bandwidth" queue=default
/queue tree add name=BIN packet-mark=bin-mark parent="Total Bandwidth" queue=default
/queue tree add name=7Z packet-mark=7z-mark parent="Total Bandwidth" queue=default
/queue tree add name=ZIP packet-mark=zip-mark parent="Total Bandwidth" queue=default
/routing ospf area add area-id=0.0.0.1 default-cost=1 inject-summary-lsas=no name=local type=stub
/routing ospf instance set [ find default=yes ] name=routes-provider-mic router-id=10.255.255.2
/snmp community set [ find default=yes ] addresses=192.168.99.180/32,192.168.99.170/32 authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 name=public
/system logging action add name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=10 disk-file-name=flash/ScriptsDiskLog disk-lines-per-file=60000 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=1 disk-file-name=flash/ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add memory-lines=500 name=OnScreenLog target=memory
/system logging action add name=DHCPOnScreenLog target=memory
/system logging action add name=DNSOnScreenLog target=memory
/system logging action add name=RouterControlLog target=memory
/system logging action add name=OSPFOnscreenLog target=memory
/system logging action add name=L2TPOnScreenLog target=memory
/system logging action add disk-file-count=20 disk-file-name=flash/AuthDiskLog disk-lines-per-file=60000 name=AuthDiskLog target=disk
/system logging action add name=CertificatesOnScreenLog target=memory
/system logging action add memory-lines=6000 name=ParseMemoryLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!write,!policy,!sensitive,!dude
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!policy,!sensitive,!dude
/certificate scep-server add days-valid=365 path=/scep/sign
/certificate settings set crl-download=no crl-store=system crl-use=no
/interface bridge filter add action=drop chain=forward comment="drop all dhcp requests over bridge" dst-port=67 ip-protocol=udp mac-protocol=ip
/interface bridge port add bridge="main infrastructure" interface="lan D (master)"
/interface bridge port add bridge="main infrastructure" interface="wlan 2Ghz"
/interface bridge port add bridge="main infrastructure" interface="wlan 5Ghz"
/interface bridge port add bridge="guest infrastructure" interface="wlan 2Ghz GUEST"
/interface bridge port add bridge="main infrastructure" interface="lan A"
/interface bridge port add bridge="main infrastructure" interface="lan B"
/interface bridge port add bridge="main infrastructure" interface="lan C"
/interface bridge settings set allow-fast-path=no use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes
/ip neighbor discovery-settings set discover-interface-list=list-neighbors-lookup
/ip settings set accept-source-route=yes allow-fast-path=no rp-filter=loose tcp-syncookies=yes
/interface detect-internet set detect-interface-list=all internet-interface-list=treated-as-INTERNET lan-interface-list=treated-as-LAN wan-interface-list=treated-as-WAN
/interface list member add comment=MGTS interface=wan list=list-untrusted
/interface list member add comment="GUEST WLAN" interface="guest infrastructure" list=list-guest-wireless
/interface list member add comment=LAN+WLAN interface="main infrastructure" list=list-trusted
/interface list member add comment="neighbors lookup" interface="main infrastructure" list=list-neighbors-lookup
/interface list member add comment="winbox allowed" interface="main infrastructure" list=list-winbox-allowed
/interface list member add comment="neighbors lookup" interface=tunnel list=list-neighbors-lookup
/interface list member add interface=wan list=list-drop-invalid-connections
/ip accounting set account-local-traffic=yes enabled=yes threshold=200
/ip address add address=192.168.99.1/24 comment="local IP" interface="main infrastructure" network=192.168.99.0
/ip address add address=192.168.98.1/24 comment="local guest wifi" interface="guest infrastructure" network=192.168.98.0
/ip address add address=192.168.100.7/24 comment=WAN interface=wan network=192.168.100.0
/ip address add address=10.255.255.2 comment="ospf router-id binding" interface="ospf loopback" network=10.255.255.2
/ip address add address=172.16.0.16/30 comment="GRAFANA IP redirect" interface="ip mapping" network=172.16.0.16
/ip address add address=172.16.0.17/30 comment="INFLUXDB IP redirect" interface="ip mapping" network=172.16.0.16
/ip arp add address=192.168.99.80 interface="main infrastructure" mac-address=90:FB:A6:2B:02:16
/ip arp add address=192.168.99.150 interface="main infrastructure" mac-address=AC:61:EA:EA:CC:84
/ip arp add address=192.168.99.140 interface="main infrastructure" mac-address=54:E4:3A:B8:12:07
/ip arp add address=192.168.99.90 interface="main infrastructure" mac-address=0C:60:76:72:6C:9B
/ip arp add address=192.168.99.160 interface="main infrastructure" mac-address=78:31:C1:CF:9E:70
/ip arp add address=192.168.100.7 interface=wan mac-address=6C:3B:6B:11:DA:18
/ip arp add address=192.168.99.190 interface="main infrastructure" mac-address=B0:34:95:2D:D6:85
/ip arp add address=192.168.99.170 interface="main infrastructure" mac-address=38:C9:86:51:D2:B3
/ip arp add address=192.168.99.20 interface="main infrastructure" mac-address=08:00:27:17:3A:80
/ip arp add address=192.168.99.130 interface="main infrastructure" mac-address=00:CD:FE:EC:B5:52
/ip arp add address=192.168.99.70 interface="main infrastructure" mac-address=98:22:EF:26:FE:6E
/ip arp add address=192.168.99.180 interface="main infrastructure" mac-address=10:DD:B1:9E:19:5E
/ip arp add address=192.168.99.88 interface="main infrastructure" mac-address=94:C6:91:94:98:DC
/ip cloud set ddns-enabled=yes
/ip dhcp-server lease add address=192.168.99.140 always-broadcast=yes client-id=1:54:e4:3a:b8:12:7 mac-address=54:E4:3A:B8:12:07 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.150 client-id=1:ac:61:ea:ea:cc:84 mac-address=AC:61:EA:EA:CC:84 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.190 client-id=1:b0:34:95:2d:d6:85 mac-address=B0:34:95:2D:D6:85 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.160 address-lists=osx-hosts client-id=1:78:31:c1:cf:9e:70 mac-address=78:31:C1:CF:9E:70 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.170 address-lists=osx-hosts mac-address=38:C9:86:51:D2:B3 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.20 mac-address=08:00:27:17:3A:80 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.130 always-broadcast=yes client-id=1:0:cd:fe:ec:b5:52 mac-address=00:CD:FE:EC:B5:52 server="main dhcp"
/ip dhcp-server lease add address=192.168.98.230 block-access=yes client-id=1:0:cd:fe:ec:b5:52 mac-address=00:CD:FE:EC:B5:52 server="guest dhcp"
/ip dhcp-server lease add address=192.168.99.70 client-id=1:98:22:ef:26:fe:6e mac-address=98:22:EF:26:FE:6E server="main dhcp"
/ip dhcp-server lease add address=192.168.98.210 block-access=yes client-id=1:98:22:ef:26:fe:6e comment=asusGl mac-address=98:22:EF:26:FE:6E server="guest dhcp"
/ip dhcp-server lease add address=192.168.98.228 block-access=yes client-id=1:88:53:95:30:68:9f mac-address=88:53:95:30:68:9F server="guest dhcp"
/ip dhcp-server lease add address=192.168.98.225 block-access=yes client-id=1:ac:61:ea:ea:cc:84 mac-address=AC:61:EA:EA:CC:84 server="guest dhcp"
/ip dhcp-server lease add address=192.168.98.224 block-access=yes client-id=1:54:e4:3a:b8:12:7 mac-address=54:E4:3A:B8:12:07 server="guest dhcp"
/ip dhcp-server lease add address=192.168.99.180 address-lists=osx-hosts always-broadcast=yes mac-address=10:DD:B1:9E:19:5E server="main dhcp"
/ip dhcp-server lease add address=192.168.99.88 mac-address=94:C6:91:94:98:DC server="main dhcp"
/ip dhcp-server network add address=192.168.98.0/24 comment="Guest DHCP leasing (Yandex protected DNS)" dns-server=77.88.8.7 gateway=192.168.98.1 ntp-server=192.168.98.1
/ip dhcp-server network add address=192.168.99.0/26 comment="VIRTUAL MACHINES DHCP leasing" dhcp-option=DomainName dns-server=192.168.99.1,8.8.8.8 gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dhcp-server network add address=192.168.99.64/26 comment="WINDOWS DHCP leasing" dhcp-option=DomainName dns-server=192.168.99.1,8.8.8.8 gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dhcp-server network add address=192.168.99.128/26 comment="APPLE DHCP leasing" dhcp-option=DomainName dns-server=192.168.99.1 gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dhcp-server network add address=192.168.99.192/26 comment="DNS/PROXY redirect DHCP leasing" gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dns set allow-remote-requests=yes cache-max-ttl=1d query-server-timeout=3s servers=192.168.100.1
/ip dns static add address=95.213.159.180 name=atv.qello.com
/ip dns static add address=192.168.99.1 name=mikrouter.home
/ip dns static add address=192.168.99.1 name=mikrouter
/ip dns static add address=192.168.99.1 name=time.windows.com
/ip dns static add address=172.16.0.17 name=influxdb
/ip dns static add address=172.16.0.17 name=influxdb.home
/ip dns static add address=172.16.0.16 name=grafana
/ip dns static add address=172.16.0.16 name=grafana.home
/ip dns static add address=192.168.97.1 name=chr.home
/ip dns static add address=192.168.100.1 name=gateway.home
/ip dns static add address=192.168.99.190 comment="<AUTO:DHCP:main dhcp>" name=ATV.home ttl=5m
/ip dns static add address=192.168.99.70 comment="<AUTO:DHCP:main dhcp>" name=DESKTOP-UPPUU22.home ttl=5m
/ip dns static add address=192.168.99.140 comment="<AUTO:DHCP:main dhcp>" name=iPadAlx.home ttl=5m
/ip dns static add address=192.168.99.150 comment="<AUTO:DHCP:main dhcp>" name=iPhoneAlx.home ttl=5m
/ip dns static add address=192.168.99.130 comment="<AUTO:DHCP:main dhcp>" name=iPhoneGl.home ttl=5m
/ip dns static add address=192.168.99.170 comment="<AUTO:DHCP:main dhcp>" name=MbpAlx.home ttl=5m
/ip dns static add address=192.168.99.180 comment="<AUTO:DHCP:main dhcp>" name=miniAlx.home ttl=5m
/ip dns static add address=192.168.99.88 comment="<AUTO:DHCP:main dhcp>" name=DESKTOP-ELCNKHP.home ttl=5m
/ip dns static add address=109.252.109.27 name=ftpserver.org
/ip firewall address-list add address=192.168.99.0/24 list=Network
/ip firewall address-list add address=0.0.0.0/8 comment="RFC 1122 \"This host on this network\"" list=Bogons
/ip firewall address-list add address=10.0.0.0/8 comment="RFC 1918 (Private Use IP Space)" disabled=yes list=Bogons
/ip firewall address-list add address=100.64.0.0/10 comment="RFC 6598 (Shared Address Space)" list=Bogons
/ip firewall address-list add address=127.0.0.0/8 comment="RFC 1122 (Loopback)" list=Bogons
/ip firewall address-list add address=169.254.0.0/16 comment="RFC 3927 (Dynamic Configuration of IPv4 Link-Local Addresses)" list=Bogons
/ip firewall address-list add address=172.16.0.0/12 comment="RFC 1918 (Private Use IP Space)" list=Bogons
/ip firewall address-list add address=192.0.0.0/24 comment="RFC 6890 (IETF Protocol Assingments)" list=Bogons
/ip firewall address-list add address=192.0.2.0/24 comment="RFC 5737 (Test-Net-1)" list=Bogons
/ip firewall address-list add address=192.168.0.0/16 comment="RFC 1918 (Private Use IP Space)" disabled=yes list=Bogons
/ip firewall address-list add address=198.18.0.0/15 comment="RFC 2544 (Benchmarking)" list=Bogons
/ip firewall address-list add address=198.51.100.0/24 comment="RFC 5737 (Test-Net-2)" list=Bogons
/ip firewall address-list add address=203.0.113.0/24 comment="RFC 5737 (Test-Net-3)" list=Bogons
/ip firewall address-list add address=224.0.0.0/4 comment="RFC 5771 (Multicast Addresses) - Will affect OSPF, RIP, PIM, VRRP, IS-IS, and others. Use with caution.)" list=Bogons
/ip firewall address-list add address=240.0.0.0/4 comment="RFC 1112 (Reserved)" list=Bogons
/ip firewall address-list add address=192.31.196.0/24 comment="RFC 7535 (AS112-v4)" list=Bogons
/ip firewall address-list add address=192.52.193.0/24 comment="RFC 7450 (AMT)" list=Bogons
/ip firewall address-list add address=192.88.99.0/24 comment="RFC 7526 (Deprecated (6to4 Relay Anycast))" list=Bogons
/ip firewall address-list add address=192.175.48.0/24 comment="RFC 7534 (Direct Delegation AS112 Service)" list=Bogons
/ip firewall address-list add address=255.255.255.255 comment="RFC 919 (Limited Broadcast)" list=Bogons
/ip firewall address-list add address=192.168.99.0/24 comment="Add DNS Server to this List" list="DNS Allow"
/ip firewall address-list add address=8.8.8.8 comment="Add DNS Server to this List" list="DNS Allow"
/ip firewall address-list add address=8.8.4.4 comment="Add DNS Server to this List" list="DNS Allow"
/ip firewall address-list add address=192.168.100.1 comment="Add DNS Server to this List" list="DNS Allow"
/ip firewall address-list add address=4.2.2.2 comment="Add DNS Server to this List" list="DNS Allow"
/ip firewall address-list add address=185.6.175.49 comment="Manual Black List" disabled=yes list="Black List"
/ip firewall address-list add address=192.168.99.0/24 list="RDP Allow"
/ip firewall address-list add address=192.168.99.0/24 list="SMB Allow"
/ip firewall address-list add address=185.13.148.14 list="VPN server"
/ip firewall address-list add address=rutracker.org list=vpn-tunneled-sites
/ip firewall address-list add address=192.168.97.0/24 list="VPN network"
/ip firewall address-list add address=10.0.0.0/30 list="VPN server"
/ip firewall address-list add address=10.0.0.0/30 list="VPN network"
/ip firewall address-list add address=nnmclub.me list=vpn-tunneled-sites
/ip firewall address-list add address=2ip.ru list=vpn-tunneled-sites
/ip firewall address-list add address=10.0.0.0/24 list=Network
/ip firewall address-list add address=myexternalip.com list=vpn-tunneled-sites
/ip firewall address-list add address=91.108.4.0/22 list=Telegram
/ip firewall address-list add address=91.108.8.0/22 list=Telegram
/ip firewall address-list add address=91.108.12.0/22 list=Telegram
/ip firewall address-list add address=91.108.16.0/22 list=Telegram
/ip firewall address-list add address=91.108.56.0/22 list=Telegram
/ip firewall address-list add address=149.154.160.0/22 list=Telegram
/ip firewall address-list add address=149.154.164.0/22 list=Telegram
/ip firewall address-list add address=149.154.168.0/22 list=Telegram
/ip firewall address-list add address=149.154.172.0/22 list=Telegram
/ip firewall address-list add address=serverfault.com list=vpn-tunneled-sites
/ip firewall address-list add address=superuser.com comment=serverfault.com list=vpn-tunneled-sites
/ip firewall address-list add address=172.16.0.16/30 list=Network
/ip firewall address-list add address=192.168.98.0/24 comment="Add DNS Server to this List" list="DNS Allow"
/ip firewall address-list add address=xhamster.com list=vpn-tunneled-sites
/ip firewall address-list add address=ru.xhamster.com list=vpn-tunneled-sites
/ip firewall address-list add address=telegram.org list=Telegram
/ip firewall address-list add address=172.16.0.16 list=grafana-server
/ip firewall address-list add address=192.168.99.180 list=grafana-service
/ip firewall address-list add address=172.16.0.17 list=influxdb-server
/ip firewall address-list add address=192.168.99.180 list=influxdb-service
/ip firewall address-list add address=109.252.109.27 list=external-ip
/ip firewall filter add action=accept chain=input comment="OSFP neighbour-ing allow" log-prefix=#OSFP protocol=ospf
/ip firewall filter add action=jump chain=input comment="VPN Access" jump-target=vpn-rules
/ip firewall filter add action=accept chain=vpn-rules comment="L2TP tunnel" dst-port=1701 log-prefix=#L2TP protocol=udp
/ip firewall filter add action=accept chain=vpn-rules comment="VPN \"Allow IPSec-ah\"" log-prefix=#VPN protocol=ipsec-ah src-address-list="VPN server"
/ip firewall filter add action=accept chain=vpn-rules comment="VPN \"Allow IPSec-esp\"" log-prefix=#VPN_FRW protocol=ipsec-esp src-address-list="VPN server"
/ip firewall filter add action=accept chain=vpn-rules comment="VPN \"Allow IKE\" - IPSEC connection establishing" dst-port=500 log-prefix=#VPN_FRW protocol=udp src-address-list="VPN server"
/ip firewall filter add action=accept chain=vpn-rules comment="VPN \"Allow UDP\" - IPSEC data trasfer" dst-port=4500 log-prefix=#VPN_FRW protocol=udp src-address-list="VPN server"
/ip firewall filter add action=return chain=vpn-rules comment="VPN Access"
/ip firewall filter add action=accept chain=forward comment=VPN dst-address-list="VPN network" log-prefix=#VPN_FRW src-address-list=Network
/ip firewall filter add action=accept chain=forward comment=VPN dst-address-list=Network log-prefix=#VPN_FRW src-address-list="VPN network"
/ip firewall filter add action=jump chain=forward comment="Jump to RDP staged control" jump-target="RDP staged control"
/ip firewall filter add action=drop chain="RDP staged control" comment="drop rdp brute forcers" dst-port=3389 protocol=tcp src-address-list="RDP Block"
/ip firewall filter add action=add-src-to-address-list address-list="RDP Block" address-list-timeout=10h chain="RDP staged control" connection-state=new dst-port=3389 protocol=tcp src-address-list="RDP Stage3"
/ip firewall filter add action=add-src-to-address-list address-list="RDP Stage3" address-list-timeout=1m chain="RDP staged control" connection-state=new dst-port=3389 protocol=tcp src-address-list="RDP Stage2"
/ip firewall filter add action=add-src-to-address-list address-list="RDP Stage2" address-list-timeout=1m chain="RDP staged control" connection-state=new dst-port=3389 protocol=tcp src-address-list="RDP Stage1"
/ip firewall filter add action=add-src-to-address-list address-list="RDP Stage1" address-list-timeout=1m chain="RDP staged control" connection-state=new dst-port=3389 protocol=tcp src-address-list="!RDP Allow"
/ip firewall filter add action=return chain="RDP staged control" comment="Return From RDP staged control"
/ip firewall filter add action=drop chain=input comment="Drop Invalid Connections" connection-state=invalid in-interface-list=list-drop-invalid-connections
/ip firewall filter add action=drop chain=forward comment="Drop Invalid Connections" connection-state=invalid
/ip firewall filter add action=jump chain=forward comment="jump to SMB shares control" jump-target="SMB shares control" src-address-list="!SMB Allow"
/ip firewall filter add action=add-src-to-address-list address-list="SMB Shares" address-list-timeout=10h chain="SMB shares control" comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=#SMB protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list="SMB Shares" address-list-timeout=10h chain="SMB shares control" comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=#SMB protocol=tcp
/ip firewall filter add action=drop chain="SMB shares control" comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=#SMB protocol=tcp src-address-list="SMB Shares"
/ip firewall filter add action=drop chain="SMB shares control" comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=#SMB protocol=udp src-address-list="SMB Shares"
/ip firewall filter add action=return chain="SMB shares control" comment="Return from SMB shares control"
/ip firewall filter add action=drop chain=input comment="drop ftp brute forcers" dst-port=21 protocol=tcp src-address-list=ftp_blacklist
/ip firewall filter add action=accept chain=output comment="drop ftp brute forcers" content="530 Login incorrect" dst-limit=1/1m,9,dst-address/1m protocol=tcp
/ip firewall filter add action=add-dst-to-address-list address-list=ftp_blacklist address-list-timeout=3h chain=output comment="drop ftp brute forcers" content="530 Login incorrect" protocol=tcp
/ip firewall filter add action=jump chain=input comment="Jump to DNS Amplification" jump-target="DNS Amplification"
/ip firewall filter add action=accept chain="DNS Amplification" comment="Make exceptions for DNS" log-prefix=#DNS port=53 protocol=udp src-address-list="DNS Allow"
/ip firewall filter add action=accept chain="DNS Amplification" comment="Make exceptions for DNS" dst-address-list="DNS Allow" log-prefix=#DNS port=53 protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list="DNS Block" address-list-timeout=10h chain="DNS Amplification" comment="Add DNS Amplification to Blacklist" port=53 protocol=udp src-address-list="!DNS Allow"
/ip firewall filter add action=drop chain="DNS Amplification" comment="Drop DNS Amplification" src-address-list="DNS Block"
/ip firewall filter add action=return chain="DNS Amplification" comment="Return from DNS Amplification"
/ip firewall filter add action=accept chain=input comment="Self fetch requests" log=yes log-prefix=WEB port=80 protocol=tcp
/ip firewall filter add action=jump chain=input comment="Allow router services on the lan" in-interface="main infrastructure" jump-target=router-services-lan
/ip firewall filter add action=accept chain=router-services-lan comment="Winbox (8291/TCP)" dst-port=8291 protocol=tcp
/ip firewall filter add action=accept chain=router-services-lan comment=SNMP port=161 protocol=udp
/ip firewall filter add action=accept chain=router-services-lan comment=WEB port=80 protocol=tcp
/ip firewall filter add action=return chain=router-services-lan comment="Return from router-services-lan Chain"
/ip firewall filter add action=jump chain=input comment="Allow router services on the wan" in-interface=wan jump-target=router-services-wan
/ip firewall filter add action=drop chain=router-services-wan comment="SSH (22/TCP)" dst-port=22 protocol=tcp
/ip firewall filter add action=drop chain=router-services-wan comment="Winbox (8291/TCP)" dst-port=8291 protocol=tcp
/ip firewall filter add action=return chain=router-services-wan comment="Return from router-services-wan Chain"
/ip firewall filter add action=jump chain=input comment="Check for ping flooding" jump-target=detect-ping-flood protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="0:0 and limit for 5 pac/s" icmp-options=0:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="3:3 and limit for 5 pac/s" icmp-options=3:3 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="3:4 and limit for 5 pac/s" icmp-options=3:4 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="8:0 and limit for 5 pac/s" icmp-options=8:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="11:0 and limit for 5 pac/s" icmp-options=11:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=drop chain=detect-ping-flood comment="drop everything else" protocol=icmp
/ip firewall filter add action=return chain=detect-ping-flood comment="Return from detect-ping-flood Chain"
/ip firewall filter add action=log chain=forward comment=DUMMY1 log-prefix=#DUMMY1 src-address-list=dummy
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Manually Added)" src-address-list="Black List"
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Manually Added)" src-address-list="Black List"
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (SSH)" src-address-list="Black List (SSH)"
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (SSH)" src-address-list="Black List (SSH)"
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Telnet)" src-address-list="Black List (Telnet)"
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Telnet)" src-address-list="Black List (Telnet)"
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Winbox)" src-address-list="Black List (Winbox)"
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Winbox)" src-address-list="Black List (Winbox)"
/ip firewall filter add action=drop chain=input comment="Drop anyone in the WAN Port Scanner List" src-address-list=WAN-port-scanner
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the WAN Port Scanner List" src-address-list=WAN-port-scanner
/ip firewall filter add action=passthrough chain=input comment="Drop anyone in the LAN Port Scanner List" src-address-list=LAN-port-scanner
/ip firewall filter add action=passthrough chain=forward comment="Drop anyone in the LAN Port Scanner List" src-address-list=LAN-port-scanner
/ip firewall filter add action=drop chain=input comment="Drop all Bogons" src-address-list=Bogons
/ip firewall filter add action=drop chain=forward comment="Drop all Bogons" src-address-list=Bogons
/ip firewall filter add action=log chain=forward comment=DUMMY2 log-prefix=#DUMMY2 src-address-list=dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC SSH Chain" jump-target="RFC SSH Chain"
/ip firewall filter add action=add-src-to-address-list address-list="Black List (SSH)" address-list-timeout=1w3d chain="RFC SSH Chain" comment="Transfer repeated attempts from SSH Stage 3 to Black-List" connection-state=new dst-port=22 protocol=tcp src-address-list="SSH Stage 3"
/ip firewall filter add action=add-src-to-address-list address-list="SSH Stage 3" address-list-timeout=1m chain="RFC SSH Chain" comment="Add succesive attempts to SSH Stage 3" connection-state=new dst-port=22 protocol=tcp src-address-list="SSH Stage 2"
/ip firewall filter add action=add-src-to-address-list address-list="SSH Stage 2" address-list-timeout=1m chain="RFC SSH Chain" comment="Add succesive attempts to SSH Stage 2" connection-state=new dst-port=22 protocol=tcp src-address-list="SSH Stage 1"
/ip firewall filter add action=add-src-to-address-list address-list="SSH Stage 1" address-list-timeout=1m chain="RFC SSH Chain" comment="Add intial attempt to SSH Stage 1 List" connection-state=new dst-port=22 protocol=tcp
/ip firewall filter add action=return chain="RFC SSH Chain" comment="Return From RFC SSH Chain"
/ip firewall filter add action=log chain=forward comment=DUMMY3 log-prefix=#DUMMY3 src-address-list=dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Telnet Chain" jump-target="RFC Telnet Chain"
/ip firewall filter add action=add-src-to-address-list address-list="Black List (Telnet)" address-list-timeout=1w3d chain="RFC Telnet Chain" comment="Transfer repeated attempts from Telnet Stage 3 to Black-List" connection-state=new dst-port=23 protocol=tcp src-address-list="Telnet Stage 3"
/ip firewall filter add action=add-src-to-address-list address-list="Telnet Stage 3" address-list-timeout=1m chain="RFC Telnet Chain" comment="Add succesive attempts to Telnet Stage 3" connection-state=new dst-port=23 protocol=tcp src-address-list="Telnet Stage 2"
/ip firewall filter add action=add-src-to-address-list address-list="Telnet Stage 1" address-list-timeout=1m chain="RFC Telnet Chain" comment="Add Intial attempt to Telnet Stage 1" connection-state=new dst-port=23 protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list="Telnet Stage 2" address-list-timeout=1m chain="RFC Telnet Chain" comment="Add succesive attempts to Telnet Stage 2" connection-state=new dst-port=23 protocol=tcp src-address-list="Telnet Stage 1"
/ip firewall filter add action=return chain="RFC Telnet Chain" comment="Return From RFC Telnet Chain"
/ip firewall filter add action=log chain=forward comment=DUMMY4 log-prefix=#DUMMY4 src-address-list=dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Winbox Chain" jump-target="RFC Winbox Chain"
/ip firewall filter add action=add-src-to-address-list address-list="Black List (Winbox)" address-list-timeout=1w3d chain="RFC Winbox Chain" comment="Transfer repeated attempts from Winbox Stage 3 to Black-List" connection-state=new dst-port=8291 protocol=tcp src-address-list="Winbox Stage 3"
/ip firewall filter add action=add-src-to-address-list address-list="Winbox Stage 3" address-list-timeout=1m chain="RFC Winbox Chain" comment="Add succesive attempts to Winbox Stage 3" connection-state=new dst-port=8291 protocol=tcp src-address-list="Winbox Stage 2"
/ip firewall filter add action=add-src-to-address-list address-list="Winbox Stage 2" address-list-timeout=1m chain="RFC Winbox Chain" comment="Add succesive attempts to Winbox Stage 2" connection-state=new dst-port=8291 protocol=tcp src-address-list="Winbox Stage 1"
/ip firewall filter add action=add-src-to-address-list address-list="Winbox Stage 1" address-list-timeout=1m chain="RFC Winbox Chain" comment="Add Intial attempt to Winbox Stage 1" connection-state=new dst-port=8291 protocol=tcp
/ip firewall filter add action=return chain="RFC Winbox Chain" comment="Return From RFC Winbox Chain"
/ip firewall filter add action=log chain=forward comment=DUMMY5 log-prefix=#DUMMY5 src-address-list=dummy
/ip firewall filter add action=add-src-to-address-list address-list=WAN-port-scanner address-list-timeout=10h chain=input comment="Add TCP Port Scanners to Address List" protocol=tcp psd=40,3s,2,1 src-address-list=!WAN-port-scanner
/ip firewall filter add action=add-src-to-address-list address-list=LAN-port-scanner address-list-timeout=10h chain=forward comment="Add TCP Port Scanners to Address List" protocol=tcp psd=40,3s,2,1 src-address-list=!LAN-port-scanner
/ip firewall filter add action=log chain=forward comment=DUMMY6 log-prefix=#DUMMY6 src-address-list=dummy
/ip firewall filter add action=add-src-to-address-list address-list="WAN Highload" address-list-timeout=1h chain=input comment="WAN Highload" connection-limit=100,32 protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list="LAN Highload" address-list-timeout=10h chain=forward comment="LAN Highload" connection-limit=100,32 protocol=tcp
/ip firewall filter add action=jump chain=input comment="Jump to Virus Chain" jump-target=Virus
/ip firewall filter add action=drop chain=Virus comment=Conficker dst-port=593 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment=Worm dst-port=1024-1030 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="ndm requester" dst-port=1363 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="ndm server" dst-port=1364 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="screen cast" dst-port=1368 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment=hromgrafx dst-port=1373 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop MyDoom" dst-port=1080 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment=cichlid dst-port=1377 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment=Worm dst-port=1433-1434 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop Dumaru.Y" dst-port=2283 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop Beagle" dst-port=2535 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop Beagle.C-K" dst-port=2745 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop MyDoom" dst-port=3127-3128 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop Backdoor OptixPro" dst-port=3410 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop Sasser" dst-port=5554 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment=Worm dst-port=4444 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment=Worm dst-port=4444 protocol=udp
/ip firewall filter add action=drop chain=Virus comment="Drop Beagle.B" dst-port=8866 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop Dabber.A-B" dst-port=9898 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop Dumaru.Y" dst-port=10000 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop MyDoom.B" dst-port=10080 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop NetBus" dst-port=12345 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop Kuang2" dst-port=17300 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop SubSeven" dst-port=27374 protocol=tcp
/ip firewall filter add action=drop chain=Virus comment="Drop PhatBot, Agobot, Gaobot" dst-port=65506 protocol=tcp
/ip firewall filter add action=return chain=Virus comment="Return From Virus Chain"
/ip firewall filter add action=log chain=forward comment=DUMMY7 log-prefix=#DUMMY7 src-address-list=dummy
/ip firewall filter add action=jump chain=input comment="Jump to \"Manage Common Ports\" Chain" jump-target="Manage Common Ports"
/ip firewall filter add action=accept chain="Manage Common Ports" comment="\"All hosts on this subnet\" Broadcast" src-address=224.0.0.1
/ip firewall filter add action=accept chain="Manage Common Ports" comment="\"All routers on this subnet\" Broadcast" src-address=224.0.0.2
/ip firewall filter add action=accept chain="Manage Common Ports" comment="DVMRP (Distance Vector Multicast Routing Protocol)" src-address=224.0.0.4
/ip firewall filter add action=accept chain="Manage Common Ports" comment="OSPF - All OSPF Routers Broadcast" src-address=224.0.0.5
/ip firewall filter add action=accept chain="Manage Common Ports" comment="OSPF - OSPF DR Routers Broadcast" src-address=224.0.0.6
/ip firewall filter add action=accept chain="Manage Common Ports" comment="RIP Broadcast" src-address=224.0.0.9
/ip firewall filter add action=accept chain="Manage Common Ports" comment="EIGRP Broadcast" src-address=224.0.0.10
/ip firewall filter add action=accept chain="Manage Common Ports" comment="PIM Broadcast" src-address=224.0.0.13
/ip firewall filter add action=accept chain="Manage Common Ports" comment="VRRP Broadcast" src-address=224.0.0.18
/ip firewall filter add action=accept chain="Manage Common Ports" comment="IS-IS Broadcast" src-address=224.0.0.19
/ip firewall filter add action=accept chain="Manage Common Ports" comment="IS-IS Broadcast" src-address=224.0.0.20
/ip firewall filter add action=accept chain="Manage Common Ports" comment="IS-IS Broadcast" src-address=224.0.0.21
/ip firewall filter add action=accept chain="Manage Common Ports" comment="IGMP Broadcast" src-address=224.0.0.22
/ip firewall filter add action=accept chain="Manage Common Ports" comment="GRE Protocol (Local Management)" protocol=gre
/ip firewall filter add action=accept chain="Manage Common Ports" comment="FTPdata transfer" log-prefix=#FTP port=20 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="FTPcontrol (command)" log-prefix=#FTP port=21 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="FTPdata transfer  " log-prefix=#FTP port=20 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Secure Shell(SSH)" port=22 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Secure Shell(SSH)   " port=22 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment=Telnet port=23 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment=Telnet port=23 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Priv-mail: any privatemailsystem." port=24 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Priv-mail: any privatemailsystem.  " port=24 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Simple Mail Transfer Protocol(SMTP)" port=25 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Simple Mail Transfer Protocol(SMTP)  " port=25 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="TIME protocol" port=37 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="TIME protocol  " port=37 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="ARPA Host Name Server Protocol & WINS" port=42 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="ARPA Host Name Server Protocol  & WINS  " port=42 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="WHOIS protocol" port=43 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="WHOIS protocol" port=43 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Domain Name System (DNS)" port=53 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Domain Name System (DNS)" port=53 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Mail Transfer Protocol(RFC 780)" port=57 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="(BOOTP) Server & (DHCP)  " port=67 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="(BOOTP) Client & (DHCP)  " port=68 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Trivial File Transfer Protocol (TFTP)  " port=69 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Gopher protocol" port=70 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Finger protocol" port=79 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Hypertext Transfer Protocol (HTTP)" port=80 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="RemoteTELNETService protocol" port=107 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Post Office Protocolv2 (POP2)" port=109 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Post Office Protocolv3 (POP3)" port=110 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="IdentAuthentication Service/Identification Protocol" port=113 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Authentication Service (auth)  " port=113 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Simple File Transfer Protocol (SFTP)" port=115 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Network Time Protocol(NTP)" port=123 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="NetBIOSNetBIOS Name Service" port=137 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="NetBIOSNetBIOS Name Service  " port=137 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="NetBIOSNetBIOS Datagram Service" port=138 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="NetBIOSNetBIOS Datagram Service  " port=138 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="NetBIOSNetBIOS Session Service" port=139 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="NetBIOSNetBIOS Session Service  " port=139 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Internet Message Access Protocol (IMAP)" port=143 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Background File Transfer Program (BFTP)" port=152 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Background File Transfer Program (BFTP)  " port=152 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="SGMP,Simple Gateway Monitoring Protocol" port=153 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="SGMP,Simple Gateway Monitoring Protocol  " port=153 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="DMSP, Distributed Mail Service Protocol" port=158 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="DMSP, Distributed Mail Service Protocol  " port=158 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Simple Network Management Protocol(SNMP)  " port=161 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Simple Network Management ProtocolTrap (SNMPTRAP)" port=162 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Simple Network Management ProtocolTrap (SNMPTRAP)  " port=162 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="BGP (Border Gateway Protocol)" port=179 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Internet Message Access Protocol (IMAP), version 3" port=220 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Internet Message Access Protocol (IMAP), version 3" port=220 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="BGMP, Border Gateway Multicast Protocol" port=264 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="BGMP, Border Gateway Multicast Protocol  " port=264 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Lightweight Directory Access Protocol (LDAP)" port=389 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Lightweight Directory Access Protocol (LDAP)" port=389 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="SSTP TCP Port 443 (Local Management) & HTTPS" port=443 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Microsoft-DSActive Directory, Windows shares" port=445 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="L2TP/ IPSEC UDP Port 500 (Local Management)" port=500 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Modbus, Protocol" port=502 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Modbus, Protocol  " port=502 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Shell (Remote Shell, rsh, remsh)" port=514 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Syslog - used for system logging  " port=514 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Routing Information Protocol (RIP)  " port=520 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="e-mail message submission (SMTP)" port=587 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="LDP,Label Distribution Protocol" port=646 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="LDP,Label Distribution Protocol" port=646 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="FTPS Protocol (data):FTP over TLS/SSL" port=989 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="FTPS Protocol (data):FTP over TLS/SSL" port=989 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="FTPS Protocol (control):FTP over TLS/SSL" port=990 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="FTPS Protocol (control):FTP over TLS/SSL" port=990 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="TELNET protocol overTLS/SSL" port=992 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="TELNET protocol overTLS/SSL" port=992 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Internet Message Access Protocol over TLS/SSL (IMAPS)" port=993 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="Post Office Protocol3 over TLS/SSL (POP3S)" port=995 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="OVPN TCP Port 1194 (Local Management)" port=1194 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="PPTP Port 1723 (Local Management)" port=1723 protocol=tcp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="L2TP UDP Port 1701 (Local Management)" port=1701 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="L2TP UDP Port 4500 (Local Management)" port=4500 protocol=udp
/ip firewall filter add action=accept chain="Manage Common Ports" comment="WINBOX TCP Port 8291 (Local Management)" port=8291 protocol=tcp
/ip firewall filter add action=accept chain=input comment="TCP/UDP ports necessary for SMB" dst-port=137-138 log-prefix=#SMB protocol=udp src-address-list="SMB Allow"
/ip firewall filter add action=accept chain=input comment="TCP/UDP ports necessary for SMB" dst-port=137,139 log-prefix=#SMB protocol=tcp src-address-list="SMB Allow"
/ip firewall filter add action=accept chain=input comment="Accept Related or Established Connections" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (INPUT)"
/ip firewall filter add action=accept chain=forward comment="Accept New Connections" connection-state=new log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=accept chain=forward comment="Accept Related or Established Connections" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=accept chain=input comment="Allow proxy on 8888" dst-port=8888 in-interface="main infrastructure" protocol=tcp
/ip firewall filter add action=log chain=forward comment=DUMMY8 log-prefix=#DUMMY8 src-address-list=dummy
/ip firewall filter add action=drop chain=input comment="Open proxy block" dst-port=8888 in-interface=wan protocol=tcp
/ip firewall filter add action=drop chain=forward comment="WAN static-routes intruders not DSTNATed drop" connection-nat-state=dstnat connection-state=new in-interface=wan log-prefix="#DROP UNKNOWN (FWD/no DSTN)"
/ip firewall filter add action=drop chain=forward comment="Drop all other LAN Traffic" log-prefix="#DROP UNKNOWN (FWD)"
/ip firewall filter add action=drop chain=input comment="Drop all other WAN Traffic" log-prefix="#DROP UNKNOWN (INPUT)"
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" in-interface=all-ppp new-mss=1360 passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" new-mss=1360 out-interface=all-ppp passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=mark-connection chain=prerouting comment="Mark l2tp" connection-mark=no-mark connection-state=new dst-address-list=vpn-tunneled-sites new-connection-mark=vpn-l2tp passthrough=yes
/ip firewall mangle add action=mark-connection chain=prerouting comment="Mark l2tp (telegram)" connection-mark=no-mark connection-state=new dst-address-list=Telegram new-connection-mark=vpn-l2tp passthrough=yes
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self, telegram notify)" dst-address-list=Telegram log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self)" dst-address-list=vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites" connection-mark=vpn-l2tp dst-address-list=vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites (telegram)" connection-mark=vpn-l2tp dst-address-list=Telegram log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-packet chain=input comment="VPN Traffic" log-prefix="#VPN PCKT MARK" new-packet-mark="IPSEC PCKT" passthrough=yes protocol=ipsec-esp
/ip firewall mangle add action=mark-connection chain=prerouting comment="Provider mark" connection-mark=no-mark in-interface=wan new-connection-mark=MGTS passthrough=no
/ip firewall mangle add action=mark-packet chain=prerouting comment=7z layer7-protocol=7Z log-prefix=#DL_7z new-packet-mark=7z-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-packet chain=prerouting comment=bin layer7-protocol=BIN log-prefix=#DL_bin new-packet-mark=bin-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-packet chain=prerouting comment=iso layer7-protocol=ISO log-prefix=#DL_iso new-packet-mark=iso-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-packet chain=prerouting comment=exe layer7-protocol=EXE log-prefix=#DL_exe new-packet-mark=exe-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-packet chain=prerouting comment=mp3 layer7-protocol=MP3 log-prefix=#DL_mp3 new-packet-mark=mp3-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-packet chain=prerouting comment=pdf layer7-protocol=PDF log-prefix=#DL_pdf new-packet-mark=pdf-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-packet chain=prerouting comment=rar layer7-protocol=RAR log-prefix=#DL_rar new-packet-mark=rar-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-packet chain=prerouting comment=zip layer7-protocol=ZIP log-prefix=#DL_zip new-packet-mark=zip-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=add-src-to-address-list address-list=lan-routers address-list-timeout=none-dynamic chain=prerouting comment="LAN Routers detection" ttl=equal:63
/ip firewall mangle add action=add-src-to-address-list address-list=lan-routers address-list-timeout=none-dynamic chain=prerouting comment="LAN Routers detection" ttl=equal:127
/ip firewall nat add action=redirect chain=dstnat comment="Redirect DNS requests to router (prevent local DNS assignment)" dst-port=53 log-prefix="#DNS Req" protocol=udp
/ip firewall nat add action=redirect chain=dstnat comment="Redirect DNS requests to router (prevent local DNS assignment)" dst-port=53 protocol=tcp
/ip firewall nat add action=dst-nat chain=dstnat comment="Redirect to GRAFANA (map to port 3000, local only)" dst-address-list=grafana-server dst-port=80 in-interface="main infrastructure" protocol=tcp src-address-list=Network to-addresses=192.168.99.180 to-ports=3000
/ip firewall nat add action=masquerade chain=srcnat comment="Backward redirect to GRAFANA  (local only)" dst-address-list=grafana-service dst-port=3000 out-interface="main infrastructure" protocol=tcp src-address-list=Network
/ip firewall nat add action=dst-nat chain=dstnat comment="Redirect to INFLUXDB (map to port 8000, local only)" dst-address-list=influxdb-server dst-port=80 in-interface="main infrastructure" protocol=tcp src-address-list=Network to-addresses=192.168.99.180 to-ports=8000
/ip firewall nat add action=masquerade chain=srcnat comment="Backward redirect to INFLUXDB  (local only)" dst-address-list=influxdb-service dst-port=8000 out-interface="main infrastructure" protocol=tcp src-address-list=Network
/ip firewall nat add action=accept chain=srcnat comment="accept tunnel traffic" dst-address-list="VPN network" log-prefix=#VPN_NAT src-address-list=Network
/ip firewall nat add action=accept chain=srcnat comment="accept tunnel traffic (sites)" dst-address-list=vpn-tunneled-sites log-prefix=#VPN_NAT
/ip firewall nat add action=accept chain=dstnat comment="accept tunnel traffic" dst-address-list=Network log-prefix=#VPN_NAT src-address-list="VPN network"
/ip firewall nat add action=masquerade chain=srcnat comment="VPN masq (pure L2TP, w/o IPSEC)" out-interface=tunnel
/ip firewall nat add action=netmap chain=dstnat comment="WINBOX pass through" dst-port=9999 in-interface=wan log-prefix=#WNBOX protocol=tcp to-addresses=192.168.99.1 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="WINBOX NAT loopback" dst-address-list=external-ip dst-address-type="" dst-port=8291 in-interface="main infrastructure" log-prefix=#LOOP protocol=tcp src-address-list=Network to-addresses=192.168.99.1 to-ports=8291
/ip firewall nat add action=netmap chain=dstnat comment="WEB pass through" dst-port=8888 in-interface=wan log-prefix="#WEB EXT CTRL" protocol=tcp to-addresses=192.168.99.1 to-ports=80
/ip firewall nat add action=dst-nat chain=dstnat comment="WEB NAT loopback" dst-address-list=external-ip dst-address-type="" dst-port=80 in-interface="main infrastructure" log-prefix=#LOOP protocol=tcp src-address-list=Network to-addresses=192.168.99.1 to-ports=80
/ip firewall nat add action=netmap chain=dstnat comment="FTP pass through" dst-port=1111 in-interface=wan log-prefix=#FTP protocol=tcp to-addresses=192.168.99.80 to-ports=21
/ip firewall nat add action=netmap chain=dstnat comment="FTP pass through PASV" dst-port=65000-65050 in-interface=wan log-prefix=#FTP protocol=tcp to-addresses=192.168.99.80 to-ports=65000-65050
/ip firewall nat add action=dst-nat chain=dstnat comment="FTP NAT loopback" dst-address-list=external-ip dst-address-type="" dst-port=21 in-interface="main infrastructure" log-prefix=#LOOP protocol=tcp src-address-list=Network to-addresses=192.168.99.80 to-ports=21
/ip firewall nat add action=netmap chain=dstnat comment="RDP pass through" dst-address-type=local dst-port=3333 in-interface=wan log-prefix=#RDP protocol=tcp to-addresses=192.168.99.80 to-ports=3389
/ip firewall nat add action=dst-nat chain=dstnat comment="RDP NAT loopback" dst-address-list=external-ip dst-address-type="" dst-port=3389 in-interface="main infrastructure" log-prefix=#LOOP protocol=tcp src-address-list=Network to-addresses=192.168.99.80 to-ports=3389
/ip firewall nat add action=masquerade chain=srcnat comment="all WAN allowed" dst-address-list="!VPN network" out-interface=wan
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set irc disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip firewall service-port set udplite disabled=yes
/ip firewall service-port set dccp disabled=yes
/ip firewall service-port set sctp disabled=yes
/ip hotspot service-port set ftp disabled=yes
/ip ipsec identity add peer=CHR-internal policy-template-group=inside-ipsec-encryption remote-id=ignore
/ip ipsec identity add auth-method=digital-signature certificate=mikrouter@CHR peer=CHR-external policy-template-group=outside-ipsec-encryption remote-id=ignore
/ip ipsec policy set 0 proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip ipsec policy add comment="Common IPSEC TRANSPORT (outer-tunnel encryption)" dst-address=185.13.148.14/32 dst-port=1701 proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=192.168.100.7/32 src-port=1701
/ip ipsec policy add comment="Common IPSEC TUNNEL (traffic-only encryption)" dst-address=192.168.97.0/30 proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" sa-dst-address=10.0.0.1 sa-src-address=10.0.0.2 src-address=192.168.99.0/24 tunnel=yes
/ip proxy set anonymous=yes cache-administrator=defm.kopcap@gmail.com enabled=yes max-client-connections=10 max-fresh-time=20m max-server-connections=10 parent-proxy=0.0.0.0 port=8888 serialize-connections=yes
/ip proxy access add action=deny dst-host=grafana redirect-to=192.168.99.180:3000
/ip proxy access add action=deny dst-host=influxdb redirect-to=192.168.99.180:8000
/ip route add comment=api.telegram.org disabled=yes distance=1 gateway=tunnel routing-mark=mark-telegram
/ip route add comment="GLOBAL MGTS" distance=50 gateway=192.168.100.1
/ip route rule add action=unreachable comment="LAN/GUEST isolation" dst-address=192.168.98.0/24 src-address=192.168.99.0/24
/ip route rule add action=unreachable comment="LAN/GUEST isolation" dst-address=192.168.99.0/24 src-address=192.168.98.0/24
/ip route rule add comment=API.TELEGRAM.ORG dst-address=149.154.167.0/24 table=mark-telegram
/ip service set telnet disabled=yes
/ip service set ftp disabled=yes
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip smb set allow-guests=no domain=HNW interfaces="main infrastructure"
/ip smb shares set [ find default=yes ] directory=/pub disabled=yes
/ip ssh set allow-none-crypto=yes
/ip tftp add real-filename=NAS/ req-filename=.*
/ip traffic-flow set cache-entries=64k enabled=yes interfaces=wan
/ip upnp set enabled=yes
/ip upnp interfaces add interface=wan type=external
/ip upnp interfaces add interface="main infrastructure" type=internal
/ip upnp interfaces add interface="guest infrastructure" type=internal
/routing filter add action=discard chain=ospf-in comment="discard intra area routes" ospf-type=intra-area
/routing filter add action=accept chain=ospf-in comment="set default remote route mark" prefix-length=0 set-pref-src=10.0.0.2 set-route-comment="GLOBAL VPN" set-routing-mark=mark-site-over-vpn
/routing filter add action=accept chain=ospf-in comment="set pref source" set-pref-src=10.0.0.2
/routing ospf nbma-neighbor add address=10.255.255.1
/routing ospf network add area=local network=192.168.99.0/24
/routing ospf network add area=backbone network=10.0.0.0/30
/routing ospf network add area=backbone network=10.255.255.2/32
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces="main infrastructure" trap-version=2
/system clock set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity set name=mikrouter
/system logging set 0 action=OnScreenLog topics=info,!ipsec,!script,!dns
/system logging set 1 action=OnScreenLog
/system logging set 2 action=OnScreenLog
/system logging set 3 action=TerminalConsoleLog
/system logging add action=IpsecOnScreenLog topics=ipsec,!debug
/system logging add action=ErrorDiskLog topics=critical
/system logging add action=ErrorDiskLog topics=error
/system logging add action=ScriptsDiskLog topics=script
/system logging add action=OnScreenLog topics=firewall
/system logging add action=OnScreenLog topics=smb
/system logging add action=OnScreenLog topics=critical
/system logging add action=DHCPOnScreenLog topics=dhcp
/system logging add action=DNSOnScreenLog topics=dns
/system logging add action=OSPFOnscreenLog topics=ospf,!raw
/system logging add action=OnScreenLog topics=event
/system logging add action=L2TPOnScreenLog topics=l2tp
/system logging add action=AuthDiskLog topics=account
/system logging add action=CertificatesOnScreenLog topics=certificate
/system logging add action=AuthDiskLog topics=manager
/system logging add action=ParseMemoryLog topics=account
/system logging add action=ParseMemoryLog topics=wireless
/system note set note="You are logged into: mikrouter\
    \n############### system health ###############\
    \nUptime:  00:00:37 d:h:m:s | CPU: 40%\
    \nRAM: 33448/131072M | Voltage: 23 v | Temp: 51c\
    \n############# user auth details #############\
    \nHotspot online: 0 | PPP online: 0\
    \n"
/system ntp client set enabled=yes primary-ntp=195.151.98.66 secondary-ntp=46.254.216.9
/system ntp server set broadcast=yes enabled=yes multicast=yes
/system package update set channel=testing
/system scheduler add interval=1h name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=read,write,policy,password start-date=jan/30/2017 start-time=18:57:09
/system scheduler add interval=10h name=doIpsecPolicyUpd on-event="/system script run doIpsecPolicyUpd" policy=read,write start-date=feb/21/2017 start-time=15:31:13
/system scheduler add interval=1d name=doUpdateStaticDNSviaDHCP on-event="/system script run doUpdateStaticDNSviaDHCP" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/21/2017 start-time=19:19:59
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sensitive start-date=mar/01/2018 start-time=15:54:04
/system scheduler add disabled=yes interval=1w3d name=doAdblock on-event="/system script run doAdblock" policy=read,write,policy,test start-date=mar/01/2018 start-time=19:01:38
/system scheduler add interval=1w3d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jun/26/2018 start-time=15:17:58
/system scheduler add interval=30m name=doHeatFlag on-event="/system script run doHeatFlag" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/10/2018 start-time=15:06:29
/system scheduler add interval=1h name=doCollectSpeedStats on-event="/system script run doCollectSpeedStats" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2018 start-time=14:41:22
/system scheduler add interval=1h name=doCheckPingRate on-event="/system script run doCheckPingRate" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2018 start-time=14:41:22
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=07:00:00
/system scheduler add interval=1m name=doPeriodicLogDump on-event="/system script run doPeriodicLogDump" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=11:31:24
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=1d name=doTrackFirmwareUpdates on-event="/system script run doTrackFirmwareUpdates" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=11:30:00
/system script add dont-require-permissions=yes name=doUpdateStaticDNSviaDHCP owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doUpdateStaticDNSviaDHCP\";\r\
    \n\r\
    \n# Creates static DNS entres for DHCP clients in the named DHCP server.\r\
    \n# Hostnames passed to DHCP are appended with the zone.\r\
    \n#\r\
    \n\r\
    \n# Name of the DHCP server instance:\r\
    \n:local dhcpServer \"main dhcp\"\r\
    \n\r\
    \n# DNS zone suffix:\r\
    \n:local dnsSuffix \".home\"\r\
    \n\r\
    \n# DNS TTL:\r\
    \n:local ttl \"00:05:00\"\r\
    \n\r\
    \n# Enable console debug:\r\
    \n#:local debugout do={ :put (\"DEBUG: \" . [:tostr \$1]); }\r\
    \n# Disable console debug:\r\
    \n:local debugout do={ :log debug \$1; }\r\
    \n\r\
    \n#----- END OF CONFIG -----#\r\
    \n\r\
    \n:local cleanHostname do={\r\
    \n  :local max ([:len \$1] - 1);\r\
    \n  :if (\$1 ~ \"^[a-zA-Z0-9]+[a-zA-Z0-9\\\\-]*[a-zA-Z0-9]+\\\$\" && ([:pick \$1 (\$max)] != \"\\00\")) do={\r\
    \n    :return (\$1);\r\
    \n  } else={\r\
    \n    :local cleaned \"\";\r\
    \n    :for i from=0 to=\$max do={\r\
    \n      :local c [:pick \$1 \$i]\r\
    \n      :if (\$c ~ \"^[a-zA-Z0-9]{1}\\\$\") do={\r\
    \n        :set cleaned (\$cleaned . \$c)\r\
    \n      } else={\r\
    \n        if (\$c = \"-\" and \$i > 0 and \$i < \$max) do={\r\
    \n          :set cleaned (\$cleaned . \$c)\r\
    \n        }\r\
    \n      }\r\
    \n    }\r\
    \n    :return (\$cleaned);\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# Cache current DHCP lease IDs and cleaned hostnames\r\
    \n:local dhcpLeases\r\
    \n:set \$dhcpLeases [:toarray \"\"]\r\
    \n/ip dhcp-server lease\r\
    \n:foreach lease in=[find where server=\$dhcpServer] do={\r\
    \n  :local hostRaw [get \$lease host-name]\r\
    \n  :if ([:len \$hostRaw] > 0) do={\r\
    \n    :local hostCleaned\r\
    \n    :set hostCleaned [\$cleanHostname \$hostRaw]\r\
    \n    :set (\$dhcpLeases->\$hostCleaned) \$lease\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# Remove or update stale DNS entries\r\
    \n/ip dns static\r\
    \n:foreach record in=[find where comment=\"<AUTO:DHCP:\$dhcpServer>\"] do={\r\
    \n  :local fqdn [get \$record name]\r\
    \n  :local hostname [:pick \$fqdn 0 ([:len \$fqdn] - [:len \$dnsSuffix])]\r\
    \n  :local leaseMatch (\$dhcpLeases->\$hostname)\r\
    \n  \r\
    \n  :if ([:len \$leaseMatch] < 1) do={\r\
    \n    \$debugout (\"Removing stale DNS record '\$fqdn'\")\r\
    \n    remove \$record\r\
    \n  } else={\r\
    \n    :local lease [/ip dhcp-server lease get \$leaseMatch address]\r\
    \n    :if (\$lease != [get \$record address]) do={\r\
    \n      \$debugout (\"Updating stale DNS record '\$fqdn' to \$lease\")\r\
    \n      :do {\r\
    \n        set \$record address=\$lease\r\
    \n      } on-error={\r\
    \n        :log warning \"Unable to update stale DNS record '\$fqdn'\"\r\
    \n      }\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# Add new DNS entries\r\
    \n/ip dns static\r\
    \n:foreach k,v in=\$dhcpLeases do={\r\
    \n  :local fqdn (\$k . \$dnsSuffix)\r\
    \n  :if ([:len [find where name=\$fqdn]] < 1) do={\r\
    \n    :local lease [/ip dhcp-server lease get \$v address]\r\
    \n    \$debugout (\"Creating DNS record '\$fqdn': \$lease\")\r\
    \n    :do {\r\
    \n      add name=\$fqdn address=\$lease ttl=\$ttl comment=\"<AUTO:DHCP:\$dhcpServer>\"\r\
    \n    } on-error={\r\
    \n      :log warning \"Unable to create DNS record '\$fqdn'\"\r\
    \n    }\r\
    \n  }\r\
    \n}"
/system script add dont-require-permissions=yes name=doImperialMarch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doImperialMarch\";\r\
    \n\r\
    \n:delay 6\r\
    \n\r\
    \n:beep frequency=500 length=500ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=500 length=500ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=500 length=500ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=400 length=500ms;\r\
    \n:delay 400ms;\r\
    \n\r\
    \n:beep frequency=600 length=200ms;\r\
    \n:delay 100ms;\r\
    \n\r\
    \n:beep frequency=500 length=500ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=400 length=500ms;\r\
    \n:delay 400ms;\r\
    \n\r\
    \n:beep frequency=600 length=200ms;\r\
    \n:delay 100ms;\r\
    \n\r\
    \n:beep frequency=500 length=500ms;\r\
    \n:delay 1000ms;\r\
    \n\r\
    \n\r\
    \n\r\
    \n:beep frequency=750 length=500ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=750 length=500ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=750 length=500ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=810 length=500ms;\r\
    \n:delay 400ms;\r\
    \n\r\
    \n:beep frequency=600 length=200ms;\r\
    \n:delay 100ms;\r\
    \n\r\
    \n:beep frequency=470 length=500ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=400 length=500ms;\r\
    \n:delay 400ms;\r\
    \n\r\
    \n:beep frequency=600 length=200ms;\r\
    \n:delay 100ms;\r\
    \n\r\
    \n:beep frequency=500 length=500ms;\r\
    \n:delay 1000ms;"
/system script add dont-require-permissions=yes name=doUpdateExternalDNS owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local content\
    \n:local IPv4\
    \n:global LastIPv4\
    \n\
    \n# Getting my current IPv4 address\
    \n\
    \n# via web\
    \n\
    \n\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doUpdateExternalDNS\";\r\
    \n\r\
    \n# parsing the current IPv4 result\
    \n:set IPv4 [/ip cloud get public-address];\
    \n\
    \n:put \"EXTERNAL IP: Current IPv4 = \$IPv4\";\
    \n:log info \"EXTERNAL IP: Current IPv4 = \$IPv4\";\
    \n\
    \n:if ((\$LastIPv4 != \$IPv4) || (\$force = true)) do={\
    \n   :put \"EXTERNAL IP: update needed!\";\
    \n   :log info \"EXTERNAL IP: update needed!\";\
    \n\
    \n    :log info \"Address list updated: external-ip\";\
    \n   /ip firewall address-list remove [find list~\"external-ip\"];\
    \n   /ip firewall address-list add list=\"external-ip\" address=\$IPv4;\
    \n   \
    \n   /ip dns static remove [/ip dns static find name=ftpserver.org];\
    \n   \r\
    \n   :log info \"Address list updated: Static DNS of ftpserver.org\";\
    \n   /ip dns static add name=ftpserver.org address=\$IPv4;\
    \n \
    \n   :set LastIPv4 \$IPv4;\
    \n    \
    \n} else={\
    \n   :put \"EXTERNAL IP: no update needed!\"\
    \n   :log info \"EXTERNAL IP: no update needed!\"\
    \n}\
    \n\
    \n"
/system script add dont-require-permissions=no name=doCoolConcole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doCoolConcole\";\r\
    \n\r\
    \n:local content\r\
    \n:local logcontenttemp \"\"\r\
    \n:local logcontent \"\"\r\
    \n:local counter\r\
    \n:local v 0\r\
    \n \r\
    \n:set logcontenttemp \"You are logged into: \$[/system identity get name]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"\\n\")\r\
    \n \r\
    \n:set logcontenttemp \"############### system health ###############\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"\\n\")\r\
    \n \r\
    \n:set logcontenttemp \"Uptime:  \$[/system resource get uptime] d:h:m:s\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" | \")\r\
    \n \r\
    \n:set logcontenttemp \"CPU: \$[/system resource get cpu-load]%\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"\\n\")\r\
    \n \r\
    \n:set logcontenttemp \"RAM: \$(([/system resource get total-memory]-[/system resource get free-memory])/1024)/\$([/system resource get total-memory]/1024)M\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" | \")\r\
    \n \r\
    \n##\r\
    \n#voltage and temp readout not available on x86, check for this before trying\r\
    \n#to record otherwise script will halt unexpectedly\r\
    \n##\r\
    \n \r\
    \n:if ([/system resource get architecture-name]=\"x86\") do={\r\
    \n  :set logcontenttemp \"Voltage: NIL\"\r\
    \n  :set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" | \")\r\
    \n  :set logcontenttemp \"Temp: NIL\"\r\
    \n  :set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"\\n\")\r\
    \n} else={\r\
    \n  :set logcontenttemp \"Voltage: \$[:pick [/system health get voltage] 0 2] v\"\r\
    \n  :set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" | \")\r\
    \n  :set logcontenttemp \"Temp: \$[ /system health get temperature]c\"\r\
    \n  :set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"\\n\")\r\
    \n}\r\
    \n \r\
    \n:set logcontenttemp \"############# user auth details #############\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"\\n\")\r\
    \n \r\
    \n:foreach counter in=[/ip hotspot active find ] do={:set v (\$v + 1)}\r\
    \n:set logcontenttemp \"Hotspot online: \$v |\"\r\
    \n:set v 0\r\
    \n:foreach counter in=[/ppp active find ] do={:set v (\$v + 1)}\r\
    \n:set logcontenttemp (\"\$logcontenttemp\" . \" PPP online: \$v\")\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"\\n\")\r\
    \n \r\
    \n/system note set note=\"\$logcontent\""
/system script add dont-require-permissions=yes name=doIpsecPolicyUpd owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local PolicyComment \"UBUNTU VPN traffic\"\r\
    \n:local WANip [/ip address get [find interface=\"wan\"] address] \r\
    \n:local shortWANip ( [:pick \"\$WANip\" 0 [:find \"\$WANip\" \"/\" -1]] ) \r\
    \n\r\
    \n:do {\r\
    \n:local extip ( \$shortWANip . \"/32\" ) \r\
    \n\r\
    \n:local IPSECip [/ip ipsec policy get [find comment=\"\$PolicyComment\"] sa-src-address] \r\
    \n\r\
    \nif (\$shortWANip != \$IPSECip) do={ \r\
    \n/ip ipsec policy set [find comment=\"\$PolicyComment\"] sa-src-address=\$shortWANip src-address=\$extip \r\
    \n}\r\
    \n} on-error={\r\
    \n        :put \"IPSEC Policy Updater: 'WAN' Unable to update IPSEC address'\"\r\
    \n        :log info \"IPSEC Policy Updater: 'WAN' Unable to update IPSEC address'\"\r\
    \n}"
/system script add dont-require-permissions=no name=doFastTrackActivation owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/ip settings set allow-fast-path=yes\r\
    \n/ip firewall filter add chain=forward action=fasttrack-connection connection-state=established,related"
/system script add dont-require-permissions=yes name=doWestminister owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doWestminister\";\r\
    \n\r\
    \n#Westminister Sequence #1\r\
    \n# E-660 D-588 C-528 G-396\r\
    \n# EDCG\r\
    \n:beep length=480ms frequency=660\r\
    \n:delay 500ms\r\
    \n:beep length=480ms frequency=588\r\
    \n:delay 500ms\r\
    \n:beep length=480ms frequency=528\r\
    \n:delay 500ms\r\
    \n:beep length=480ms frequency=396\r\
    \n:delay 10000ms"
/system script add dont-require-permissions=no name=doAdblock owner=reserved policy=read,write,policy source="## StopAD - Script for blocking advertisements, based on your defined hosts files\r\
    \n## For changing any parameters, please, use this link: https://stopad.cgood.ru/\r\
    \n##\r\
    \n## @github    <https://github.com/tarampampam/mikrotik-hosts-parser>\r\
    \n## @version   2.0.2\r\
    \n##\r\
    \n## Setup this Policy for script: [X] Read [X] Write [X] Policy [X] Test\r\
    \n\r\
    \n:local hostScriptUrl \"https://stopad.cgood.ru/script/source\?format=routeros&version=2.0.2&sources_urls=https%3A%2F%2Fcdn.rawgit.com%2Ftarampampam%2Fstatic%2Fmaster%2Fhosts%2Fblock_shit.txt,http%3A%2F%2Fadaway.org%2Fhosts.txt,http%3A%2F%2Fpgl.yoyo.org%2Fadservers%2Fserverlist.php%3Fhostformat%3Dhosts%26showintro%3D0%26mimetype%3Dplaintext&excluded_hosts=localhost\";\r\
    \n:local scriptName \"stop_ad.script\";\r\
    \n:local backupFileName \"before_stopad\";\r\
    \n:local logPrefix \"[StopAD]\";\r\
    \n\r\
    \ndo {\r\
    \n  /tool fetch check-certificate=no mode=https url=\$hostScriptUrl dst-path=(\"./\".\$scriptName);\r\
    \n  :if ([:len [/file find name=\$scriptName]] > 0) do={\r\
    \n    /system backup save name=\$backupFileName;\r\
    \n    :delay 1s;\r\
    \n    :if ([:len [/file find name=(\$backupFileName.\".backup\")]] > 0) do={\r\
    \n      /ip dns static remove [/ip dns static find comment=ADBlock];\r\
    \n      /import file-name=\$scriptName;\r\
    \n      /file remove \$scriptName;\r\
    \n      :log info \"\$logPrefix AD block script imported, backup file (\\\"\$backupFileName.backup\\\") created\";\r\
    \n    } else={\r\
    \n      :log warning \"\$logPrefix Backup file not created, importing AD block script stopped\";\r\
    \n    }\r\
    \n  } else={\r\
    \n    :log warning \"\$logPrefix AD block script not downloaded, script stopped\";\r\
    \n  }\r\
    \n} on-error={\r\
    \n  :log warning \"\$logPrefix AD block script download FAILED\";\r\
    \n};"
/system script add dont-require-permissions=yes name=doPerformanceStats owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doPerformanceStats\";\r\
    \n\r\
    \n#\r\
    \n#   MikroTik RouterOS Script\r\
    \n#   This script has two parts:  1) RouterOS statistics collector 2) Push router stats up to dweet.io\r\
    \n#\r\
    \n#   This script can be adapted to send the collected statistics to any NMS system that supports\r\
    \n#    receiving data via http get/post requests.\r\
    \n#\r\
    \n#   Tested on RouterOS v6.40.3\r\
    \n#   Learn more about this script and dweet.io by reading...\r\
    \n#   http://jcutrer.com/howto/networking/mikrotik/mikrotik-script-dweet-io-stats\r\
    \n# \r\
    \n#   Script Revision:  1.0.2\r\
    \n#   Author Name:     Jonathan Cutrer\r\
    \n#   Author URL:       http://jcutrer.com\r\
    \n#\r\
    \n#   Change Log\r\
    \n#\r\
    \n#   1.0.2      Reworked stats collection in groups, you can turn each on/off below\r\
    \n#              Changed dweet.io call to use SSL (https://)\r\
    \n#              Added VPN stats collection\r\
    \n#              Added Health stats collection\r\
    \n#              Added Routing Protocol stats collection\r\
    \n#\r\
    \n#   1.0.1      Added keep-result=no to last line\r\
    \n#\r\
    \n#   1.0.0      Initial Release\r\
    \n#\r\
    \n#\r\
    \n# Begin Setup\r\
    \n#\r\
    \n:local interfaceWAN         \"wan\";\r\
    \n:local interfaceWLAN        \"wlan 5Ghz\";\r\
    \n:local interfaceWLANGuest   \"wlan 2Ghz GUEST\";\r\
    \n:local prefix               \"mikrotik-stats\";\r\
    \n:local dweetURL             \"https://dweet.io/dweet/for/\";\r\
    \n:local dataParams;\r\
    \n\r\
    \n#\r\
    \n# Collection Groups\r\
    \n# Define what gets groups of statistics get collected and sent\r\
    \n#\r\
    \n:local enBoard true\r\
    \n:local enPerf true\r\
    \n:local enHealth true\r\
    \n:local enRouter true\r\
    \n:local enRouting true\r\
    \n:local enFirewall true\r\
    \n:local enWireless true\r\
    \n:local enVPN true\r\
    \n#\r\
    \n# End Setup\r\
    \n\r\
    \n\r\
    \n#\r\
    \n# Collect Stats: Board\r\
    \n#\r\
    \n:local boardData; :local identity; :local model; :local serial;\r\
    \nif ( \$enBoard ) do={\r\
    \n:put \"Collecting Board data...\"\r\
    \n    :set identity             [/system identity get name];\r\
    \n    :set model                [/system routerboard get model];\r\
    \n    :set serial         [/system routerboard get serial-number];\r\
    \n    :set boardData        \"identity=\$identity&model=\$model&serial=\$serial\"\r\
    \n    :set dataParams \$boardData;\r\
    \n\r\
    \n}\r\
    \n\r\
    \n# Set the thing name\r\
    \n:local thing          \"\$prefix-\$serial\"\r\
    \n\r\
    \n#\r\
    \n# Collect Stats: Perf\r\
    \n#\r\
    \n:local perfData; :local cpuLoad; :local memFree; :local uptime;\r\
    \nif ( \$enPerf ) do={\r\
    \n    :put \"Collecting Performance data...\"\r\
    \n    :delay 5\r\
    \n    :set cpuLoad [/system resource get cpu-load];\r\
    \n    :set memFree [/system resource get free-memory];\r\
    \n    :set uptime [/system resource get uptime];\r\
    \n    :set perfData \"cpu-load=\$cpuLoad&uptime=\$uptime&mem-free=\$memFree\"\r\
    \n    :set dataParams ( \$dataParams . \"&\" . \$perfData);\r\
    \n}\r\
    \n\r\
    \n#\r\
    \n# Collect Stats: Health\r\
    \n#\r\
    \n:local healthData; :local volts; :local amps; :local watts; :local temp; :local cpuTemp; :local fanSpeed;\r\
    \nif ( \$enHealth ) do={\r\
    \n    :put \"Collecting Health data...\"\r\
    \n    :set volts [/system health get voltage];\r\
    \n    :set amps [/system health get current];\r\
    \n    :set watts [/system health get power-consumption];\r\
    \n    :set temp [/system health get temperature];\r\
    \n    :set cpuTemp [/system health get cpu-temperature];\r\
    \n    :set fanSpeed [/system health get fan1-speed];\r\
    \n    :set healthData \"volts=\$volts&amps=\$amps&watts=\$watts&temp=\$temp&cpu-temp=\$cpuTemp&fan-speed=\$fanSpeed\"\r\
    \n    :set dataParams ( \$dataParams . \"&\" . \$healthData);\r\
    \n}\r\
    \n\r\
    \n\r\
    \n#\r\
    \n# Collect Stats: Router\r\
    \n#\r\
    \n:local routerData; :local ipRoutes;\r\
    \nif ( \$enRouter ) do={\r\
    \n    :put \"Collecting Router data...\"\r\
    \n    :set ipRoutes [:len [/ip route find]];\r\
    \n    :set routerData  \"ip-routes=\$ipRoutes\"\r\
    \n    :set dataParams ( \$dataParams . \"&\" . \$routerData);\r\
    \n}\r\
    \n\r\
    \n#\r\
    \n# Collect Stats: Routing\r\
    \n#\r\
    \n:local routingData; :local bgpPeers; :local ospfNeighbors;\r\
    \nif ( \$enRouting ) do={\r\
    \n    : put \"Collecting Routing Protocol data...\" ;\r\
    \n    :set bgpPeers [:len [/routing bgp peer find]];\r\
    \n    :set ospfNeighbors [:len [/routing ospf neighbor find]];\r\
    \n    :set routingData  \"bgp-peers=\$bgpPeers&ospf-neighbors=\$ospfNeighbors\";\r\
    \n    :set dataParams ( \$dataParams . \"&\" . \$routingData);\r\
    \n}\r\
    \n\r\
    \n#\r\
    \n# Collect Stats: Wireless\r\
    \n#\r\
    \n:local wirelessData; :local wlanClients; :local wlanGuests;\r\
    \nif ( \$enWireless ) do={\r\
    \n    :put \"Collecting Wireless data...\";\r\
    \n    :set wlanClients [/interface wireless registration-table print count-only where interface=\"\$interfaceWLAN\"];\r\
    \n    :set wlanGuests [/interface wireless registration-table print count-only where interface=\"\$interfaceWLANGuest\"];\r\
    \n    :set wirelessData \"wlan-clients=\$wlanClients&wlan-guests=\$wlanGuests\";\r\
    \n    :set dataParams ( \$dataParams . \"&\" . \$wirelessData);\r\
    \n}\r\
    \n\r\
    \n#\r\
    \n# Collect Stats: Firewall\r\
    \n#\r\
    \n:local firewallData; :local ipFwConx;\r\
    \nif ( \$enFirewall ) do={\r\
    \n    :put \"Collecting Firewall data...\";\r\
    \n    :set ipFwConx [/ip firewall connection tracking get total-entries];\r\
    \n    :set firewallData \"ip-fw-conx=\$ipFwConx\";\r\
    \n    :set dataParams ( \$dataParams . \"&\" . \$firewallData);\r\
    \n}\r\
    \n\r\
    \n#\r\
    \n# Collect Stats: VPN\r\
    \n#\r\
    \n:local vpnData; :local vpnPppConx; :local vpnIpsecPeers; :local vpnIpsecPolicy;\r\
    \nif ( \$enFirewall ) do={\r\
    \n    :put \"Collecting VPN data...\";\r\
    \n    :set vpnPppConx [:len [/ppp active find]];\r\
    \n    :set vpnIpsecPeers [:len [/ip ipsec remote-peers find]];\r\
    \n    :set vpnIpsecPolicy [:len [/ip ipsec policy find]];\r\
    \n    :set vpnData \"vpn-ppp-conx=\$vpnPppConx&vpn-ipsec-peers=\$vpnIpsecPeers&vpn-ipsec-policys=\$vpnIpsecPolicy\";\r\
    \n    :set dataParams ( \$dataParams . \"&\" . \$vpnData);\r\
    \n}\r\
    \n\r\
    \n\r\
    \n#\r\
    \n# Test Output of Collected Data\r\
    \n#\r\
    \n:put \$boardData\r\
    \n:put \$perfData\r\
    \n:put \$healthData\r\
    \n:put \$routerData\r\
    \n:put \$routingData\r\
    \n:put \$wirelessData\r\
    \n:put \$firewallData\r\
    \n:put \$vpnData\r\
    \n\r\
    \n\r\
    \n#\r\
    \n# Build the Final Request URL\r\
    \n#\r\
    \n:local finalURL;\r\
    \n:set finalURL \"\$dweetURL\$thing\?\$dataParams\" \r\
    \n\r\
    \n# print the final url\r\
    \n:put \$finalURL\r\
    \n\r\
    \n\r\
    \n#\r\
    \n# Push data to dweet.io\r\
    \n#\r\
    \n#/tool fetch url=\"\$finalURL\" mode=https keep-result=no\r\
    \n#\r\
    \n# end of script"
/system script add dont-require-permissions=yes name=doCertificatesIssuing owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n# generates IPSEC certs: CA, server, code sign and clients\r\
    \n# i recommend to run it on server side\r\
    \n\r\
    \n#clients\r\
    \n:local IDs [:toarray \"mikrouter,alx.iphone.rw.2019,glo.iphone.rw.2019,alx.mbp.rw.2019\"];\r\
    \n\r\
    \n:local sysname [/system identity get name]\r\
    \n:local sysver [/system package get system version]\r\
    \n:local scriptname \"doCertificatesIssuing\"\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n## this fields should be empty IPSEC/ike2/RSA to work, i can't get it functional with filled fields\r\
    \n## :local COUNTRY \"RU\"\r\
    \n## :local STATE \"MSC\"\r\
    \n## :local LOC \"Moscow\"\r\
    \n## :local ORG \"IKEv2 Home\"\r\
    \n## :local OU \"IKEv2 Mikrotik\"\r\
    \n\r\
    \n:local COUNTRY \"\"\r\
    \n:local STATE \"\"\r\
    \n:local LOC \"\"\r\
    \n:local ORG \"\"\r\
    \n:local OU \"\"\r\
    \n\r\
    \n:local KEYSIZE \"2048\"\r\
    \n:local USERNAME \"mikrouter\"\r\
    \n\r\
    \n:local MaskedServerIP [/ip address get [find where interface=wan] address];\r\
    \n:local ServerIP ( [:pick \"\$MaskedServerIP\" 0 [:find \"\$MaskedServerIP\" \"/\" -1]] ) ;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n  \r\
    \n:do {\r\
    \n\r\
    \n  :local state \"CA certificates generation...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  ## generate a CA certificate\r\
    \n  /certificate add name=\"ca.myvpn.local\" common-name=\"ca@\$sysname\" subject-alt-name=\"email:ca@myvpn.local\"  key-usage=crl-sign,key-cert-sign country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"   \\\r\
    \n  ##  key-size=\"\$KEYSIZE\" days-valid=3650 \r\
    \n\r\
    \n  :local state \"Signing...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  sign \"ca.myvpn.local\" ca-crl-host=\"\$ServerIP\" name=\"ca@\$sysname\"\r\
    \n\r\
    \n  :delay 6s\r\
    \n\r\
    \n  set trusted=yes \"ca@\$sysname\"\r\
    \n\r\
    \n  :local state \"SERVER certificates generation...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  ## generate a server certificate\r\
    \n  /certificate add name=\"server.myvpn.local\" common-name=\"\$ServerIP\" subject-alt-name=\"IP:\$ServerIP\" key-usage=tls-server country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  \\\r\
    \n  ##  key-size=\"\$KEYSIZE\" days-valid=1095 \r\
    \n\r\
    \n  :local state \"Signing...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  sign \"server.myvpn.local\" ca=\"ca@\$sysname\" name=\"server@\$sysname\"\r\
    \n\r\
    \n  :delay 6s\r\
    \n\r\
    \n  set trusted=yes \"server@\$sysname\"\r\
    \n\r\
    \n  :local state \"CODE SIGN certificates generation...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  ## generate a code signing (apple IOS profiles) certificate\r\
    \n  /certificate add name=\"sign.myvpn.local\" common-name=\"sign@\$sysname\" subject-alt-name=\"email:sign@myvpn.local\" key-usage=code-sign,digital-signature country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  \\\r\
    \n  ##  key-size=\"\$KEYSIZE\" days-valid=1095 \r\
    \n\r\
    \n  :local state \"Signing...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  sign \"sign.myvpn.local\" ca=\"ca@\$sysname\" name=\"sign@\$sysname\"\r\
    \n\r\
    \n  :delay 6s\r\
    \n\r\
    \n  set trusted=yes \"sign@\$sysname\"\r\
    \n\r\
    \n  ## export the CA, code sign certificate, and private key\r\
    \n  /certificate export-certificate \"sign@\$sysname\" export-passphrase=\"1234567890\" type=pkcs12\r\
    \n\r\
    \n  :foreach USERNAME in=\$IDs do={\r\
    \n\r\
    \n    :local state \"CLIENT certificates generation...  \$USERNAME\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    ## create a client certificate\r\
    \n    /certificate add name=\"client.myvpn.local\" common-name=\"\$USERNAME@\$sysname\" subject-alt-name=\"email:\$USERNAME@myvpn.local\" key-usage=tls-client country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  \\\r\
    \n    ##  key-size=\"\$KEYSIZE\" days-valid=1095 \r\
    \n\r\
    \n    :local state \"Signing...\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    sign \"client.myvpn.local\" ca=\"ca@\$sysname\" name=\"\$USERNAME@\$sysname\"\r\
    \n\r\
    \n    :delay 6s\r\
    \n\r\
    \n    set trusted=yes \"\$USERNAME@\$sysname\"\r\
    \n\r\
    \n    ## export the CA, client certificate, and private key\r\
    \n    /certificate export-certificate \"\$USERNAME@\$sysname\" export-passphrase=\"1234567890\" type=pkcs12\r\
    \n\r\
    \n  };\r\
    \n\r\
    \n} on-error={\r\
    \n\r\
    \n  :local state \"Certificates generation script FAILED\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n};\r\
    \n"
/system script add dont-require-permissions=yes name=doHeatFlag owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doHeatFlag\";\r\
    \n\r\
    \n:global maxTemp;\r\
    \n:global currentTemp [/system health get temperature];\r\
    \n\r\
    \n:set maxTemp 55;\r\
    \n\r\
    \n#\r\
    \n\r\
    \n:if (\$currentTemp > \$maxTemp) do= {\r\
    \n\r\
    \n:local tooHigh \"%D0%9E%D0%B1%D0%BD%D0%B0%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%BE%20%D0%BF%D1%80%D0%B5%D0%B2%D1%8B%D1%88%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%BF%D0%BE%D1%80%D0%BE%D0%B3%D0%B0%20%D1%82%D0%B5%D0%BC%D0%BF%D0%B5%D1%80%D0%B0%D1%82%D1%83%D1%80%D1%8B%20%D1%8F%D0%B4%D1%80%D0%B0%20\";\r\
    \n\r\
    \n:global TelegramMessage \"\$tooHigh\";\r\
    \n/system script run doTelegramNotify;\r\
    \n\r\
    \n/beep length=.1\r\
    \n :delay 250ms\r\
    \n /beep length=.1\r\
    \n :delay 800ms\r\
    \n /beep length=.1\r\
    \n :delay 250ms\r\
    \n /beep length=.1\r\
    \n :delay 800ms\r\
    \n\r\
    \n\r\
    \n};"
/system script add dont-require-permissions=yes name=doCollectSpeedStats owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doCollectSpeedStats\";\r\
    \n\r\
    \n:local txAvg 0\r\
    \n:local rxAvg 0\r\
    \n\r\
    \n:local ts [/system clock get time]\r\
    \n:set ts ([:pick \$ts 0 2].[:pick \$ts 3 5].[:pick \$ts 6 8])\r\
    \n\r\
    \n:local ds [/system clock get date]\r\
    \n:set ds ([:pick \$ds 7 11].[:pick \$ds 0 3].[:pick \$ds 4 6])\r\
    \n\r\
    \n:local btServer 185.13.148.14;\r\
    \n\r\
    \ntool bandwidth-test protocol=tcp direction=transmit user=btest password=btest address=\$btServer duration=5s do={\r\
    \n:set txAvg (\$\"tx-total-average\" / 1048576 );\r\
    \n}\r\
    \n\r\
    \ntool bandwidth-test protocol=tcp direction=receive user=btest password=btest address=\$btServer duration=5s do={\r\
    \n:set rxAvg (\$\"rx-total-average\" / 1048576 );\r\
    \n}\r\
    \n\r\
    \n:local perf \"%D0%9F%D1%80%D0%BE%D0%B8%D0%B7%D0%B2%D0%BE%D0%B4%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D1%8C%20%D0%BA%D0%B0%D0%BD%D0%B0%D0%BB%D0%B0%3A%20\";\r\
    \n:local stats \"\$ds-\$ts tx: \$txAvg Mbps - rx: \$rxAvg Mbps\";\r\
    \n\r\
    \n:log info (\"VPN Tunnel speed \$stats\");\r\
    \n:put \"VPN Tunnel speed \$stats\";\r\
    \n\r\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doCheckPingRate owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doCheckPingRate\";\r\
    \n\r\
    \n#Mikrotik Ping more than 25ms to send mail\r\
    \n\r\
    \n:local host  [:resolve \"ya.ru\"];\r\
    \n:local ms 25;\r\
    \n\r\
    \n:log info (\"Checking ping rate \$host\");\r\
    \n:put \"Checking ping rate to \$host\";\r\
    \n\r\
    \n:local avgRttA value=0;\r\
    \n:local avgRttB value=0;\r\
    \n:local numPing value=6;\r\
    \n:local toPingIP1 value=8.8.8.8;\r\
    \n:local toPingIP2 value=\$host;\r\
    \n\r\
    \n:for tmpA from=1 to=\$numPing step=1 do={\r\
    \n /tool flood-ping count=1 size=38 address=\$toPingIP1 do={\r\
    \n  :set avgRttA (\$\"avg-rtt\" + \$avgRttA);\r\
    \n }\r\
    \n /tool flood-ping count=1 size=38 address=\$toPingIP2 do={\r\
    \n  :set avgRttB (\$\"avg-rtt\" + \$avgRttB);\r\
    \n }\r\
    \n /delay delay-time=1;\r\
    \n}\r\
    \n\r\
    \n:log info (\"Ping Average for 8.8.8.8: \".[:tostr (\$avgRttA / \$numPing )].\"ms\");\r\
    \n:log info (\"Ping Average for \$host: \".[:tostr (\$avgRttB / \$numPing )].\"ms\");\r\
    \n\r\
    \n:local rate (\$avgRttB / \$numPing );\r\
    \n\r\
    \n:if (\$rate >= \$ms) do={\r\
    \n\r\
    \n:log error \"Check ping rate over \$ms ms\";\r\
    \n:put \"Check ping rate over \$ms ms\";\r\
    \n\r\
    \n:local tooSlow \"%D0%9E%D0%B1%D0%BD%D0%B0%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%BE%20%D1%81%D0%BD%D0%B8%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20%28%3E25ms%29%20%D1%81%D0%BA%D0%BE%D1%80%D0%BE%D1%81%D1%82%D0%B8%20%D0%BE%D1%82%D0%BA%D0%BB%D0%B8%D0%BA%D0%B0%20%D0%B4%D0%BE%20%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80%D0%BE%D0%B2%20Yandex%3A%20\";\r\
    \n\r\
    \n:global TelegramMessage \"\$tooSlow \$rate ms\";\r\
    \n/system script run doTelegramNotify;\r\
    \n\r\
    \n\r\
    \n#some sound\r\
    \n\r\
    \n}"
/system script add dont-require-permissions=yes name=doSomeAlarm owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doSomeAlarm\";\r\
    \n\r\
    \n:for i from=1000 to=3000 step=1000  do={\r\
    \n :beep frequency=2000 length=500ms;\r\
    \n :delay delay-time=1000ms;\r\
    \n :beep frequency=4000 length=500ms;\r\
    \n :delay delay-time=1000ms;\r\
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=doLEDoff owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doLEDoff\";\r\
    \n\r\
    \n/system leds settings set all-leds-off=immediate\r\
    \n\r\
    \n:local LedNightMode \"%D0%90%D0%BA%D1%82%D0%B8%D0%B2%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%20%D0%BD%D0%BE%D1%87%D0%BD%D0%BE%D0%B9%20%D1%80%D0%B5%D0%B6%D0%B8%D0%BC%20%D1%81%D0%B2%D0%B5%D1%82%D0%BE%D0%B2%D1%8B%D1%85%20%D0%B8%D0%BD%D0%B4%D0%B8%D0%BA%D0%B0%D1%82%D0%BE%D1%80%D0%BE%D0%B2\";\r\
    \n:global TelegramMessage \"\$LedNightMode\";\r\
    \n/system script run doTelegramNotify;\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doLEDon owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doLEDon\";\r\
    \n\r\
    \n/system leds settings set all-leds-off=never;\r\
    \n\r\
    \n:local LedNightMode \"%D0%94%D0%B5%D0%B0%D0%BA%D1%82%D0%B8%D0%B2%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%20%D0%BD%D0%BE%D1%87%D0%BD%D0%BE%D0%B9%20%D1%80%D0%B5%D0%B6%D0%B8%D0%BC%20%D1%81%D0%B2%D0%B5%D1%82%D0%BE%D0%B2%D1%8B%D1%85%20%D0%B8%D0%BD%D0%B4%D0%B8%D0%BA%D0%B0%D1%82%D0%BE%D1%80%D0%BE%D0%B2\";\r\
    \n:global TelegramMessage \"\$LedNightMode\";\r\
    \n/system script run doTelegramNotify;"
/system script add dont-require-permissions=no name=doBumerSound owner=owner policy=read,test source=":global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doBumerSound\";\r\
    \n\r\
    \n:beep frequency=1300 length=400ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=700ms;\r\
    \n:delay 1500ms;\r\
    \n:beep frequency=1550 length=400ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1300 length=700ms;\r\
    \n:delay 1500ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1950 length=700ms;\r\
    \n:delay 1500ms;\r\
    \n:beep frequency=1300 length=400ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=700ms;\r\
    \n:delay 1500ms;\r\
    \n:beep frequency=1550 length=400ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1300 length=700ms;\r\
    \n:delay 1500ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1550 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1720 length=200ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=1950 length=700ms;\r\
    \n:delay 200ms;"
/system script add dont-require-permissions=yes name=doNetwatchHostIsDown owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doNetwatchHostIsDown\";\r\
    \n\r\
    \n#NetWatch notifier OnDown\r\
    \n\r\
    \n:global NetwatchHostName;\r\
    \n\r\
    \n/log warning \"\$NetwatchHostName fail...\"\r\
    \n\r\
    \n:do {\r\
    \n\r\
    \nif ([system resource get uptime] > 00:01:00) do={\r\
    \n\r\
    \n     :local connectionlost \"%D0%A1%D0%B2%D1%8F%D0%B7%D1%8C%20%D0%BF%D0%BE%D1%82%D0%B5%D1%80%D1%8F%D0%BD%D0%B0%3A%20\";\r\
    \n\r\
    \n     :local checkip [/ping \$NetwatchHostName count=10];\r\
    \n\r\
    \n     :if (checkip < 7) do={\r\
    \n\r\
    \n            /log error \"\$NetwatchHostName IS DOWN\";\r\
    \n\r\
    \n            :global TelegramMessage \"\$connectionlost\$NetwatchHostName\";\r\
    \n\r\
    \n            /system script run doTelegramNotify;\r\
    \n\r\
    \n            :delay 2\r\
    \n       }\r\
    \n   }\r\
    \n} on-error= {\r\
    \n\r\
    \n:log info (\"Telegram notify error\");\r\
    \n\r\
    \n:put \"Telegram notify error\";\r\
    \n\r\
    \n};"
/system script add dont-require-permissions=yes name=doTelegramNotify owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doTelegramNotify\";\r\
    \n\r\
    \n:global TelegramToken \"798290125:AAE3gfeLKdtai3RPtnHRLbE8quNgAh7iC8M\";\r\
    \n:global TelegramGroupID \"-343674739\";\r\
    \n:global TelegramURL \"https://api.telegram.org/bot\$TelegramToken/sendMessage\\\?chat_id=\$TelegramGroupID\";\r\
    \n\r\
    \n:global TelegramMessage;\r\
    \n\r\
    \n:log info (\"Sending telegram message... \$TelegramMessage\");\r\
    \n:put \"Sending telegram message... \$TelegramMessage\";\r\
    \n\r\
    \n:do {\r\
    \n/tool fetch http-method=post mode=https url=\"\$TelegramURL\" http-data=\"text=\$TelegramMessage\" keep-result=no;\r\
    \n} on-error= {\r\
    \n:log error (\"Telegram notify error\");\r\
    \n:put \"Telegram notify error\";\r\
    \n};"
/system script add dont-require-permissions=yes name=doNetwatchHost owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n\r\
    \n\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doNetwatchHost\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n#NetWatch notifier OnUp/OnDown\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n:local state \"\";\r\
    \n  \r\
    \n:global NetwatchHostName;\r\
    \n\r\
    \n:local state \"Netwatch for \$NetwatchHostName started...\";\r\
    \n\$globalNoteMe value=\$state;\r\
    \n\r\
    \n:do {\r\
    \n\r\
    \n  if ([system resource get uptime] > 00:01:00) do={\r\
    \n\r\
    \n   #additional manual check via ping\r\
    \n   :local checkip [/ping \$NetwatchHostName count=10];\r\
    \n\r\
    \n   :if (\$checkip = 10) do={\r\
    \n\r\
    \n     :local state \"\$NetwatchHostName is UP\";\r\
    \n     \$globalNoteMe value=\$state;\r\
    \n     #success when OnUp\r\
    \n     :local itsOk true;\r\
    \n\r\
    \n   } else {\r\
    \n\r\
    \n    :local state \"\$NetwatchHostName is DOWN\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    #success when OnDown\r\
    \n    :local itsOk true;\r\
    \n    \r\
    \n   }\r\
    \n } else {\r\
    \n\r\
    \n  :local state \"The system is just started, wait some time before using netwatch\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n  :local itsOk false;\r\
    \n\r\
    \n }\r\
    \n} on-error= {\r\
    \n\r\
    \n  :local state \"Netwatch for \$NetwatchHostName FAILED...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n  :local itsOk false;\r\
    \n\r\
    \n};\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: netwatch \$state\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \r\
    \n}\r\
    \n\r\
    \n\$noteMe value=\$inf\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\$globalTgMessage value=\$inf;\r\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doDHCPLeaseTrack owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doDHCPLeaseTrack\";\r\
    \n\r\
    \n# Globals\r\
    \n#\r\
    \n:global GleaseBound;\r\
    \n:global GleaseServerName;\r\
    \n:global GleaseActMAC;\r\
    \n:global GleaseActIP;\r\
    \n\r\
    \n:local date [/system clock get date];\r\
    \n:local time [/system clock get time];\r\
    \n:local systemIdentity [/system identity get name];\r\
    \n:local json \"{\\\"date\\\":\\\"\$date\\\",\\\"time\\\":\\\"\$time\\\",\\\"systemIdentity\\\":\\\"\$systemIdentity\\\",\\\"bound\\\":\$GleaseBound,\\\"serverName\\\":\\\"\$GleaseServerName\\\",\\\"mac\\\":\\\"\$GleaseActMAC\\\",\\\"ip\\\":\\\"\$GleaseActIP\\\"}\";\r\
    \n\r\
    \n\r\
    \n:if (\$GleaseBound = 1) do={\r\
    \n\t/ip dhcp-server lease;\r\
    \n\t:foreach i in=[find dynamic=yes] do={\r\
    \n\t\t:local dhcpip \r\
    \n\t\t:set dhcpip [ get \$i address ];\r\
    \n\t\t:local clientid\r\
    \n\t\t:set clientid [get \$i host-name];\r\
    \n\r\
    \n\t\t:if (\$GleaseActIP = \$dhcpip) do={\r\
    \n\t\t\t:local comment \"New IP\"\r\
    \n\t\t\t:set comment ( \$comment . \": \" .  \$dhcpip . \": \" . \$clientid);\r\
    \n\t\t\t/log error \$comment;\r\
    \n\r\
    \n                                        :local newGuest \"%D0%9A%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%20%D0%B3%D0%BE%D1%81%D1%82%D0%B5%D0%B2%D0%BE%D0%B3%D0%BE%20wi-fi%3A%20\";\r\
    \n                                        :global TelegramMessage \"\$newGuest \$comment\";\r\
    \n                                         /system script run doTelegramNotify;\r\
    \n\r\
    \n                                         /system script run doWestminister;\r\
    \n\t\t}\r\
    \n\t}\r\
    \n}"
/system script add dont-require-permissions=yes name=doEnvironmentClearance owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n#clear all global variables\r\
    \n/system script environment remove [find];"
/system script add dont-require-permissions=yes name=doStartupScript owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#Force sync time\r\
    \n/ip cloud force-update;\r\
    \n\r\
    \n:log warning \"Starting script: doStartupScript\";\r\
    \n:put \"Starting script: doStartupScript\"\r\
    \n\r\
    \n:delay 3s;\r\
    \n\r\
    \n/system script run doEnvironmentClearance;\r\
    \n\r\
    \n/system script run doEnvironmentSetup;\r\
    \n\r\
    \n/system script run doCoolConcole;\r\
    \n\r\
    \n/system script run doImperialMarch;\r\
    \n\r\
    \n#wait some for all tunnels to come up after reboot and VPN to work\r\
    \n\r\
    \n:delay 15s;\r\
    \n\r\
    \n:local rebootEvent \"%D0%9C%D0%B0%D1%80%D1%88%D1%80%D1%83%D1%82%D0%B8%D0%B7%D0%B0%D1%82%D0%BE%D1%80%20%D0%B1%D1%8B%D0%BB%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B7%D0%B0%D0%B3%D1%80%D1%83%D0%B6%D0%B5%D0%BD\";\r\
    \n:global TelegramMessage \"\$rebootEvent\";\r\
    \n\r\
    \n/system script run doTelegramNotify;\r\
    \n      \r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doSuperviseCHRviaSSH owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# This script will set a password and identity on all accesspoints it can connect to\r\
    \n# Intended for when you put up many capsman managed aps and want to secure them in one go.\r\
    \n# The identity part can be commented or removed if not needed\r\
    \n# Script will only work once, when there's no password on the AP\r\
    \n{\r\
    \n    :local Password \"Coolpassword192\"\r\
    \n    \r\
    \n    :local Counter 0\r\
    \n    :foreach neighbor in=[/ip neighbor find] do={\r\
    \n        :local Platform [/ip neighbor get \$neighbor platform]\r\
    \n        :local IP [/ip neighbor get \$neighbor address4]\r\
    \n        \r\
    \n        if (\$Platform = \"MikroTik\") do={\r\
    \n            :local Identity \"AP\$Counter\"\r\
    \n            /system ssh address=\$IP user=admin src-address=10.0.0.2 port=2222 command=\"/system identity set name=\$Identity\"\r\
    \n        }\r\
    \n        :set Counter (\$Counter + 1)\r\
    \n    }\r\
    \n}"
/system script add dont-require-permissions=yes name=doTrackFirmwareUpdates owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doTrackFirmwareUpdates\";\r\
    \n\r\
    \n:local isUpdateAvailable false\r\
    \n\r\
    \n/system package update check-for-updates once\r\
    \n:delay 15s\r\
    \n:if ([/system package update get installed-version] != [/system package update get latest-version]) do={\r\
    \n  :set isUpdateAvailable true\r\
    \n}\r\
    \n:if ([/system routerboard get routerboard] = true) do={\r\
    \n  :if ([/system routerboard get current-firmware] != [/system routerboard get upgrade-firmware]) do={\r\
    \n    :set isUpdateAvailable true\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:if (\$isUpdateAvailable = true) do={\r\
    \n  /log info \"update-monitor: system or firmware update available\"\r\
    \n \r\
    \n :local newFW \"%D0%94%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%BD%D0%B0%20%D0%BD%D0%BE%D0%B2%D0%B0%D1%8F%20%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%8F%20%D0%BC%D0%B8%D0%BA%D1%80%D0%BE%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%20%D0%B4%D0%BB%D1%8F%20%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%81%D1%82%D0%B2%D0%B0\";\r\
    \n :global TelegramMessage \"\$newFW\";\r\
    \n\r\
    \n  /system script run doTelegramNotify;\r\
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=doTranstaleMAC2IP owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doTranstaleMAC2IP\";\r\
    \n\r\
    \n#get IP and hostname by MAC address\r\
    \n#\r\
    \n{\r\
    \n  :local arr {\"00:CD:FE:EC:B5:52\" ; \"AC:61:EA:EA:CC:84\"}; \r\
    \n  \r\
    \n  foreach v in \$arr do={\r\
    \n    if ([len [/ip arp find where mac-address=\$v]] >0) do= {\r\
    \n      :put [/ip arp get [find where mac-address=\$v] address]\r\
    \n    }; \r\
    \n    if ([len [/ip dhcp-server lease find where active-mac-address=\$v]] >0) do= {\r\
    \n      :put [/ip dhcp-server lease get [find where active-mac-address=\$v] host-name]\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=doPeriodicLogDump owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n#\$globalScriptBeforeRun \"doPeriodicLogDump\";\r\
    \n\r\
    \n# Script Name: Log-Parser\r\
    \n# This script reads a specified log buffer.  At each log entry read,\r\
    \n# the global variable 'logParseVar' is set to \"<log entry time>,<log entry topics>,<log entry message>\"\r\
    \n# then a parser action script is run.  The parser action script reads the global variable, and performs specified actions.\r\
    \n# The log buffer is then cleared, so only new entries are read each time this script gets executed.\r\
    \n\r\
    \n# Set this to a \"memory\" action log buffer\r\
    \n:local logBuffer \"ParseMemoryLog\"\r\
    \n\r\
    \n# Set to name of parser script to run against each log entry in buffer\r\
    \n:local logParserScript \"doPeriodicLogParse\"\r\
    \n\r\
    \n# Internal processing below....\r\
    \n# -----------------------------------\r\
    \n:global logParseVar \"\"\r\
    \n\r\
    \n:local loglastparsetime\r\
    \n:local loglastparsemessage\r\
    \n:local findindex\r\
    \n:local property\r\
    \n:local value\r\
    \n:local logEntryTopics\r\
    \n:local logEntryTime\r\
    \n:local logEntryMessage\r\
    \n:local curDate\r\
    \n:local curMonth\r\
    \n:local curDay\r\
    \n:local curYear\r\
    \n:local clearedbuf\r\
    \n:local lines\r\
    \n\r\
    \n# Get current date settings\r\
    \n:set \$curDate [/system clock get date]\r\
    \n:set \$curMonth [:pick [:tostr \$curDate] 0 3]\r\
    \n:set \$curDay [:pick [:tostr \$curDate] 4 6]\r\
    \n:set \$curYear [:pick [:tostr \$curDate] 7 11]\r\
    \n\r\
    \n:set \$clearedbuf 0\r\
    \n:foreach rule in=[/log print as-value where buffer=(\$logBuffer)] do={\r\
    \n# Now all data is collected in memory..\r\
    \n\r\
    \n# Clear log buffer right away so new entries come in\r\
    \n   :if (\$clearedbuf = 0) do={\r\
    \n      /system logging action {\r\
    \n         :set \$lines [get (\$logBuffer) memory-lines]\r\
    \n         set (\$logBuffer) memory-lines 1\r\
    \n         set (\$logBuffer) memory-lines \$lines\r\
    \n      }\r\
    \n      :set \$clearedbuf 1\r\
    \n   }\r\
    \n# End clear log buffer\r\
    \n\r\
    \n   :set \$logEntryTime \"\"\r\
    \n   :set \$logEntryTopics \"\"\r\
    \n   :set \$logEntryMessage \"\"\r\
    \n\r\
    \n# Get each log entry's properties\r\
    \n   :local items {\$rule}\r\
    \n   :foreach item in=[\$items] do={\r\
    \n      :set \$logEntryTime (\$item->\"time\")\r\
    \n      :set \$logEntryTopics (\$item->\"topics\")\r\
    \n      :set \$logEntryMessage (\$item->\"message\")\r\
    \n   }\r\
    \n# end foreach item\r\
    \n   }\r\
    \n\r\
    \n# Set \$logEntryTime to full time format (mmm/dd/yyyy HH:MM:SS)\r\
    \n   :set \$findindex [:find [:tostr \$logEntryTime] \" \"]\r\
    \n# If no spaces are found, only time is given (HH:MM:SS), insert mmm/dd/yyyy\r\
    \n   :if ([:len \$findindex] = 0) do={\r\
    \n      :set \$logEntryTime (\$curMonth . \"/\" . \$curDay . \"/\" . \$curYear . \" \" . \\\r\
    \n                                    [:tostr \$logEntryTime])\r\
    \n   }\r\
    \n# Only (mmm/dd HH:MM:SS) is given, insert year\r\
    \n   :if (\$findindex = 6) do={\r\
    \n      :set \$logEntryTime ([:pick [:tostr \$logEntryTime] 0 \$findindex] . \"/\" . \$curYear . \\\r\
    \n                                    [:pick [:tostr \$logEntryTime] \$findindex [:len [:tostr \$logEntryTime]]])\r\
    \n   }\r\
    \n# Only (mmm HH:MM:SS) is given, insert day and year\r\
    \n   :if (\$findindex = 3) do={\r\
    \n      :set \$logEntryTime ([:pick [:tostr \$logEntryTime] 0 \$findindex] . \"/\" . \$curDay . \"/\" . \$curYear . \\\r\
    \n                                    [:pick [:tostr \$logEntryTime] \$findindex [:len [:tostr \$logEntryTime]]])\r\
    \n   }\r\
    \n# End set \$logEntryTime to full time format\r\
    \n\r\
    \n# Skip if logEntryTime and logEntryMessage are the same as previous parsed log entry\r\
    \n   :if (\$logEntryTime = \$loglastparsetime && \$logEntryMessage = \$loglastparsemessage) do={\r\
    \n   } else={\r\
    \n#   Set \$logParseVar, then run parser script\r\
    \n      :set \$logParseVar {\$logEntryTime ; \$logEntryTopics; \$logEntryMessage}\r\
    \n      /system script run (\$logParserScript)\r\
    \n\r\
    \n#   Update last parsed time, and last parsed message\r\
    \n      :set \$loglastparsetime \$logEntryTime\r\
    \n      :set \$loglastparsemessage \$logEntryMessage\r\
    \n   }\r\
    \n\r\
    \n# end foreach rule\r\
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=doPeriodicLogParse owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n#\$globalScriptBeforeRun \"doPeriodicLogParse\";\r\
    \n\r\
    \n# Script Name: Log-Parser-Script\r\
    \n#\r\
    \n# This is an EXAMPLE script.  Modify it to your requirements.\r\
    \n#\r\
    \n# This script will work with all v3.x and v4.x\r\
    \n# If your version >= v3.23, you can use the ~ operator to match against\r\
    \n# regular expressions.\r\
    \n\r\
    \n# Get log entry data from global variable and store it locally\r\
    \n:global logParseVar\r\
    \n:local logTime (\$logParseVar->0)\r\
    \n:local logTopics [:tostr (\$logParseVar->1)]\r\
    \n:local logMessage [:tostr (\$logParseVar->2)]\r\
    \n:set \$logParseVar \"\"\r\
    \n\r\
    \n:local ruleop\r\
    \n:local loguser\r\
    \n:local logsettings\r\
    \n:local findindex\r\
    \n:local tmpstring\r\
    \n\r\
    \n# Uncomment to view the log entry's details\r\
    \n:put (\"Log Time: \" . \$logTime)\r\
    \n:put (\"Log Topics: \" . \$logTopics)\r\
    \n:put (\"Log Message: \" . \$logMessage)\r\
    \n\r\
    \n# Check for login failure\r\
    \n:if (\$logMessage~\"login failure\") do={\r\
    \n   :put (\"A login failure has occured: \$logMessage.  Take some action\")\r\
    \n\r\
    \n   :local newLogin \"%D0%9E%D0%B1%D0%BD%D0%B0%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B0%20%D0%BF%D0%BE%D0%BF%D1%8B%D1%82%D0%BA%D0%B0%20%D0%B2%D1%85%D0%BE%D0%B4%D0%B0%20%D0%B2%20%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%83\";\r\
    \n   :global TelegramMessage \"\$newLogin \$logMessage\";\r\
    \n\r\
    \n   /system script run doTelegramNotify;\r\
    \n\r\
    \n}\r\
    \n# End check for login failure\r\
    \n\r\
    \n# Check for logged in users\r\
    \n:if (\$logMessage~\"logged in\") do={\r\
    \n   \r\
    \n   :put (\"A user has logged in: \$logMessage\")\r\
    \n\r\
    \n   :local newLogin \"%D0%A3%D1%81%D0%BF%D0%B5%D1%88%D0%BD%D1%8B%D0%B9%20%D0%B2%D1%85%D0%BE%D0%B4%20%D0%B2%20%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%83\";\r\
    \n   :global TelegramMessage \"\$newLogin \$logMessage\";\r\
    \n\r\
    \n   /system script run doTelegramNotify;\r\
    \n\r\
    \n}\r\
    \n# End check for logged in users\r\
    \n\r\
    \n# Wireless events\r\
    \n        :if (\$logTopics=\"wireless;info\") do={\r\
    \n            :local macAddress [:pick \$logMessage0 17]\r\
    \n            :if (\$logMessage~\"wlan 5Ghz: connected\" || \$logMessage~\"wlan 2Ghz: connected\") do={\r\
    \n\r\
    \n                #:put (\"A user \$macAddress has connected to WiFi: \$logMessage\");\r\
    \n                #:log warning (\"A user \$macAddress has connected to WiFi: \$logMessage\");\r\
    \n\r\
    \n            }\r\
    \n            :if (\$logMessage~\"wlan 5Ghz: disconnected\" || \$logMessage~\"wlan 2Ghz: disconnected\") do={\r\
    \n\r\
    \n                #:put (\"A user \$macAddress has disconnected WiFi: \$logMessage\");\r\
    \n                #:log warning (\"A user \$macAddress has disconnected WiFi: \$logMessage\");\r\
    \n\r\
    \n            }\r\
    \n        }\r\
    \n\r\
    \n# Check for configuration changes: added, changed, or removed\r\
    \n:if ([:tostr \$logTopics] = \"system;info\") do={\r\
    \n   :set ruleop \"\"\r\
    \n   :if ([:len [:find [:tostr \$logMessage] \"changed \"]] > 0) do={ :set ruleop \"changed\" }\r\
    \n   :if ([:len [:find [:tostr \$logMessage] \"added \"]] > 0) do={ :set ruleop \"added\" }\r\
    \n   :if ([:len [:find [:tostr \$logMessage] \"removed \"]] > 0) do={ :set ruleop \"removed\" }\r\
    \n\r\
    \n   :if ([:len \$ruleop] > 0) do={\r\
    \n      :set tmpstring \$logMessage\r\
    \n      :set findindex [:find [:tostr \$tmpstring] [:tostr \$ruleop]]\r\
    \n      :set tmpstring ([:pick [:tostr \$tmpstring] 0 \$findindex] . \\\r\
    \n                               [:pick [:tostr \$tmpstring] (\$findindex + [:len [:tostr \$ruleop]]) [:len [:tostr \$tmpstring]]])\r\
    \n      :set findindex [:find [:tostr \$tmpstring] \" by \"]\r\
    \n      :set loguser ([:pick [:tostr \$tmpstring] (\$findindex + 4) [:len [:tostr \$tmpstring]]])\r\
    \n      :set logsettings [:pick [:tostr \$tmpstring] 0 \$findindex]\r\
    \n\r\
    \n      :put (\$loguser . \" \" . \$ruleop . \" \" . \$logsettings . \" configuration.  We should take a backup now.\")\r\
    \n   }\r\
    \n}\r\
    \n# End check for configuration changes}"
/system script add dont-require-permissions=yes name=doIPSECviaSNMP owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# The simple script gives results of 0 or 1 after asking by SNMP (Script checks if phase 2 established with an SA Destination Address)\r\
    \n# Do not forget to use /32 on single IP\r\
    \n\r\
    \n:local sadstip 10.0.0.1\r\
    \n\r\
    \nif ([/ip ipsec policy get value-name=ph2-state [find sa-dst-address=\$sadstip]] = \"established\") do={\r\
    \n    :put 1\r\
    \n} else= {\r\
    \n    :put 0\r\
    \n}"
/system script add dont-require-permissions=yes name=doHotspotLoginTrack owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doHotspotLoginTrack\";\r\
    \n\r\
    \n# Globals\r\
    \n#\r\
    \n:global Guser;\r\
    \n\r\
    \n:local nas [/system identity get name];\r\
    \n:local today [/system clock get date];\r\
    \n:local time1 [/system clock get time ];\r\
    \n\r\
    \n:local ipuser [/ip hotspot active get [find user=\$Guser] address];\r\
    \n:local usermac [/ip hotspot active get [find user=\$Guser] mac-address]\r\
    \n\r\
    \n:put \$today\r\
    \n:put \$time1\r\
    \n\r\
    \n:local hour [:pick \$time1 0 2]; \r\
    \n:local min [:pick \$time1 3 5]; \r\
    \n:local sec [:pick \$time1 6 8];\r\
    \n\r\
    \n:set \$time1 [:put ({hour} . {min} . {sec})] \r\
    \n\r\
    \n:local mac1 [:pick \$usermac 0 2];\r\
    \n:local mac2 [:pick \$usermac 3 5];\r\
    \n:local mac3 [:pick \$usermac 6 8];\r\
    \n:local mac4 [:pick \$usermac 9 11];\r\
    \n:local mac5 [:pick \$usermac 12 14];\r\
    \n:local mac6 [:pick \$usermac 15 17];\r\
    \n\r\
    \n:set \$usermac [:put ({mac1} . {mac2} . {mac3} . {mac4} . {mac5} . {mac6})]\r\
    \n\r\
    \n:put \$time1\r\
    \n\r\
    \n/ip firewall address-list add list=\$today address=\"log-in.\$time1.\$user.\$usermac.\$ipuser\"\r\
    \n"
/system script add dont-require-permissions=yes name=doInxluxdbServiceOnline owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doInxluxdbServiceOnline\";\r\
    \n\r\
    \n:do {\r\
    \n\r\
    \n  :local result [/tool fetch port=8000 mode=http http-method=get url=\"http://influxdb/ping\" user=\"grafana\" password=\"grafana\"  as-value output=user];\r\
    \n\r\
    \n  :log info \"INFLUXDB: Service OK!\";\r\
    \n  :put \"INFLUXDB: Service OK!\";\r\
    \n\r\
    \n  :put \$result;\r\
    \n \r\
    \n} on-error={\r\
    \n  \r\
    \n  :log error \"INFLUXDB: Service Failed!\";\r\
    \n  :put \"INFLUXDB: Service Failed!\";\r\
    \n\r\
    \n}"
/system script add dont-require-permissions=yes name=doEnvironmentSetup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalNoteMe;\r\
    \n\r\
    \n:if (!any \$globalNoteMe) do={ \r\
    \n  :global globalNoteMe do={\r\
    \n\r\
    \n  ## outputs \$value using both :put and :log info\r\
    \n  ## example \$outputInfo value=\"12345\"\r\
    \n  :put \"info: \$value\"\r\
    \n  :log info \"\$value\"\r\
    \n\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:global globalScriptBeforeRun;\r\
    \n\r\
    \n:if (!any \$globalScriptBeforeRun) do={ \r\
    \n  :global globalScriptBeforeRun do={\r\
    \n\r\
    \n    :if ([:len \$1] > 0) do={\r\
    \n\r\
    \n      :local currentTime ([/system clock get date] . \" \" . [/system clock get time]);\r\
    \n      :local scriptname \"\$1\";\r\
    \n\r\
    \n      :local count [:len [/system script job find script=\$scriptname]];\r\
    \n\r\
    \n      :if (\$count > 0) do={\r\
    \n\r\
    \n        :foreach counter in=[/system script job find script=\$scriptname] do={\r\
    \n\r\
    \n         #But ignoring scripts started right NOW\r\
    \n         :local thisScriptCallTime  [/system script job get \$counter started];\r\
    \n         :if (\$currentTime != \$thisScriptCallTime) do={\r\
    \n           :local state \"\$scriptname already Running at \$thisScriptCallTime - killing old script before continuing\";\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n            /system script job remove \$counter;\r\
    \n          }\r\
    \n        }\r\
    \n      }\r\
    \n\r\
    \n      :local state \"Starting script: \$scriptname\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\r\
    \n:if (!any \$globalTgMessage) do={ \r\
    \n  :global globalTgMessage do={\r\
    \n\r\
    \n    :local tToken \"798290125:AAE3gfeLKdtai3RPtnHRLbE8quNgAh7iC8M\";\r\
    \n    :local tGroupID \"-343674739\";\r\
    \n    :local tURL \"https://api.telegram.org/bot\$tToken/sendMessage\\\?chat_id=\$tGroupID\";\r\
    \n\r\
    \n    :local state (\"Sending telegram message... \$value\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    :do {\r\
    \n      /tool fetch http-method=post mode=https url=\"\$tURL\" http-data=\"text=\$value\" keep-result=no;\r\
    \n    } on-error= {\r\
    \n      :local state (\"Telegram notify error\");\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n    };\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doCreateTrafficAccountingQueues owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# DHCP Lease to Simple Queues\r\
    \n# 2014 Lonnie Mendez (lmendez@anvilcom.com)\r\
    \n#\r\
    \n# Mikrotik RouterOS v6.9\r\
    \n\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doCreateTrafficAccountingQueues\";\r\
    \n \r\
    \n/ip dhcp-server lease\r\
    \n:foreach x in=[find] do={\r\
    \n \r\
    \n# grab variables for use below\r\
    \n:local leaseaddr ([get \$x address])\r\
    \n:local leasemacaddr [get \$x mac-address]\r\
    \n:local leasehostname [get \$x host-name]\r\
    \n:local leasename [get \$x comment]\r\
    \n:local queuecomment\r\
    \n \r\
    \n:local leaseinqueue false\r\
    \n \r\
    \n/queue simple\r\
    \n:foreach y in=[find] do={\r\
    \n \r\
    \n#grab variables for use below\r\
    \n:local queuetargetaddr [get \$y target]\r\
    \n:set queuecomment [get \$y comment]\r\
    \n \r\
    \n# Isolate information  from the comment field (MAC, Hostname)\r\
    \n:local queuemac [:pick \$queuecomment 4 21]\r\
    \n:local queuehostname [:pick \$queuecomment 22 [:len \$queuecomment]]\r\
    \n \r\
    \n# If MAC from lease matches the queue MAC then refresh the queue item\r\
    \n:if (\$queuemac = \$leasemacaddr) do={\r\
    \n# build a comment field\r\
    \n:set queuecomment (\"dtq,\" . \$leasemacaddr . \",\" . \$leasehostname)\r\
    \n \r\
    \nset \$y target=\$leaseaddr comment=\$queuecomment\r\
    \n:if (\$leasename != \"\") do= {\r\
    \nset \$y name=(\$leasename . \" (\" . \$leasemacaddr . \")\")\r\
    \n} else= {\r\
    \n:if (\$leasehostname != \"\") do= {\r\
    \nset \$y name=(\$leasehostname . \" (\" . \$leasemacaddr . \")\")\r\
    \n} else= {\r\
    \nset \$y name=\$leasemacaddr\r\
    \n}\r\
    \n}\r\
    \n:set leaseinqueue true\r\
    \n} else= {\r\
    \n# if ip exists for this lease but mac is different then update mac/hostname and reset counter\r\
    \n:if (\$queuetargetaddr = \$leaseaddr) do={\r\
    \n# build a comment field\r\
    \n:set queuecomment (\"dtq,\" . \$leasemacaddr . \",\" . \$leasehostname)\r\
    \n \r\
    \nset \$y comment=\$queuecomment\r\
    \nreset-counters \$y\r\
    \n:if (\$leasename != \"\") do= {\r\
    \nset \$y name=(\$leasename . \" (\" . \$leasemacaddr . \")\")\r\
    \n} else= {\r\
    \n:if (\$leasehostname != \"\") do= {\r\
    \nset \$y name=(\$leasehostname . \" (\" . \$leasemacaddr . \")\")\r\
    \n} else= {\r\
    \nset \$y name=\$leasemacaddr\r\
    \n}\r\
    \n}\r\
    \n:set leaseinqueue true\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n \r\
    \n# There was not an existing entry so add one for this lease\r\
    \n:if (\$leaseinqueue = false) do={\r\
    \n# build a comment field\r\
    \n:set queuecomment (\"dtq,\" . \$leasemacaddr . \",\" . \$leasehostname)\r\
    \n# build command\r\
    \n:local cmd \"/queue simple add target=\$leaseaddr max-limit=10M/10M comment=\$queuecomment\"\r\
    \n:if (\$leasename != \"\") do={ \r\
    \n:set cmd \"\$cmd name=\\\"\$leasename (\$leasemacaddr)\\\"\" \r\
    \n} else= {\r\
    \n:if (\$leasehostname != \"\") do={\r\
    \n:set cmd \"\$cmd name=\\\"\$leasehostname (\$leasemacaddr)\\\"\"\r\
    \n} else= {\r\
    \n:set cmd \"\$cmd name=\\\"\$leasemacaddr\\\"\"\r\
    \n}\r\
    \n}\r\
    \n \r\
    \n:execute \$cmd\r\
    \n\r\
    \n}\r\
    \n}\r\
    \n \r\
    \n# Cleanup Routine - remove dynamic entries that no longer exist in the lease table\r\
    \n/queue simple\r\
    \n:foreach z in=[find] do={\r\
    \n:local queuecomment [get \$z comment]\r\
    \n:local queue1stpart [:pick \$queuecomment 0 3]\r\
    \n:local queue2ndpart [:pick \$queuecomment 4 21]\r\
    \n:if ( \$queue1stpart = \"dtq\") do={\r\
    \n:if ( [/ip dhcp-server lease find mac-address=\$queue2ndpart] = \"\") do={\r\
    \n:log info (\"DTQ: Removing stale entry for MAC Address - \" . \$queue2ndpart)\r\
    \nremove \$z\r\
    \n}\r\
    \n}\r\
    \n}"
/system script add dont-require-permissions=yes name=doBackup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doBackup\";\r\
    \n\r\
    \n:local sysname [/system identity get name]\r\
    \n:local sysver [/system package get system version]\r\
    \n:local scriptname \"doBackup\"\r\
    \n:local saveSysBackup true\r\
    \n:local encryptSysBackup false\r\
    \n:local saveRawExport true\r\
    \n:local verboseRawExport false\r\
    \n:local state \"\"\r\
    \n\r\
    \n:local ts [/system clock get time]\r\
    \n:set ts ([:pick \$ts 0 2].[:pick \$ts 3 5].[:pick \$ts 6 8])\r\
    \n:local ds [/system clock get date]\r\
    \n:set ds ([:pick \$ds 7 11].[:pick \$ds 0 3].[:pick \$ds 4 6])\r\
    \n\r\
    \n#directories have to exist!\r\
    \n:local FTPEnable true\r\
    \n:local FTPServer \"minialx.home\"\r\
    \n:local FTPPort 21\r\
    \n:local FTPUser \"ftp\"\r\
    \n:local FTPPass \"\"\r\
    \n:local FTPRoot \"/pub/\"\r\
    \n:local FTPGitEnable true\r\
    \n:local FTPRawGitName \"/pub/git/rawconf_\$sysname_\$sysver.rsc\"\r\
    \n\r\
    \n:local SMTPEnable true\r\
    \n:local SMTPAddress \"defm.kopcap@gmail.com\"\r\
    \n:local SMTPSubject (\"\$sysname Full Backup (\$ds-\$ts)\")\r\
    \n:local SMTPBody (\"\$sysname full Backup file see in attachment.\\nRouterOS version: \$sysver\\nTime and Date stamp: (\$ds-\$ts) \")\r\
    \n\r\
    \n:local noteMe do={\r\
    \n  :put \"DEBUG: \$value\"\r\
    \n  :log info message=\"\$value\"\r\
    \n}\r\
    \n\r\
    \n:local itsOk true;\r\
    \n\r\
    \n:do {\r\
    \n  :local smtpserv [:resolve \"\$FTPServer\"];\r\
    \n} on-error={ \r\
    \n  :set state \"FTP server looks like to be unreachable\"\r\
    \n  \$noteMe value=\$state;\r\
    \n  :set itsOk false;\r\
    \n}\r\
    \n\r\
    \n:local fname (\"BACKUP-\$sysname-\$ds-\$ts\")\r\
    \n\r\
    \n:if (\$saveSysBackup and \$itsOk) do={\r\
    \n  :if (\$encryptSysBackup = true) do={ /system backup save name=(\$fname.\".backup\") }\r\
    \n  :if (\$encryptSysBackup = false) do={ /system backup save dont-encrypt=yes name=(\$fname.\".backup\") }\r\
    \n  \$noteMe value=\"System Backup Finished\"\r\
    \n}\r\
    \n\r\
    \n:if (\$saveRawExport and \$itsOk) do={\r\
    \n  :if (\$FTPGitEnable ) do={\r\
    \n     :if (\$verboseRawExport = true) do={ /export terse hide-sensitive verbose file=(\$fname.\".safe.rsc\") }\r\
    \n     :if (\$verboseRawExport = false) do={ /export terse hide-sensitive  file=(\$fname.\".safe.rsc\") }\r\
    \n  }\r\
    \n  \$noteMe value=\"Raw configuration script export Finished\"\r\
    \n}\r\
    \n\r\
    \n:delay 5s\r\
    \n\r\
    \n:local buFile \"\"\r\
    \n\r\
    \n:foreach backupFile in=[/file find] do={\r\
    \n  :set buFile ([/file get \$backupFile name])\r\
    \n  :if ([:typeof [:find \$buFile \$fname]] != \"nil\" and \$itsOk) do={\r\
    \n    :local itsSRC ( \$buFile ~\".safe.rsc\")\r\
    \n    if (\$FTPEnable and \$itsOk) do={\r\
    \n        :do {\r\
    \n        :local state \"Uploading \$buFile to FTP (\$FTPRoot\$buFile)\"\r\
    \n        \$noteMe value=\$state\r\
    \n        /tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\"\$FTPRoot\$buFile\" mode=ftp upload=yes\r\
    \n        \$noteMe value=\"Done\"\r\
    \n        } on-error={ \r\
    \n          :set state \"Error When \$state\"\r\
    \n          \$noteMe value=\$state;\r\
    \n          :set itsOk false;\r\
    \n       }\r\
    \n\r\
    \n        #special ftp upload for git purposes\r\
    \n        if (\$itsSRC and \$FTPGitEnable and \$itsOk) do={\r\
    \n            :do {\r\
    \n            :local state \"Uploading \$buFile to FTP (RAW, \$FTPRawGitName)\"\r\
    \n            \$noteMe value=\$state\r\
    \n            /tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\"\$FTPRawGitName\" mode=ftp upload=yes\r\
    \n            \$noteMe value=\"Done\"\r\
    \n            } on-error={ \r\
    \n              :set state \"Error When \$state\"\r\
    \n              \$noteMe value=\$state;\r\
    \n              :set itsOk false;\r\
    \n           }\r\
    \n        }\r\
    \n\r\
    \n    }\r\
    \n    if (\$SMTPEnable and !\$itsSRC and \$itsOk) do={\r\
    \n        :do {\r\
    \n        :local state \"Uploading \$buFile to SMTP\"\r\
    \n        \$noteMe value=\$state\r\
    \n        /tool e-mail send to=\$SMTPAddress body=\$SMTPBody subject=\$SMTPSubject file=\$buFile\r\
    \n        \$noteMe value=\"Done\"\r\
    \n        } on-error={ \r\
    \n          :set state \"Error When \$state\"\r\
    \n          \$noteMe value=\$state;\r\
    \n          :set itsOk false;\r\
    \n       }\r\
    \n    }\r\
    \n\r\
    \n    :delay 1s;\r\
    \n    /file remove \$backupFile;\r\
    \n\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: Automatic Backup Completed Successfully\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \r\
    \n}\r\
    \n\r\
    \n\$noteMe value=\$inf\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\$globalTgMessage value=\$inf;\r\
    \n"
/system script add dont-require-permissions=yes name=doRandomGen owner=owner policy=ftp,reboot,read,write,policy,test,password,sensitive source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doRandomGen\";\r\
    \n\r\
    \n{\r\
    \n:log info (\"Starting reserve password generator Script...\");\r\
    \n\r\
    \n# special password appendix - current month 3chars\r\
    \n:local pfx [:pick [/system clock get date] 0 3 ];\r\
    \n:local newPassword \"\";\r\
    \n\r\
    \n#call random.org\r\
    \n/tool fetch url=\"https://www.random.org/strings/\?num=1&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new\" keep-result=yes dst-path=\"pass.txt\";\r\
    \n\r\
    \ndelay 3;\r\
    \n\r\
    \n:local newPassword [/file get pass.txt contents];\r\
    \n:set newPassword [:pick [\$newPassword] 1 6 ];\r\
    \n\r\
    \n/file remove pass.txt;\r\
    \n\r\
    \n:log info (\"Randomized: '\$newPassword'\");\r\
    \n\r\
    \n# doing salt\r\
    \n:set newPassword (\$pfx . \$newPassword);\r\
    \n\r\
    \n/user set [find name=reserved] password=\$newPassword\r\
    \n\r\
    \n# crop appendix\r\
    \n:local halfPass [:pick [\$newPassword] 3 11 ];\r\
    \n\r\
    \n:local sysname [/system identity get name];\r\
    \n:local sysver [/system package get system version];\r\
    \n\r\
    \n:local Eaccount \"defm.kopcap@gmail.com\";\r\
    \n\r\
    \n:log info (\"Calculating external wan IP...\");\r\
    \n\r\
    \n:local extWANip \"\";\r\
    \n\r\
    \n:if ( [/ip firewall address-list find list~\"external-ip\" ] = \"\") do={\r\
    \n        :put \"reserve password generator Script: cant fine ext wan ip address\"\r\
    \n        :log warning \"reserve password generator Script: cant find ext wan ip address\"\r\
    \n        } else={\r\
    \n            :foreach j in=[/ip firewall address-list find list~\"external-ip\"] do={\r\
    \n\t\t:set extWANip (\$extWANip  . [/ip firewall address-list get \$j address])\r\
    \n            }\r\
    \n        }\r\
    \n\r\
    \n:log info (\"External wan IP: '\$extWANip'\");\r\
    \n\r\
    \n:log info (\"Sending generated data via E-mail...\");\r\
    \n\r\
    \n:delay 2;\r\
    \n\r\
    \n:local SMTPBody (\"Device '\$sysname'\" . \"\\\r\
    \n\" . \"\\nRouterOS version: '\$sysver'\" . \"\\\r\
    \n\" . \"\\nTime and Date: \" . [/system clock get time] .  [/system clock get date] . \"\\\r\
    \n\" . \"\\nadditional password: '***\$halfPass'\" . \"\\\r\
    \n\" . \"\\nexternal ip '\$extWANip'\")\r\
    \n\r\
    \n:local SMTPSubject (\"\$sysname reserve password generator Script (\" . [/system clock get date] . \")\")\r\
    \n\r\
    \n/tool e-mail send to=\$Eaccount body=\$SMTPBody subject=\$SMTPSubject;\r\
    \n\r\
    \n:delay 5;\r\
    \n\r\
    \n:log info \"Email sent\";\r\
    \n\r\
    \n# some beeps to notice\r\
    \n\r\
    \n:beep frequency=784 length=500ms;\r\
    \n:delay 500ms;\r\
    \n:beep frequency=738 length=500ms;\r\
    \n:delay 500ms;\r\
    \n:beep frequency=684 length=500ms;\r\
    \n:delay 500ms;\r\
    \n:beep frequency=644 length=1000ms;\r\
    \n\r\
    \n}"
/system script add dont-require-permissions=yes name=doDumpTheScripts owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doDumpTheScripts\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n#directories have to exist!\r\
    \n:local FTPRoot \"/pub/git/\"\r\
    \n\r\
    \n#This subdir will be created locally to put exported scripts in\r\
    \n#and it must exist under \$FTPRoot to upload scripts to\r\
    \n:local SubDir \"scripts/\"\r\
    \n\r\
    \n:local FTPEnable true\r\
    \n:local FTPServer \"minialx.home\"\r\
    \n:local FTPPort 21\r\
    \n:local FTPUser \"ftp\"\r\
    \n:local FTPPass \"\"\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n\r\
    \n:global GscriptId;\r\
    \n:local itsOk true;\r\
    \n\r\
    \n:do {\r\
    \n  :local smtpserv [:resolve \"\$FTPServer\"];\r\
    \n} on-error={\r\
    \n  :local state \"FTP server looks like to be unreachable\";\r\
    \n   \$globalNoteMe value=\$state;\r\
    \n  :local itsOk false;    \r\
    \n}\r\
    \n\r\
    \n:if (\$itsOk) do={\r\
    \n  :do {\r\
    \n    [/tool fetch dst-path=\"\$SubDir.FooFile\" url=\"http://127.0.0.1:80/mikrotik_logo.png\" keep-result=no];\r\
    \n  } on-error={ \r\
    \n    :local state \"Error When Creating Local Scripts Directory\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    :local itsOk false;\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:if (\$itsOk) do={\r\
    \n  :foreach scriptId in [/system script find] do={\r\
    \n\r\
    \n    :local scriptSource [/system script get \$scriptId source];\r\
    \n    :local theScript [/system script get \$scriptId name];\r\
    \n    :local scriptSourceLength [:len \$scriptSource];\r\
    \n    :local path \"\$SubDir\$theScript.rsc.txt\";\r\
    \n\r\
    \n    :set \$GscriptId \$scriptId;\r\
    \n\r\
    \n    :if (\$scriptSourceLength >= 4096) do={\r\
    \n      :local state \"Please keep care about '\$theScript' consistency - its size over 4096 bytes\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n      /file print file=\$path where 1=0;\r\
    \n      #filesystem delay\r\
    \n      :delay 1s;\r\
    \n      #/file set [find name=\"\$path\"] contents=\$scriptSource;\r\
    \n      #/file set \$path contents=\$scriptSource;\r\
    \n      # Due to max variable size 4096 bytes - this scripts should be reworked, but now using :put hack\r\
    \n      /execute script=\":global GscriptId; :put [/system script get \$GscriptId source];\" file=\$path;\r\
    \n      :local state \"Exported '\$theScript' to '\$path'\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n    } on-error={ \r\
    \n      :local state \"Error When Exporting '\$theScript' Script to '\$path'\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :local itsOk false;\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n:delay 5s\r\
    \n\r\
    \n:local buFile \"\"\r\
    \n\r\
    \n:if (\$itsOk) do={\r\
    \n  :foreach backupFile in=[/file find where name~\"^\$SubDir\"] do={\r\
    \n    :set buFile ([/file get \$backupFile name]);\r\
    \n    :if ([:typeof [:find \$buFile \".rsc.txt\"]] != \"nil\") do={\r\
    \n      :local rawfile ( \$buFile ~\".rsc.txt\");\r\
    \n      #special ftp upload for git purposes\r\
    \n      if (\$FTPEnable) do={\r\
    \n        :local dst \"\$FTPRoot\$buFile\";\r\
    \n        :do {\r\
    \n          :local state \"Uploading \$buFile' to '\$dst'\";\r\
    \n          \$globalNoteMe value=\$state;\r\
    \n          /tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\$dst mode=ftp upload=yes;\r\
    \n          \$globalNoteMe value=\"Done\";\r\
    \n        } on-error={ \r\
    \n          :local state \"Error When Uploading '\$buFile' to '\$dst'\";\r\
    \n          \$globalNoteMe value=\$state; \r\
    \n        }\r\
    \n      }\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:delay 5s\r\
    \n\r\
    \n:foreach backupFile in=[/file find where name~\"^\$SubDir\"] do={\r\
    \n  :if ([:typeof [:find \$buFile \".rsc.txt\"]] != \"nil\") do={\r\
    \n    /file remove \$backupFile;\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: scripts dump done Successfully\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \r\
    \n}\r\
    \n\r\
    \n\$noteMe value=\$inf\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\$globalTgMessage value=\$inf;\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doFreshTheScripts owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doFreshTheScripts\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:local GitHubUserName \"Defm\";\r\
    \n:local GitHubRepoName \"mikrobackups\";\r\
    \n:local GitHubAccessToken \"ce73ea614f27f4caf391850da45a94564dddc7a7\";\r\
    \n:local RequestUrl \"https://\$GitHubAccessToken@raw.githubusercontent.com/\$GitHubUserName/\$GitHubRepoName/master/scripts/\";\r\
    \n\r\
    \n:local UseUpdateList true;\r\
    \n:local UpdateList [:toarray \"doBackup, doEnvironmentSetup, doRandomGen, doFreshTheScripts, doCertificatesIssuing, doNetwatchHostIsDown, doNetwatchHostIsUp\"];\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n  \r\
    \n:foreach scriptId in [/system script find] do={\r\
    \n\r\
    \n  :local code \"\";\r\
    \n  :local theScript [/system script get \$scriptId name];\r\
    \n  :local skip false;\r\
    \n\r\
    \n  :if ( \$UseUpdateList ) do={\r\
    \n    :if ( [:len [find key=\$theScript in=\$UpdateList ]] > 0 ) do={\r\
    \n    } else={\r\
    \n      :local state \"Script '\$theScript' skipped due to setup\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set skip true;\r\
    \n    }\r\
    \n  } else={\r\
    \n  }\r\
    \n\r\
    \n  :if ( \$itsOk and !\$skip) do={\r\
    \n    :do {\r\
    \n\r\
    \n      :local state \"/tool fetch url=\$RequestUrl\$\$theScript.rsc.txt output=user as-value\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n \r\
    \n      #Please keep care about consistency if size over 4096 bytes\r\
    \n      :local answer ([ /tool fetch url=\"\$RequestUrl\$\$theScript.rsc.txt\" output=user as-value]);\r\
    \n      :set code ( \$answer->\"data\" );\r\
    \n      \$globalNoteMe value=\"Done\";\r\
    \n\r\
    \n    } on-error= { \r\
    \n      :local state \"Error When Downloading Script '\$theScript' From GitHub\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set itsOk false;\r\
    \n    }\r\
    \n  }\r\
    \n\r\
    \n  :if ( \$itsOk and !\$skip) do={\r\
    \n    :do {\r\
    \n      :local state \"Setting Up Script source for '\$theScript'\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      /system script set \$theScript source=\"\$code\";\r\
    \n      \$globalNoteMe value=\"Done\";\r\
    \n    } on-error= { \r\
    \n      :local state \"Error When Setting Up Script source for '\$theScript'\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set itsOk false;\r\
    \n    }\r\
    \n  }\r\
    \n\r\
    \n  :delay 1s\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: scripts refreshed Successfully\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \r\
    \n}\r\
    \n\r\
    \n\$noteMe value=\$inf\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\$globalTgMessage value=\$inf;\r\
    \n\r\
    \n"
/tool bandwidth-server set enabled=no
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com port=587 start-tls=yes user=defm.kopcap@gmail.com
/tool mac-server set allowed-interface-list=none
/tool mac-server mac-winbox set allowed-interface-list=list-winbox-allowed
/tool netwatch add comment="miniAlx status check" down-script=":global NetwatchHostName \"miniAlx\";\r\
    \n/system script run doNetwatchHost;" host=192.168.99.180 up-script=":global NetwatchHostName \"miniAlx\";\r\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-interface=tunnel filter-operator-between-entries=and streaming-enabled=yes streaming-server=192.168.99.170
