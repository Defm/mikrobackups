# may/16/2020 21:00:02 by RouterOS 6.46beta59
# software id = YWI9-BU1V
#
# model = RouterBOARD 962UiGS-5HacT2HnT
# serial number = 673706ED7949
/caps-man channel add band=2ghz-onlyn control-channel-width=20mhz extension-channel=disabled frequency=2412 name=common-chnls-2Ghz reselect-interval=10h skip-dfs-channels=yes tx-power=17
/caps-man channel add band=5ghz-a/n/ac comment="20Mhz + Ce = 40Mhz, reselect interval from 5180, 5220, 5745, 5785 once per 10h" control-channel-width=20mhz extension-channel=Ce frequency=5180,5220,5745,5785 name=common-chnls-5Ghz reselect-interval=10h tx-power=15
/caps-man configuration add mode=ap name=empty
/interface bridge add arp=proxy-arp name="guest infrastructure"
/interface bridge add arp=proxy-arp fast-forward=no name="ip mapping"
/interface bridge add admin-mac=6C:3B:6B:11:DA:1C arp=reply-only auto-mac=no name="main infrastructure"
/interface bridge add arp=proxy-arp fast-forward=no name="ospf loopback"
/interface ethernet set [ find default-name=ether4 ] name="lan A" speed=100Mbps
/interface ethernet set [ find default-name=ether2 ] name="lan B" speed=100Mbps
/interface ethernet set [ find default-name=ether3 ] name="lan C" speed=100Mbps
/interface ethernet set [ find default-name=ether5 ] name="lan D (master)" speed=100Mbps
/interface ethernet set [ find default-name=sfp1 ] advertise=10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full disabled=yes name=optic
/interface ethernet set [ find default-name=ether1 ] arp=proxy-arp name=wan speed=100Mbps
/caps-man datapath add bridge="guest infrastructure" name=2CapsMan-guest
/caps-man datapath add bridge="main infrastructure" client-to-client-forwarding=yes name=2CapsMan-private
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps name="5GHz Rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps vht-basic-mcs=mcs0-9 vht-supported-mcs=mcs0-9
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps ht-basic-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 ht-supported-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 name="2GHz rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps
/caps-man security add authentication-types=wpa2-psk comment="2GHz/5GHz Security" encryption=aes-ccm group-encryption=aes-ccm group-key-update=1h name=private passphrase=mikrotik
/caps-man security add authentication-types="" comment="2GHz/5GHz FREE" encryption="" group-key-update=5m name=guest
/interface list add comment="Trusted networks" name=list-trusted
/interface list add comment="Semi-Trusted networks" name=list-semi-trusted
/interface list add comment="Untrusted networks" name=list-untrusted
/interface list add comment="winbox allowed interfaces" name=list-winbox-allowed
/interface list add comment="includes l2tp client interfaces when UP" name=list-2tp-dynamic-tun
/interface list add comment="firewall rule: drop invalid conn" name=list-drop-invalid-connections
/interface list add comment="LAN intefaces" name=treated-as-LAN
/interface list add comment="WAN interfaces" name=treated-as-WAN
/interface list add comment="Internet interfaces" name=treated-as-INTERNET
/interface list add comment="Controlled access points (2ghz)" name=list-2ghz-caps-private
/interface list add comment="Controlled access points (public)" name=list-2ghz-caps-guest
/interface list add comment="Controlled access points (5ghz)" name=list-5ghz-caps-private
/caps-man configuration add channel=common-chnls-2Ghz country=russia datapath=2CapsMan-private datapath.interface-list=list-2ghz-caps-private distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-2Ghz-private rx-chains=0,1,2,3 security=private ssid="WiFi 2Ghz PRIVATE" tx-chains=0,1,2,3
/caps-man configuration add channel=common-chnls-5Ghz country=russia datapath=2CapsMan-private datapath.interface-list=list-5ghz-caps-private disconnect-timeout=9s distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-5Ghz-private rx-chains=0,1,2,3 security=private ssid="WiFi 5Ghz PRIVATE" tx-chains=0,1,2,3
/caps-man configuration add channel=common-chnls-2Ghz country=russia datapath=2CapsMan-guest datapath.interface-list=list-2ghz-caps-guest distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-2Ghz-guest rx-chains=0,1,2,3 security=guest ssid="WiFi 2Ghz FREE" tx-chains=0,1,2,3
/interface list add comment="Guest Wireless" include=list-2ghz-caps-guest name=list-guest-wireless
/interface list add comment="neighbors allowed interfaces" include=list-2ghz-caps-private name=list-neighbors-lookup
/interface list add comment="Private Wireless" include=list-2ghz-caps-private,list-5ghz-caps-private name=list-private-wireless
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/interface wireless security-profiles add authentication-types=wpa2-psk eap-methods="" group-key-update=1h management-protection=allowed mode=dynamic-keys name=private supplicant-identity="" wpa-pre-shared-key=mikrotik wpa2-pre-shared-key=mikrotik
/interface wireless security-profiles add authentication-types=wpa-psk,wpa2-psk eap-methods="" management-protection=allowed name=public supplicant-identity=""
/interface wireless
# managed by CAPsMAN
# channel: 2412/20/gn(15dBm), SSID: WiFi 2Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode antenna-gain=2 band=2ghz-onlyn basic-rates-b="" channel-width=20/40mhz-Ce country=russia3 default-authentication=no distance=indoors frequency-mode=regulatory-domain hw-protection-mode=rts-cts mode=ap-bridge multicast-helper=full name="wlan 2Ghz" preamble-mode=long security-profile=private ssid="WiFi 2Ghz PRIVATE" supported-rates-b="" wireless-protocol=802.11 wmm-support=enabled wps-mode=disabled
/interface wireless
# managed by CAPsMAN
# channel: 5180/20-Ce/ac(13dBm), SSID: WiFi 5Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan2 ] adaptive-noise-immunity=ap-and-client-mode antenna-gain=2 band=5ghz-n/ac channel-width=20/40/80mhz-Ceee country=russia3 default-authentication=no distance=indoors frequency=auto frequency-mode=regulatory-domain hw-protection-mode=rts-cts mode=ap-bridge multicast-helper=full name="wlan 5Ghz" preamble-mode=long security-profile=private ssid="WiFi 5Ghz PRIVATE" wireless-protocol=802.11 wmm-support=enabled wps-mode=disabled
/interface wireless nstreme
# managed by CAPsMAN
# channel: 2412/20/gn(15dBm), SSID: WiFi 2Ghz PRIVATE, CAPsMAN forwarding
set "wlan 2Ghz" enable-polling=no
/interface wireless nstreme
# managed by CAPsMAN
# channel: 5180/20-Ce/ac(13dBm), SSID: WiFi 5Ghz PRIVATE, CAPsMAN forwarding
set "wlan 5Ghz" enable-polling=no
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
/ip ipsec mode-config set [ find default=yes ] src-address-list=vpn-tunneled-sites
/ip ipsec policy group add name=inside-ipsec-encryption
/ip ipsec policy group add name=outside-ipsec-encryption
/ip ipsec profile set [ find default=yes ] dh-group=modp1024
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=ROUTEROS
/ip ipsec peer add address=185.13.148.14/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, outer-tunnel encryption, RSA)" exchange-mode=ike2 local-address=192.168.100.7 name=CHR-external profile=ROUTEROS
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
/interface l2tp-client add allow=mschap2 connect-to=185.13.148.14 disabled=no ipsec-secret=123 max-mru=1418 max-mtu=1418 name=tunnel profile=l2tp-no-encrypt-site2site user=vpn-remote-mic
/queue simple add comment=dtq,54:E4:3A:B8:12:07,iPadAlx name="iPadAlx@main dhcp (54:E4:3A:B8:12:07)" target=192.168.99.140/32
/queue simple add comment=dtq,AC:61:EA:EA:CC:84,iPhone name="iPhone@main dhcp (AC:61:EA:EA:CC:84)" target=192.168.99.150/32
/queue simple add comment=dtq,90:DD:5D:C8:46:AB,AlxATV name="AlxATV@main dhcp (90:DD:5D:C8:46:AB)" target=192.168.99.190/32
/queue simple add comment=dtq,78:31:C1:CF:9E:70,MbpAlx name="MbpAlx@main dhcp (78:31:C1:CF:9E:70)" target=192.168.99.160/32
/queue simple add comment=dtq,38:C9:86:51:D2:B3,MbpAlx name="MbpAlx@main dhcp (38:C9:86:51:D2:B3)" target=192.168.99.170/32
/queue simple add comment=dtq,08:00:27:17:3A:80,AsusGlo name="AsusGlo@main dhcp (08:00:27:17:3A:80)" target=192.168.99.20/32
/queue simple add comment=dtq,00:CD:FE:EC:B5:52,iPhoneGl name="iPhoneGl@main dhcp (00:CD:FE:EC:B5:52)" target=192.168.99.130/32
/queue simple add comment=dtq,00:CD:FE:EC:B5:52, name="@guest dhcp (00:CD:FE:EC:B5:52)" target=192.168.98.230/32
/queue simple add comment=dtq,98:22:EF:26:FE:6E,AsusGlo name="AsusGlo@main dhcp (98:22:EF:26:FE:6E)" target=192.168.99.70/32
/queue simple add comment=dtq,98:22:EF:26:FE:6E, name="asusGl@guest dhcp (98:22:EF:26:FE:6E)" target=192.168.98.210/32
/queue simple add comment=dtq,88:53:95:30:68:9F, name="@guest dhcp (88:53:95:30:68:9F)" target=192.168.98.228/32
/queue simple add comment=dtq,AC:61:EA:EA:CC:84, name="@guest dhcp (AC:61:EA:EA:CC:84)" target=192.168.98.225/32
/queue simple add comment=dtq,54:E4:3A:B8:12:07,iPadAlx name="iPadAlx@guest dhcp (54:E4:3A:B8:12:07)" target=192.168.98.224/32
/queue simple add comment=dtq,10:DD:B1:9E:19:5E,miniAlx name="miniAlx@main dhcp (10:DD:B1:9E:19:5E)" target=192.168.99.180/32
/queue simple add comment=dtq,94:C6:91:94:98:DC, name="@main dhcp (94:C6:91:94:98:DC)" target=192.168.99.88/32
/queue simple add comment=dtq,CC:2D:E0:E7:BE:02,LivingRoomWAP name="LivingRoomWAP@main dhcp (CC:2D:E0:E7:BE:02)" target=192.168.99.2/32
/queue simple add comment=dtq,54:2B:8D:77:38:A0,iPhoneAlxr name="iPhoneAlxr@guest dhcp (54:2B:8D:77:38:A0)" target=192.168.98.223/32
/queue simple add comment=dtq,00:11:32:2C:A7:85,nas name="nas@main dhcp (00:11:32:2C:A7:85)" target=192.168.99.30/32
/queue simple add comment=dtq,54:2B:8D:7F:83:A6,iPhoneGl name="iPhoneGl@guest dhcp (54:2B:8D:7F:83:A6)" target=192.168.98.226/32
/queue simple add comment=dtq,54:2B:8D:77:38:A0,iPhoneAlxr name="iPhoneAlxr@main dhcp (54:2B:8D:77:38:A0)" target=192.168.99.230/32
/queue simple add comment=dtq,54:2B:8D:7F:83:A6,iPhoneGLO name="iPhoneGLO@main dhcp (54:2B:8D:7F:83:A6)" target=192.168.99.240/32
/queue simple add comment=dtq,08:00:27:1C:F3:07,openflixr name="openflixr@main dhcp (08:00:27:1C:F3:07)" target=192.168.99.10/32
/queue tree add comment="FILE download control" disabled=yes name="Total Bandwidth" parent=global queue=default
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
/system logging action add disk-file-count=1 disk-file-name=flash/ScriptsDiskLog disk-lines-per-file=10000 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=1 disk-file-name=flash/ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add memory-lines=500 name=OnScreenLog target=memory
/system logging action add name=DHCPOnScreenLog target=memory
/system logging action add name=DNSOnScreenLog target=memory
/system logging action add name=RouterControlLog target=memory
/system logging action add name=OSPFOnscreenLog target=memory
/system logging action add name=L2TPOnScreenLog target=memory
/system logging action add disk-file-name=flash/AuthDiskLog name=AuthDiskLog target=disk
/system logging action add name=CertificatesOnScreenLog target=memory
/system logging action add memory-lines=6000 name=ParseMemoryLog target=memory
/system logging action add name=CAPSOnScreenLog target=memory
/system logging action add name=FirewallOnScreenLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!write,!policy,!sensitive,!dude
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!policy,!sensitive,!dude
/caps-man access-list add action=reject allow-signal-out-of-range=10s comment="Drop any when poor signal rate, https://support.apple.com/en-us/HT203068" disabled=no signal-range=-120..-70 ssid-regexp=WiFi
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=iPhoneAlx disabled=no mac-address=AC:61:EA:EA:CC:84 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=iPhoneGl disabled=no mac-address=00:CD:FE:EC:B5:52 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=mbpAlx disabled=no mac-address=78:31:C1:CF:9E:70 ssid-regexp=WiFi
/caps-man access-list add action=accept allow-signal-out-of-range=10s ap-tx-limit=0 client-to-client-forwarding=yes comment=ATV disabled=no mac-address=90:DD:5D:C8:46:AB ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=iPadAlx disabled=no mac-address=54:E4:3A:B8:12:07 ssid-regexp="WiFi 2"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=iPhoneAlxr disabled=no mac-address=54:2B:8D:77:38:A0 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=iPhoneGlo disabled=no mac-address=54:2B:8D:7F:83:A6 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=asusGl disabled=no mac-address=98:22:EF:26:FE:6E ssid-regexp=WiFi
/caps-man access-list add action=accept allow-signal-out-of-range=10s comment="Allow any other on guest wireless" disabled=no ssid-regexp=FREE
/caps-man access-list add action=reject allow-signal-out-of-range=10s comment="Drop any other on private wireless" disabled=no ssid-regexp=PRIVATE
/caps-man manager set ca-certificate=auto certificate=auto enabled=yes require-peer-certificate=yes upgrade-policy=suggest-same-version
/caps-man manager interface set [ find default=yes ] comment="Deny CapsMan on All"
/caps-man manager interface add comment="Deny WAN CapsMan" disabled=no forbid=yes interface=wan
/caps-man manager interface add comment="Do CapsMan on private" disabled=no interface="main infrastructure"
/caps-man manager interface add comment="Do CapsMan on guest" disabled=no interface="guest infrastructure"
/caps-man provisioning add action=create-dynamic-enabled comment="2Ghz private/guest" hw-supported-modes=gn identity-regexp=WAP master-configuration=zone-2Ghz-private name-format=prefix-identity name-prefix=2Ghz slave-configurations=zone-2Ghz-guest
/caps-man provisioning add action=create-dynamic-enabled comment="5Ghz private" hw-supported-modes=ac identity-regexp=WAP master-configuration=zone-5Ghz-private name-format=prefix-identity name-prefix=5Ghz
/caps-man provisioning add action=create-dynamic-enabled comment="2Ghz private/guest (self-cap)" hw-supported-modes=gn identity-regexp=mikrouter master-configuration=zone-2Ghz-private name-format=prefix-identity name-prefix=2Ghz slave-configurations=zone-2Ghz-guest
/caps-man provisioning add action=create-dynamic-enabled comment="5Ghz private (self-cap)" hw-supported-modes=ac identity-regexp=mikrouter master-configuration=zone-5Ghz-private name-format=prefix-identity name-prefix=5Ghz
/caps-man provisioning add comment=DUMMY master-configuration=empty name-format=prefix-identity name-prefix=dummy
/certificate settings set crl-download=no crl-use=no
/interface bridge filter add action=drop chain=forward comment="drop all dhcp requests over bridge" dst-port=67 ip-protocol=udp mac-protocol=ip
/interface bridge port add bridge="main infrastructure" interface="lan D (master)"
/interface bridge port add bridge="main infrastructure" interface="wlan 2Ghz"
/interface bridge port add bridge="main infrastructure" interface="wlan 5Ghz"
/interface bridge port add bridge="main infrastructure" interface="lan A"
/interface bridge port add bridge="main infrastructure" interface="lan B"
/interface bridge port add bridge="main infrastructure" interface="lan C"
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
/interface list member add comment="PRIVATE WLAN" interface="wlan 2Ghz" list=list-private-wireless
/interface list member add comment="PRIVATE WLAN" interface="wlan 5Ghz" list=list-private-wireless
/interface wireless access-list add comment=ATV interface="wlan 2Ghz" mac-address=B0:34:95:2D:D6:85 vlan-mode=no-tag
/interface wireless access-list add comment=iPhoneAlx interface="wlan 5Ghz" mac-address=AC:61:EA:EA:CC:84 vlan-mode=no-tag
/interface wireless access-list add authentication=no comment="Block iPhoneAlx on 2Ghz" interface="wlan 2Ghz" mac-address=AC:61:EA:EA:CC:84 vlan-mode=no-tag
/interface wireless access-list add comment=iPhoneGl interface="wlan 5Ghz" mac-address=00:CD:FE:EC:B5:52 vlan-mode=no-tag
/interface wireless access-list add authentication=no comment="Block iPhoneGl on 2Ghz" interface="wlan 2Ghz" mac-address=00:CD:FE:EC:B5:52 vlan-mode=no-tag
/interface wireless access-list add comment=iPadAlx interface="wlan 2Ghz" mac-address=54:E4:3A:B8:12:07 vlan-mode=no-tag
/interface wireless access-list add authentication=no comment="Block iPadAlx on 5Ghz" interface="wlan 5Ghz" mac-address=54:E4:3A:B8:12:07 vlan-mode=no-tag
/interface wireless access-list add comment=MbpAlx interface="wlan 2Ghz" mac-address=78:31:C1:CF:9E:70 vlan-mode=no-tag
/interface wireless access-list add comment=asusGl interface="wlan 2Ghz" mac-address=98:22:EF:26:FE:6E vlan-mode=no-tag
/interface wireless cap
# 
set caps-man-addresses=192.168.99.1 certificate=request enabled=yes interfaces="wlan 2Ghz,wlan 5Ghz" lock-to-caps-man=yes
/interface wireless snooper set receive-errors=yes
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
/ip arp add address=192.168.99.190 interface="main infrastructure" mac-address=90:DD:5D:C8:46:AB
/ip arp add address=192.168.99.170 interface="main infrastructure" mac-address=38:C9:86:51:D2:B3
/ip arp add address=192.168.99.20 interface="main infrastructure" mac-address=08:00:27:17:3A:80
/ip arp add address=192.168.99.130 interface="main infrastructure" mac-address=00:CD:FE:EC:B5:52
/ip arp add address=192.168.99.70 interface="main infrastructure" mac-address=98:22:EF:26:FE:6E
/ip arp add address=192.168.99.180 interface="main infrastructure" mac-address=10:DD:B1:9E:19:5E
/ip arp add address=192.168.99.88 interface="main infrastructure" mac-address=94:C6:91:94:98:DC
/ip arp add address=192.168.99.200 interface="main infrastructure" mac-address=CC:2D:E0:E7:BE:02
/ip arp add address=192.168.99.30 interface="main infrastructure" mac-address=00:11:32:2C:A7:85
/ip arp add address=192.168.99.230 interface="main infrastructure" mac-address=54:2B:8D:77:38:A0
/ip arp add address=192.168.99.240 interface="main infrastructure" mac-address=54:2B:8D:7F:83:A6
/ip arp add address=192.168.99.10 interface="main infrastructure" mac-address=08:00:27:1C:F3:07
/ip arp add address=192.168.99.2 interface="main infrastructure" mac-address=CC:2D:E0:E7:BE:02
/ip cloud set ddns-enabled=yes
/ip dhcp-server lease add address=192.168.99.140 always-broadcast=yes client-id=1:54:e4:3a:b8:12:7 mac-address=54:E4:3A:B8:12:07 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.150 client-id=1:ac:61:ea:ea:cc:84 disabled=yes mac-address=AC:61:EA:EA:CC:84 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.190 mac-address=90:DD:5D:C8:46:AB server="main dhcp"
/ip dhcp-server lease add address=192.168.99.160 address-lists=osx-hosts client-id=1:78:31:c1:cf:9e:70 mac-address=78:31:C1:CF:9E:70 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.170 address-lists=osx-hosts mac-address=38:C9:86:51:D2:B3 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.20 mac-address=08:00:27:17:3A:80 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.130 always-broadcast=yes client-id=1:0:cd:fe:ec:b5:52 disabled=yes mac-address=00:CD:FE:EC:B5:52 server="main dhcp"
/ip dhcp-server lease add address=192.168.98.230 block-access=yes client-id=1:0:cd:fe:ec:b5:52 mac-address=00:CD:FE:EC:B5:52 server="guest dhcp"
/ip dhcp-server lease add address=192.168.99.70 client-id=1:98:22:ef:26:fe:6e mac-address=98:22:EF:26:FE:6E server="main dhcp"
/ip dhcp-server lease add address=192.168.98.210 block-access=yes client-id=1:98:22:ef:26:fe:6e comment=asusGl mac-address=98:22:EF:26:FE:6E server="guest dhcp"
/ip dhcp-server lease add address=192.168.98.228 block-access=yes client-id=1:88:53:95:30:68:9f mac-address=88:53:95:30:68:9F server="guest dhcp"
/ip dhcp-server lease add address=192.168.98.225 block-access=yes client-id=1:ac:61:ea:ea:cc:84 mac-address=AC:61:EA:EA:CC:84 server="guest dhcp"
/ip dhcp-server lease add address=192.168.98.224 block-access=yes client-id=1:54:e4:3a:b8:12:7 mac-address=54:E4:3A:B8:12:07 server="guest dhcp"
/ip dhcp-server lease add address=192.168.99.180 address-lists=osx-hosts always-broadcast=yes mac-address=10:DD:B1:9E:19:5E server="main dhcp"
/ip dhcp-server lease add address=192.168.99.88 mac-address=94:C6:91:94:98:DC server="main dhcp"
/ip dhcp-server lease add address=192.168.99.2 mac-address=CC:2D:E0:E7:BE:02 server="main dhcp"
/ip dhcp-server lease add address=192.168.98.223 block-access=yes client-id=1:54:2b:8d:77:38:a0 mac-address=54:2B:8D:77:38:A0 server="guest dhcp"
/ip dhcp-server lease add address=192.168.99.30 mac-address=00:11:32:2C:A7:85 server="main dhcp"
/ip dhcp-server lease add address=192.168.98.226 block-access=yes client-id=1:54:2b:8d:7f:83:a6 mac-address=54:2B:8D:7F:83:A6 server="guest dhcp"
/ip dhcp-server lease add address=192.168.99.230 client-id=1:54:2b:8d:77:38:a0 mac-address=54:2B:8D:77:38:A0 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.240 client-id=1:54:2b:8d:7f:83:a6 mac-address=54:2B:8D:7F:83:A6 server="main dhcp"
/ip dhcp-server lease add address=192.168.99.10 mac-address=08:00:27:1C:F3:07 server="main dhcp"
/ip dhcp-server network add address=192.168.98.0/24 comment="Guest DHCP leasing (Yandex protected DNS)" dns-server=77.88.8.7 gateway=192.168.98.1 ntp-server=192.168.98.1
/ip dhcp-server network add address=192.168.99.0/26 caps-manager=192.168.99.1 comment="VIRTUAL MACHINES DHCP leasing" dhcp-option=DomainName dns-server=192.168.99.1,8.8.8.8 gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dhcp-server network add address=192.168.99.64/26 caps-manager=192.168.99.1 comment="WINDOWS DHCP leasing" dhcp-option=DomainName dns-server=192.168.99.1,8.8.8.8 gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dhcp-server network add address=192.168.99.128/26 caps-manager=192.168.99.1 comment="APPLE DHCP leasing" dhcp-option=DomainName dns-server=192.168.99.1 gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dhcp-server network add address=192.168.99.192/27 caps-manager=192.168.99.1 comment="DNS/PROXY redirect DHCP leasing" gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dhcp-server network add address=192.168.99.224/27 caps-manager=192.168.99.1 comment="RESERVED space DHCP leasing" dhcp-option=DomainName dns-server=192.168.99.1 gateway=192.168.99.1 netmask=24 ntp-server=192.168.99.1
/ip dns set allow-remote-requests=yes cache-max-ttl=1d query-server-timeout=3s servers=192.168.100.1
/ip dns static add address=95.213.159.180 name=atv.qello.com
/ip dns static add address=192.168.99.1 name=mikrouter.home
/ip dns static add address=10.0.0.2 name=mikrouter.home
/ip dns static add address=192.168.99.1 name=mikrouter
/ip dns static add address=192.168.99.1 name=time.windows.com
/ip dns static add address=172.16.0.17 name=influxdb
/ip dns static add address=172.16.0.17 name=influxdb.home
/ip dns static add address=172.16.0.16 name=grafana
/ip dns static add address=172.16.0.16 name=grafana.home
/ip dns static add address=192.168.97.1 name=chr.home
/ip dns static add address=10.0.0.1 name=chr.home
/ip dns static add address=192.168.100.1 name=gateway.home
/ip dns static add address=192.168.99.2 comment="<AUTO:DHCP:main dhcp>" name=LivingRoomWAP.home ttl=5m
/ip dns static add address=192.168.99.170 comment="<AUTO:DHCP:main dhcp>" name=MbpAlx.home ttl=5m
/ip dns static add address=192.168.99.140 comment="<AUTO:DHCP:main dhcp>" name=iPadAlx.home ttl=5m
/ip dns static add address=192.168.99.130 comment="<AUTO:DHCP:main dhcp>" name=iPhoneGl.home ttl=5m
/ip dns static add address=192.168.99.180 comment="<AUTO:DHCP:main dhcp>" name=miniAlx.home ttl=5m
/ip dns static add address=192.168.99.190 comment="<AUTO:DHCP:main dhcp>" name=AlxATV.home ttl=5m
/ip dns static add address=192.168.99.30 comment="<AUTO:DHCP:main dhcp>" name=nas.home ttl=5m
/ip dns static add address=192.168.99.230 comment="<AUTO:DHCP:main dhcp>" name=iPhoneAlxr.home ttl=5m
/ip dns static add address=192.168.99.240 comment="<AUTO:DHCP:main dhcp>" name=iPhoneGLO.home ttl=5m
/ip dns static add address=192.168.99.70 comment="<AUTO:DHCP:main dhcp>" name=AsusGlo.home ttl=5m
/ip dns static add address=192.168.99.10 comment="<AUTO:DHCP:main dhcp>" name=openflixr.home ttl=5m
/ip dns static add address=192.168.99.150 comment="<AUTO:DHCP:main dhcp>" name=iPhone.home ttl=5m
/ip dns static add address=94.29.30.41 name=ftpserver.org
/ip firewall address-list add address=192.168.99.0/24 list=Network
/ip firewall address-list add address=0.0.0.0/8 comment="RFC 1122 \"This host on this network\"" disabled=yes list=Bogons
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
/ip firewall address-list add address=185.6.175.49 comment="Manual Black List" list="Black List"
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
/ip firewall address-list add address=auntmia.com list=vpn-tunneled-sites
/ip firewall address-list add address=clubseventeen.com list=vpn-tunneled-sites
/ip firewall address-list add address=207.32.194.24 list=vpn-tunneled-sites
/ip firewall address-list add address=speedtest.tele2.net disabled=yes list=vpn-tunneled-sites
/ip firewall address-list add address=192.168.99.1 comment="Add DNS Server to this List" list="DNS Allow"
/ip firewall address-list add address=hqporner.com list=vpn-tunneled-sites
/ip firewall address-list add address=www.eporner.com list=vpn-tunneled-sites
/ip firewall address-list add address=www.youjizz.com list=vpn-tunneled-sites
/ip firewall address-list add address=teenskitten.com list=vpn-tunneled-sites
/ip firewall address-list add address=lostfilm.tv list=vpn-tunneled-sites
/ip firewall address-list add address=pornhub.com list=vpn-tunneled-sites
/ip firewall address-list add address=nnmclub.to list=vpn-tunneled-sites
/ip firewall address-list add address=rutor.org list=vpn-tunneled-sites
/ip firewall address-list add address=Fast-Torrent.ru list=vpn-tunneled-sites
/ip firewall address-list add address=rutor.info list=vpn-tunneled-sites
/ip firewall address-list add address=hdreactor.net list=vpn-tunneled-sites
/ip firewall address-list add address=94.29.30.41 list=external-ip
/ip firewall filter add action=accept chain=input comment="OSFP neighbour-ing allow" log-prefix=#OSFP protocol=ospf
/ip firewall filter add action=accept chain=input comment="Allow mikrotik self-discovery" dst-address-type=broadcast dst-port=5678 protocol=udp
/ip firewall filter add action=accept chain=forward comment="Allow mikrotik neighbor-discovery" dst-address-type=broadcast dst-port=5678 protocol=udp
/ip firewall filter add action=accept chain=output comment=CAPsMAN dst-address-type=local port=5246,5247 protocol=udp src-address-type=local
/ip firewall filter add action=accept chain=input comment=CAPsMAN dst-address-type=local port=5246,5247 protocol=udp src-address-type=local
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
/ip firewall filter add action=accept chain=input comment="Self fetch requests" log-prefix=WEB port=80 protocol=tcp
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
/ip firewall filter add action=accept chain=detect-ping-flood comment="0:0 and limit for 5 pac/s Allow Ping" icmp-options=0:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="3:3 and limit for 5 pac/s Allow Traceroute" icmp-options=3:3 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="3:4 and limit for 5 pac/s Allow Path MTU Discovery" icmp-options=3:4 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="8:0 and limit for 5 pac/s Allow Ping" icmp-options=8:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="11:0 and limit for 5 pac/s Allow Traceroute" icmp-options=11:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="0:0 and limit for 50 pac/s Allow Ping tool speed-test" icmp-options=0:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="8:0 and limit for 50 pac/s Allow Ping tool speed-test" icmp-options=8:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=drop chain=detect-ping-flood comment="drop everything else" log-prefix="#ICMP DROP" protocol=icmp
/ip firewall filter add action=return chain=detect-ping-flood comment="Return from detect-ping-flood Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY1 disabled=yes log-prefix=#DUMMY1 src-address-list=dummy
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
/ip firewall filter add action=passthrough chain=forward comment=DUMMY2 disabled=yes log-prefix=#DUMMY2 src-address-list=dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC SSH Chain" jump-target="RFC SSH Chain"
/ip firewall filter add action=add-src-to-address-list address-list="Black List (SSH)" address-list-timeout=1w3d chain="RFC SSH Chain" comment="Transfer repeated attempts from SSH Stage 3 to Black-List" connection-state=new dst-port=22 protocol=tcp src-address-list="SSH Stage 3"
/ip firewall filter add action=add-src-to-address-list address-list="SSH Stage 3" address-list-timeout=1m chain="RFC SSH Chain" comment="Add succesive attempts to SSH Stage 3" connection-state=new dst-port=22 protocol=tcp src-address-list="SSH Stage 2"
/ip firewall filter add action=add-src-to-address-list address-list="SSH Stage 2" address-list-timeout=1m chain="RFC SSH Chain" comment="Add succesive attempts to SSH Stage 2" connection-state=new dst-port=22 protocol=tcp src-address-list="SSH Stage 1"
/ip firewall filter add action=add-src-to-address-list address-list="SSH Stage 1" address-list-timeout=1m chain="RFC SSH Chain" comment="Add intial attempt to SSH Stage 1 List" connection-state=new dst-port=22 protocol=tcp
/ip firewall filter add action=return chain="RFC SSH Chain" comment="Return From RFC SSH Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY3 disabled=yes log-prefix=#DUMMY3 src-address-list=dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Telnet Chain" jump-target="RFC Telnet Chain"
/ip firewall filter add action=add-src-to-address-list address-list="Black List (Telnet)" address-list-timeout=1w3d chain="RFC Telnet Chain" comment="Transfer repeated attempts from Telnet Stage 3 to Black-List" connection-state=new dst-port=23 protocol=tcp src-address-list="Telnet Stage 3"
/ip firewall filter add action=add-src-to-address-list address-list="Telnet Stage 3" address-list-timeout=1m chain="RFC Telnet Chain" comment="Add succesive attempts to Telnet Stage 3" connection-state=new dst-port=23 protocol=tcp src-address-list="Telnet Stage 2"
/ip firewall filter add action=add-src-to-address-list address-list="Telnet Stage 1" address-list-timeout=1m chain="RFC Telnet Chain" comment="Add Intial attempt to Telnet Stage 1" connection-state=new dst-port=23 protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list="Telnet Stage 2" address-list-timeout=1m chain="RFC Telnet Chain" comment="Add succesive attempts to Telnet Stage 2" connection-state=new dst-port=23 protocol=tcp src-address-list="Telnet Stage 1"
/ip firewall filter add action=return chain="RFC Telnet Chain" comment="Return From RFC Telnet Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY4 disabled=yes log-prefix=#DUMMY4 src-address-list=dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Winbox Chain" jump-target="RFC Winbox Chain"
/ip firewall filter add action=add-src-to-address-list address-list="Black List (Winbox)" address-list-timeout=1w3d chain="RFC Winbox Chain" comment="Transfer repeated attempts from Winbox Stage 3 to Black-List" connection-state=new dst-port=8291 protocol=tcp src-address-list="Winbox Stage 3"
/ip firewall filter add action=add-src-to-address-list address-list="Winbox Stage 3" address-list-timeout=1m chain="RFC Winbox Chain" comment="Add succesive attempts to Winbox Stage 3" connection-state=new dst-port=8291 protocol=tcp src-address-list="Winbox Stage 2"
/ip firewall filter add action=add-src-to-address-list address-list="Winbox Stage 2" address-list-timeout=1m chain="RFC Winbox Chain" comment="Add succesive attempts to Winbox Stage 2" connection-state=new dst-port=8291 protocol=tcp src-address-list="Winbox Stage 1"
/ip firewall filter add action=add-src-to-address-list address-list="Winbox Stage 1" address-list-timeout=1m chain="RFC Winbox Chain" comment="Add Intial attempt to Winbox Stage 1" connection-state=new dst-port=8291 protocol=tcp
/ip firewall filter add action=return chain="RFC Winbox Chain" comment="Return From RFC Winbox Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY5 disabled=yes log-prefix=#DUMMY5 src-address-list=dummy
/ip firewall filter add action=add-src-to-address-list address-list=WAN-port-scanner address-list-timeout=10h chain=input comment="Add TCP Port Scanners to Address List" disabled=yes protocol=tcp psd=40,3s,2,1 src-address-list=!WAN-port-scanner
/ip firewall filter add action=add-src-to-address-list address-list=LAN-port-scanner address-list-timeout=10h chain=forward comment="Add TCP Port Scanners to Address List" disabled=yes protocol=tcp psd=40,3s,2,1 src-address-list=!LAN-port-scanner
/ip firewall filter add action=passthrough chain=forward comment=DUMMY6 disabled=yes log-prefix=#DUMMY6 src-address-list=dummy
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
/ip firewall filter add action=passthrough chain=forward comment=DUMMY7 disabled=yes log-prefix=#DUMMY7 src-address-list=dummy
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
/ip firewall filter add action=passthrough chain=forward comment=DUMMY8 disabled=yes log-prefix=#DUMMY8 src-address-list=dummy
/ip firewall filter add action=drop chain=input comment="Open proxy block" dst-port=8888 in-interface=wan protocol=tcp
/ip firewall filter add action=drop chain=forward comment="WAN static-routes intruders not DSTNATed drop" connection-nat-state=dstnat connection-state=new in-interface=wan log-prefix="#DROP UNKNOWN (FWD/no DSTN)"
/ip firewall filter add action=drop chain=forward comment="Drop all other LAN Traffic" log-prefix="#DROP UNKNOWN (FWD)"
/ip firewall filter add action=drop chain=input comment="Drop all other WAN Traffic" log-prefix="#DROP UNKNOWN (INPUT)"
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" in-interface=all-ppp new-mss=1360 passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" new-mss=1360 out-interface=all-ppp passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=output comment="fix MSS for l2tp/ipsec (self)" new-mss=1360 passthrough=yes protocol=tcp src-address-list="VPN network" tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=mark-connection chain=prerouting comment="Mark l2tp" connection-mark=no-mark connection-state=new dst-address-list=vpn-tunneled-sites new-connection-mark=vpn-l2tp passthrough=yes
/ip firewall mangle add action=mark-connection chain=prerouting comment="Mark l2tp (telegram)" connection-mark=no-mark connection-state=new dst-address-list=Telegram new-connection-mark=vpn-l2tp passthrough=yes
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self)" dst-address-list=vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self, telegram notify)" dst-address-list=Telegram log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites" connection-mark=vpn-l2tp dst-address-list=vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites (telegram)" connection-mark=vpn-l2tp dst-address-list=Telegram log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=passthrough chain=prerouting comment=DUMMY
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
/ip ipsec identity add auth-method=digital-signature certificate=mikrouter@CHR comment=to-CHR-outer-tunnel-encryption-RSA peer=CHR-external policy-template-group=outside-ipsec-encryption
/ip ipsec identity add comment=to-CHR-traffic-only-encryption-PSK peer=CHR-internal policy-template-group=inside-ipsec-encryption remote-id=ignore secret=123
/ip ipsec policy set 0 proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip ipsec policy add comment="Common IPSEC TRANSPORT (outer-tunnel encryption)" dst-address=185.13.148.14/32 dst-port=1701 peer=CHR-external proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=192.168.100.7/32 src-port=1701
/ip ipsec policy add comment="Common IPSEC TUNNEL (traffic-only encryption)" dst-address=192.168.97.0/30 peer=CHR-internal proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" sa-dst-address=10.0.0.1 sa-src-address=10.0.0.2 src-address=192.168.99.0/24 tunnel=yes
/ip proxy set cache-administrator=defm.kopcap@gmail.com max-client-connections=10 max-fresh-time=20m max-server-connections=10 parent-proxy=0.0.0.0 port=8888 serialize-connections=yes
/ip proxy access add action=deny dst-host=grafana redirect-to=192.168.99.180:3000
/ip proxy access add action=deny dst-host=influxdb redirect-to=192.168.99.180:8000
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
/ip ssh set allow-none-crypto=yes forwarding-enabled=remote
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
/system logging add action=CAPSOnScreenLog topics=caps
/system logging add action=FirewallOnScreenLog topics=firewall
/system logging add action=CAPSOnScreenLog topics=wireless
/system logging add action=ParseMemoryLog topics=info,system
/system note set note="You are logged into: mikrouter\
    \n############### system health ###############\
    \nUptime:  00:00:20 d:h:m:s | CPU: 63%\
    \nRAM: 29920/131072M | Voltage: 23 v | Temp: 49c\
    \n############# user auth details #############\
    \nHotspot online: 0 | PPP online: 0\
    \n"
/system ntp client set enabled=yes primary-ntp=195.151.98.66 secondary-ntp=46.254.216.9
/system ntp server set broadcast=yes enabled=yes multicast=yes
/system package update set channel=testing
/system scheduler add interval=1h name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=read,write,policy,password start-date=jan/30/2017 start-time=18:57:09
/system scheduler add interval=10h name=doIpsecPolicyUpd on-event="/system script run doIpsecPolicyUpd" policy=read,write start-date=feb/21/2017 start-time=15:31:13
/system scheduler add interval=1d name=doUpdateStaticDNSviaDHCP on-event="/system script run doUpdateStaticDNSviaDHCP" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/21/2017 start-time=19:19:59
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sensitive start-date=mar/01/2018 start-time=15:55:00
/system scheduler add interval=1w3d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jun/26/2018 start-time=21:00:00
/system scheduler add interval=30m name=doHeatFlag on-event="/system script run doHeatFlag" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/10/2018 start-time=15:10:00
/system scheduler add interval=1h name=doCollectSpeedStats on-event="/system script run doCollectSpeedStats" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2018 start-time=03:25:00
/system scheduler add interval=1h name=doCheckPingRate on-event="/system script run doCheckPingRate" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2018 start-time=02:40:00
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=07:00:00
/system scheduler add interval=1m name=doPeriodicLogDump on-event="/system script run doPeriodicLogDump" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=11:31:24
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=1d name=doTrackFirmwareUpdates on-event="/system script run doTrackFirmwareUpdates" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=11:30:00
/system scheduler add interval=1d name=doCreateTrafficAccountingQueues on-event="/system script run doCreateTrafficAccountingQueues" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system scheduler add interval=10m name=doPushStatsToInfluxDB on-event="/system script run doPushStatsToInfluxDB" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system scheduler add interval=15m name=doCPUHighLoadReboot on-event="/system script run doCPUHighLoadReboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=06:05:00
/system scheduler add interval=10m name=doIPSECPunch on-event="/system script run doIPSECPunch" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system script add comment="Creates static DNS entres for DHCP clients in the named DHCP server. Hostnames passed to DHCP are appended with the zone" dont-require-permissions=yes name=doUpdateStaticDNSviaDHCP owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="StarWars march to  alarm on startup" dont-require-permissions=yes name=doImperialMarch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="Updates address-list that contains my external IP" dont-require-permissions=yes name=doUpdateExternalDNS owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="Runs once on startup and makes console welcome message pretty" dont-require-permissions=no name=doCoolConcole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="Just to note of fast-track activation" dont-require-permissions=no name=doFastTrackActivation owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/ip settings set allow-fast-path=yes\r\
    \n/ip firewall filter add chain=forward action=fasttrack-connection connection-state=established,related"
/system script add comment="Some sound" dont-require-permissions=yes name=doWestminister owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="Loads a HUGE list of ads/spammers to DNS-static records. https://stopad.cgood.ru/" dont-require-permissions=no name=doAdblock owner=owner policy=read,write,policy source="## StopAD - Script for blocking advertisements, based on your defined hosts files\r\
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
/system script add comment="Script to simplify IPSEC IKEv2 certificates ussuing (a set of CA, server, clients and signing) to be used for VPN tunnels" dont-require-permissions=yes name=doCertificatesIssuing owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n# generates IPSEC certs: CA, server, IOS *.mobileconfig profile sign and clients\r\
    \n# i recommend to run it on server side\r\
    \n\r\
    \n#clients\r\
    \n:local IDs [:toarray \"mikrouter,alx.iphone.rw.2019,glo.iphone.rw.2019,alx.mbp.rw.2019\"];\r\
    \n:local fakeDomain \"myvpn.fake.org\"\r\
    \n\r\
    \n:local sysname [/system identity get name]\r\
    \n:local sysver [/system package get system version]\r\
    \n:local scriptname \"doCertificatesIssuing\"\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n## this fields should be empty IPSEC/ike2/RSA to work, i can't get it functional with filled fields\r\
    \n#:local COUNTRY \"RU\"\r\
    \n#:local STATE \"MSC\"\r\
    \n#:local LOC \"Moscow\"\r\
    \n#:local ORG \"IKEv2 Home\"\r\
    \n#:local OU \"IKEv2 Mikrotik\"\r\
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
    \n  ## generate a CA certificate (that will be just a template while not signed)\r\
    \n  ## crl-sign allows to use SCEP\r\
    \n  /certificate add name=\"ca.\$fakeDomain\" common-name=\"ca@\$sysname\" subject-alt-name=\"DNS:ca.\$fakeDomain\"  key-usage=crl-sign,key-cert-sign country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=3650 \r\
    \n\r\
    \n  :local state \"Signing...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  /certificate sign \"ca.\$fakeDomain\" ca-crl-host=\"\$ServerIP\" name=\"ca@\$sysname\"\r\
    \n\r\
    \n  :delay 6s\r\
    \n\r\
    \n  /certificate set trusted=yes \"ca@\$sysname\"\r\
    \n\r\
    \n  :local state \"Exporting CA as PEM...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  ## export the CA, as PEM\r\
    \n  /certificate export-certificate \"ca@\$sysname\" type=pem\r\
    \n  \r\
    \n  :local state \"SERVER certificates generation...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  ## generate a server certificate (that will be just a template while not signed)\r\
    \n  /certificate add name=\"server.\$fakeDomain\" common-name=\"server@\$sysname\" subject-alt-name=\"IP:\$ServerIP,DNS:\$fakeDomain\" key-usage=tls-server country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365 \r\
    \n\r\
    \n  :local state \"Signing...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  /certificate sign \"server.\$fakeDomain\" ca=\"ca@\$sysname\" name=\"server@\$sysname\"\r\
    \n\r\
    \n  :delay 6s\r\
    \n\r\
    \n  /certificate set trusted=yes \"server@\$sysname\"\r\
    \n\r\
    \n  :local state \"CODE SIGN certificates generation...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  ## generate a code signing (apple IOS profiles) certificate (that will be just a template while not signed)\r\
    \n  /certificate add name=\"sign.\$fakeDomain\" common-name=\"sign@\$sysname\" subject-alt-name=\"DNS:sign.\$fakeDomain\" key-usage=code-sign,digital-signature country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365 \r\
    \n\r\
    \n  :local state \"Signing...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  /certificate sign \"sign.\$fakeDomain\" ca=\"ca@\$sysname\" name=\"sign@\$sysname\"\r\
    \n\r\
    \n  :delay 6s\r\
    \n\r\
    \n  /certificate set trusted=yes \"sign@\$sysname\"\r\
    \n\r\
    \n  ## export the CA, code sign certificate, and private key\r\
    \n  /certificate export-certificate \"sign@\$sysname\" export-passphrase=\"1234567890\" type=pkcs12\r\
    \n\r\
    \n  :foreach USERNAME in=\$IDs do={\r\
    \n\r\
    \n    :local state \"CLIENT certificates generation...  \$USERNAME\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    ## create a client certificate (that will be just a template while not signed)\r\
    \n    /certificate add name=\"client.\$fakeDomain\" common-name=\"\$USERNAME@\$sysname\" subject-alt-name=\"email:\$USERNAME@\$fakeDomain\" key-usage=tls-client country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365 \r\
    \n\r\
    \n    :local state \"Signing...\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    /certificate sign \"client.\$fakeDomain\" ca=\"ca@\$sysname\" name=\"\$USERNAME@\$sysname\"\r\
    \n\r\
    \n    :delay 6s\r\
    \n\r\
    \n    /certificate set trusted=yes \"\$USERNAME@\$sysname\"\r\
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
    \n\r\
    \n"
/system script add comment="Checks device temperature and warns on overheat" dont-require-permissions=yes name=doHeatFlag owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doHeatFlag\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n\r\
    \n:local maxTemp;\r\
    \n:local currentTemp [/system health get temperature];\r\
    \n\r\
    \n:set maxTemp 60;\r\
    \n\r\
    \n#\r\
    \n\r\
    \n:if (\$currentTemp > \$maxTemp) do= {\r\
    \n\r\
    \n:local inf \"\$scriptname on \$sysname: system overheat at \$currentTemp C\"  \r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\$globalTgMessage value=\$inf;\r\
    \n\r\
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
/system script add comment="Collects bandwidth speeds using Mikrotik proprietary protocol, so you need mikrotik devices on both sides (i'm using CHR)" dont-require-permissions=yes name=doCollectSpeedStats owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \ntool bandwidth-test protocol=tcp direction=transmit user=btest password=btest address=\$btServer duration=15s do={\r\
    \n:set txAvg (\$\"tx-total-average\" / 1048576 );\r\
    \n}\r\
    \n\r\
    \ntool bandwidth-test protocol=tcp direction=receive user=btest password=btest address=\$btServer duration=15s do={\r\
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
/system script add comment="This one checks some latencies (2 hosts, one is 8.8.8.8) and warns if its over \$ms value" dont-require-permissions=yes name=doCheckPingRate owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doCheckPingRate\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n\r\
    \n#Mikrotik Ping more than 25ms to send mail\r\
    \n\r\
    \n:local host  [:resolve \"ya.ru\"];\r\
    \n:local ms 20;\r\
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
    \n:local inf \"\$scriptname on \$sysname: Yandex latency is too high (\$rate ms, over \$ms ms)\";\r\
    \n\r\
    \n\$globalNoteMe value=\$inf;\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\$globalTgMessage value=\$inf;\r\
    \n\r\
    \n#some sound\r\
    \n\r\
    \n}"
/system script add comment="Some sound" dont-require-permissions=yes name=doSomeAlarm owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="Runs at midnight to have less flashes at living room (swith off all LEDs)" dont-require-permissions=yes name=doLEDoff owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doLEDoff\";\r\
    \n\r\
    \n/system leds settings set all-leds-off=immediate\r\
    \n\r\
    \n"
/system script add comment="Runs at morning to get flashes back (swith on all LEDs)" dont-require-permissions=yes name=doLEDon owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doLEDon\";\r\
    \n\r\
    \n/system leds settings set all-leds-off=never;\r\
    \n"
/system script add comment="Just some sound" dont-require-permissions=no name=doBumerSound owner=owner policy=read,test source=":global globalScriptBeforeRun;\r\
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
/system script add comment="Netwatch handler both when OnUp and OnDown" dont-require-permissions=no name=doNetwatchHost owner=owner policy=reboot,read,write,test source="\r\
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
    \n:set state \"Netwatch for \$NetwatchHostName started...\";\r\
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
    \n     :set state \"\$NetwatchHostName is UP\";\r\
    \n     \$globalNoteMe value=\$state;\r\
    \n     #success when OnUp\r\
    \n     :set itsOk true;\r\
    \n\r\
    \n   } else {\r\
    \n\r\
    \n    :set state \"\$NetwatchHostName is DOWN\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    #success when OnDown\r\
    \n    :set itsOk true;\r\
    \n    \r\
    \n   }\r\
    \n } else {\r\
    \n\r\
    \n  :set state \"The system is just started, wait some time before using netwatch\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n  :set itsOk false;\r\
    \n\r\
    \n }\r\
    \n} on-error= {\r\
    \n\r\
    \n  :set state \"Netwatch for \$NetwatchHostName FAILED...\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n  :set itsOk false;\r\
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
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: \$state\"  \r\
    \n  \r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n\r\
    \n}\r\
    \n\r\
    \n\r\
    \n"
/system script add comment="DHCP service OnLease handler, should be called from DHCP server script page (see mikrotik manual available variables \$leaseBound, \$leaseServerName etc..)" dont-require-permissions=yes name=doDHCPLeaseTrack owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="Flushes all global variables on Startup" dont-require-permissions=yes name=doEnvironmentClearance owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n#clear all global variables\r\
    \n/system script environment remove [find];"
/system script add comment="Startup script" dont-require-permissions=yes name=doStartupScript owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#Force sync time\r\
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
    \n:delay 25s;\r\
    \n\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doStartupScript\";\r\
    \n\r\
    \n:local inf \"\$scriptname on \$sysname: system restart detected\" ;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n\$globalNoteMe value=\$inf;\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\$globalTgMessage value=\$inf;\r\
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
/system script add comment="Tracks and notifies about firmware releases" dont-require-permissions=yes name=doTrackFirmwareUpdates owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doTrackFirmwareUpdates\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
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
    \n\r\
    \n  :local inf \"\$scriptname on \$sysname: system or firmware update available\";\r\
    \n\r\
    \n  :global globalNoteMe;\r\
    \n  \$globalNoteMe value=\$inf\r\
    \n\r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n\r\
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
/system script add comment="Mikrotik system log dump, collects new entries once per minute. You should have 'ParseMemoryLog' buffer at your 'system-logging'. Calls 'doPeriodicLogParse' when new logs available" dont-require-permissions=yes name=doPeriodicLogDump owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n#\$globalScriptBeforeRun \"doPeriodicLogDump\";\r\
    \n\r\
    \n# Script Name: Log-Parser\r\
    \n# This script reads a specified log buffer.  At each log entry read,\r\
    \n# the global variable 'globalParseVar' is set to \"<log entry time>,<log entry topics>,<log entry message>\"\r\
    \n# then a parser action script is run.  The parser action script reads the global variable, and performs specified actions.\r\
    \n# The log buffer is then cleared, so only new entries are read each time this script gets executed.\r\
    \n\r\
    \n# Set this to a \"memory\" action log buffer\r\
    \n:local logBuffer \"ParseMemoryLog\"\r\
    \n\r\
    \n# Set to name of parser script to run against each log entry in buffer\r\
    \n:local logParserScript \"doPeriodicLogParse\"\r\
    \n# This changes are almost made by the other scripts, so skip them to avoid spam\r\
    \n:local excludedMsgs [:toarray \"static dns entry, simple queue, script settings, led settings\"];\r\
    \n\r\
    \n# Internal processing below....\r\
    \n# -----------------------------------\r\
    \n:global globalParseVar \"\"\r\
    \n:global globalLastParseTime\r\
    \n:global globalLastParseMsg\r\
    \n:global globalNoteMe;\r\
    \n\r\
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
    \n   :if (\$logEntryTime = \$globalLastParseTime && \$logEntryMessage = \$globalLastParseMsg) do={\r\
    \n   \r\
    \n   } else={\r\
    \n\r\
    \n        :local skip false;\r\
    \n        :foreach i in=\$excludedMsgs do={\r\
    \n            :if ( !\$skip and \$logEntryMessage~\$i ) do={\r\
    \n                :set skip true;\r\
    \n                :put \"log entry skipped due to setup: \$logEntryMessage\";  \r\
    \n                }\r\
    \n        }\r\
    \n\r\
    \n        # Do not track LOG config changes because we're doing it right there (in that script)\r\
    \n        # and that will be a huge one-per-minute spam\r\
    \n        :if ( \$skip or \$logEntryMessage~\"log action\") do={\r\
    \n\r\
    \n    \r\
    \n        } else={\r\
    \n\r\
    \n            # Set \$globalParseVar, then run parser script\r\
    \n            :set \$globalParseVar {\$logEntryTime ; \$logEntryTopics; \$logEntryMessage}\r\
    \n            /system script run (\$logParserScript)\r\
    \n\r\
    \n            # Update last parsed time, and last parsed message\r\
    \n            :set \$globalLastParseTime \$logEntryTime\r\
    \n            :set \$globalLastParseMsg \$logEntryMessage\r\
    \n        }\r\
    \n   }\r\
    \n\r\
    \n# end foreach rule\r\
    \n}\r\
    \n"
/system script add comment="Mikrotik system log analyzer, called manually by 'doPeriodicLogDump' script, checks 'interesting' conditions and does the routine" dont-require-permissions=yes name=doPeriodicLogParse owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n#\$globalScriptBeforeRun \"doPeriodicLogParse\";\r\
    \n\r\
    \n:local sysname [/system identity get name]\r\
    \n:local scriptname \"doPeriodicLogParse\"\r\
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
    \n:global globalParseVar;\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n:global globalNoteMe;\r\
    \n\r\
    \n:local logTime (\$globalParseVar->0)\r\
    \n:local logTopics [:tostr (\$globalParseVar->1)]\r\
    \n:local logMessage [:tostr (\$globalParseVar->2)]\r\
    \n\r\
    \n:set \$globalParseVar \"\"\r\
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
    \n\r\
    \n   :local inf \"\$scriptname on \$sysname: A login failure has occured: \$logMessage. Take some action\";\r\
    \n\r\
    \n   \$globalNoteMe value=\$inf;\r\
    \n   \$globalTgMessage value=\$inf;\r\
    \n\r\
    \n}\r\
    \n# End check for login failure\r\
    \n\r\
    \n# Check for logged in users\r\
    \n:if (\$logMessage~\"logged in\") do={\r\
    \n   \r\
    \n   :local inf \"\$scriptname on \$sysname: A user has logged in: \$logMessage\";\r\
    \n\r\
    \n   \$globalNoteMe value=\$inf;\r\
    \n   \$globalTgMessage value=\$inf;\r\
    \n\r\
    \n}\r\
    \n# End check for logged in users\r\
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
    \n\r\
    \n      :local inf \"\$scriptname on \$sysname: \$loguser \$ruleop \$logsettings configuration.  We should take a backup now.\";\r\
    \n\r\
    \n      \$globalNoteMe value=\$inf;\r\
    \n      \$globalTgMessage value=\$inf;\r\
    \n\r\
    \n   }\r\
    \n}\r\
    \n\r\
    \n# End check for configuration changes\r\
    \n\r\
    \n}"
/system script add comment="Punches IPSEC policies when they're not in 'established' state" dont-require-permissions=yes name=doIPSECPunch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\r\
    \n:local scriptname \"doIPSECPunch\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n\r\
    \n:local state \"\";\r\
    \n:local punched \"\";\r\
    \n\r\
    \n\r\
    \n/ip ipsec policy {\r\
    \n  :foreach vpnEndpoint in=[find (!disabled and !template)] do={\r\
    \n\r\
    \n    :local ph2state [get value-name=ph2-state \$vpnEndpoint]\r\
    \n    :local isTunnel [get value-name=tunnel \$vpnEndpoint]\r\
    \n    :local peerPoint [get \$vpnEndpoint peer]\r\
    \n    :local dstIp;\r\
    \n\r\
    \n    :if (\$isTunnel) do={\r\
    \n      :set dstIp [get value-name=sa-dst-address \$vpnEndpoint]\r\
    \n    } else {\r\
    \n      :set dstIp [get value-name=dst-address \$vpnEndpoint]\r\
    \n    }\r\
    \n\r\
    \n    :if ((\$itsOk) and (\$ph2state != \"established\")) do={\r\
    \n\r\
    \n      :set state \"Non-established IPSEC policy found for destination IP \$dstIp. Checking active peers..\"\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n\r\
    \n      :local actPeerProcessed 0;\r\
    \n\r\
    \n      /ip ipsec active-peers {\r\
    \n        :foreach actPeer in=[find remote-address=\$dstIp] do={\r\
    \n\r\
    \n          :local peerId [get \$actPeer id];\r\
    \n          :local peer \"\";\r\
    \n\r\
    \n          :if ([:typeof \$peerId] != \"nil\") do={\r\
    \n            :set peer \"\$peerId\"\r\
    \n          } else {\r\
    \n            :set peer \"\$dstIp\"\r\
    \n          }\r\
    \n\r\
    \n          :do {\r\
    \n\r\
    \n            :set state \"Active peer \$peer found Non-established IPSEC policy. Kill it..\"\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n\r\
    \n            [remove \$actPeer];\r\
    \n\r\
    \n            :set state (\"IPSEC tunnel got a punch after down for \$dstIp \");\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n\r\
    \n            #waiting for tunnel to come up, because Telegram notes goes through tunnel\r\
    \n            :delay 10;\r\
    \n\r\
    \n            :set punched (\$punched . \"\$peer\");\r\
    \n          \r\
    \n          } on-error= {\r\
    \n\r\
    \n            :set state \"Error When \$state\"\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n\r\
    \n            :set itsOk false;\r\
    \n            \r\
    \n          }\r\
    \n\r\
    \n          :set actPeerProcessed (\$actPeerProcessed + 1);\r\
    \n        }\r\
    \n\r\
    \n      }\r\
    \n\r\
    \n      #there were no active peers with such remote-address\r\
    \n      #This is the most common case if the policy is non-established\r\
    \n\r\
    \n      :if (\$actPeerProcessed = 0) do={\r\
    \n\r\
    \n        #should not flush InstalledSA, because ot flushes the whole policies\r\
    \n        #just make disable-enable cycle\r\
    \n        \r\
    \n        :set state (\"There were no active peers with \$dstIp destination IP, but policy is non-established.\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n\r\
    \n        :set state (\"Making disable-enable cycle for policy to clear InstalledSA\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n\r\
    \n        :delay 2;\r\
    \n\r\
    \n        [set \$vpnEndpoint disabled=yes];\r\
    \n        \r\
    \n        #waiting for tunnel to come up, because Telegram notes goes through tunnel\r\
    \n        :delay 5;\r\
    \n\r\
    \n        [set \$vpnEndpoint disabled=no];\r\
    \n\r\
    \n       :delay 5;\r\
    \n\r\
    \n        :local peerId (\$peerPoint -> \"id\");\r\
    \n        :local peer \"\";\r\
    \n\r\
    \n        :put \$peerId;        \r\
    \n\r\
    \n        :if ([:typeof \$peerId] != \"nil\") do={\r\
    \n          :set peer \"\$peerId\"\r\
    \n        } else {\r\
    \n          :set peer \"\$dstIp\"\r\
    \n        }\r\
    \n\r\
    \n        :set punched (\$punched . \"\$peer\");\r\
    \n\r\
    \n      }      \r\
    \n\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n\r\
    \n:if ((\$itsOk) and (\$punched = \"\")) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: IPSEC tunnels are fine\"\r\
    \n}\r\
    \n\r\
    \n:if ((\$itsOk) and (\$punched != \"\")) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: IPSEC tunnels refreshed for \$punched\"\r\
    \n\r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: \$state\"  \r\
    \n  \r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n\r\
    \n}\r\
    \n"
/system script add comment="A template to track hotspot users" dont-require-permissions=yes name=doHotspotLoginTrack owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="Setups global functions, called by the other scripts (runs once on startup)" dont-require-permissions=yes name=doEnvironmentSetup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n    :global globalNoteMe;\r\
    \n    \r\
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
    \n    :global globalNoteMe;\r\
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
    \n\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n\r\
    \n"
/system script add comment="Creates simple queues based on DHCP leases, i'm using it just for per-host traffic statistic and periodically send counters to Grafana" dont-require-permissions=yes name=doCreateTrafficAccountingQueues owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\r\
    \n:local scriptname \"doCreateTrafficAccountingQueues\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n#a part of queue comment to locate queues to be processed\r\
    \n:local qCommentMark \"dtq\";\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n\r\
    \n:local state \"\";\r\
    \n \r\
    \n/ip dhcp-server lease\r\
    \n:foreach x in=[find] do={\r\
    \n   \r\
    \n  # grab variables for use below\r\
    \n  :local dhcpIp ([get \$x address])\r\
    \n  :local dhcpMac [get \$x mac-address]\r\
    \n  :local dhcpHost [get \$x host-name]\r\
    \n  :local dhcpComment [get \$x comment]\r\
    \n  :local dhcpServer [get \$x server]\r\
    \n  :local qComment \"\"\r\
    \n   \r\
    \n  :local leaseinqueue false\r\
    \n\r\
    \n  /queue simple\r\
    \n  :foreach y in=[find where comment~\"\$qCommentMark\"] do={\r\
    \n     \r\
    \n    #grab variables for use below\r\
    \n    :local qIp [get \$y target]\r\
    \n    :set qComment [get \$y comment]\r\
    \n\r\
    \n    :local skip false;\r\
    \n  \r\
    \n    :if ( (\$qIp->0) != nil ) do={\r\
    \n      :set qIp (\$qIp->0) \r\
    \n      :set qIp ( [:pick \$qIp 0 [:find \$qIp \"/\" -1]] ) ;\r\
    \n    } else {\r\
    \n      :set skip true;\r\
    \n    }\r\
    \n         \r\
    \n    # Isolate information  from the comment field (MAC, Hostname)\r\
    \n    :local qMac [:pick \$qComment 4 21]\r\
    \n    :local qHost [:pick \$qComment 22 [:len \$qComment]]\r\
    \n\r\
    \n    # If MAC from lease matches the queue MAC and IPs are the same - then refresh the queue item\r\
    \n    :if (\$qMac = \$dhcpMac and \$qIp = \$dhcpIp and !\$skip) do={\r\
    \n\r\
    \n      # build a comment field\r\
    \n      :set qComment (\$qCommentMark . \",\" . \$dhcpMac . \",\" . \$dhcpHost)\r\
    \n\r\
    \n      set \$y target=\$dhcpIp comment=\$qComment\r\
    \n\r\
    \n      :if (\$dhcpComment != \"\") do= {\r\
    \n        set \$y name=(\$dhcpComment . \"@\" . \$dhcpServer . \" (\" . \$dhcpMac . \")\")\r\
    \n      } else= {\r\
    \n        :if (\$dhcpHost != \"\") do= {\r\
    \n          set \$y name=(\$dhcpHost . \"@\" . \$dhcpServer . \" (\" . \$dhcpMac . \")\")\r\
    \n        } else= {\r\
    \n          set \$y name=(\$dhcpMac . \"@\" . \$dhcpServer)\r\
    \n        }\r\
    \n      }\r\
    \n\r\
    \n      :local queuename [get \$y name]\r\
    \n\r\
    \n      :set state \"Queue \$queuename updated\"\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n\r\
    \n      :set leaseinqueue true\r\
    \n    } \r\
    \n  }\r\
    \n\r\
    \n  # There was not an existing entry so add one for this lease\r\
    \n  :if (\$leaseinqueue = false) do={\r\
    \n\r\
    \n    # build a comment field\r\
    \n    :set qComment (\$qCommentMark . \",\" . \$dhcpMac . \",\" . \$dhcpHost)\r\
    \n\r\
    \n    # build command (queue names should be unique)\r\
    \n    :local cmd \"/queue simple add target=\$dhcpIp comment=\$qComment\"\r\
    \n    :if (\$dhcpComment != \"\") do={ \r\
    \n      :set cmd \"\$cmd name=\\\"\$dhcpComment@\$dhcpServer (\$dhcpMac)\\\"\" \r\
    \n    } else= {\r\
    \n      :if (\$dhcpHost != \"\") do={\r\
    \n        :set cmd \"\$cmd name=\\\"\$dhcpHost@\$dhcpServer (\$dhcpMac)\\\"\"\r\
    \n      } else= {\r\
    \n        :set cmd \"\$cmd name=\\\"\$dhcpMac@\$dhcpServer\\\"\"\r\
    \n      }\r\
    \n    }\r\
    \n\r\
    \n    :execute \$cmd\r\
    \n\r\
    \n    :set state \"Queue \$qComment created\"\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n# Cleanup Routine - remove dynamic entries that no longer exist in the lease table\r\
    \n/queue simple\r\
    \n:foreach z in=[find where comment~\"\$qCommentMark\"] do={\r\
    \n\r\
    \n  :local qComment [get \$z comment]\r\
    \n  :local qMac [:pick \$qComment 4 21]\r\
    \n\r\
    \n  :local qIp [get \$z target]\r\
    \n  :local skip false\r\
    \n\r\
    \n  :if ( (\$qIp->0) != nil ) do={\r\
    \n    :set qIp (\$qIp->0) \r\
    \n    :set qIp ( [:pick \$qIp 0 [:find \$qIp \"/\" -1]] ) ;\r\
    \n  } else {\r\
    \n    :set skip true;\r\
    \n  }\r\
    \n\r\
    \n  :if (\$itsOk and !\$skip) do={\r\
    \n    :if ( [/ip dhcp-server lease find address=\$qIp and mac-address=\$qMac] = \"\") do={\r\
    \n      :set state \"Queue \$qComment dropped as stale\"\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      remove \$z\r\
    \n    }\r\
    \n  }    \r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: refreshed traffic accounting queues Succesfully\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n\r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n  \r\
    \n}\r\
    \n"
/system script add comment="Common backup script to ftp/email using both raw/plain formats. Can also be used to collect Git config history" dont-require-permissions=yes name=doBackup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\r\
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
    \n:local FTPServer \"nas.home\"\r\
    \n:local FTPPort 21\r\
    \n:local FTPUser \"git\"\r\
    \n:local FTPPass \"git\"\r\
    \n:local FTPRoot \"/REPO/backups/\"\r\
    \n:local FTPGitEnable true\r\
    \n:local FTPRawGitName \"/REPO/mikrobackups/rawconf_\$sysname_\$sysver.rsc\"\r\
    \n\r\
    \n:local SMTPEnable true\r\
    \n:local SMTPAddress \"defm.kopcap@gmail.com\"\r\
    \n:local SMTPSubject (\"\$sysname Full Backup (\$ds-\$ts)\")\r\
    \n:local SMTPBody (\"\$sysname full Backup file see in attachment.\\nRouterOS version: \$sysver\\nTime and Date stamp: (\$ds-\$ts) \")\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n\r\
    \n:local itsOk true;\r\
    \n\r\
    \n:do {\r\
    \n  :local smtpserv [:resolve \"\$FTPServer\"];\r\
    \n} on-error={ \r\
    \n  :set state \"FTP server looks like to be unreachable\"\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n  :set itsOk false;\r\
    \n}\r\
    \n\r\
    \n:local fname (\"BACKUP-\$sysname-\$ds-\$ts\")\r\
    \n\r\
    \n:if (\$saveSysBackup and \$itsOk) do={\r\
    \n  :if (\$encryptSysBackup = true) do={ /system backup save name=(\$fname.\".backup\") }\r\
    \n  :if (\$encryptSysBackup = false) do={ /system backup save dont-encrypt=yes name=(\$fname.\".backup\") }\r\
    \n  :delay 2s;\r\
    \n  \$globalNoteMe value=\"System Backup Finished\"\r\
    \n}\r\
    \n\r\
    \n:if (\$saveRawExport and \$itsOk) do={\r\
    \n  :if (\$FTPGitEnable ) do={\r\
    \n     #do not apply hide-sensitive flag\r\
    \n     :if (\$verboseRawExport = true) do={ /export terse verbose file=(\$fname.\".safe.rsc\") }\r\
    \n     :if (\$verboseRawExport = false) do={ /export terse file=(\$fname.\".safe.rsc\") }\r\
    \n     :delay 2s;\r\
    \n  }\r\
    \n  \$globalNoteMe value=\"Raw configuration script export Finished\"\r\
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
    \n        \$globalNoteMe value=\$state\r\
    \n        /tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\"\$FTPRoot\$buFile\" mode=ftp upload=yes\r\
    \n        \$globalNoteMe value=\"Done\"\r\
    \n        } on-error={ \r\
    \n          :set state \"Error When \$state\"\r\
    \n          \$globalNoteMe value=\$state;\r\
    \n          :set itsOk false;\r\
    \n       }\r\
    \n\r\
    \n        #special ftp upload for git purposes\r\
    \n        if (\$itsSRC and \$FTPGitEnable and \$itsOk) do={\r\
    \n            :do {\r\
    \n            :local state \"Uploading \$buFile to FTP (RAW, \$FTPRawGitName)\"\r\
    \n            \$globalNoteMe value=\$state\r\
    \n            /tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\"\$FTPRawGitName\" mode=ftp upload=yes\r\
    \n            \$globalNoteMe value=\"Done\"\r\
    \n            } on-error={ \r\
    \n              :set state \"Error When \$state\"\r\
    \n              \$globalNoteMe value=\$state;\r\
    \n              :set itsOk false;\r\
    \n           }\r\
    \n        }\r\
    \n\r\
    \n    }\r\
    \n    if (\$SMTPEnable and !\$itsSRC and \$itsOk) do={\r\
    \n        :do {\r\
    \n        :local state \"Uploading \$buFile to SMTP\"\r\
    \n        \$globalNoteMe value=\$state\r\
    \n\r\
    \n        #email works in background, delay needed\r\
    \n        /tool e-mail send to=\$SMTPAddress body=\$SMTPBody subject=\$SMTPSubject file=\$buFile\r\
    \n\r\
    \n        #waiting for email to be delivered\r\
    \n        :delay 15s;\r\
    \n\r\
    \n        :local emlResult ([/tool e-mail get last-status] = \"succeeded\")\r\
    \n\r\
    \n        if (!\$emlResult) do={\r\
    \n\r\
    \n          :set state \"Error When \$state\"\r\
    \n          \$globalNoteMe value=\$state;\r\
    \n          :set itsOk false;\r\
    \n\r\
    \n        } else={\r\
    \n\r\
    \n          \$globalNoteMe value=\"Done\"\r\
    \n       \r\
    \n        }\r\
    \n\r\
    \n        } on-error={ \r\
    \n          :set state \"Error When \$state\"\r\
    \n          \$globalNoteMe value=\$state;\r\
    \n          :set itsOk false;\r\
    \n       }\r\
    \n    }\r\
    \n\r\
    \n    :delay 2s;\r\
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
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n\r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n  \r\
    \n}"
/system script add comment="Periodically renews password for some user accounts and sends a email" dont-require-permissions=yes name=doRandomGen owner=owner policy=ftp,reboot,read,write,policy,test,password,sensitive source="\r\
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
/system script add comment="Dumps all the scripts from you device to *.rsc.txt files, loads to FTP (all scripts in this Repo made with it)" dont-require-permissions=yes name=doDumpTheScripts owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doDumpTheScripts\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n#directories have to exist!\r\
    \n:local FTPRoot \"/REPO/mikrobackups/\"\r\
    \n\r\
    \n#This subdir will be created locally to put exported scripts in\r\
    \n#and it must exist under \$FTPRoot to upload scripts to\r\
    \n:local SubDir \"scripts/\"\r\
    \n\r\
    \n:local FTPEnable true\r\
    \n:local FTPServer \"nas.home\"\r\
    \n:local FTPPort 21\r\
    \n:local FTPUser \"git\"\r\
    \n:local FTPPass \"git\"\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n:local state \"\";\r\
    \n:global globalScriptId;\r\
    \n\r\
    \n:do {\r\
    \n  :local smtpserv [:resolve \"\$FTPServer\"];\r\
    \n} on-error={\r\
    \n  :set state \"FTP server looks like to be unreachable\";\r\
    \n   \$globalNoteMe value=\$state;\r\
    \n  :set itsOk false;    \r\
    \n}\r\
    \n\r\
    \n:if (\$itsOk) do={\r\
    \n  :do {\r\
    \n    [/tool fetch dst-path=\"\$SubDir.FooFile\" url=\"http://127.0.0.1:80/mikrotik_logo.png\" keep-result=yes];\r\
    \n  } on-error={ \r\
    \n    :set state \"Error When Creating Local Scripts Directory\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    :set itsOk false;\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:foreach scriptId in [/system script find] do={\r\
    \n  :if (\$itsOk) do={\r\
    \n\r\
    \n    :local scriptSource [/system script get \$scriptId source];\r\
    \n    :local theScript [/system script get \$scriptId name];\r\
    \n    :local scriptSourceLength [:len \$scriptSource];\r\
    \n    :local path \"\$SubDir\$theScript.rsc.txt\";\r\
    \n\r\
    \n    :set \$globalScriptId \$scriptId;\r\
    \n\r\
    \n    :if (\$scriptSourceLength >= 4096) do={\r\
    \n      :set state \"Please keep care about '\$theScript' consistency - its size over 4096 bytes\";\r\
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
    \n      /execute script=\":global globalScriptId; :put [/system script get \$globalScriptId source];\" file=\$path;\r\
    \n      :set state \"Exported '\$theScript' to '\$path'\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n    } on-error={ \r\
    \n      :set state \"Error When Exporting '\$theScript' Script to '\$path'\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set itsOk false;\r\
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
    \n          :set state \"Uploading \$buFile' to '\$dst'\";\r\
    \n          \$globalNoteMe value=\$state;\r\
    \n          /tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\$dst mode=ftp upload=yes;\r\
    \n          \$globalNoteMe value=\"Done\";\r\
    \n        } on-error={ \r\
    \n          :set state \"Error When Uploading '\$buFile' to '\$dst'\";\r\
    \n          \$globalNoteMe value=\$state;\r\
    \n          :set itsOk false;\r\
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
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n\r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n  \r\
    \n}\r\
    \n"
/system script add comment="Updates chosen scripts from Git/master (sheduler entry with the same name have to exist)" dont-require-permissions=yes name=doFreshTheScripts owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doFreshTheScripts\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:local GitHubUserName \"Defm\";\r\
    \n:local GitHubRepoName \"mikrobackups\";\r\
    \n\r\
    \n#should be used for private repos\r\
    \n:local GitHubAccessToken \"\";\r\
    \n\r\
    \n:local RequestUrl \"https://\$GitHubAccessToken@raw.githubusercontent.com/\$GitHubUserName/\$GitHubRepoName/master/scripts/\";\r\
    \n\r\
    \n:local UseUpdateList true;\r\
    \n:local UpdateList [:toarray \"doBackup,doEnvironmentSetup,doEnvironmentClearance,doRandomGen,doFreshTheScripts,doCertificatesIssuing,doNetwatchHost, doIPSECPunch,doStartupScript,doHeatFlag,doPeriodicLogDump,doPeriodicLogParse,doTelegramNotify,doLEDoff,doLEDon,doCPUHighLoadReboot\"];\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n:local state \"\";\r\
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
    \n      :set state \"Script '\$theScript' skipped due to setup\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set skip true;\r\
    \n    }\r\
    \n  } else={\r\
    \n  }\r\
    \n\r\
    \n  :if ( \$itsOk and !\$skip) do={\r\
    \n    :do {\r\
    \n\r\
    \n      :set state \"/tool fetch url=\$RequestUrl\$\$theScript.rsc.txt output=user as-value\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n \r\
    \n      #Please keep care about consistency if size over 4096 bytes\r\
    \n      :local answer ([ /tool fetch url=\"\$RequestUrl\$\$theScript.rsc.txt\" output=user as-value]);\r\
    \n      :set code ( \$answer->\"data\" );\r\
    \n      \$globalNoteMe value=\"Done\";\r\
    \n\r\
    \n    } on-error= { \r\
    \n      :set state \"Error When Downloading Script '\$theScript' From GitHub\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set itsOk false;\r\
    \n    }\r\
    \n  }\r\
    \n\r\
    \n  :if ( \$itsOk and !\$skip) do={\r\
    \n    :do {\r\
    \n      :set state \"Setting Up Script source for '\$theScript'\";\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      /system script set \$theScript source=\"\$code\";\r\
    \n      \$globalNoteMe value=\"Done\";\r\
    \n    } on-error= { \r\
    \n      :set state \"Error When Setting Up Script source for '\$theScript'\";\r\
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
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n\r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n  \r\
    \n}"
/system script add comment="Uses INFLUX DB http/rest api to push some stats to" dont-require-permissions=yes name=doPushStatsToInfluxDB owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\r\
    \n:local scriptname \"doPushStatsToInfluxDB\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n#a part of queue comment to locate queues to be processed\r\
    \n:local queueCommentMark \"dtq\";\r\
    \n\r\
    \n#influxDB service URL (beware about port when /fetch)\r\
    \n:local tURL \"http://192.168.99.180/write\\\?db=mikroscripts\"\r\
    \n:local tPingURL \"http://192.168.99.180/ping\"\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n\r\
    \n:local state \"\";\r\
    \n\r\
    \n:do {\r\
    \n\r\
    \n  :set state (\"Checking if INFLUXDB Service online\");\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  :local result [/tool fetch http-method=get port=8000 user=\"mikrotik\" password=\"mikrotik\" mode=http url=\"\$tPingURL\"  as-value output=user];\r\
    \n \r\
    \n} on-error={\r\
    \n  \r\
    \n  :set state (\"INFLUXDB: Service Failed!\");\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  :local inf \"Error When \$scriptname on \$sysname: \$state\"  \r\
    \n\r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n\r\
    \n  :error \$inf;\r\
    \n}\r\
    \n \r\
    \n/queue simple\r\
    \n\r\
    \n:foreach z in=[find where comment~\"\$queueCommentMark\"] do={\r\
    \n\r\
    \n  :local skip false;\r\
    \n\r\
    \n  :local queuecomment [get \$z comment]\r\
    \n  :local ip [get \$z target]\r\
    \n\r\
    \n  :if ( \$itsOk ) do={\r\
    \n\r\
    \n    :if ( (\$ip->0) != nil ) do={\r\
    \n      :set state (\"Locating queue target IP for queue \$queuecomment\");\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set ip (\$ip->0) \r\
    \n      :set ip ( [:pick \$ip 0 [:find \$ip \"/\" -1]] ) ;\r\
    \n      \$globalNoteMe value=\"Done\";\r\
    \n    } else {\r\
    \n      :set state \"Cant locate queue target IP for queue \$queuecomment. Skip it.\"\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set skip true;\r\
    \n    }\r\
    \n\r\
    \n  }\r\
    \n\r\
    \n  :local hostName \"\"\r\
    \n  :local upload 0\r\
    \n  :local download 0\r\
    \n\r\
    \n  :if ( \$itsOk and !\$skip) do={\r\
    \n    :local bytes [get \$z bytes]\r\
    \n    :set upload (\$upload + [:pick \$bytes 0 [:find \$bytes \"/\"]])\r\
    \n    :set download (\$download + [:pick \$bytes ([:find \$bytes \"/\"]+1) [:len \$bytes]])\r\
    \n  }\r\
    \n\r\
    \n  :if ( \$itsOk and !\$skip) do={\r\
    \n    :do {\r\
    \n      #dhcp server for IP->name translation\r\
    \n      :set state (\"Picking host name for \$ip via DHCP\");\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set hostName [/ip dhcp-server lease get [find (address=\$ip)] host-name]\r\
    \n\r\
    \n      :local typeOfValue [:typeof \$hostName]\r\
    \n\r\
    \n      :if ((\$typeOfValue = \"nothing\") or (\$typeOfValue = \"nil\")) do={\r\
    \n        :set state \"Got empty host name. Skip it.\"\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :set skip true;\r\
    \n      } else={\r\
    \n        :set state \"Got it \$hostName\"\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n      }\r\
    \n\r\
    \n    } on-error= {\r\
    \n      :set state \"Error When \$state\"\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set skip true;\r\
    \n    }\r\
    \n  }\r\
    \n\r\
    \n  :if ( \$itsOk and !\$skip) do={\r\
    \n    :do {\r\
    \n      :set state (\"Pushing stats to influxDB about \$hostName: UP = \$upload, DOWN=\$download\");\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      /tool fetch http-method=post port=8000 user=\"mikrotik\" password=\"mikrotik\" mode=http url=\"\$tURL\" http-header-field=\"content-type: text/plain\" http-data=\"TrafficStats,host=\$sysname,target=\$hostName upload=\$upload,download=\$download\" keep-result=no;\r\
    \n      \$globalNoteMe value=\"Done\";\r\
    \n    } on-error= {\r\
    \n      :set state \"Error When \$state\"\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n      :set itsOk false;\r\
    \n    }\r\
    \n  }\r\
    \n  \r\
    \n  :if (\$itsOk and !\$skip) do={\r\
    \n    :set state \"Flushing stats..\"\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    reset-counters \$z\r\
    \n  }  \r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: stats pushed Succesfully\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: \$state\"  \r\
    \n  \r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n\r\
    \n}\r\
    \n"
/system script add comment="This will check for free CPU/RAM resources over \$ticks times to be more than \$CpuWarnLimit%/\$RamWarnLimit% each time. Will reboot the router when overload" dont-require-permissions=yes name=doCPUHighLoadReboot owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doCPUHighLoadReboot\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n:local state \"\";\r\
    \n  \r\
    \n:local UsedCPU [/system resource get cpu-load]\r\
    \n:local FreeCPU (100 - \$UsedCPU)\r\
    \n:local FreeRam ((100 * [/system resource get free-memory]) / [/system resource get total-memory])\r\
    \n:local UsedRam (100 - \$FreeRam)\r\
    \n\r\
    \n#available (free) resource (percent), set it to 90 for testing\r\
    \n:local RamWarnLimit 15;\r\
    \n:local CpuWarnLimit 15;\r\
    \n\r\
    \n:local ticks 7;\r\
    \n:local delayTime 7;\r\
    \n:local progressiveDelay true;\r\
    \n\r\
    \n:set state (\"Checking for free CPU/RAM resources over \$ticks times to be more than \$CpuWarnLimit%/\$RamWarnLimit% each time\");\r\
    \n\$globalNoteMe value=\$state;\r\
    \n\r\
    \n:set state (\"Step 0: free CPU/RAM \$FreeCPU%/\$FreeRam%, goind deeper..\");\r\
    \n\$globalNoteMe value=\$state;\r\
    \n\r\
    \n:if (\$FreeRam < \$RamWarnLimit or \$FreeCPU < \$CpuWarnLimit) do={\r\
    \n\r\
    \n  #this tick is high-HighLoad\r\
    \n  :set itsOk false;  \r\
    \n\r\
    \n  :delay (\$delayTime);\r\
    \n\r\
    \n} \r\
    \n\r\
    \n:for i from=1 to=\$ticks do={\r\
    \n\r\
    \n  :if (!\$itsOk) do={\r\
    \n\r\
    \n    :set UsedCPU [/system resource get cpu-load]\r\
    \n    :set FreeCPU (100 - \$UsedCPU)\r\
    \n    :set FreeRam ((100 * [/system resource get free-memory]) / [/system resource get total-memory])\r\
    \n    :set UsedRam (100 - \$FreeRam)\r\
    \n\r\
    \n    :set state (\"Recalc stats\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  }\r\
    \n\r\
    \n  :if (!\$itsOk and \$FreeRam < \$RamWarnLimit or \$FreeCPU < \$CpuWarnLimit) do={\r\
    \n\r\
    \n    #keep \$itsOk = false\r\
    \n\r\
    \n    :local delaySec 0;\r\
    \n    :if (\$progressiveDelay) do={\r\
    \n      :set delaySec (\$delayTime + \$i)\r\
    \n    } else={\r\
    \n      :set delaySec (\$delayTime)\r\
    \n    }\r\
    \n\r\
    \n    :set state (\"Step \$i: free CPU/RAM \$FreeCPU%/\$FreeRam%, its too low, sleep \$delaySec and recheck..\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    :delay (\$delaySec);\r\
    \n\r\
    \n  } else={\r\
    \n\r\
    \n    #if one step is non-HighLoad, then the whole result is non-HighLoad\r\
    \n    :set itsOk true;\r\
    \n\r\
    \n  }\r\
    \n\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: cpu load ok\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n  :set inf \"Warn When \$scriptname on \$sysname: CPU load too high, I'm going reboot\"  \r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n\r\
    \n  :global globalTgMessage;\r\
    \n  \$globalTgMessage value=\$inf;\r\
    \n\r\
    \n  /system reboot\r\
    \n  \r\
    \n}\r\
    \n\r\
    \n"
/system script add comment="A very special script for CFG restore from *.rsc files (not from backup). This one should be placed at flash/perfectrestore.rsc, your config should be at flash/backup.rsc. Run 'Reset confuguration' with 'no default config', choose 'flash/perfectrestore.rsc' as 'run after reset. Pretty logs will be at flash/import.log and flash/perfectrestore.log" dont-require-permissions=yes name=doPerfectRestore owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n\r\
    \n{\r\
    \n\r\
    \n:global targetfile \"flash/backup.rsc\"\r\
    \n:global importlog \"flash/import.log\"\r\
    \n:global debuglog \"flash/perfectrestore.log\"\r\
    \n\r\
    \n/file remove [find name ~\"\$importlog\"]\r\
    \n/file remove [find name ~\"\$debuglog\"]\r\
    \n\r\
    \n# Wait for interfaces to initialize\r\
    \n:delay 15s\r\
    \n\r\
    \n# Beep Functions\r\
    \n :local doStartBeep [:parse \":beep frequency=1000 length=300ms;:delay 150ms;:beep frequency=1500 length=300ms;\"];\r\
    \n :local doFinishBeep [:parse \":beep frequency=1000 length=.6;:delay .5s;:beep frequency=1600 length=.6;:delay .5s;:beep frequency=2100 length=.3;:delay .3s;:beep frequency=2500 length=.3;:delay .3s;:beep frequency=2400 length=1;\r\
    \n\"];\r\
    \n\r\
    \n# Setup temporary logging to disk\r\
    \n/system logging action add disk-file-count=1 disk-file-name=\$debuglog disk-lines-per-file=4096 name=perfectrestore target=disk\r\
    \n/system logging add action=perfectrestore topics=system,info\r\
    \n/system logging add action=perfectrestore topics=script,info\r\
    \n/system logging add action=perfectrestore topics=warning\r\
    \n/system logging add action=perfectrestore topics=error\r\
    \n/system logging add action=perfectrestore topics=critical\r\
    \n/system logging add action=perfectrestore topics=debug,!packet\r\
    \n\r\
    \n# Play Audible Start Sequence\r\
    \n\$doStartBeep\r\
    \n\r\
    \n# Import the rsc file\r\
    \n:log info \"BEGIN IMPORT file=\$targetfile -----------------------------------------------------------------------------\"\r\
    \n\r\
    \n:do {\r\
    \n\r\
    \n  #IPSEC certs have to be imported before the other config is restored\r\
    \n  #Its should be kept on flash memory to get alive after /system reset-configuration\r\
    \n\r\
    \n  /certificate import file-name=flash/ca@CHR.p12 passphrase=1234567890\r\
    \n  /certificate set [find common-name=ca@CHR] name=ca@CHR\r\
    \n  /certificate import file-name=flash/mikrouter@CHR.p12 passphrase=1234567890\r\
    \n  /certificate set [find common-name=mikrouter@CHR] name=mikrouter@CHR\r\
    \n\r\
    \n  :local write2file \":import file-name=\$targetfile verbose=yes\"\r\
    \n\r\
    \n  :execute script=\$write2file file=\$importlog\r\
    \n\r\
    \n  :log info \"END IMPORT file=\$targetfile  -----------------------------------------------------------------------------\"\r\
    \n\r\
    \n} on-error={\r\
    \n\r\
    \n:log error \"ERROR IMPORT file=\$targetfile  -----------------------------------------------------------------------------\"\r\
    \n\r\
    \n}\r\
    \n\r\
    \n# Post import delay\r\
    \n:delay 20s\r\
    \n\r\
    \n# Play Audible Finish Sequence\r\
    \n\$doFinishBeep\r\
    \n\r\
    \n# Teardown temporary logging to disk\r\
    \n/system logging remove [/system logging find where action=perfectrestore]\r\
    \n/system logging action remove [/system logging action find where name=perfectrestore]\r\
    \n\r\
    \n/system script environment remove [find name=\"targetfile\"]\r\
    \n/system script environment remove [find name=\"importlog\"]\r\
    \n/system script environment remove [find name=\"debuglog\"]\r\
    \n\r\
    \n#new startup scripts maybe restored so...\r\
    \n/system reboot\r\
    \n\r\
    \n}\r\
    \n"
/tool bandwidth-server set enabled=no
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com password=zgejdmvndvorrmsn port=587 start-tls=yes user=defm.kopcap@gmail.com
/tool mac-server set allowed-interface-list=none
/tool mac-server mac-winbox set allowed-interface-list=list-winbox-allowed
/tool netwatch add comment="miniAlx status check" down-script="\r\
    \n:put \"info: Netwatch UP\"\r\
    \n:log info \"Netwatch UP\"\r\
    \n\r\
    \n:global NetwatchHostName \"miniAlx\";\r\
    \n/system script run doNetwatchHost;" host=192.168.99.180 up-script="\r\
    \n:put \"info: Netwatch UP\"\r\
    \n:log info \"Netwatch UP\"\r\
    \n\r\
    \n:global NetwatchHostName \"miniAlx\";\r\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-interface=tunnel filter-operator-between-entries=and streaming-enabled=yes streaming-server=192.168.99.170
