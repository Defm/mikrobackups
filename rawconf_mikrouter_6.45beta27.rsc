# may/19/2019 02:05:22 by RouterOS 6.45beta27
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
/queue simple add comment=dtq,54:E4:3A:B8:12:07,iPadAlx max-limit=10M/10M name="iPadAlx@main dhcp (54:E4:3A:B8:12:07)" target=192.168.99.140/32
/queue simple add comment=dtq,AC:61:EA:EA:CC:84,iPhoneAlx max-limit=10M/10M name="iPhoneAlx@main dhcp (AC:61:EA:EA:CC:84)" target=192.168.99.150/32
/queue simple add comment=dtq,B0:34:95:2D:D6:85,ATV max-limit=10M/10M name="ATV@main dhcp (B0:34:95:2D:D6:85)" target=192.168.99.190/32
/queue simple add comment=dtq,78:31:C1:CF:9E:70,MbpAlx max-limit=10M/10M name="MbpAlx@main dhcp (78:31:C1:CF:9E:70)" target=192.168.99.160/32
/queue simple add comment=dtq,38:C9:86:51:D2:B3,MbpAlx max-limit=10M/10M name="MbpAlx@main dhcp (38:C9:86:51:D2:B3)" target=192.168.99.170/32
/queue simple add comment=dtq,08:00:27:17:3A:80, max-limit=10M/10M name="@main dhcp (08:00:27:17:3A:80)" target=192.168.99.20/32
/queue simple add comment=dtq,00:CD:FE:EC:B5:52,iPhoneGl max-limit=10M/10M name="iPhoneGl@main dhcp (00:CD:FE:EC:B5:52)" target=192.168.99.130/32
/queue simple add comment=dtq,00:CD:FE:EC:B5:52,iPhoneGl max-limit=10M/10M name="iPhoneGl@guest dhcp (00:CD:FE:EC:B5:52)" target=192.168.98.230/32
/queue simple add comment=dtq,98:22:EF:26:FE:6E,DESKTOP-UPPUU22 max-limit=10M/10M name="DESKTOP-UPPUU22@main dhcp (98:22:EF:26:FE:6E)" target=192.168.99.70/32
/queue simple add comment=dtq,98:22:EF:26:FE:6E, max-limit=10M/10M name="asusGl@guest dhcp (98:22:EF:26:FE:6E)" target=192.168.98.210/32
/queue simple add comment=dtq,88:53:95:30:68:9F,miniAlx max-limit=10M/10M name="miniAlx@guest dhcp (88:53:95:30:68:9F)" target=192.168.98.228/32
/queue simple add comment=dtq,AC:61:EA:EA:CC:84,iPhoneAlx max-limit=10M/10M name="iPhoneAlx@guest dhcp (AC:61:EA:EA:CC:84)" target=192.168.98.225/32
/queue simple add comment=dtq,54:E4:3A:B8:12:07,iPadAlx max-limit=10M/10M name="iPadAlx@guest dhcp (54:E4:3A:B8:12:07)" target=192.168.98.224/32
/queue simple add comment=dtq,10:DD:B1:9E:19:5E,miniAlx max-limit=10M/10M name="miniAlx@main dhcp (10:DD:B1:9E:19:5E)" target=192.168.99.180/32
/queue simple add comment=dtq,94:C6:91:94:98:DC,DESKTOP-ELCNKHP max-limit=10M/10M name="DESKTOP-ELCNKHP@main dhcp (94:C6:91:94:98:DC)" target=192.168.99.88/32
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
/system logging action add disk-file-count=10 disk-file-name=flash/ScriptsDiskLog name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=1 disk-file-name=flash/ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add memory-lines=500 name=OnScreenLog target=memory
/system logging action add name=DHCPOnScreenLog target=memory
/system logging action add name=DNSOnScreenLog target=memory
/system logging action add name=RouterControlLog target=memory
/system logging action add name=OSPFOnscreenLog target=memory
/system logging action add name=L2TPOnScreenLog target=memory
/system logging action add disk-file-count=20 disk-file-name=flash/AuthDiskLog name=AuthDiskLog target=disk
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
/ip dns static add address=109.252.109.53 name=ftpserver.org
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
/ip firewall address-list add address=109.252.109.53 list=external-ip
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
/system leds settings set all-leds-off=immediate
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
    \nUptime:  00:04:18 d:h:m:s | CPU: 39%\
    \nRAM: 34552/131072M | Voltage: 23 v | Temp: 55c\
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
/system scheduler add interval=1w3d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jun/26/2018 start-time=15:17:58
/system scheduler add interval=30m name=doHeatFlag on-event="/system script run doHeatFlag" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/10/2018 start-time=15:06:29
/system scheduler add interval=1h name=doCollectSpeedStats on-event="/system script run doCollectSpeedStats" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2018 start-time=14:41:22
/system scheduler add interval=1h name=doCheckPingRate on-event="/system script run doCheckPingRate" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2018 start-time=14:41:22
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=07:00:00
/system scheduler add interval=1m name=doPeriodicLogDump on-event="/system script run doPeriodicLogDump" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=11:31:24
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=1d name=doTrackFirmwareUpdates on-event="/system script run doTrackFirmwareUpdates" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=11:30:00
/system scheduler add interval=1d name=doCreateTrafficAccountingQueues on-event="/system script run doCreateTrafficAccountingQueues" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system scheduler add interval=10m name=doPushStatsToInfluxDB on-event="/system script run doPushStatsToInfluxDB" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system scheduler add interval=10m name=doIPSECPunch on-event="/system script run doIPSECPunch" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system script add dont-require-permissions=yes name=doIPSECPunch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\r\
    \n:local scriptname \"doIPSECPunch\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n\r\
    \n:local state \"\";\r\
    \n\r\
    \n#IPSEC Policies SA-Dst addresses\r\
    \n:local vpnEndpoints [:toarray \"10.0.0.1, 185.13.148.14/32\"];\r\
    \n\r\
    \n:foreach vpnEndpoint in=\$vpnEndpoints do={\r\
    \n\r\
    \n  :local skip false;\r\
    \n\r\
    \n  :if ([:len [/ip ipsec policy find sa-dst-address=\$vpnEndpoint]] != 0) do={:nothing}\r\
    \n\r\
    \n  :local ph2state \"\"\r\
    \n\r\
    \n  :do {\r\
    \n\r\
    \n    #tunnel=yes\r\
    \n    :set ph2state [/ip ipsec policy get value-name=ph2-state [find sa-dst-address=\$vpnEndpoint]]\r\
    \n\r\
    \n  } on-error= { \r\
    \n\r\
    \n    :do {\r\
    \n\r\
    \n      #tunnel=no\r\
    \n      :set ph2state [/ip ipsec policy get value-name=ph2-state [find dst-address=\$vpnEndpoint]]\r\
    \n\r\
    \n    } on-error= { \r\
    \n\r\
    \n      :set state \"Can't locate IPSEC policy for \$vpnEndpoint endpoint. Skip it (do you really have one\?)\"\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n\r\
    \n      :set skip true;\r\
    \n\r\
    \n    };\r\
    \n\r\
    \n  };\r\
    \n\r\
    \n  :local typeOfValue [:typeof \$ph2state]\r\
    \n  :if ((\$itsOk and !\$skip) and (\$typeOfValue = \"nothing\") or (\$typeOfValue = \"nil\")) do={\r\
    \n\r\
    \n    :set state \"Got IPSEC policy for \$vpnEndpoint endpoint of wrong type \$typeOfValue. Skip it\"\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    :set skip true;\r\
    \n\r\
    \n  } \r\
    \n\r\
    \n  if ((\$itsOk and !\$skip) and (\$ph2state != \"established\")) do={\r\
    \n\r\
    \n    :set state \"Non-established IPSEC policy found for \$vpnEndpoint endpoint. Going flush..\"\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    :set itsOk false;\r\
    \n\r\
    \n  }\r\
    \n\r\
    \n}\r\
    \n\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :do {\r\
    \n    :set state (\"Disconnecting IPSEC active peers\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    /ip ipsec active-peers kill-connections;\r\
    \n\r\
    \n    :set state (\"Flushing installed SA\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    /ip ipsec installed-sa flush;\r\
    \n\r\
    \n    #waiting for tunnel to come up\r\
    \n    :delay 10;\r\
    \n\r\
    \n    :set state (\"IPSEC tunnel got a punch after down\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    \r\
    \n  } on-error= {\r\
    \n    :set state \"Error When \$state\"\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    :set itsOk false;\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: IPSEC tunnel is fine\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  \r\
    \n  :set inf \"\$scriptname on \$sysname: \$state\"  \r\
    \n  \r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n"
/tool bandwidth-server set enabled=no
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com port=587 start-tls=yes user=defm.kopcap@gmail.com
/tool mac-server set allowed-interface-list=none
/tool mac-server mac-winbox set allowed-interface-list=list-winbox-allowed
/tool netwatch add comment="miniAlx status check" down-script=":global NetwatchHostName \"miniAlx\";\r\
    \n/system script run doNetwatchHost;" host=192.168.99.180 up-script=":global NetwatchHostName \"miniAlx\";\r\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-interface=tunnel filter-operator-between-entries=and streaming-enabled=yes streaming-server=192.168.99.170
