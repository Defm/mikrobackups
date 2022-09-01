# sep/01/2022 09:35:07 by RouterOS 6.49.6
# software id = R98Z-YE17
#
# model = RB4011iGS+
# serial number = D4440C1FE42A
/caps-man channel add band=2ghz-b/g/n control-channel-width=20mhz extension-channel=disabled frequency=2412 name=common-chnls-2Ghz reselect-interval=10h skip-dfs-channels=yes tx-power=17
/caps-man channel add band=5ghz-a/n/ac comment="20Mhz + Ce = 40Mhz, reselect interval from 5180, 5220, 5745, 5785 once per 10h" control-channel-width=20mhz extension-channel=Ce frequency=5180,5220,5745,5785 name=common-chnls-5Ghz reselect-interval=10h tx-power=15
/caps-man configuration add mode=ap name=empty
/interface bridge add arp=proxy-arp name=guest-infrastructure-br
/interface bridge add arp=proxy-arp fast-forward=no name=ip-mapping-br
/interface bridge add admin-mac=48:8F:5A:D4:5F:69 arp=reply-only auto-mac=no name=main-infrastructure-br
/interface bridge add arp=proxy-arp fast-forward=no name=ospf-loopback-br
/interface ethernet set [ find default-name=ether2 ] name="lan A"
/interface ethernet set [ find default-name=ether3 ] name="lan B"
/interface ethernet set [ find default-name=ether4 ] name="lan C"
/interface ethernet set [ find default-name=ether5 ] name="lan D"
/interface ethernet set [ find default-name=ether6 ] disabled=yes name="lan E"
/interface ethernet set [ find default-name=ether7 ] disabled=yes name="lan F"
/interface ethernet set [ find default-name=ether8 ] disabled=yes name="lan G"
/interface ethernet set [ find default-name=ether9 ] disabled=yes name="lan H"
/interface ethernet set [ find default-name=ether10 ] name="lan I" poe-out=forced-on
/interface ethernet set [ find default-name=sfp-sfpplus1 ] disabled=yes name=optic
/interface ethernet set [ find default-name=ether1 ] arp=proxy-arp name="wan A"
/caps-man datapath add arp=proxy-arp bridge=guest-infrastructure-br name=2CapsMan-guest
/caps-man datapath add arp=reply-only bridge=main-infrastructure-br client-to-client-forwarding=yes name=2CapsMan-private
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps name="5GHz Rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps vht-basic-mcs=mcs0-9 vht-supported-mcs=mcs0-9
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps ht-basic-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 ht-supported-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 name="2GHz rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps
/caps-man security add authentication-types=wpa2-psk comment="2GHz/5GHz Security" encryption=aes-ccm group-encryption=aes-ccm group-key-update=1h name=private passphrase=mikrotik
/caps-man security add authentication-types="" comment="2GHz/5GHz FREE" encryption="" group-key-update=5m name=guest
/interface ethernet switch port set 0 default-vlan-id=0
/interface ethernet switch port set 1 default-vlan-id=0
/interface ethernet switch port set 2 default-vlan-id=0
/interface ethernet switch port set 3 default-vlan-id=0
/interface ethernet switch port set 4 default-vlan-id=0
/interface ethernet switch port set 5 default-vlan-id=0
/interface ethernet switch port set 6 default-vlan-id=0
/interface ethernet switch port set 7 default-vlan-id=0
/interface ethernet switch port set 8 default-vlan-id=0
/interface ethernet switch port set 9 default-vlan-id=0
/interface ethernet switch port set 10 default-vlan-id=0
/interface ethernet switch port set 11 default-vlan-id=0
/interface list add comment="Trusted networks" name=list-trusted
/interface list add comment="Semi-Trusted networks" name=list-semi-trusted
/interface list add comment="Untrusted networks" name=list-untrusted
/interface list add comment="winbox allowed interfaces" name=list-winbox-allowed
/interface list add comment="includes l2tp client interfaces when UP" name=list-l2tp-tunnels
/interface list add comment="firewall rule: drop invalid conn" name=list-drop-invalid-connections
/interface list add comment="LAN intefaces" name=list-autodetect-LAN
/interface list add comment="WAN interfaces" name=list-autodetect-WAN
/interface list add comment="Internet interfaces" name=list-autodetect-INTERNET
/interface list add comment="Controlled access points (2ghz)" name=list-2ghz-caps-private
/interface list add comment="Controlled access points (public)" name=list-2ghz-caps-guest
/interface list add comment="Controlled access points (5ghz)" name=list-5ghz-caps-private
/interface list add comment="Guest Wireless" include=list-2ghz-caps-guest name=list-guest-wireless
/interface list add comment="neighbors allowed interfaces" include=list-2ghz-caps-private,list-5ghz-caps-private name=list-neighbors-lookup
/interface list add comment="Private Wireless" include=list-2ghz-caps-private,list-5ghz-caps-private name=list-private-wireless
/caps-man configuration add channel=common-chnls-2Ghz country=russia datapath=2CapsMan-private datapath.interface-list=list-2ghz-caps-private distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-2Ghz-private rx-chains=0,1,2,3 security=private ssid="WiFi 2Ghz PRIVATE" tx-chains=0,1,2,3
/caps-man configuration add channel=common-chnls-5Ghz country=russia datapath=2CapsMan-private datapath.interface-list=list-5ghz-caps-private disconnect-timeout=9s distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-5Ghz-private rx-chains=0,1,2,3 security=private ssid="WiFi 5Ghz PRIVATE" tx-chains=0,1,2,3
/caps-man configuration add channel=common-chnls-2Ghz country=russia datapath=2CapsMan-guest datapath.interface-list=list-2ghz-caps-guest distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-2Ghz-guest rx-chains=0,1,2,3 security=guest ssid="WiFi 2Ghz FREE" tx-chains=0,1,2,3
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=anna
/interface wireless security-profiles add authentication-types=wpa2-psk eap-methods="" group-key-update=1h management-protection=allowed mode=dynamic-keys name=private supplicant-identity="" wpa-pre-shared-key=mikrotik wpa2-pre-shared-key=mikrotik
/interface wireless security-profiles add authentication-types=wpa-psk,wpa2-psk eap-methods="" management-protection=allowed name=public supplicant-identity=""
/ip dhcp-server add authoritative=after-2sec-delay disabled=no interface=main-infrastructure-br lease-time=1d name=main-dhcp-server
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
/ip ipsec mode-config set [ find default=yes ] src-address-list=alist-mangle-vpn-tunneled-sites
/ip ipsec policy group add name=inside-ipsec-encryption
/ip ipsec policy group add name=outside-ipsec-encryption
/ip ipsec profile set [ find default=yes ] dh-group=modp1024
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=ROUTEROS
/ip ipsec peer add address=185.13.148.14/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, outer-tunnel encryption, RSA)" exchange-mode=ike2 local-address=192.168.100.7 name=CHR-external profile=ROUTEROS
/ip ipsec peer add address=10.0.0.1/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, traffic-only encryption)" local-address=10.0.0.3 name=CHR-internal profile=ROUTEROS
/ip ipsec proposal set [ find default=yes ] enc-algorithms=aes-256-cbc,aes-192-cbc,aes-128-cbc,3des lifetime=1h
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip pool add name=pool-main ranges=192.168.90.100-192.168.90.200
/ip pool add name=pool-guest ranges=192.168.98.200-192.168.98.230
/ip pool add name=pool-virtual-machines ranges=192.168.90.0/26
/ip pool add name=pool-vendor ranges=192.168.90.2-192.168.90.10
/ip dhcp-server add add-arp=yes address-pool=pool-guest authoritative=after-2sec-delay disabled=no interface=guest-infrastructure-br lease-script="\r\
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
    \n/system script run doDHCPLeaseTrack;" lease-time=3h name=guest-dhcp-server
/ppp profile add address-list=alist-l2tp-active-clients interface-list=list-l2tp-tunnels local-address=10.0.0.3 name=l2tp-no-encrypt-site2site only-one=no remote-address=10.0.0.1
/interface l2tp-client add allow=mschap2 connect-to=185.13.148.14 disabled=no ipsec-secret=123 max-mru=1418 max-mtu=1418 name=tunnel profile=l2tp-no-encrypt-site2site user=vpn-remote-anna
/queue simple add comment=dtq,54:2B:8D:77:38:A0, name="iPhoneAlxr(blocked)@guest-dhcp-server (54:2B:8D:77:38:A0)" queue=default/default target=192.168.98.223/32 total-queue=default
/queue simple add comment=dtq,54:2B:8D:77:38:A0,iPhoneAlxr name="iPhoneAlxr@main-dhcp-server (54:2B:8D:77:38:A0)" queue=default/default target=192.168.90.150/32 total-queue=default
/queue simple add comment=dtq,50:DE:06:25:C2:FC,iPadProAlx name="iPadAlxPro@main-dhcp-server (50:DE:06:25:C2:FC)" queue=default/default target=192.168.90.130/32 total-queue=default
/queue simple add comment=dtq,50:DE:06:25:C2:FC, name="iPadAlxPro(blocked)@guest-dhcp-server (50:DE:06:25:C2:FC)" queue=default/default target=192.168.98.229/32 total-queue=default
/queue simple add comment=dtq,B0:34:95:50:A1:6A, name="AudioATV(blocked)@guest-dhcp-server (B0:34:95:50:A1:6A)" queue=default/default target=192.168.98.231/32 total-queue=default
/queue simple add comment=dtq,90:DD:5D:C8:46:AB,AlxATV name="AlxATV (wireless)@main-dhcp-server (90:DD:5D:C8:46:AB)" queue=default/default target=192.168.90.200/32 total-queue=default
/queue simple add comment=dtq,B0:34:95:50:A1:6A,AudioATV name="AudioATV (wireless)@main-dhcp-server (B0:34:95:50:A1:6A)" queue=default/default target=192.168.90.210/32 total-queue=default
/queue simple add comment=dtq,CC:2D:E0:E7:BE:02,LivingRoomWAP name="LivingRoomWap@main-dhcp-server (CC:2D:E0:E7:BE:02)" queue=default/default target=192.168.90.10/32 total-queue=default
/queue simple add comment=dtq,10:DD:B1:9E:19:5E,miniAlx name="miniAlx (wire)@main-dhcp-server (10:DD:B1:9E:19:5E)" queue=default/default target=192.168.90.70/32 total-queue=default
/queue simple add comment=dtq,78:31:C1:CF:9E:70,MbpAlx name="MbpAlx (wireless)@main-dhcp-server (78:31:C1:CF:9E:70)" queue=default/default target=192.168.90.80/32 total-queue=default
/queue simple add comment=dtq,38:C9:86:51:D2:B3,MbpAlx name="MbpAlx (wire)@main-dhcp-server (38:C9:86:51:D2:B3)" queue=default/default target=192.168.90.90/32 total-queue=default
/queue simple add comment=dtq,00:11:32:2C:A7:85,nas name="NAS@main-dhcp-server (00:11:32:2C:A7:85)" queue=default/default target=192.168.90.40/32 total-queue=default
/queue simple add comment=dtq,FC:F5:C4:79:ED:D8,Twinkly_79EDD9 name="Twinkle@main-dhcp-server (FC:F5:C4:79:ED:D8)" queue=default/default target=192.168.90.170/32 total-queue=default
/queue simple add comment=dtq,FC:F5:C4:79:ED:D8, name="Twinkle(blocked)@guest-dhcp-server (FC:F5:C4:79:ED:D8)" queue=default/default target=192.168.98.170/32 total-queue=default
/queue simple add comment=dtq,54:35:30:05:9B:BD,ASUS name="ASUS(wireless)@main-dhcp-server (54:35:30:05:9B:BD)" queue=default/default target=192.168.90.88/32 total-queue=default
/queue simple add comment=dtq,54:35:30:05:9B:BD, name="ASUS(wireless)(blocked)@guest-dhcp-server (54:35:30:05:9B:BD)" queue=default/default target=192.168.98.88/32 total-queue=default
/queue simple add comment=dtq,00:27:15:CE:B8:DD,android-95914276d1da81b5 name="android(wireless)@main-dhcp-server (00:27:15:CE:B8:DD)" queue=default/default target=192.168.90.140/32 total-queue=default
/queue simple add comment=dtq,00:27:15:CE:B8:DD, name="android(wireless)(blocked)@guest-dhcp-server (00:27:15:CE:B8:DD)" queue=default/default target=192.168.98.140/32 total-queue=default
/queue simple add comment=dtq,BC:D0:74:0A:B2:6A,MbpAlxm name="MbpAlxm (wireless)@main-dhcp-server (BC:D0:74:0A:B2:6A)" queue=default/default target=192.168.90.75/32 total-queue=default
/queue simple add comment=dtq,BC:D0:74:0A:B2:6A, name="MbpAlxm(blocked)@guest-dhcp-server (BC:D0:74:0A:B2:6A)" queue=default/default target=192.168.98.75/32 total-queue=default
/queue simple add comment=dtq,48:65:EE:19:3C:0D,MbpAlxm name="MbpAlxm (wire)@main-dhcp-server (48:65:EE:19:3C:0D)" queue=default/default target=192.168.90.85/32 total-queue=default
/queue simple add comment=dtq,48:65:EE:19:3C:0D, name="MbpAlxm(blocked)@guest-dhcp-server (48:65:EE:19:3C:0D)" queue=default/default target=192.168.98.85/32 total-queue=default
/queue tree add comment="FILE download control" name="Total Bandwidth" parent=global queue=default
/queue tree add name=RAR packet-mark=rar-mark parent="Total Bandwidth" queue=default
/queue tree add name=EXE packet-mark=exe-mark parent="Total Bandwidth" queue=default
/queue tree add name=7Z packet-mark=7z-mark parent="Total Bandwidth" queue=default
/queue tree add name=ZIP packet-mark=zip-mark parent="Total Bandwidth" queue=default
/routing ospf area add area-id=0.0.0.1 default-cost=1 inject-summary-lsas=no name=local type=stub
/routing ospf instance set [ find default=yes ] name=routes-provider-mic router-id=10.255.255.2
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action set 1 disk-file-name=flash/log
/system logging action add name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=1 disk-file-name=ScriptsDiskLog disk-lines-per-file=10000 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=20 disk-file-name=ErrorDiskLog disk-lines-per-file=30000 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add memory-lines=500 name=OnScreenLog target=memory
/system logging action add name=DHCPOnScreenLog target=memory
/system logging action add name=DNSOnScreenLog target=memory
/system logging action add name=RouterControlLog target=memory
/system logging action add name=OSPFOnscreenLog target=memory
/system logging action add name=L2TPOnScreenLog target=memory
/system logging action add disk-file-count=20 disk-file-name=AuthDiskLog disk-lines-per-file=30000 name=AuthDiskLog target=disk
/system logging action add memory-lines=10000 name=CertificatesOnScreenLog target=memory
/system logging action add memory-lines=6000 name=ParseMemoryLog target=memory
/system logging action add name=CAPSOnScreenLog target=memory
/system logging action add name=FirewallOnScreenLog target=memory
/system logging action add name=SSHOnScreenLog target=memory
/system logging action add name=PoEOnscreenLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!write,!policy,!sensitive,!dude
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!policy,!sensitive,!dude
/user group set full policy=local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,password,web,sniff,sensitive,api,romon,dude,tikapp
/user group add name=remote policy=ssh,read,write,!local,!telnet,!ftp,!reboot,!policy,!test,!winbox,!password,!web,!sniff,!sensitive,!api,!romon,!dude,!tikapp
/caps-man access-list add action=reject allow-signal-out-of-range=10s comment="Drop any when poor signal rate, https://support.apple.com/en-us/HT203068" disabled=no signal-range=-120..-70 ssid-regexp=WiFi
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=MbpAlxm disabled=no mac-address=48:65:EE:19:3C:0D ssid-regexp=""
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=MbpAlxm disabled=no mac-address=BC:D0:74:0A:B2:6A ssid-regexp=""
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="android(wireless)" disabled=no mac-address=00:27:15:CE:B8:DD ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="ASUS(wireless)" disabled=no mac-address=54:35:30:05:9B:BD ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=Twinkle disabled=no mac-address=FC:F5:C4:79:ED:D8 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=AudioATV disabled=no mac-address=B0:34:95:50:A1:6A ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=iPadAlxPro disabled=no mac-address=50:DE:06:25:C2:FC ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=mbpAlx disabled=no mac-address=78:31:C1:CF:9E:70 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=AlxATV disabled=no mac-address=90:DD:5D:C8:46:AB ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=iPhoneAlxr disabled=no mac-address=54:2B:8D:77:38:A0 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s comment="Allow any other on guest wireless" disabled=no ssid-regexp=FREE
/caps-man access-list add action=reject allow-signal-out-of-range=10s comment="Drop any other on private wireless" disabled=no ssid-regexp=PRIVATE
/caps-man manager set ca-certificate=ca@CHR certificate=anna.capsman.2021@CHR enabled=yes require-peer-certificate=yes
/caps-man manager interface set [ find default=yes ] comment="Deny CapsMan on All"
/caps-man manager interface add comment="Deny WAN CapsMan" disabled=no forbid=yes interface="wan A"
/caps-man manager interface add comment="Do CapsMan on private" disabled=no interface=main-infrastructure-br
/caps-man manager interface add comment="Do CapsMan on guest" disabled=no interface=guest-infrastructure-br
/caps-man provisioning add action=create-dynamic-enabled comment="2Ghz private/guest" hw-supported-modes=gn identity-regexp=WAP master-configuration=zone-2Ghz-private name-format=prefix-identity name-prefix=2Ghz slave-configurations=zone-2Ghz-guest
/caps-man provisioning add action=create-dynamic-enabled comment="5Ghz private" hw-supported-modes=ac identity-regexp=WAP master-configuration=zone-5Ghz-private name-format=prefix-identity name-prefix=5Ghz
/caps-man provisioning add action=create-dynamic-enabled comment="2Ghz private/guest (self-cap)" hw-supported-modes=gn identity-regexp=anna master-configuration=zone-2Ghz-private name-format=prefix-identity name-prefix=2Ghz slave-configurations=zone-2Ghz-guest
/caps-man provisioning add action=create-dynamic-enabled comment="5Ghz private (self-cap)" hw-supported-modes=ac identity-regexp=anna master-configuration=zone-5Ghz-private name-format=prefix-identity name-prefix=5Ghz
/caps-man provisioning add comment=DUMMY master-configuration=empty name-format=prefix-identity name-prefix=dummy
/interface bridge port add bridge=main-infrastructure-br interface="lan D"
/interface bridge port add bridge=main-infrastructure-br interface="lan A"
/interface bridge port add bridge=main-infrastructure-br interface="lan B"
/interface bridge port add bridge=main-infrastructure-br interface="lan C"
/interface bridge port add bridge=main-infrastructure-br interface="lan I"
/interface bridge settings set allow-fast-path=no
/ip firewall connection tracking set enabled=yes
/ip neighbor discovery-settings set discover-interface-list=list-neighbors-lookup
/ip settings set accept-source-route=yes allow-fast-path=no rp-filter=loose tcp-syncookies=yes
/interface detect-internet set detect-interface-list=all internet-interface-list=list-autodetect-INTERNET lan-interface-list=list-autodetect-LAN wan-interface-list=list-autodetect-WAN
/interface list member add comment="MGTS, GPON via Huavei" interface="wan A" list=list-untrusted
/interface list member add comment="GUEST WLAN" interface=guest-infrastructure-br list=list-guest-wireless
/interface list member add comment="LAN, WLAN" interface=main-infrastructure-br list=list-trusted
/interface list member add comment="neighbors lookup" interface=main-infrastructure-br list=list-neighbors-lookup
/interface list member add comment="FW: winbox allowed" interface=main-infrastructure-br list=list-winbox-allowed
/interface list member add comment="neighbors lookup" interface=tunnel list=list-neighbors-lookup
/interface list member add comment="FW: drop invalid" interface="wan A" list=list-drop-invalid-connections
/interface wireless snooper set receive-errors=yes
/ip accounting set enabled=yes threshold=1600
/ip accounting web-access set accessible-via-web=yes
/ip address add address=192.168.90.1/24 comment="local ip" interface=main-infrastructure-br network=192.168.90.0
/ip address add address=192.168.98.1/24 comment="local guest wifi" interface=guest-infrastructure-br network=192.168.98.0
/ip address add address=10.255.255.2 comment="ospf router-id binding" interface=ospf-loopback-br network=10.255.255.2
/ip address add address=172.16.0.16/30 comment="GRAFANA IP redirect" interface=ip-mapping-br network=172.16.0.16
/ip address add address=172.16.0.17/30 comment="INFLUXDB IP redirect" interface=ip-mapping-br network=172.16.0.16
/ip address add address=192.168.100.7/24 comment="wan via ACADO edge router" interface="wan A" network=192.168.100.0
/ip arp add address=192.168.90.80 comment="MbpAlx (wireless)" interface=main-infrastructure-br mac-address=78:31:C1:CF:9E:70
/ip arp add address=192.168.90.200 comment="AlxATV (wireless)" interface=main-infrastructure-br mac-address=90:DD:5D:C8:46:AB
/ip arp add address=192.168.90.90 comment="MbpAlx (wire)" interface=main-infrastructure-br mac-address=38:C9:86:51:D2:B3
/ip arp add address=192.168.90.40 comment=NAS interface=main-infrastructure-br mac-address=00:11:32:2C:A7:85
/ip arp add address=192.168.90.150 comment=iPhoneAlxr interface=main-infrastructure-br mac-address=54:2B:8D:77:38:A0
/ip arp add address=192.168.90.130 comment=iPadAlxPro interface=main-infrastructure-br mac-address=50:DE:06:25:C2:FC
/ip arp add address=192.168.100.7 interface="wan A" mac-address=48:8F:5A:D4:5F:68
/ip arp add address=192.168.90.10 comment=LiwingRoomWAP interface=main-infrastructure-br mac-address=CC:2D:E0:E7:BE:02
/ip arp add address=192.168.90.70 comment="miniAlx (wire)" interface=main-infrastructure-br mac-address=10:DD:B1:9E:19:5E
/ip arp add address=192.168.90.210 comment=AudioATV interface=main-infrastructure-br mac-address=B0:34:95:50:A1:6A
/ip arp add address=192.168.90.170 comment=Twinkle interface=main-infrastructure-br mac-address=FC:F5:C4:79:ED:D8
/ip arp add address=192.168.90.88 comment="ASUS(wireless)" interface=main-infrastructure-br mac-address=54:35:30:05:9B:BD
/ip arp add address=192.168.90.140 comment="android(wireless)" interface=main-infrastructure-br mac-address=00:27:15:CE:B8:DD
/ip arp add address=192.168.90.75 comment=MbpAlxm interface=main-infrastructure-br mac-address=BC:D0:74:0A:B2:6A
/ip arp add address=192.168.90.85 comment=MbpAlxm interface=main-infrastructure-br mac-address=48:65:EE:19:3C:0D
/ip cloud set ddns-enabled=yes ddns-update-interval=10m
/ip dhcp-client add add-default-route=no !dhcp-options interface="wan A" use-peer-ntp=no
/ip dhcp-server lease add address=192.168.90.200 comment="AlxATV (wireless)" mac-address=90:DD:5D:C8:46:AB server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.80 address-lists=alist-osx-hosts client-id=1:78:31:c1:cf:9e:70 comment="MbpAlx (wireless)" mac-address=78:31:C1:CF:9E:70 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.90 address-lists=alist-osx-hosts comment="MbpAlx (wire)" mac-address=38:C9:86:51:D2:B3 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.223 block-access=yes client-id=1:54:2b:8d:77:38:a0 comment="iPhoneAlxr(blocked)" mac-address=54:2B:8D:77:38:A0 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.40 comment=NAS mac-address=00:11:32:2C:A7:85 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.150 client-id=1:54:2b:8d:77:38:a0 comment=iPhoneAlxr mac-address=54:2B:8D:77:38:A0 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.130 comment=iPadAlxPro mac-address=50:DE:06:25:C2:FC server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.229 block-access=yes comment="iPadAlxPro(blocked)" mac-address=50:DE:06:25:C2:FC server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.210 comment="AudioATV (wireless)" mac-address=B0:34:95:50:A1:6A server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.231 block-access=yes comment="AudioATV(blocked)" mac-address=B0:34:95:50:A1:6A server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.10 client-id=1:cc:2d:e0:e7:be:2 comment=LivingRoomWap mac-address=CC:2D:E0:E7:BE:02 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.70 address-lists=alist-osx-hosts client-id=1:10:dd:b1:9e:19:5e comment="miniAlx (wire)" mac-address=10:DD:B1:9E:19:5E server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.170 comment=Twinkle mac-address=FC:F5:C4:79:ED:D8 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.170 block-access=yes comment="Twinkle(blocked)" mac-address=FC:F5:C4:79:ED:D8 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.88 comment="ASUS(wireless)" mac-address=54:35:30:05:9B:BD server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.88 block-access=yes comment="ASUS(wireless)(blocked)" mac-address=54:35:30:05:9B:BD server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.140 comment="android(wireless)" mac-address=00:27:15:CE:B8:DD server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.140 block-access=yes comment="android(wireless)(blocked)" mac-address=00:27:15:CE:B8:DD server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.75 comment="MbpAlxm (wireless)" mac-address=BC:D0:74:0A:B2:6A server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.75 block-access=yes comment="MbpAlxm(blocked)" mac-address=BC:D0:74:0A:B2:6A server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.85 comment="MbpAlxm (wire)" mac-address=48:65:EE:19:3C:0D server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.85 block-access=yes comment="MbpAlxm(blocked)" mac-address=48:65:EE:19:3C:0D server=guest-dhcp-server
/ip dhcp-server network add address=192.168.90.0/27 caps-manager=192.168.90.1 comment="Network devices, CCTV" dhcp-option=DomainName dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.32/27 caps-manager=192.168.90.1 comment="Virtual machines" dhcp-option=DomainName dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.64/26 caps-manager=192.168.90.1 comment="Mac, Pc" dhcp-option=DomainName dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.128/27 caps-manager=192.168.90.1 comment="Phones, tablets" dhcp-option=DomainName dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.160/27 caps-manager=192.168.90.1 comment="IoT, intercom" dhcp-option=DomainName dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.192/27 caps-manager=192.168.90.1 comment="TV, projector, boxes" dns-server=8.8.8.8 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.224/27 caps-manager=192.168.90.1 comment="Reserved, special" dhcp-option=DomainName dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.98.0/24 comment="Guest DHCP leasing (Yandex protected DNS)" dns-server=77.88.8.7 gateway=192.168.98.1 ntp-server=192.168.98.1
/ip dhcp-server vendor-class-id add address-pool=pool-vendor name=vendor-mikrotik-caps server=main-dhcp-server vid=mikrotik-cap
/ip dns set allow-remote-requests=yes cache-max-ttl=1d query-server-timeout=3s use-doh-server=https://1.1.1.1/dns-query verify-doh-cert=yes
/ip dns static add address=192.168.90.1 name=anna.home
/ip dns static add cname=anna.home name=anna type=CNAME
/ip dns static add address=192.168.90.1 name=time.windows.com
/ip dns static add cname=influxdb.home name=influxdb type=CNAME
/ip dns static add address=172.16.0.17 name=influxdb.home
/ip dns static add cname=minialx.home name=influxdbsvc.home type=CNAME
/ip dns static add cname=grafana.home name=grafana type=CNAME
/ip dns static add address=172.16.0.16 name=grafana.home
/ip dns static add cname=minialx.home name=grafanasvc.home type=CNAME
/ip dns static add address=192.168.97.1 name=chr.home
/ip dns static add address=192.168.99.1 name=mikrouter.home
/ip dns static add cname=chr.home name=chr type=CNAME
/ip dns static add address=192.168.100.1 name=gateway.home
/ip dns static add address=192.168.90.10 name=LivingRoomWAP.home
/ip dns static add cname=LivingRoomWAP.home name=LivingRoomWAP type=CNAME
/ip dns static add address=192.168.90.90 comment=<AUTO:DHCP:main-dhcp-server> name=MbpAlx.home ttl=5m
/ip dns static add address=192.168.90.150 comment=<AUTO:DHCP:main-dhcp-server> name=iPhoneAlxr.home ttl=5m
/ip dns static add address=192.168.90.70 comment=<AUTO:DHCP:main-dhcp-server> name=miniAlx.home
/ip dns static add address=192.168.90.40 comment=<AUTO:DHCP:main-dhcp-server> name=nas.home
/ip dns static add cname=nas.home name=nas type=CNAME
/ip dns static add address=192.168.90.200 comment=<AUTO:DHCP:main-dhcp-server> name=AlxATV.home ttl=5m
/ip dns static add address=192.168.90.210 comment=<AUTO:DHCP:main-dhcp-server> name=AudioATV.home ttl=5m
/ip dns static add address=192.168.90.130 comment=<AUTO:DHCP:main-dhcp-server> name=iPadProAlx.home ttl=5m
/ip dns static add name=special-remote-CHR-ipsec-policy-comment text=ANNA-OUTER-IP-REMOTE-CONTROLLABLE type=TXT
/ip dns static add address=192.168.90.170 comment=<AUTO:DHCP:main-dhcp-server> name=Twinkly79EDD9.home ttl=5m
/ip dns static add cname=mikrouter.home name=mikrouter type=CNAME
/ip dns static add address=95.213.159.180 name=atv.qello.com
/ip dns static add address=95.213.159.180 name=atv.package2.qello.com
/ip dns static add address=192.168.90.88 comment=<AUTO:DHCP:main-dhcp-server> name=ASUS.home ttl=5m
/ip dns static add address=192.168.90.140 comment=<AUTO:DHCP:main-dhcp-server> name=android-95914276d1da81b5.home ttl=5m
/ip dns static add address=192.168.90.85 comment=<AUTO:DHCP:main-dhcp-server> name=MbpAlxm.home ttl=5m
/ip dns static add address=46.39.51.163 name=ftpserver.org
/ip firewall address-list add address=192.168.90.0/24 list=alist-fw-local-subnets
/ip firewall address-list add address=192.168.90.0/24 list=alist-nat-local-subnets
/ip firewall address-list add address=0.0.0.0/8 comment="RFC 1122 \"This host on this network\"" disabled=yes list=alist-fw-rfc-special
/ip firewall address-list add address=10.0.0.0/8 comment="RFC 1918 (Private Use IP Space)" disabled=yes list=alist-fw-rfc-special
/ip firewall address-list add address=100.64.0.0/10 comment="RFC 6598 (Shared Address Space)" list=alist-fw-rfc-special
/ip firewall address-list add address=127.0.0.0/8 comment="RFC 1122 (Loopback)" list=alist-fw-rfc-special
/ip firewall address-list add address=169.254.0.0/16 comment="RFC 3927 (Dynamic Configuration of IPv4 Link-Local Addresses)" list=alist-fw-rfc-special
/ip firewall address-list add address=172.16.0.0/12 comment="RFC 1918 (Private Use IP Space)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.0.0.0/24 comment="RFC 6890 (IETF Protocol Assingments)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.0.2.0/24 comment="RFC 5737 (Test-Net-1)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.168.0.0/16 comment="RFC 1918 (Private Use IP Space)" disabled=yes list=alist-fw-rfc-special
/ip firewall address-list add address=198.18.0.0/15 comment="RFC 2544 (Benchmarking)" list=alist-fw-rfc-special
/ip firewall address-list add address=198.51.100.0/24 comment="RFC 5737 (Test-Net-2)" list=alist-fw-rfc-special
/ip firewall address-list add address=203.0.113.0/24 comment="RFC 5737 (Test-Net-3)" list=alist-fw-rfc-special
/ip firewall address-list add address=224.0.0.0/4 comment="RFC 5771 (Multicast Addresses) - Will affect OSPF, RIP, PIM, VRRP, IS-IS, and others. Use with caution.)" list=alist-fw-rfc-special
/ip firewall address-list add address=240.0.0.0/4 comment="RFC 1112 (Reserved)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.31.196.0/24 comment="RFC 7535 (AS112-v4)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.52.193.0/24 comment="RFC 7450 (AMT)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.88.99.0/24 comment="RFC 7526 (Deprecated (6to4 Relay Anycast))" list=alist-fw-rfc-special
/ip firewall address-list add address=192.175.48.0/24 comment="RFC 7534 (Direct Delegation AS112 Service)" list=alist-fw-rfc-special
/ip firewall address-list add address=255.255.255.255 comment="RFC 919 (Limited Broadcast)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.168.90.0/24 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=8.8.8.8 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=8.8.4.4 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=192.168.100.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=4.2.2.2 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=185.6.175.49 comment="Manual Black List" list=alist-fw-manual-block
/ip firewall address-list add address=192.168.90.0/24 list=alist-fw-rdp-allow
/ip firewall address-list add address=192.168.90.0/24 list=alist-fw-smb-allow
/ip firewall address-list add address=185.13.148.14 list=alist-fw-vpn-server-addr
/ip firewall address-list add address=rutracker.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.97.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=10.0.0.0/29 list=alist-fw-vpn-server-addr
/ip firewall address-list add address=10.0.0.0/29 list=alist-fw-vpn-subnets
/ip firewall address-list add address=nnmclub.me list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=10.0.0.0/24 list=alist-fw-local-subnets
/ip firewall address-list add address=10.0.0.0/24 list=alist-nat-local-subnets
/ip firewall address-list add address=myexternalip.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=serverfault.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.16.0.16/30 list=alist-fw-local-subnets
/ip firewall address-list add address=172.16.0.16/30 list=alist-nat-local-subnets
/ip firewall address-list add address=192.168.98.0/24 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=ru.xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=telegram.org list=alist-fw-telegram-servers
/ip firewall address-list add address=grafana.home list=alist-nat-grafana-server
/ip firewall address-list add address=grafanasvc.home list=alist-nat-grafana-service
/ip firewall address-list add address=influxdb.home list=alist-nat-influxdb-server
/ip firewall address-list add address=influxdbsvc.home list=alist-nat-influxdb-service
/ip firewall address-list add address=auntmia.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=clubseventeen.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=speedtest.tele2.net disabled=yes list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.90.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=lostfilm.tv list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=nnmclub.to list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=rutor.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=rutor.info list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=hdreactor.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=10.0.0.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=185.13.148.14 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=minialx.home list=alist-fw-port-scanner-allow
/ip firewall address-list add address=mbpalx.home list=alist-fw-port-scanner-allow
/ip firewall address-list add address=nas.home list=alist-fw-port-scanner-allow
/ip firewall address-list add address=asus.home comment=asus.home list=alist-fw-port-scanner-allow
/ip firewall address-list add address=www.parallels.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=instagram.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=facebook.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=l.instagram.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=46.39.51.163 list=alist-nat-external-ip
/ip firewall filter add action=drop chain=input comment="Drop Invalid Connections (HIGH PRIORIRY RULE)" connection-state=invalid in-interface-list=list-drop-invalid-connections
/ip firewall filter add action=drop chain=forward comment="Drop Invalid Connections (HIGH PRIORIRY RULE)" connection-state=invalid dst-address-list=!alist-fw-vpn-subnets
/ip firewall filter add action=accept chain=forward comment="Accept Related or Established Connections (HIGH PRIORIRY RULE)" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=accept chain=input comment="OSFP neighbour-ing allow" log-prefix=~~~OSFP protocol=ospf
/ip firewall filter add action=accept chain=input comment="Allow mikrotik self-discovery" dst-address-type=broadcast dst-port=5678 protocol=udp
/ip firewall filter add action=accept chain=forward comment="Allow mikrotik neighbor-discovery" dst-address-type=broadcast dst-port=5678 protocol=udp
/ip firewall filter add action=accept chain=output comment=CAPsMAN dst-address-type=local port=5246,5247 protocol=udp src-address-type=local
/ip firewall filter add action=accept chain=input comment=CAPsMAN dst-address-type=local port=5246,5247 protocol=udp src-address-type=local
/ip firewall filter add action=jump chain=input comment="VPN Access" jump-target=chain-vpn-rules
/ip firewall filter add action=accept chain=chain-vpn-rules comment="L2TP tunnel" dst-port=1701 log-prefix=~~~L2TP protocol=udp
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IPSec-ah\"" log-prefix=~~~VPN protocol=ipsec-ah src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IPSec-esp\"" log-prefix=~~~VPN_FRW protocol=ipsec-esp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IKE\" - IPSEC connection establishing" dst-port=500 log-prefix=~~~VPN_FRW protocol=udp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow UDP\" - IPSEC data trasfer" dst-port=4500 log-prefix=~~~VPN_FRW protocol=udp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=return chain=chain-vpn-rules comment="VPN Access"
/ip firewall filter add action=accept chain=forward comment=VPN dst-address-list=alist-fw-vpn-subnets log-prefix=~~~VPN_FRW src-address-list=alist-fw-local-subnets
/ip firewall filter add action=accept chain=forward comment=VPN dst-address-list=alist-fw-local-subnets log-prefix=~~~VPN_FRW src-address-list=alist-fw-vpn-subnets
/ip firewall filter add action=jump chain=forward comment="Jump to chain-rdp-staged-control" jump-target=chain-rdp-staged-control
/ip firewall filter add action=drop chain=chain-rdp-staged-control comment="drop rdp brute forcers" dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-block
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-block address-list-timeout=10h chain=chain-rdp-staged-control connection-state=new dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage3 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage2 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage1 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new dst-port=3389 protocol=tcp src-address-list=!alist-fw-rdp-allow
/ip firewall filter add action=return chain=chain-rdp-staged-control comment="Return From chain-rdp-staged-control"
/ip firewall filter add action=jump chain=forward comment="jump to chain-smb-staged-control" jump-target=chain-smb-staged-control src-address-list=!alist-fw-smb-allow
/ip firewall filter add action=add-src-to-address-list address-list=alist-smb-shares-track address-list-timeout=10h chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=~~~SMB protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list=alist-smb-shares-track address-list-timeout=10h chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=~~~SMB protocol=tcp
/ip firewall filter add action=drop chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=~~~SMB protocol=tcp src-address-list=alist-smb-shares-track
/ip firewall filter add action=drop chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=~~~SMB protocol=udp src-address-list=alist-smb-shares-track
/ip firewall filter add action=return chain=chain-smb-staged-control comment="Return from chain-smb-staged-control"
/ip firewall filter add action=drop chain=input comment="drop ftp brute forcers" dst-port=21 protocol=tcp src-address-list=alist-fw-ftp-block
/ip firewall filter add action=accept chain=output comment="drop ftp brute forcers" content="530 Login incorrect" dst-limit=1/1m,9,dst-address/1m protocol=tcp
/ip firewall filter add action=add-dst-to-address-list address-list=alist-fw-ftp-block address-list-timeout=3h chain=output comment="drop ftp brute forcers" content="530 Login incorrect" protocol=tcp
/ip firewall filter add action=jump chain=input comment="Jump to DNS Amplification" jump-target=chain-dns-amp-attack
/ip firewall filter add action=accept chain=chain-dns-amp-attack comment="Make exceptions for DNS" log-prefix=~~~DNS port=53 protocol=udp src-address-list=alist-fw-dns-allow
/ip firewall filter add action=accept chain=chain-dns-amp-attack comment="Make exceptions for DNS" dst-address-list=alist-fw-dns-allow log-prefix=~~~DNS port=53 protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-dns-amp-block address-list-timeout=10h chain=chain-dns-amp-attack comment="Add DNS Amplification to Blacklist" port=53 protocol=udp src-address-list=!alist-fw-dns-allow
/ip firewall filter add action=drop chain=chain-dns-amp-attack comment="Drop DNS Amplification" src-address-list=alist-fw-dns-amp-block
/ip firewall filter add action=return chain=chain-dns-amp-attack comment="Return from DNS Amplification"
/ip firewall filter add action=accept chain=input comment="Self fetch requests" log-prefix=WEB port=80 protocol=tcp
/ip firewall filter add action=jump chain=input comment="Allow router services on the lan" in-interface=main-infrastructure-br jump-target=chain-router-services-lan
/ip firewall filter add action=accept chain=chain-router-services-lan comment="Winbox (8291/TCP)" dst-port=8291 protocol=tcp
/ip firewall filter add action=accept chain=chain-router-services-lan comment=SNMP port=161 protocol=udp
/ip firewall filter add action=accept chain=chain-router-services-lan comment=WEB port=80 protocol=tcp
/ip firewall filter add action=return chain=chain-router-services-lan comment="Return from chain-router-services-lan Chain"
/ip firewall filter add action=jump chain=input comment="Allow router services on the wan" in-interface="wan A" jump-target=chain-router-services-wan
/ip firewall filter add action=drop chain=chain-router-services-wan comment="SSH (22/TCP)" dst-port=22 protocol=tcp
/ip firewall filter add action=drop chain=chain-router-services-wan comment="Winbox (8291/TCP)" dst-port=8291 protocol=tcp
/ip firewall filter add action=return chain=chain-router-services-wan comment="Return from chain-router-services-wan Chain"
/ip firewall filter add action=jump chain=input comment="Check for ping flooding" jump-target=chain-detect-ping-flood protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="0:0 and limit for 5 pac/s Allow Ping" icmp-options=0:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="3:3 and limit for 5 pac/s Allow Traceroute" icmp-options=3:3 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="3:4 and limit for 5 pac/s Allow Path MTU Discovery" icmp-options=3:4 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="8:0 and limit for 5 pac/s Allow Ping" icmp-options=8:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="11:0 and limit for 5 pac/s Allow Traceroute" icmp-options=11:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="0:0 and limit for 50 pac/s Allow Ping tool speed-test" icmp-options=0:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="8:0 and limit for 50 pac/s Allow Ping tool speed-test" icmp-options=8:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=drop chain=chain-detect-ping-flood comment="drop everything else" log-prefix="#ICMP DROP" protocol=icmp
/ip firewall filter add action=return chain=chain-detect-ping-flood comment="Return from chain-detect-ping-flood Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY1 log-prefix=~~~DUMMY1 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Manually Added)" src-address-list=alist-fw-manual-block
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Manually Added)" src-address-list=alist-fw-manual-block
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (SSH)" src-address-list=alist-fw-ssh-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (SSH)" src-address-list=alist-fw-ssh-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Telnet)" src-address-list=alist-fw-telnet-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Telnet)" src-address-list=alist-fw-telnet-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Winbox)" src-address-list=alist-fw-winbox-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Winbox)" src-address-list=alist-fw-winbox-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the WAN Port Scanner List" src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the WAN Port Scanner List" src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=passthrough chain=input comment="Drop anyone in the LAN Port Scanner List" src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=passthrough chain=forward comment="Drop anyone in the LAN Port Scanner List" src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=drop chain=input comment="Drop all Bogons" src-address-list=alist-fw-rfc-special
/ip firewall filter add action=drop chain=forward comment="Drop all Bogons" src-address-list=alist-fw-rfc-special
/ip firewall filter add action=passthrough chain=forward comment=DUMMY2 log-prefix=~~~DUMMY2 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC SSH Chain" jump-target=chain-ssh-staged-control
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-ban address-list-timeout=1w3d chain=chain-ssh-staged-control comment="Transfer repeated attempts from SSH Stage 3 to Black-List" connection-state=new dst-port=22 protocol=tcp src-address-list=alist-fw-ssh-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage3 address-list-timeout=1m chain=chain-ssh-staged-control comment="Add succesive attempts to SSH Stage 3" connection-state=new dst-port=22 protocol=tcp src-address-list=alist-fw-ssh-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage2 address-list-timeout=1m chain=chain-ssh-staged-control comment="Add succesive attempts to SSH Stage 2" connection-state=new dst-port=22 protocol=tcp src-address-list=alist-fw-ssh-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage1 address-list-timeout=1m chain=chain-ssh-staged-control comment="Add intial attempt to SSH Stage 1 List" connection-state=new dst-port=22 protocol=tcp
/ip firewall filter add action=return chain=chain-ssh-staged-control comment="Return From RFC SSH Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY3 log-prefix=~~~DUMMY3 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Telnet Chain" jump-target=chain-telnet-staged-control
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-ban address-list-timeout=1w3d chain=chain-telnet-staged-control comment="Transfer repeated attempts from Telnet Stage 3 to Black-List" connection-state=new dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage3 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add succesive attempts to Telnet Stage 3" connection-state=new dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage2 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add succesive attempts to Telnet Stage 2" connection-state=new dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage1 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add Intial attempt to Telnet Stage 1" connection-state=new dst-port=23 protocol=tcp
/ip firewall filter add action=return chain=chain-telnet-staged-control comment="Return From RFC Telnet Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY4 log-prefix=~~~DUMMY4 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Winbox Chain" jump-target=chain-winbox-staged-control
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-ban address-list-timeout=1w3d chain=chain-winbox-staged-control comment="Transfer repeated attempts from Winbox Stage 3 to Black-List" connection-state=new dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage3 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add succesive attempts to Winbox Stage 3" connection-state=new dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage2 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add succesive attempts to Winbox Stage 2" connection-state=new dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage1 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add Intial attempt to Winbox Stage 1" connection-state=new dst-port=8291 protocol=tcp src-address-list=!alist-fw-vpn-subnets
/ip firewall filter add action=return chain=chain-winbox-staged-control comment="Return From RFC Winbox Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY5 log-prefix=~~~DUMMY5 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-port-scanner-ban address-list-timeout=10h chain=input comment="Add TCP Port Scanners to Address List" protocol=tcp psd=40,3s,2,1 src-address-list=!alist-fw-port-scanner-allow
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-port-scanner-ban address-list-timeout=10h chain=forward comment="Add TCP Port Scanners to Address List" protocol=tcp psd=40,3s,2,1 src-address-list=!alist-fw-port-scanner-allow
/ip firewall filter add action=passthrough chain=forward comment=DUMMY6 log-prefix=~~~DUMMY6 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-highload address-list-timeout=1h chain=input comment=alist-fw-highload connection-limit=100,32 protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-highload address-list-timeout=10h chain=forward comment=alist-fw-highload connection-limit=100,32 protocol=tcp
/ip firewall filter add action=jump chain=input comment="Jump to Virus Chain" jump-target=chain-worms-detector
/ip firewall filter add action=drop chain=chain-worms-detector comment=Conficker dst-port=593 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm dst-port=1024-1030 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="ndm requester" dst-port=1363 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="ndm server" dst-port=1364 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="screen cast" dst-port=1368 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=hromgrafx dst-port=1373 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom" dst-port=1080 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=cichlid dst-port=1377 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm dst-port=1433-1434 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dumaru.Y" dst-port=2283 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle" dst-port=2535 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle.C-K" dst-port=2745 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom" dst-port=3127-3128 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Backdoor OptixPro" dst-port=3410 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Sasser" dst-port=5554 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm dst-port=4444 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm dst-port=4444 protocol=udp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle.B" dst-port=8866 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dabber.A-B" dst-port=9898 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dumaru.Y" dst-port=10000 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom.B" dst-port=10080 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop NetBus" dst-port=12345 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Kuang2" dst-port=17300 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop SubSeven" dst-port=27374 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop PhatBot, Agobot, Gaobot" dst-port=65506 protocol=tcp
/ip firewall filter add action=return chain=chain-worms-detector comment="Return From Virus Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY7 log-prefix=~~~DUMMY7 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to \"Manage Common Ports\" Chain" jump-target=chain-self-common-ports
/ip firewall filter add action=accept chain=chain-self-common-ports comment="\"All hosts on this subnet\" Broadcast" src-address=224.0.0.1
/ip firewall filter add action=accept chain=chain-self-common-ports comment="\"All routers on this subnet\" Broadcast" src-address=224.0.0.2
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DVMRP (Distance Vector Multicast Routing Protocol)" src-address=224.0.0.4
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OSPF - All OSPF Routers Broadcast" src-address=224.0.0.5
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OSPF - OSPF DR Routers Broadcast" src-address=224.0.0.6
/ip firewall filter add action=accept chain=chain-self-common-ports comment="RIP Broadcast" src-address=224.0.0.9
/ip firewall filter add action=accept chain=chain-self-common-ports comment="EIGRP Broadcast" src-address=224.0.0.10
/ip firewall filter add action=accept chain=chain-self-common-ports comment="PIM Broadcast" src-address=224.0.0.13
/ip firewall filter add action=accept chain=chain-self-common-ports comment="VRRP Broadcast" src-address=224.0.0.18
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" src-address=224.0.0.19
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" src-address=224.0.0.20
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" src-address=224.0.0.21
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IGMP Broadcast" src-address=224.0.0.22
/ip firewall filter add action=accept chain=chain-self-common-ports comment="GRE Protocol (Local Management)" protocol=gre
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPdata transfer" log-prefix=~~~FTP port=20 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPcontrol (command)" log-prefix=~~~FTP port=21 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPdata transfer  " log-prefix=~~~FTP port=20 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Secure Shell(SSH)" port=22 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Secure Shell(SSH)   " port=22 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment=Telnet port=23 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment=Telnet port=23 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Priv-mail: any privatemailsystem." port=24 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Priv-mail: any privatemailsystem.  " port=24 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Mail Transfer Protocol(SMTP)" port=25 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Mail Transfer Protocol(SMTP)  " port=25 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TIME protocol" port=37 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TIME protocol  " port=37 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="ARPA Host Name Server Protocol & WINS" port=42 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="ARPA Host Name Server Protocol  & WINS  " port=42 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WHOIS protocol" port=43 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WHOIS protocol" port=43 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Domain Name System (DNS)" port=53 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Domain Name System (DNS)" port=53 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Mail Transfer Protocol(RFC 780)" port=57 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="(BOOTP) Server & (DHCP)  " port=67 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="(BOOTP) Client & (DHCP)  " port=68 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Trivial File Transfer Protocol (TFTP)  " port=69 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Gopher protocol" port=70 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Finger protocol" port=79 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Hypertext Transfer Protocol (HTTP)" port=80 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="RemoteTELNETService protocol" port=107 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocolv2 (POP2)" port=109 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocolv3 (POP3)" port=110 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IdentAuthentication Service/Identification Protocol" port=113 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Authentication Service (auth)  " port=113 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple File Transfer Protocol (SFTP)" port=115 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Network Time Protocol(NTP)" port=123 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Name Service" port=137 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Name Service  " port=137 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Datagram Service" port=138 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Datagram Service  " port=138 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Session Service" port=139 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Session Service  " port=139 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP)" port=143 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Background File Transfer Program (BFTP)" port=152 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Background File Transfer Program (BFTP)  " port=152 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SGMP,Simple Gateway Monitoring Protocol" port=153 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SGMP,Simple Gateway Monitoring Protocol  " port=153 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DMSP, Distributed Mail Service Protocol" port=158 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DMSP, Distributed Mail Service Protocol  " port=158 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management Protocol(SNMP)  " port=161 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management ProtocolTrap (SNMPTRAP)" port=162 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management ProtocolTrap (SNMPTRAP)  " port=162 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGP (Border Gateway Protocol)" port=179 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP), version 3" port=220 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP), version 3" port=220 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGMP, Border Gateway Multicast Protocol" port=264 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGMP, Border Gateway Multicast Protocol  " port=264 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Lightweight Directory Access Protocol (LDAP)" port=389 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Lightweight Directory Access Protocol (LDAP)" port=389 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SSTP TCP Port 443 (Local Management) & HTTPS" port=443 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Microsoft-DSActive Directory, Windows shares" port=445 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP/ IPSEC UDP Port 500 (Local Management)" port=500 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Modbus, Protocol" port=502 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Modbus, Protocol  " port=502 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Shell (Remote Shell, rsh, remsh)" port=514 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Syslog - used for system logging  " port=514 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Routing Information Protocol (RIP)  " port=520 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="e-mail message submission (SMTP)" port=587 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="LDP,Label Distribution Protocol" port=646 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="LDP,Label Distribution Protocol" port=646 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (data):FTP over TLS/SSL" port=989 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (data):FTP over TLS/SSL" port=989 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (control):FTP over TLS/SSL" port=990 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (control):FTP over TLS/SSL" port=990 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TELNET protocol overTLS/SSL" port=992 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TELNET protocol overTLS/SSL" port=992 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol over TLS/SSL (IMAPS)" port=993 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocol3 over TLS/SSL (POP3S)" port=995 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OVPN TCP Port 1194 (Local Management)" port=1194 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="PPTP Port 1723 (Local Management)" port=1723 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP UDP Port 1701 (Local Management)" port=1701 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP UDP Port 4500 (Local Management)" port=4500 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WINBOX TCP Port 8291 (Local Management)" port=8291 protocol=tcp
/ip firewall filter add action=accept chain=input comment="TCP/UDP ports necessary for SMB" dst-port=137-138 log-prefix=~~~SMB protocol=udp src-address-list=alist-fw-smb-allow
/ip firewall filter add action=accept chain=input comment="TCP/UDP ports necessary for SMB" dst-port=137,139 log-prefix=~~~SMB protocol=tcp src-address-list=alist-fw-smb-allow
/ip firewall filter add action=accept chain=input comment="Accept Related or Established Connections" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (INPUT)"
/ip firewall filter add action=accept chain=forward comment="Accept New Connections" connection-state=new log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=accept chain=input comment="Allow proxy on 8888" dst-port=8888 in-interface=main-infrastructure-br protocol=tcp
/ip firewall filter add action=passthrough chain=forward comment=DUMMY8 log-prefix=~~~DUMMY8 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=drop chain=input comment="Open proxy block" dst-port=8888 in-interface="wan A" protocol=tcp
/ip firewall filter add action=drop chain=forward comment="WAN static-routes intruders not DSTNATed drop" connection-nat-state=dstnat connection-state=new in-interface="wan A" log-prefix="#DROP UNKNOWN (FWD/no DSTN)"
/ip firewall filter add action=drop chain=forward comment="Drop all other LAN Traffic" log-prefix="#DROP UNKNOWN (FWD)"
/ip firewall filter add action=drop chain=input comment="Drop all other WAN Traffic" log-prefix="#DROP UNKNOWN (INPUT)"
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" in-interface=all-ppp new-mss=1360 passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" new-mss=1360 out-interface=all-ppp passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=output comment="fix MSS for l2tp/ipsec (self)" new-mss=1360 passthrough=yes protocol=tcp src-address-list=alist-fw-vpn-subnets tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=mark-connection chain=prerouting comment="Mark l2tp" connection-mark=no-mark connection-state=new dst-address-list=alist-mangle-vpn-tunneled-sites new-connection-mark=cmark-tunnel-connection passthrough=yes
/ip firewall mangle add action=mark-connection chain=prerouting comment="Mark l2tp (telegram)" connection-mark=no-mark connection-state=new dst-address-list=alist-fw-telegram-servers new-connection-mark=cmark-tunnel-connection passthrough=yes
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self)" dst-address-list=alist-mangle-vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self, telegram notify)" dst-address-list=alist-fw-telegram-servers log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites" connection-mark=cmark-tunnel-connection dst-address-list=alist-mangle-vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites (telegram)" connection-mark=cmark-tunnel-connection dst-address-list=alist-fw-telegram-servers log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=passthrough chain=prerouting comment=DUMMY
/ip firewall mangle add action=mark-connection chain=prerouting comment="7Z DL CONN mark" connection-mark=no-mark layer7-protocol=7Z new-connection-mark=conn-7z-download passthrough=yes
/ip firewall mangle add action=mark-packet chain=prerouting comment=7z connection-mark=conn-7z-download layer7-protocol=7Z log-prefix=~~~DL_7z new-packet-mark=7z-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-connection chain=prerouting comment="EXE DL CONN mark" connection-mark=no-mark layer7-protocol=EXE new-connection-mark=conn-exe-download passthrough=yes
/ip firewall mangle add action=mark-packet chain=prerouting comment=exe connection-mark=conn-exe-download layer7-protocol=EXE log-prefix=~~~DL_exe new-packet-mark=exe-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-connection chain=prerouting comment="RAR DL CONN mark" connection-mark=no-mark layer7-protocol=RAR new-connection-mark=conn-rar-download passthrough=yes
/ip firewall mangle add action=mark-packet chain=prerouting comment=rar connection-mark=conn-rar-download layer7-protocol=RAR log-prefix=~~~DL_rar new-packet-mark=rar-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-connection chain=prerouting comment="ZIP DL CONN mark" connection-mark=no-mark layer7-protocol=ZIP new-connection-mark=conn-zip-download passthrough=yes
/ip firewall mangle add action=mark-packet chain=prerouting comment=zip connection-mark=conn-zip-download layer7-protocol=ZIP log-prefix=~~~DL_zip new-packet-mark=zip-mark passthrough=yes protocol=tcp
/ip firewall mangle add action=add-src-to-address-list address-list=alist-mangle-routers-detection address-list-timeout=none-dynamic chain=prerouting comment="LAN Routers detection" ttl=equal:63
/ip firewall mangle add action=add-src-to-address-list address-list=alist-mangle-routers-detection address-list-timeout=none-dynamic chain=prerouting comment="LAN Routers detection" ttl=equal:127
/ip firewall nat add action=redirect chain=dstnat comment="Redirect DNS requests to router (prevent local DNS assignment)" dst-port=53 log-prefix="#DNS Req" protocol=udp
/ip firewall nat add action=redirect chain=dstnat comment="Redirect DNS requests to router (prevent local DNS assignment)" dst-port=53 protocol=tcp
/ip firewall nat add action=dst-nat chain=dstnat comment="Redirect to GRAFANA (map to port 3000, local only)" dst-address-list=alist-nat-grafana-server dst-port=80 in-interface=main-infrastructure-br log=yes log-prefix="~~~GRAFANA REDIRECT" protocol=tcp src-address-list=alist-nat-local-subnets to-addresses=192.168.90.70 to-ports=3000
/ip firewall nat add action=masquerade chain=srcnat comment="Backward redirect to GRAFANA  (local only)" dst-address-list=alist-nat-grafana-service dst-port=3000 log=yes log-prefix="~~~ GRAFANA BACK" out-interface=main-infrastructure-br protocol=tcp src-address-list=alist-nat-local-subnets
/ip firewall nat add action=dst-nat chain=dstnat comment="Redirect to INFLUXDB (map to port 8000, local only)" dst-address-list=alist-nat-influxdb-server log=yes log-prefix=~~~INFLUX src-address-list=alist-nat-local-subnets to-addresses=192.168.90.40
/ip firewall nat add action=masquerade chain=srcnat comment="Backward redirect to INFLUXDB  (local only)" dst-address-list=alist-nat-influxdb-service log=yes log-prefix="~~~~~~~~INFLUX BACK" src-address-list=alist-nat-local-subnets
/ip firewall nat add action=accept chain=srcnat comment="accept tunnel traffic" dst-address-list=alist-fw-vpn-subnets log-prefix=~~~VPN_NAT src-address-list=alist-nat-local-subnets
/ip firewall nat add action=accept chain=srcnat comment="accept tunnel traffic (sites)" dst-address-list=alist-mangle-vpn-tunneled-sites log-prefix=~~~VPN_NAT
/ip firewall nat add action=accept chain=dstnat comment="accept tunnel traffic" dst-address-list=alist-nat-local-subnets log-prefix=~~~VPN_NAT src-address-list=alist-fw-vpn-subnets
/ip firewall nat add action=masquerade chain=srcnat comment="VPN masq (pure L2TP, w/o IPSEC)" out-interface-list=list-l2tp-tunnels
/ip firewall nat add action=netmap chain=dstnat comment="WINBOX pass through" dst-port=9999 in-interface="wan A" log-prefix=~~~WNBOX protocol=tcp to-addresses=192.168.90.1 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="WINBOX NAT loopback" dst-address-list=alist-nat-external-ip dst-address-type="" dst-port=8291 in-interface=main-infrastructure-br log-prefix=~~~LOOP protocol=tcp src-address-list=alist-nat-local-subnets to-addresses=192.168.90.1 to-ports=8291
/ip firewall nat add action=netmap chain=dstnat comment="WEB pass through" dst-port=8888 in-interface="wan A" log-prefix="#WEB EXT CTRL" protocol=tcp to-addresses=192.168.90.1 to-ports=80
/ip firewall nat add action=dst-nat chain=dstnat comment="WEB NAT loopback" dst-address-list=alist-nat-external-ip dst-address-type="" dst-port=80 in-interface=main-infrastructure-br log-prefix=~~~LOOP protocol=tcp src-address-list=alist-nat-local-subnets to-addresses=192.168.90.1 to-ports=80
/ip firewall nat add action=netmap chain=dstnat comment="FTP pass through" dst-port=1111 in-interface="wan A" log-prefix=~~~FTP protocol=tcp to-addresses=192.168.90.80 to-ports=21
/ip firewall nat add action=netmap chain=dstnat comment="FTP pass through PASV" dst-port=65000-65050 in-interface="wan A" log-prefix=~~~FTP protocol=tcp to-addresses=192.168.90.80 to-ports=65000-65050
/ip firewall nat add action=dst-nat chain=dstnat comment="FTP NAT loopback" dst-address-list=alist-nat-external-ip dst-address-type="" dst-port=21 in-interface=main-infrastructure-br log-prefix=~~~LOOP protocol=tcp src-address-list=alist-nat-local-subnets to-addresses=192.168.90.80 to-ports=21
/ip firewall nat add action=netmap chain=dstnat comment="RDP pass through" dst-address-type=local dst-port=3333 in-interface="wan A" log-prefix=~~~RDP protocol=tcp to-addresses=192.168.90.80 to-ports=3389
/ip firewall nat add action=dst-nat chain=dstnat comment="RDP NAT loopback" dst-address-list=alist-nat-external-ip dst-address-type="" dst-port=3389 in-interface=main-infrastructure-br log-prefix=~~~LOOP protocol=tcp src-address-list=alist-nat-local-subnets to-addresses=192.168.90.80 to-ports=3389
/ip firewall nat add action=masquerade chain=srcnat comment="all WAN allowed" dst-address-list=!alist-fw-vpn-subnets out-interface="wan A"
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set irc disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip firewall service-port set udplite disabled=yes
/ip firewall service-port set dccp disabled=yes
/ip firewall service-port set sctp disabled=yes
/ip hotspot service-port set ftp disabled=yes
/ip ipsec identity add auth-method=digital-signature certificate=anna.ipsec.2021@CHR comment=to-CHR-outer-tunnel-encryption-RSA peer=CHR-external policy-template-group=outside-ipsec-encryption
/ip ipsec identity add comment=to-CHR-traffic-only-encryption-PSK peer=CHR-internal policy-template-group=inside-ipsec-encryption remote-id=ignore secret=123
/ip ipsec policy set 0 proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip ipsec policy add comment="Common IPSEC TRANSPORT (outer-tunnel encryption)" dst-address=185.13.148.14/32 dst-port=1701 peer=CHR-external proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=192.168.100.7/32 src-port=1701
/ip ipsec policy add comment="Common IPSEC TUNNEL (traffic-only encryption)" dst-address=192.168.97.0/29 peer=CHR-internal proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" src-address=192.168.90.0/24 tunnel=yes
/ip proxy set cache-administrator=defm.kopcap@gmail.com max-client-connections=10 max-fresh-time=20m max-server-connections=10 parent-proxy=0.0.0.0 port=8888 serialize-connections=yes
/ip proxy access add action=deny dst-host=grafana redirect-to=192.168.90.180:3000
/ip proxy access add action=deny dst-host=influxdb redirect-to=192.168.90.180:8000
/ip route add comment="GLOBAL MGTS" distance=50 gateway=192.168.100.1
/ip route rule add action=unreachable comment="LAN/GUEST isolation" dst-address=192.168.98.0/24 src-address=192.168.90.0/24
/ip route rule add action=unreachable comment="LAN/GUEST isolation" dst-address=192.168.90.0/24 src-address=192.168.98.0/24
/ip route rule add comment=API.TELEGRAM.ORG dst-address=149.154.167.0/24 table=mark-telegram
/ip service set telnet disabled=yes
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip smb set allow-guests=no domain=HNW interfaces=main-infrastructure-br
/ip smb shares set [ find default=yes ] disabled=yes
/ip ssh set allow-none-crypto=yes forwarding-enabled=remote
/ip tftp add real-filename=NAS/ req-filename=.*
/ip traffic-flow set cache-entries=64k enabled=yes interfaces="wan A"
/ip upnp set enabled=yes
/ip upnp interfaces add interface="wan A" type=external
/ip upnp interfaces add interface=main-infrastructure-br type=internal
/ip upnp interfaces add interface=guest-infrastructure-br type=internal
/routing filter add action=discard chain=ospf-in comment="discard intra area routes" ospf-type=intra-area
/routing filter add action=accept chain=ospf-in comment="set default remote route mark" prefix-length=0 set-pref-src=10.0.0.3 set-route-comment="GLOBAL VPN" set-routing-mark=rmark-vpn-redirect
/routing filter add action=accept chain=ospf-in comment="set pref source" set-pref-src=10.0.0.3
/routing ospf nbma-neighbor add address=10.255.255.1
/routing ospf network add area=local network=192.168.90.0/24
/routing ospf network add area=backbone network=10.0.0.0/29
/routing ospf network add area=backbone network=10.255.255.2/32
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces=main-infrastructure-br trap-version=2
/system clock set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity set name=anna
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
/system logging add action=SSHOnScreenLog topics=ssh
/system logging add action=PoEOnscreenLog topics=poe-out
/system note set note="You are logged into: anna\
    \n############### system health ###############\
    \nUptime:  3d16:59:44 d:h:m:s | CPU: 2%\
    \nRAM: 99240/1048576M | Voltage: 24 v | Temp: 48c\
    \n############# user auth details #############\
    \nHotspot online: 0 | PPP online: 0\
    \n" show-at-login=no
/system ntp client set enabled=yes primary-ntp=85.21.78.91 secondary-ntp=46.254.216.9
/system scheduler add interval=7m name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jan/30/2017 start-time=18:57:09
/system scheduler add interval=10h name=doIpsecPolicyUpd on-event="/system script run doIpsecPolicyUpd" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/21/2017 start-time=15:31:13
/system scheduler add interval=1d name=doUpdateStaticDNSviaDHCP on-event="/system script run doUpdateStaticDNSviaDHCP" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/21/2017 start-time=19:19:59
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=15:55:00
/system scheduler add interval=1w3d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jun/26/2018 start-time=21:00:00
/system scheduler add interval=30m name=doHeatFlag on-event="/system script run doHeatFlag" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/10/2018 start-time=15:10:00
/system scheduler add interval=1h name=doCollectSpeedStats on-event="/system script run doCollectSpeedStats" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2018 start-time=03:25:00
/system scheduler add interval=1h name=doCheckPingRate on-event="/system script run doCheckPingRate" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2018 start-time=02:40:00
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=07:00:00
/system scheduler add interval=1m name=doPeriodicLogDump on-event="/system script run doPeriodicLogDump" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=11:31:24
/system scheduler add name=doStartupScript on-event="\r\
    \n/system script run doStartupScript;" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=1w name=doTrackFirmwareUpdates on-event="/system script run doTrackFirmwareUpdates" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=11:30:00
/system scheduler add interval=1d name=doCreateTrafficAccountingQueues on-event="/system script run doCreateTrafficAccountingQueues" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system scheduler add interval=10m name=doPushStatsToInfluxDB on-event="/system script run doPushStatsToInfluxDB" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system scheduler add interval=15m name=doCPUHighLoadReboot on-event="/system script run doCPUHighLoadReboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=06:05:00
/system scheduler add interval=10m name=doIPSECPunch on-event="/system script run doIPSECPunch" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=08:00:00
/system scheduler add comment="added by function FuncSchedScriptAdd" interval=30s name="Run script TLGRMcall--10:13:34" on-event=":do {/system script run TLGRMcall;} on-error={:log info \"\"; :log error \"ERROR when executing a scheduled run script TLGRMcall\"; :log info \"\" }" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system script add comment="Creates static DNS entres for DHCP clients in the named DHCP server. Hostnames passed to DHCP are appended with the zone" dont-require-permissions=yes name=doUpdateStaticDNSviaDHCP owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doUpdateStaticDNSviaDHCP\";\r\
    \n\r\
    \n# Creates static DNS entres for DHCP clients in the named DHCP server.\r\
    \n# Hostnames passed to DHCP are appended with the zone.\r\
    \n#\r\
    \n\r\
    \n# Name of the DHCP server instance:\r\
    \n:local dhcpServer \"main-dhcp-server\"\r\
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
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doUpdateExternalDNS\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n:local payLoad false;\r\
    \n:local state \"\";\r\
    \n\r\
    \n:local content\r\
    \n:local IPv4\r\
    \n:global LastIPv4\r\
    \n\r\
    \n# parsing the current IPv4 result\r\
    \n/ip cloud force-update;\r\
    \n:delay 7s;\r\
    \n:set IPv4 [/ip cloud get public-address];\r\
    \n\r\
    \n\r\
    \n:if ((\$LastIPv4 != \$IPv4) || (\$force = true)) do={\r\
    \n\r\
    \n    :set state \"External IP changed: current - (\$IPv4), last - (\$LastIPv4)\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    /ip firewall address-list remove [find list~\"alist-nat-external-ip\"];\r\
    \n    /ip firewall address-list add list=\"alist-nat-external-ip\" address=\$IPv4;\r\
    \n   \r\
    \n    /ip dns static remove [/ip dns static find name=ftpserver.org];\r\
    \n    /ip dns static add name=ftpserver.org address=\$IPv4;\r\
    \n \r\
    \n    :set LastIPv4 \$IPv4;\r\
    \n    \r\
    \n    :set payLoad true; \r\
    \n\r\
    \n    :local count [:len [/system script find name=\"doSuperviseCHRviaSSH\"]];\r\
    \n    :if (\$count > 0) do={\r\
    \n       \r\
    \n        :set state \"Refreshing VPN server (CHR) IPSEC policies\";\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        /system script run doSuperviseCHRviaSSH;\r\
    \n    \r\
    \n     }\r\
    \n   \r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk and \$payLoad ) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: external IP address change detected, refreshed\"\r\
    \n}\r\
    \n\r\
    \n\r\
    \n:if (\$itsOk and !\$payLoad ) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: no external IP address update needed\"\r\
    \n}\r\
    \n\r\
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
    \n\r\
    \n"
/system script add comment="Runs once on startup and makes console welcome message pretty" dont-require-permissions=yes name=doCoolConcole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n:local WANip [/ip address get [find interface=\"wan A\"] address] \r\
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
/system script add comment="Just to note of fast-track activation" dont-require-permissions=yes name=doFastTrackActivation owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/ip settings set allow-fast-path=yes\r\
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
/system script add comment="Loads a HUGE list of ads/spammers to DNS-static records. https://stopad.cgood.ru/" dont-require-permissions=yes name=doAdblock owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="## StopAD - Script for blocking advertisements, based on your defined hosts files\r\
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
/system script add comment="Script to simplify IPSEC IKEv2 certificates ussuing (a set of CA, server, clients and signing) to be used for VPN tunnels" dont-require-permissions=yes name=doCertificatesIssuing owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n# generates IPSEC certs: CA, server, IOS *.mobileconfig profile sign and clients\r\
    \n# i recommend to run it on server side\r\
    \n\r\
    \n#clients\r\
    \n:local IDs [:toarray \"alx.iphone.rw.20-21,alx.mbp.rw.20-21\"];\r\
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
    \n:local USERNAME \"anna\"\r\
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
    \n:set maxTemp 68;\r\
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
/system script add comment="Just some sound" dont-require-permissions=yes name=doBumerSound owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\r\
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
/system script add comment="Netwatch handler both when OnUp and OnDown" dont-require-permissions=yes name=doNetwatchHost owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n/system script run SATELLITEstart;\r\
    \n\r\
    \n/system script run doCoolConcole;\r\
    \n\r\
    \n/system script run doImperialMarch;\r\
    \n\r\
    \n#wait some for all tunnels to come up after reboot and VPN to work\r\
    \n\r\
    \n:local inf \"Wait some for all tunnels to come up after reboot and VPN to work..\" ;\r\
    \n:global globalNoteMe;\r\
    \n\$globalNoteMe value=\$inf;\r\
    \n\r\
    \n:delay 25s;\r\
    \n\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doStartupScript\";\r\
    \n\r\
    \n:local inf \"\$scriptname on \$sysname: system restart detected\" ;\r\
    \n\$globalNoteMe value=\$inf;\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n\$globalTgMessage value=\$inf;\r\
    \n      \r\
    \n\r\
    \n"
/system script add comment="Updates remote VPN server (CHR) IPSEC policies for this mikrotik client via SSH when external IP changed" dont-require-permissions=yes name=doSuperviseCHRviaSSH owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doSuperviseCHRviaSSH\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n:local state \"n/d\";\r\
    \n\r\
    \n:local exitCode 0;\r\
    \n\r\
    \n:local callSSH do={\r\
    \n\r\
    \n    # reading params\r\
    \n    :local cmd \$1;\r\
    \n\r\
    \n    # ssh server attr\r\
    \n    :local dst \"185.13.148.14\";\r\
    \n    :local port 2222;\r\
    \n    :local user \"mikrouter\";\r\
    \n\r\
    \n    :local errorDef \"\";\r\
    \n\r\
    \n    :do {\r\
    \n \r\
    \n        #password-less (RSA keys) connection should be set up before\r\
    \n        :local callResult ([/system ssh-exec address=\$dst user=\$user port=\$port command=\$cmd as-value]);\r\
    \n        :local exitCode ([\$callResult]->\"exit-code\");\r\
    \n\r\
    \n        :if (\$exitCode != 0) do={\r\
    \n\r\
    \n            :set errorDef \"RPC: script parameter setup returns exit code (\$exitCode)\";\r\
    \n\r\
    \n        } else={\r\
    \n\r\
    \n            # success\r\
    \n\r\
    \n        }\r\
    \n\r\
    \n    } on-error= {\r\
    \n        :set errorDef \"Remote SSH session gets unexperted error\";\r\
    \n    };\r\
    \n\r\
    \n    :return \$errorDef;\r\
    \n\r\
    \n};\r\
    \n\r\
    \n:do {\r\
    \n    \r\
    \n    :local policyComment [/ip dns static get value-name=text [find where type=TXT and name=\"special-remote-CHR-ipsec-policy-comment\"]]\r\
    \n    :local remoteCommand \":global globalPolicyComment \$policyComment\";\r\
    \n\r\
    \n    :set state \"Calling --- \$remoteCommand\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    :local errorDef [\$callSSH \$remoteCommand];\r\
    \n\r\
    \n    :if ([:len \$errorDef] > 0) do={\r\
    \n\r\
    \n        :set state \$errorDef;\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :set itsOk false;\r\
    \n\r\
    \n    } else={\r\
    \n\r\
    \n        :set state \"RPC: set remote preferred policy comment variable: (\$policyComment) - Ok\";\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n    \r\
    \n    }\r\
    \n\r\
    \n};\r\
    \n\r\
    \n:if (\$itsOk) do={\r\
    \n\r\
    \n    :do {\r\
    \n        \r\
    \n        :local wanIp [/ip cloud get public-address];\r\
    \n        :local remoteCommand \":global globalRemoteIp \$wanIp/32\";\r\
    \n\r\
    \n        :set state \"Calling --- \$remoteCommand\";\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n       \r\
    \n        :local errorDef [\$callSSH \$remoteCommand];\r\
    \n\r\
    \n        :if ([:len \$errorDef] > 0) do={\r\
    \n\r\
    \n            :set state \$errorDef;\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n            :set itsOk false;\r\
    \n\r\
    \n        } else={\r\
    \n\r\
    \n            :set state \"RPC: set remote preferred policy IP variable: (\$wanIp) - Ok\";\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n        \r\
    \n        }\r\
    \n\r\
    \n    };\r\
    \n\r\
    \n}\r\
    \n\r\
    \n:if (\$itsOk) do={\r\
    \n\r\
    \n    :do {\r\
    \n        \r\
    \n        :local remoteCommand \"/system script run doUpdatePoliciesRemotely\";\r\
    \n\r\
    \n        :set state \"Calling --- \$remoteCommand\";\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n       \r\
    \n        :local errorDef [\$callSSH \$remoteCommand];\r\
    \n\r\
    \n        :if ([:len \$errorDef] > 0) do={\r\
    \n\r\
    \n            :set state \$errorDef;\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n            :set itsOk false;\r\
    \n\r\
    \n        } else={\r\
    \n\r\
    \n            :set state \"RPC: call remote script: doUpdatePoliciesRemotely - Ok\";\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n        \r\
    \n        }\r\
    \n\r\
    \n    };\r\
    \n\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: remote policies refreshed Successfully\"\r\
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
    \n\r\
    \n"
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
    \n        :delay 15;\r\
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
/system script add comment="Setups global functions, called by the other scripts (runs once on startup)" dont-require-permissions=no name=doEnvironmentSetup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:if (!any \$globalNoteMe) do={\r\
    \n\r\
    \n  :global globalNoteMe do={\r\
    \n\r\
    \n  ## outputs \$value using both :put and :log info\r\
    \n  ## example \$outputInfo value=\"12345\"\r\
    \n\r\
    \n  :put \"info: \$value\"\r\
    \n  :log info \"\$value\"\r\
    \n\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n:global globalScriptBeforeRun;\r\
    \n:if (!any \$globalScriptBeforeRun) do={\r\
    \n  :global globalScriptBeforeRun do={\r\
    \n\r\
    \n    :global globalNoteMe;\r\
    \n    :if ([:len \$1] > 0) do={\r\
    \n\r\
    \n      :local currentTime ([/system clock get date] . \" \" . [/system clock get time]);\r\
    \n      :local scriptname \"\$1\";\r\
    \n      :local count [:len [/system script job find script=\$scriptname]];\r\
    \n\r\
    \n      :if (\$count > 0) do={\r\
    \n\r\
    \n        :foreach counter in=[/system script job find script=\$scriptname] do={\r\
    \n         #But ignoring scripts started right NOW\r\
    \n\r\
    \n         :local thisScriptCallTime  [/system script job get \$counter started];\r\
    \n         :if (\$currentTime != \$thisScriptCallTime) do={\r\
    \n\r\
    \n           :local state \"\$scriptname already Running at \$thisScriptCallTime - killing old script before continuing\";\r\
    \n             :log error \$state\r\
    \n             \$globalNoteMe value=\$state;\r\
    \n            /system script job remove \$counter;\r\
    \n\r\
    \n          }\r\
    \n        }\r\
    \n      }\r\
    \n\r\
    \n      :local state \"Starting script: \$scriptname\";\r\
    \n      :put \"info: \$state\"\r\
    \n      :log info \"\$state\"\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n:global globalTgMessage;\r\
    \n:if (!any \$globalTgMessage) do={\r\
    \n  :global globalTgMessage do={\r\
    \n\r\
    \n    :global globalNoteMe;\r\
    \n    :local tToken \"798290125:AAE3gfeLKdtai3RPtnHRLbE8quNgAh7iC8M\";\r\
    \n    :local tGroupID \"-1001798127067\";\r\
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
    \n:global globalIPSECPolicyUpdateViaSSH;\r\
    \n:if (!any \$globalIPSECPolicyUpdateViaSSH) do={\r\
    \n  :global globalIPSECPolicyUpdateViaSSH do={\r\
    \n\r\
    \n    :global globalRemoteIp;\r\
    \n    :global globalNoteMe;\r\
    \n\r\
    \n    :if ([:len \$1] > 0) do={\r\
    \n      :global globalRemoteIp (\"\$1\" . \"/32\");\r\
    \n    }\r\
    \n\r\
    \n    :if (!any \$globalRemoteIp) do={\r\
    \n      :global globalRemoteIp \"0.0.0.0/32\"\r\
    \n    } else={\r\
    \n    }\r\
    \n\r\
    \n    :local state (\"RPC... \$value\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    :local count [:len [/system script find name=\"doUpdatePoliciesRemotely\"]];\r\
    \n    :if (\$count > 0) do={\r\
    \n       :local state (\"Starting policies process... \$globalRemoteIp \");\r\
    \n       \$globalNoteMe value=\$state;\r\
    \n       /system script run doUpdatePoliciesRemotely;\r\
    \n     }\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n#Example call\r\
    \n#\$globalNewNetworkMember ip=192.168.99.130 mac=50:DE:06:25:C2:FC gip=192.168.98.229 comm=iPadAlxPro ssid=\"WiFi 5\"\r\
    \n:global globalNewNetworkMember;\r\
    \n:if (!any \$globalNewNetworkMember) do={\r\
    \n  :global globalNewNetworkMember do={\r\
    \n\r\
    \n    :global globalNoteMe;\r\
    \n\r\
    \n    #to prevent connection\r\
    \n    :local guestDHCP \"guest-dhcp-server\";\r\
    \n\r\
    \n    #to allow connection\r\
    \n    :local mainDHCP \"main-dhcp-server\";\r\
    \n\r\
    \n    #when DHCP not using (add arp for leases)\r\
    \n    :local arpInterface \"main-infrastructure\";\r\
    \n    :local state (\"Adding new network member... \");\r\
    \n\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    # incoming named params\r\
    \n    :local newIp [ :tostr \$ip ];\r\
    \n    :local newBlockedIp [ :tostr \$gip ];\r\
    \n    :local newMac [ :tostr \$mac ];\r\
    \n    :local comment [ :tostr \$comm ];\r\
    \n    :local ssid [ :tostr \$ssid ];\r\
    \n    :if ([:len \$newIp] > 0) do={\r\
    \n        :if ([ :typeof [ :toip \$newIp ] ] != \"ip\" ) do={\r\
    \n\r\
    \n            :local state (\"Error: bad IP parameter passed - (\$newIp)\");\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n            :return false;\r\
    \n\r\
    \n        }\r\
    \n    } else={\r\
    \n\r\
    \n        :local state (\"Error: bad IP parameter passed - (\$newIp)\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n\r\
    \n        :local state (\"Removing existing DHCP configuration for (\$newIp/\$newMac) on \$mainDHCP\");\r\
    \n        \$globalNoteMe value=\$state;       /ip dhcp-server lease remove [find address=\$newIp];\r\
    \n        /ip dhcp-server lease remove [find mac-address=\$newMac];\r\
    \n\r\
    \n        :local state (\"Adding DHCP configuration for (\$newIp/\$newMac) on \$mainDHCP\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        /ip dhcp-server lease add address=\$newIp mac-address=\$newMac server=\$mainDHCP comment=\$comment;\r\
    \n\r\
    \n    } on-error={\r\
    \n\r\
    \n        :local state (\"Error: something fail on DHCP configuration 'allow' step for (\$newIp/\$newMac) on \$mainDHCP\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n\r\
    \n        /ip dhcp-server lease remove [find address=\$newBlockedIp];\r\
    \n        :local state (\"Adding DHCP configuration for (\$newBlockedIp/\$newMac) on \$guestDHCP (preventing connections to guest network)\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        /ip dhcp-server lease add address=\$newBlockedIp block-access=yes mac-address=\$newMac server=\$guestDHCP comment=(\$comment . \"(blocked)\");\r\
    \n\r\
    \n    } on-error={\r\
    \n\r\
    \n        :local state (\"Error: something fail on DHCP configuration 'block' step for (\$newBlockedIp/\$newMac) on \$guestDHCP\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n\r\
    \n        :local state (\"Adding ARP static entries for (\$newBlockedIp/\$newMac) on \$mainDHCP\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        /ip arp remove [find address=\$newIp];\r\
    \n        /ip arp remove [find address=\$newBlockedIp];\r\
    \n        /ip arp remove [find mac-address=\$newMac];\r\
    \n        /ip arp add address=\$newIp interface=\$arpInterface mac-address=\$newMac comment=\$comment\r\
    \n\r\
    \n    } on-error={\r\
    \n\r\
    \n        :local state (\"Error: something fail on ARP configuration step\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n\r\
    \n        :local state (\"Adding CAPs ACL static entries for (\$newBlockedIp/\$newMac)\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        /caps-man access-list remove [find mac-address=\$newMac];\r\
    \n        /caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=\$comment disabled=no mac-address=\$newMac ssid-regexp=\$ssid place-before=1\r\
    \n\r\
    \n    } on-error={\r\
    \n\r\
    \n        :local state (\"Error: something fail on CAPS configuration step\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n\r\
    \n    }\r\
    \n\r\
    \n    :return true;\r\
    \n\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n\r\
    \n#Example call\r\
    \n#\$globalNewClientCert argClients=\"alx.iphone.rw.2021, alx.mini.rw.2021\" argUsage=\"tls-client,digital-signature,key-encipherment\"\r\
    \n#\$globalNewClientCert argClients=\"182.13.148.14\" argUsage=\"tls-server\" argBindAsIP=\"any\"\r\
    \n:if (!any \$globalNewClientCert) do={\r\
    \n  :global globalNewClientCert do={\r\
    \n\r\
    \n    # generates IPSEC certs CLIENT TEMPLATE, then requests SCEP to sign it\r\
    \n    # This script is a SCEP-client, it request the server to provide a new certificate\r\
    \n    # it ONLY form the request via API to remote SCEP server\r\
    \n\r\
    \n    # incoming named params\r\
    \n    :local clients [ :tostr \$argClients ];\r\
    \n    :local prefs  [ :tostr \$argUsage ];\r\
    \n    :local asIp  \$argBindAsIP ;\r\
    \n\r\
    \n    # scope global functions\r\
    \n    :global globalNoteMe;\r\
    \n    :global globalScriptBeforeRun;\r\
    \n\r\
    \n    :if ([:len \$clients] > 0) do={\r\
    \n      :if ([ :typeof [ :tostr \$clients ] ] != \"str\" ) do={\r\
    \n\r\
    \n          :local state (\"Error: bad 'cients' parameter passed - (\$clients)\");\r\
    \n          \$globalNoteMe value=\$state;\r\
    \n          :return false;\r\
    \n\r\
    \n      }\r\
    \n    } else={\r\
    \n\r\
    \n        :local state (\"Error: bad 'cients' parameter passed - (\$clients\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n\r\
    \n      #clients\r\
    \n      :local IDs [:toarray \"\$clients\"];\r\
    \n      :local fakeDomain \"myvpn.fake.org\"\r\
    \n      :local scepAlias \"CHR\"\r\
    \n      :local sysver [/system package get system version]\r\
    \n      :local state (\"Started requests generation\");\r\
    \n\r\
    \n      \$globalNoteMe value=\$state;\r\
    \n\r\
    \n      ## this fields should be empty IPSEC/ike2/RSA to work, i can't get it functional with filled fields\r\
    \n      :local COUNTRY \"RU\"\r\
    \n      :local STATE \"MSC\"\r\
    \n      :local LOC \"Moscow\"\r\
    \n      :local ORG \"IKEv2 Home\"\r\
    \n      :local OU \"IKEv2 Mikrotik\"\r\
    \n\r\
    \n      # :local COUNTRY \"\"\r\
    \n      # :local STATE \"\"\r\
    \n      # :local LOC \"\"\r\
    \n      # :local ORG \"\"\r\
    \n      # :local OU \"\"\r\
    \n\r\
    \n\r\
    \n      :local KEYSIZE \"2048\"\r\
    \n      :local USERNAME \"mikrouter\"\r\
    \n\r\
    \n      :local scepUrl \"http://185.13.148.14/scep/grant\";\r\
    \n      :local itsOk true;\r\
    \n\r\
    \n      :local tname \"\";\r\
    \n      :foreach USERNAME in=\$IDs do={\r\
    \n\r\
    \n        ## create a client certificate (that will be just a template while not signed)\r\
    \n        :if (  [:len \$asIp ] > 0 ) do={\r\
    \n\r\
    \n                :local state \"CLIENT TEMPLATE certificates generation as IP...  \$USERNAME\";\r\
    \n                \$globalNoteMe value=\$state;\r\
    \n\r\
    \n                :set tname \"S.\$USERNAME@\$scepAlias\";\r\
    \n\r\
    \n                /certificate add name=\"\$tname\" common-name=\"\$USERNAME@\$scepAlias\" subject-alt-name=\"IP:\$USERNAME,DNS:\$fakeDomain\" key-usage=\$prefs country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365;\r\
    \n\r\
    \n            } else={\r\
    \n\r\
    \n                :local state \"CLIENT TEMPLATE certificates generation as EMAIL...  \$USERNAME\";\r\
    \n                \$globalNoteMe value=\$state;\r\
    \n\r\
    \n                :set tname \"C.\$USERNAME@\$scepAlias\";\r\
    \n\r\
    \n                /certificate add name=\"\$tname\" common-name=\"\$USERNAME@\$scepAlias\" subject-alt-name=\"email:\$USERNAME@\$fakeDomain\" key-usage=\$prefs  country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365\r\
    \n\r\
    \n            }\r\
    \n\r\
    \n        :local state \"Pushing sign request...\";\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        /certificate add-scep template=\"\$tname\" scep-url=\"\$scepUrl\";\r\
    \n\r\
    \n        :delay 6s\r\
    \n\r\
    \n        ## we now have to wait while on remote [mikrotik] this request will be granted and pushed back ready-to-use certificate\r\
    \n        :local state \"We now have to wait while on remote [mikrotik] this request will be granted and pushed back ready-to-use certificate... \";\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n\r\
    \n        :local state \"Proceed to remote SCEP please, find this request and appove it. I'll wait 30 seconds\";\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n\r\
    \n        :delay 30s\r\
    \n\r\
    \n        :local baseLength 5;\r\
    \n        :for j from=1 to=\$baseLength do={\r\
    \n          :if ([ :len [ /certificate find where status=\"idle\" name=\"\$tname\" ] ] > 0) do={\r\
    \n\r\
    \n            :local state \"Got it at last. Exporting to file\";\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n\r\
    \n            /certificate set trusted=yes \"\$tname\"\r\
    \n\r\
    \n            ## export the CA, client certificate, and private key\r\
    \n            /certificate export-certificate \"\$tname\" export-passphrase=\"1234567890\" type=pkcs12\r\
    \n\r\
    \n            :return true;\r\
    \n\r\
    \n          } else={\r\
    \n\r\
    \n            :local state \"Waiting for mikrotik to download the certificate...\";\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n            :delay 8s\r\
    \n\r\
    \n          };\r\
    \n        }\r\
    \n      };\r\
    \n\r\
    \n      :return false;\r\
    \n\r\
    \n    } on-error={\r\
    \n\r\
    \n        :local state (\"Error: something fail on SCEP certifcates issuing step\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n\r\
    \n:if (!any \$globalCallFetch) do={\r\
    \n  :global globalCallFetch do={\r\
    \n\r\
    \n    # this one calls Fetch and catches its errors\r\
    \n    :global globalNoteMe;\r\
    \n    :if ([:len \$1] > 0) do={\r\
    \n\r\
    \n        # something like \"/tool fetch address=nas.home port=21 src-path=scripts/doSwitchDoHOn.rsc.txt user=git password=git dst-path=/REPO/doSwitchDoHOn.rsc.txt mode=ftp upload=yes\"\r\
    \n        :local fetchCmd \"\$1\";\r\
    \n\r\
    \n        :local state \"I'm now putting: \$fetchCmd\";\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n\r\
    \n        /file remove [find where name=\"fetch.log.txt\"]\r\
    \n        {\r\
    \n            :local jobid [:execute file=fetch.log.txt script=\$fetchCmd]\r\
    \n\r\
    \n            :local state \"Waiting the end of process for file fetch.log to be ready, max 20 seconds...\";\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n\r\
    \n            :global Gltesec 0\r\
    \n            :while (([:len [/sys script job find where .id=\$jobid]] = 1) && (\$Gltesec < 20)) do={\r\
    \n                :set Gltesec (\$Gltesec + 1)\r\
    \n                :delay 1s\r\
    \n\r\
    \n                :local state \"waiting... \$Gltesec\";\r\
    \n                \$globalNoteMe value=\$state;\r\
    \n\r\
    \n            }\r\
    \n\r\
    \n            :local state \"Done. Elapsed Seconds: \$Gltesec\\r\\n\";\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n\r\
    \n            :if ([:len [/file find where name=\"fetch.log.txt\"]] = 1) do={\r\
    \n                :local filecontent [/file get [/file find where name=\"fetch.log.txt\"] contents]\r\
    \n                :put \"Result of Fetch:\\r\\n****************************\\r\\n\$filecontent\\r\\n****************************\"\r\
    \n            } else={\r\
    \n                :put \"File not created.\"\r\
    \n            }\r\
    \n        }\r\
    \n    }\r\
    \n  }\r\
    \n}\r\
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
    \n    :local cmd \"/queue simple add target=\$dhcpIp comment=\$qComment queue=default/default total-queue=default\"\r\
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
    \n        :set state \"Uploading \$buFile to FTP (\$FTPRoot\$buFile)\"\r\
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
    \n            :set state \"Uploading \$buFile to FTP (RAW, \$FTPRawGitName)\"\r\
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
    \n        :set state \"Uploading \$buFile to SMTP\"\r\
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
/system script add comment="Periodically renews password for some user accounts and sends a email" dont-require-permissions=yes name=doRandomGen owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n:if ( [/ip firewall address-list find list~\"alist-nat-external-ip\" ] = \"\") do={\r\
    \n        :put \"reserve password generator Script: cant fine ext wan ip address\"\r\
    \n        :log warning \"reserve password generator Script: cant find ext wan ip address\"\r\
    \n        } else={\r\
    \n            :foreach j in=[/ip firewall address-list find list~\"alist-nat-external-ip\"] do={\r\
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
    \n:global globalCallFetch;\r\
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
    \n          \r\
    \n          :local fetchCmd \"/tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\$dst mode=ftp upload=yes\";\r\
    \n        \r\
    \n          \$globalCallFetch \$fetchCmd;\r\
    \n\r\
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
    \n:local UpdateList [:toarray \"doBackup,doEnvironmentSetup,doEnvironmentClearance,doRandomGen,doFreshTheScripts,doCertificatesIssuing,doNetwatchHost, doIPSECPunch,doStartupScript,doHeatFlag,doPeriodicLogDump,doPeriodicLogParse,doTelegramNotify,doLEDoff,doLEDon,doCPUHighLoadReboot,doUpdatePoliciesRemotely,doUpdateExternalDNS\"];\r\
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
/system script add comment="Uses INFLUX DB http/rest api to push some stats to" dont-require-permissions=yes name=doPushStatsToInfluxDB owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doPushStatsToInfluxDB\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n#a part of queue comment to locate queues to be processed\r\
    \n:local queueCommentMark \"dtq\";\r\
    \n\r\
    \n#influxDB service URL (beware about port when /fetch)\r\
    \n:local tURL \"http://nas.home/api/v2/write\\\?bucket=httpapi&org=home\"\r\
    \n:local tPingURL \"http://nas.home/ping\"\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n\r\
    \n\r\
    \n:local useBandwidthTest false;\r\
    \n\r\
    \n:local state \"\";\r\
    \n\r\
    \n:do {\r\
    \n\r\
    \n  :set state (\"Checking if INFLUXDB Service online\");\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  :local result [/tool fetch http-method=get port=8086 user=\"mikrotik\" password=\"mikrotik\" mode=http url=\"\$tPingURL\"  as-value output=user];\r\
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
    \n\r\
    \n:local state \"\";\r\
    \n\r\
    \n:local authHeader (\"Authorization: Token nh-mJylW1FCluBlUGXYZq_s5zne_QjzkHcc56y8v6AIlUOOiOm4bU2652r2Vkv3Vp6WzgQT7WPsi4yF0RvdElg==\"); \r\
    \n\r\
    \n\r\
    \n:if ( \$useBandwidthTest  ) do={\r\
    \n\r\
    \n:local txAvg 0\r\
    \n:local rxAvg 0\r\
    \n\r\
    \n:local btServer 192.168.97.1;\r\
    \n\r\
    \n:set state (\"Starting VPN bandwidth test\");\r\
    \n\$globalNoteMe value=\$state;\r\
    \n\r\
    \ntool bandwidth-test protocol=tcp direction=transmit user=btest password=btest address=\$btServer duration=15s do={\r\
    \n:set txAvg (\$\"tx-total-average\" / 1048576 );\r\
    \n}\r\
    \n\r\
    \ntool bandwidth-test protocol=tcp direction=receive user=btest password=btest address=\$btServer duration=15s do={\r\
    \n:set rxAvg (\$\"rx-total-average\" / 1048576 );\r\
    \n}\r\
    \n\r\
    \n:global globalCallFetch;\r\
    \n:local fetchCmd  \"/tool fetch http-method=post port=8086 mode=http url=\\\"\$tURL\\\" http-header-field=\\\"\$authHeader, content-type: text/plain\\\" http-data=\\\"bandwidth,host=\$sysname,target=CHR transmit=\$txAvg,recieve=\$rxAvg\\\" keep-result=no\";\r\
    \n\r\
    \n\$globalCallFetch \$fetchCmd;\r\
    \n\r\
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
    \n     \$globalNoteMe value=\$state;\r\
    \n      /tool fetch http-method=post port=8086 mode=http url=\"\$tURL\" http-header-field=\"\$authHeader, content-type: text/plain\" http-data=\"traffic,host=\$sysname,target=\$hostName upload=\$upload,download=\$download\" keep-result=no;\r\
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
    \n  :local scriptName \"flash/ca@CHR.p12\"\r\r\
    \n\r\r\
    \n  :if ([:len [/file find name=\$scriptName]] > 0) do={\r\r\
    \n  /certificate import file-name=\$scriptName passphrase=1234567890\r\r\
    \n  /certificate set [find common-name=ca@CHR] name=ca@CHR\r\r\
    \n  }\r\r\
    \n  \r\r\
    \n  :local scriptName \"flash/mikrouter@CHR.p12\"\r\r\
    \n  :if ([:len [/file find name=\$scriptName]] > 0) do={\r\r\
    \n  /certificate import file-name=\$scriptName passphrase=1234567890\r\r\
    \n  /certificate set [find common-name=mikrouter@CHR] name=mikrouter@CHR\r\r\
    \n  }\r\
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
/system script add comment="A server-side script, that is called via global function using ssh-exec from another mikrotik-client to update it's IPSEC policy IP address" dont-require-permissions=yes name=doUpdatePoliciesRemotely owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doUpdatePoliciesRemotely\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n:local state \"\";\r\
    \n\r\
    \n# variables should be set before via remote SSH call\r\
    \n:global globalRemoteIp;\r\
    \n:global globalPolicyComment;\r\
    \n\r\
    \n\r\
    \n:do {\r\
    \n    :if ([:len \$globalRemoteIp] > 0) do={\r\
    \n\r\
    \n    :local peerID \$globalPolicyComment;\r\
    \n\r\
    \n    /ip ipsec policy {\r\
    \n        :foreach vpnEndpoint in=[find (!disabled and template and comment=\"\$peerID\")] do={\r\
    \n        \r\
    \n            :local dstIp;\r\
    \n            :set dstIp [get value-name=dst-address \$vpnEndpoint];\r\
    \n\r\
    \n            :if ((\$itsOk) and (\$globalRemoteIp != \$dstIp )) do={\r\
    \n\r\
    \n                [set \$vpnEndpoint disabled=yes];\r\
    \n\r\
    \n                :set state \"IPSEC policy template found with wrong IP (\$dstIp). Going change it to (\$globalRemoteIp)\";\r\
    \n                \$globalNoteMe value=\$state;\r\
    \n\r\
    \n                /ip ipsec peer {\r\
    \n                    :foreach thePeer in=[find name=\$peerID] do={\r\
    \n\r\
    \n                        :if (\$itsOk) do={\r\
    \n\r\
    \n                            :set state \"Setting up peer remote address..\"\r\
    \n                            \$globalNoteMe value=\$state;\r\
    \n\r\
    \n                            [set \$thePeer disabled=yes];\r\
    \n\r\
    \n                            :delay 5;\r\
    \n\r\
    \n                            [set \$thePeer disabled=no address=\$globalRemoteIp];\r\
    \n\r\
    \n                          \r\
    \n                        }\r\
    \n\r\
    \n                    }\r\
    \n\r\
    \n                }\r\
    \n\r\
    \n                :delay 5;\r\
    \n                \r\
    \n                [set \$vpnEndpoint dst-address=\$globalRemoteIp disabled=no];\r\
    \n\r\
    \n            }\r\
    \n\r\
    \n        }\r\
    \n\r\
    \n    }\r\
    \n    \r\
    \n    }\r\
    \n} on-error= {\r\
    \n    :local state (\"globalIPSECPolicyUpdateViaSSH error\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n    :set itsOk false;\r\
    \n};\r\
    \n\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n  :set inf \"\$scriptname on \$sysname: policies refreshed Successfully\"\r\
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
/system script add comment="This script is a SCEP-client, it request the server to ptovide a new certificate" dont-require-permissions=yes name=doSCEPClientCertificatesIssuing owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n# generates IPSEC certs CLIENT TEMPLATE, then requests SCEP to sign it\r\
    \n\r\
    \n#clients\r\
    \n:local IDs [:toarray \"alx.iphone.rw.2021\"];\r\
    \n:local fakeDomain \"myvpn.fake.org\"\r\
    \n\r\
    \n:local scepAlias \"CHR\"\r\
    \n:local sysver [/system package get system version]\r\
    \n:local scriptname \"doSCEPClientCertificatesIssuing\"\r\
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
    \n:local USERNAME \"anna\"\r\
    \n\r\
    \n:local scepUrl \"http://185.13.148.14/scep/grant\";\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n  \r\
    \n  :foreach USERNAME in=\$IDs do={\r\
    \n\r\
    \n    :local state \"CLIENT TEMPLATE certificates generation...  \$USERNAME\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    ## create a client certificate (that will be just a template while not signed)\r\
    \n    /certificate add name=\"\$USERNAME@\$scepAlias\" common-name=\"\$USERNAME@\$scepAlias\" subject-alt-name=\"email:\$USERNAME@\$fakeDomain\" key-usage=tls-client country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365 \r\
    \n\r\
    \n    :local state \"Pushing sign request...\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    /certificate add-scep template=\"\$USERNAME@\$scepAlias\" scep-url=\"\$scepUrl\"; \r\
    \n\r\
    \n    :delay 6s\r\
    \n\r\
    \n   ## we now have to wait while on remote [mikrotik] this request will be granted and pushed back ready-to-use certificate\r\
    \n\r\
    \n    :local state \"We now have to wait while on remote [mikrotik] this request will be granted and pushed back ready-to-use certificate... Proceed to remote SCEP please\";\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n  };\r\
    \n\r\
    \n} on-error={\r\
    \n\r\
    \n  :local state \"Certificates generation script FAILED\";\r\
    \n  \$globalNoteMe value=\$state;\r\
    \n\r\
    \n};"
/system script add dont-require-permissions=yes name=doSwitchDoHOn owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":do {\r\
    \n    :do {/tool fetch https://cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem check-certificate=no} \\\r\
    \n        while=([/file print count-only where name=\"DigiCertGlobalRootCA.crt.pem\"]=0);\r\
    \n    :do {/certificate import file-name=\"DigiCertGlobalRootCA.crt.pem\" passphrase=\"\" name=\"DigiCertGlobalRootCA.crt.pem\"} \\\r\
    \n        while=([/certificate print count-only where name=\"DigiCertGlobalRootCA.crt.pem\"]=0);\r\
    \n    :do {\r\
    \n        # Change DNS servers\r\
    \n        /ip dns set servers=\r\
    \n        /ip dns set use-doh-server=\"https://1.1.1.1/dns-query\" verify-doh-cert=yes\r\
    \n\r\
    \n        # Transparent proxy all DNS queries from your LAN through your router towards DoH servers / put this rule on top\r\
    \n        :do {/ip firewall nat add chain=dstnat protocol=udp dst-port=53 in-interface-list=LAN action=redirect} \\\r\
    \n            if=([/ip dns get allow-remote-requests]=yes)\r\
    \n    } while=([/certificate print count-only where fingerprint=\"4348a0e9444c78cb265e058d5e8944b4d84f9662bd26db257f8934a443c70161\"]=0);\r\
    \n} if=([/certificate print count-only where name=\"DigiCertGlobalRootCA.crt.pem\"]=0);"
/system script add comment="STARTER SATELLITE" dont-require-permissions=no name=SATELLITEstart owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\
    \n# start SATELLITE Library functions for TLGRM by Serkov S.V. (Sertik) 24/04/2022 version 1.8\r\
    \n#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\
    \n\r\
    \n# user settings:\r\
    \n\r\
    \n:global Emoji \"%E2%9B%BA\";    # Router Emoji for Tele\r\
    \n:global botID \"bot798290125:AAE3gfeLKdtai3RPtnHRLbE8quNgAh7iC8M\";          # you Telegram`s bot  ID;\r\
    \n:global myChatID \"-1001798127067\";      # you Telegram`s chat ID;\r\
    \n:global ADMINPHONE;       # admin phone number;\r\
    \n:global ADMINMAIL \"ayugov@icloud.com\";       # admin e-mail;\r\
    \n:local callTLGRM  00:00:30;         # circulation script TLGRM period;\r\
    \n:global fMirror false;               # mirror command name changed;\r\
    \n:global broadCast false;           # broadCast flag;\r\
    \n:local SATSchedAdd true;         # add to Scheduler flag;\r\
    \n\r\
    \n:log info \"\"\r\
    \n:log warning \"Running the SETUP library SATELLITE v. 1.8 24-04-2022:\"\r\
    \n:log info \"\"\r\
    \n:local Trel do={:if ([:len \$0]!=0) do={\r\
    \n:beep frequency=1760 length=67ms; :delay 77ms; :beep frequency=2093 length=67ms; :delay 77ms; :beep frequency=2637 length=67ms; :delay 77ms; :beep frequency=3520 length=268ms; :delay 278ms;}}\r\
    \n\r\
    \n/system script run SATELLITE1; [\$Trel]\r\
    \n/system script run SATELLITE1ext; [\$Trel]\r\
    \n/system script run SATELLITE2; [\$Trel]\r\
    \n/system script run SATELLITE3; [\$Trel]\r\
    \n\r\
    \n:delay 1s\r\
    \n:beep frequency=600 length=165ms; :delay 165ms; :beep frequency=700 length=275ms; :delay 275ms; :beep frequency=800 length=275ms; :delay 275ms; :beep frequency=900 length=110ms; :delay 110ms;\r\
    \n\r\
    \n:global FuncTelegramSender\r\
    \n:global FuncSATLogo\r\
    \n:global FuncSATList\r\
    \n\r\
    \n[\$FuncSATLogo]\r\
    \n:do {\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\" Router \".\"\$[/system identity get name]\".\" Satellite Script Library 1.8 is running ...\")]\r\
    \n} on-error={}\r\
    \n\r\
    \n:if (\$SATSchedAdd) do={\r\
    \n:global FuncSchedScriptAdd\r\
    \n:local Date \"\"\r\
    \n\r\
    \n/system scheduler remove [find name~\"Run script TLGRMcall\"];\r\
    \n\r\
    \n:local ScriptAddTLGRM [\$FuncSchedScriptAdd TLGRMcall  \$Date startup \$callTLGRM];\r\
    \n:delay 1s;\r\
    \n:if (\$ScriptAddTLGRM=\"OK\") do={\r\
    \n:log info \"Polling TLGRM script scheduled OK\"\r\
    \n} else={:log error \$ScriptAddTLGRM}\r\
    \n}\r\
    \n\r\
    \n:put [\$FuncSATList]\r\
    \n\r\
    \n#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\
    \n\r\
    \n\r\
    \n# examples usage:\r\
    \n\r\
    \n# :log info [\$FuncStatus]\r\
    \n# :log info [\$FuncReport]\r\
    \n\r\
    \n# :log warning (\"\C7\E0\EF\E8\F1\E5\E9 \E2 address: \".\"\$[\$FuncAddress]\")\r\
    \n# :global FuncTelegramSender\r\
    \n# [\$FuncTelegramSender (\"\C7\E0\EF\E8\F1\E5\E9 \E2 address:\".\"\$[\$FuncAddress]\")]\r\
    \n\r\
    \n# [\$FuncBackup]\r\
    \n\r\
    \n# :log warning (\"\D1\EA\F0\E8\EF\F2\EE\E2 \E2 \F0\E5\EF\EE\E7\E8\F2\EE\F0\E8\E8: \".\"\$[\$FuncScriptList]\")\r\
    \n# :log warning (\"\D1\E5\E9\F7\E0\F1 \E0\EA\F2\E8\E2\ED\FB\F5 \F4\F3\ED\EA\F6\E8\E9 \E2 \EE\EA\F0\F3\E6\E5\ED\E8\E8 \".\"\$[\$FuncFuncList]\")\r\
    \n# :log warning (\"\C3\EB\EE\E1\E0\EB\FC\ED\FB\F5 \EF\E5\F0\E5\EC\E5\ED\ED\FB\F5 \".\"\$[\$FuncGlobalVarList]\")\r\
    \n\r\
    \n# :log warning [\$FuncVPN]\r\
    \n# :log warning [\$FuncVpnUser]\r\
    \n\r\
    \n# :put [\$FuncWifi]\r\
    \n# :log warning [\$FuncWifiAccess]\r\
    \n# :log warning [\$FuncWifiReg]\r\
    \n# :put [\$FuncWifiPass]\r\
    \n\r\
    \n# :log warning [\$FuncSATClear]"
/system script add comment="module 1 SATELLITE for TLGRM" dont-require-permissions=no name=SATELLITE1 owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#------------------------------------------------------------------------------------------------------------------------\r\
    \n# SATELLITE1 module  for TLGRM version 1.8 by Sertik (Serkov S.V.) 24/04/2022\r\
    \n#------------------------------------------------------------------------------------------------------------------------\r\
    \n\r\
    \n# declare functions:\r\
    \n\r\
    \n:global FuncSATLogo\r\
    \n:global FuncSATList\r\
    \n:global FuncArp\r\
    \n:global FuncAddress\r\
    \n:global FuncBackup\r\
    \n:global FuncLease\r\
    \n:global FuncReport \r\
    \n:global FuncStatus\r\
    \n:global FuncVPN \r\
    \n:global FuncVpnUser \r\
    \n:global FuncWifi \r\
    \n:global FuncWifiReg \r\
    \n:global FuncWifiAccess\r\
    \n:global FuncWifiPass\r\
    \n:global FuncScriptList\r\
    \n:global FuncFuncList\r\
    \n:global FuncSchedList\r\
    \n:global FuncGlobalVarList\r\
    \n\r\
    \n\r\
    \n# \E2\FB\E4\E0\F7\E0 \EB\EE\E3\EE\F2\E8\EF\E0 \E1\E8\E1\EB\E8\EE\F2\E5\EA\E8 \E2 \EB\EE\E3\r\
    \n#              FuncSATlogo\r\
    \n# ---------------------------------------------------------\r\
    \n\r\
    \n:set FuncSATLogo do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:log warning \"\";\r\
    \n:log warning \"#------------------------------------------------------------------------#\";\r\
    \n:log warning \"#                 Library SATELLITE for TLGRM\" ;\r\
    \n:log warning \"#   \C1\E8\E1\EB\E8\EE\F2\E5\EA\E0 \D1\CF\D3\D2\CD\C8\CA \E4\EB\FF \F1\EA\F0\E8\EF\F2\E0 TLGRM\";\r\
    \n:log warning \"#       by Serkov S.V. (Sertik) update 24/04/2022\";\r\
    \n:log warning \"#                                 version 1.8\"; \r\
    \n:log warning \"#------------------------------------------------------------------------#\";\r\
    \n:log warning \"\";\r\
    \n }\r\
    \n:return []}\r\
    \n\r\
    \n\r\
    \n# \EF\E5\F7\E0\F2\FC \F1\EF\E8\F1\EA\E0 \EA\EE\EC\E0\ED\E4-\F4\F3\ED\EA\F6\E8\E9 \E1\E8\E1\EB\E8\EE\F2\E5\EA\E8\r\
    \n#                FuncSATList \E2 \F7\E0\F2 \D2\E5\EB\E5\E3\F0\E0\EC\EC\r\
    \n# -----------------------------------------------------------------------\r\
    \n\r\
    \n:set FuncSATList do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n\r\
    \n# send list function SATELITE to Telegram\r\
    \nif ([:len \$1]=0) do={\r\
    \n:local arrayCom [:toarray {\"/FuncArp\"=\"\F1\EF\E8\F1\EE\EA arp\";\r\
    \n                                        \"/FuncAddress\"=\"\F1\EF\E8\F1\EE\EA /ip addresses\";\r\
    \n                                        \"/FuncBackup\"=\"\F0\E5\E7\E5\F0\E2\ED\EE\E5 \EA\EE\EF\E8\F0\EE\E2\E0\ED\E8\E5 \EA\EE\ED\F4\E8\E3\F3\F0\E0\F6\E8\E8 \F0\EE\F3\F2\E5\F0\E0\";\r\
    \n                                         \"/FuncLease\"=\"\F1\EF\E8\F1\EE\EA DHCP liase\";\r\
    \n                                         \"/FuncReport\"=\"\EE\F2\F7\E5\F2 \F1\F2\E0\F2\F3\F1\E0 \F0\EE\F3\F2\E5\F0\E0\";\r\
    \n                                         \"/FuncStatus\"=\"\EF\E0\F0\E0\EC\E5\F2\F0\FB \F1\E8\F1\F2\E5\EC\FB\";\r\
    \n                                         \"/FuncVpnUser\"=\"\ED\E0\F1\F2\F0\EE\E5\ED\ED\FB\E5 VPN-\EF\EE\EB\FC\E7\EE\E2\E0\F2\E5\EB\E8 \F1 \EF\E0\F0\EE\EB\FF\EC\E8\";\r\
    \n                                         \"/FuncVPN\"=\"\F1\E5\F0\E2\E5\F0\FB \E8 \EA\EB\E8\E5\ED\F2\FB VPN \F0\EE\F3\F2\E5\F0\E0\";\r\
    \n                                          \"/FuncWifi\"=\"wifi-\E8\ED\F2\E5\F0\F4\E5\E9\F1\FB \F0\EE\F3\F2\E5\F0\E0\";\r\
    \n                                          \"/FuncWifiReg\"=\"\E7\E0\F0\E5\E3\E8\F1\F2\F0\E8\F0\EE\E2\E0\ED\ED\FB\E5 \E2 \F1\E5\F2\E8 wifi-\EF\EE\EB\FC\E7\EE\E2\E0\F2\E5\EB\E8\";\r\
    \n                                          \"/FuncWifiAccess\"=\"\F0\E0\E7\F0\E5\F8\E5\ED\ED\FB\E5 wifi-\EF\EE\EB\FC\E7\EE\E2\E0\F2\E5\EB\E8\";\r\
    \n                                          \"/FuncWifiConnect\"=\"wifi-\EA\EB\E8\E5\ED\F2\F1\EA\E8\E5 \F1\F2\E0\ED\F6\E8\E8\";\r\
    \n                                          \"/FuncWifiPass\"=\"\EF\E0\F0\EE\EB\E8 wifi-\F1\E5\F2\E8/\E5\E9\";\r\
    \n                                          \"/FuncHealth\"=\"\EE\F2\F7\B8\F2 \EE \E7\E4\EE\F0\EE\E2\FC\E5 \F0\EE\F3\F2\E5\F0\E0\"\r\
    \n                                          \"/FuncDHCPclient\"=\"\F0\EE\F3\F2\E5\F0-\EA\EB\E8\E5\ED\F2 DHCP\";\r\
    \n                                          \"/FuncUsers\"=\"\EF\EE\EB\FC\E7\EE\E2\E0\F2\E5\EB\E8 \F0\EE\F3\F2\E5\F0\E0 \E8 \EF\E0\F0\EE\EB\E8\";\r\
    \n                                           \"/FuncScriptList\"=\"\F1\EF\E8\F1\EE\EA \F1\EA\F0\E8\EF\F2\EE\E2 \F0\EE\F3\F2\E5\F0\E0 \F1 \EA\EE\EC\EC\E5\F2\E0\F0\E8\FF\EC\E8\";\r\
    \n                                           \"/FuncLog\"=\"\E2\FB\E4\E0\F2\FC \F1\F2\F0\EE\EA\E8 \EB\EE\E3\E0 \E2 \D2\E5\EB\E5\E3\F0\E0\EC\EC\";\r\
    \n                                           \"/FuncLogReset\"=\"\EE\F7\E8\F1\F2\EA\E0 \EB\EE\E3\E0\";\r\
    \n                                           \"/FuncPingPong\"=\"\EF\F0\EE\E2\E5\F0\EA\E0 \F5\EE\F1\F2\E0 \ED\E0 \EF\E8\ED\E3\";\r\
    \n                                           \"/FuncMail\"=\"\F4\F3\ED\EA\F6\E8\FF \EE\F2\EF\F0\E0\E2\EA\E8 \EF\EE\F7\F2\FB\";\r\
    \n                                           \"/FuncSMSsend\"=\"\EE\F2\EF\F0\E0\E2\EA\E0 SMS \F7\E5\F0\E5\E7 \EC\EE\E4\E5\EC \F0\EE\F3\F2\E5\F0\E0\";\r\
    \n                                           \"/FuncModemInfo\"=\"\EF\EE\E8\F1\EA \E8 \EE\F2\F7\B8\F2 \EC\EE\E4\E5\EC\EE\E2 \F0\EE\F3\F2\E5\F0\E0\";\r\
    \n                                           \"/FuncFuncList\"=\"\F1\EF\E8\F1\EE\EA \E0\EA\F2\E8\E2\ED\FB\F5 \F4\F3\ED\EA\F6\E8\E9 \E2 Environment\"; \r\
    \n                                           \"/FuncSchedList\"=\"\F1\EF\E8\F1\EE\EA \E7\E0\E4\E0\ED\E8\E9 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA\E0\"; \r\
    \n                                           \"/FuncGlobalVarList\"=\"\E3\EB\EE\E1\E0\EB\FC\ED\FB\E5 \EF\E5\F0\E5\EC\E5\ED\ED\FB\E5 \E8 \E8\F5 \E7\ED\E0\F7\E5\ED\E8\FF\"}]\r\
    \n;\r\
    \n:local count 0\r\
    \n:local TXTmessage \"\"\r\
    \n:foreach k,v in=\$arrayCom do={:set count (\$count+1);\r\
    \n:local command\r\
    \n:global fMirror\r\
    \n:if (\$fMirror) do={\r\
    \n:set command (\"/\".\"\$[:pick \$k 5 [:len \$k]]\")\r\
    \n:set TXTmessage (\"\$TXTmessage        \".\"\$count \".\"\$command  -  \$v\". \"%0A\")} else={ \r\
    \n:set TXTmessage (\"\$TXTmessage        \".\"\$count \".\"\$k  -  \$v\". \"%0A\")}}\r\
    \n[\$FuncTelegramSender (\"\$Emoji \". \"Router \$[system identity get name]\".\"  function complex SATELITE available for execution:\".\"%0A\".\"\$TXTmessage\")]\r\
    \n:return \$count }\r\
    \n\r\
    \n# send list special function to Telegram\r\
    \n:if (\$1=\"special\") do={\r\
    \n:local arraySpecial [:toarray {\"/FuncTelegramSender\"=\"\EE\F2\EF\F0\E0\E2\EA\E0 \F1\EE\EE\E1\F9\E5\ED\E8\E9 \E2 Telegram\";\r\
    \n                                                        \"/FuncSchedFuncAdd\"=\"\E4\EE\E1\E0\E2\EB\E5\ED\E8\E5 \F4\F3\ED\EA\F6\E8\E8-\E7\E0\E4\E0\ED\E8\FF \E2 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA\";\r\
    \n                                                        \"/FuncSchedScriptAdd\"=\"\E4\EE\E1\E0\E2\EB\E5\ED\E8\E5 \F1\EA\F0\E8\EF\F2\E0-\E7\E0\E4\E0\ED\E8\FF \E2 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA\";\r\
    \n                                                        \"/FuncSchedRemove\"=\"\F3\E4\E0\EB\E5\ED\E8\E5 \E7\E0\E4\E0\ED\E8\FF \E8\E7 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA\E0\";\r\
    \n                                                        \"/FuncEpochTime\"=\"\EF\F0\E5\EE\E1\F0\E0\E7\EE\E2\E0\ED\E8\E5 \E2\F0\E5\EC\E5\ED\E8 \E2 \DE\EB\E8\E0\ED\F1\EA\EE\E5\";\r\
    \n                                                        \"/FuncUnixTimeToFormat\"=\"\EF\F0\E5\EE\E1\F0\E0\E7\EE\E2\E0\ED\E8\E5 Unix-\E2\F0\E5\EC\E5\ED\E8 \E2 \EF\F0\E8\E2\FB\F7\ED\FB\E9 \F4\EE\F0\EC\E0\F2\";\r\
    \n                                                        \"/FuncSATClear\"=\"\E2\FB\E3\F0\F3\E7\E8\F2\FC \E1\E8\E1\EB\E8\EE\F2\E5\EA\F3 SATELLITE\"}]\r\
    \n;\r\
    \n:local count1 0\r\
    \n:local TXTmessage1 \"\"\r\
    \n\r\
    \n:foreach k,v in=\$arraySpecial do={:set count1 (\$count1+1);\r\
    \n:local command1 \r\
    \n:set TXTmessage1 (\"\$TXTmessage1        \".\"\$count1 \".\"\$k -  \$v\". \"%0A\")}\r\
    \n[\$FuncTelegramSender (\"\$Emoji \". \"Router \$[system identity get name]\".\"  special function complex SATELITE:\".\"%0A\".\"\$TXTmessage1\")]\r\
    \n:return \$count1}\r\
    \n\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n#\r\
    \n#   \CA\CE\CC\C0\CD\C4\DB \C1\C8\C1\CB\C8\CE\D2\C5\CA\C8 SATELLITE\r\
    \n#\r\
    \n\r\
    \n# arp tabl - > Telegram\r\
    \n# ----------------------------------\r\
    \n:set FuncArp do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:local TXTarp\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:local count 0\r\
    \n:local WS\r\
    \n:local TT\r\
    \nforeach i in=[ /ip arp find] do={\r\
    \n:local active [/ip arp get \$i disabled]\r\
    \n:if (\$active) do={:set WS \"enable\"; :set TT \"%F0%9F%94%B4\"} else={:set WS \"disable\"; :set TT \"%F0%9F%94%B5\"}\r\
    \n:local ipARPaddress [/ip arp get \$i address];\r\
    \n:local ipARPmacaddress [/ip arp get \$i mac];\r\
    \n:local ARPface [/ip arp get \$i interface];\r\
    \n:local ARPcomment [/ip arp get \$i comment];\r\
    \n:if ([:len \$ipARPmacaddress]!=0) do={:set count (\$count+1); :set \$TXTarp (\"\$TXTarp\".\"\$count \".\"\$TT \".\"\$ipARPaddress \".\" \$ipARPmacaddress \".\" \$ARPface \".\" \$ARPcomment\".\"%0A\")\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\" \$[/system identity get name]\".\" arp tabl:\".\"%0A\".\"\$TXTarp\")]\r\
    \n:return \$count\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# ip addresses tabl - > Telegram\r\
    \n# ---------------------------------------------\r\
    \n:set FuncAddress do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:local system [/system identity get name]\r\
    \n:local WS\r\
    \n:local listAL\r\
    \n:local TT\r\
    \n:local count 0\r\
    \n\r\
    \n:foreach AddrList in=[/ip address find true] do={\r\
    \n:local Aname [/ip address get \$AddrList]\r\
    \n:local Aadr (\$Aname->\"address\")\r\
    \n:local Acomment (\$Aname->\"comment\")\r\
    \n:local Anetwork (\$Aname->\"network\")\r\
    \n:local Aface (\$Aname->\"actual-interface\")\r\
    \n:local WsState [/ip address get \$AddrList disabled]\r\
    \n:if (\$WsState) do={:set WS \"enable\"; :set TT \"%F0%9F%94%B4\"} else={:set WS \"disable\"; :set TT \"%F0%9F%94%B5\"}\r\
    \n:set count (\$count+1)\r\
    \n:set listAL (\"\$listAL\".\"\$count\".\" \$TT\".\" \$Aadr\".\" \$Acomment\".\" \$Anetwork\".\" \$Aface\".\"%0A\")\r\
    \n}\r\
    \n\r\
    \n:if ([:len \$listAL]!=0) do={\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\" \$system\".\" /ip address :%0A\".\"\$listAL\")]\r\
    \n   }\r\
    \n :return \$count\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# backup  - > Telegram\r\
    \n# ----------------------------------\r\
    \n:set FuncBackup do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n# send or no send on E-mail\r\
    \n:local mailsend false\r\
    \n:global ADMINMAIL;  \r\
    \n:local mailBox \$ADMINMAIL;  \r\
    \n\r\
    \n:log warning \"Starting Backup Script...\";\r\
    \n:local sysname [/system identity get name];\r\
    \n:local sysver [/system package get system version];\r\
    \n:log info \"Flushing DNS cache...\";\r\
    \n/ip dns cache flush;\r\
    \n:delay 2;\r\
    \n:log info \"Deleting last Backups...\";\r\
    \n:foreach i in=[/file find] do={:if (([:typeof [:find [/file get \$i name] \\\r\
    \n\"\$sysname-backup-\"]]!=\"nil\") or ([:typeof [:find [/file get \$i name] \\\r\
    \n\"\$sysname-script-\"]]!=\"nil\")) do={/file remove \$i}};\r\
    \n:delay 2;\r\
    \n:local backupfile (\"\$sysname-backup-\" . \\\r\
    \n[:pick [/system clock get date] 7 11] . [:pick [/system \\\r\
    \nclock get date] 0 3] . [:pick [/system clock get date] 4 6] . \".backup\");\r\
    \n:log warning \"Creating new Full Backup file...\$backupfile\";\r\
    \n/system backup save name=\$backupfile;\r\
    \n:delay 5;\r\
    \n:local exportfile (\"\$sysname-backup-\" . \\\r\
    \n[:pick [/system clock get date] 7 11] . [:pick [/system \\\r\
    \nclock get date] 0 3] . [:pick [/system clock get date] 4 6] . \".rsc\");\r\
    \n:log warning \"Creating new Setup Script file...\$exportfile\";\r\
    \n/export verbose file=\$exportfile;\r\
    \n:delay 5;\r\
    \n:local scriptfile (\"\$sysname-script-\" . \\\r\
    \n[:pick [/system clock get date] 7 11] . [:pick [/system \\\r\
    \nclock get date] 0 3] . [:pick [/system clock get date] 4 6] . \".rsc\");\r\
    \n:log warning \"Creating new file export all scripts ...\$scriptfile\";\r\
    \n/system script export file=\$scriptfile;\r\
    \n:delay 2;\r\
    \n:log warning \"All System Backups and export all Scripts created successfully.\\nBackuping completed.\";\r\
    \n\r\
    \nif (\$mailsend) do={\r\
    \n:log warning \"Sending Setup Script file via E-mail...\";\r\
    \n:local smtpserv [:resolve \"smtp.mail.ru\"];\r\
    \n:local Eaccount [/tool e-mail get user];\r\
    \n:local pass [/tool e-mail get password];\r\
    \n/tool e-mail send from=\"<\$Eaccount>\" to=\$mailBox server=\$smtpserv \\\r\
    \nport=587 user=\$Eaccount password=\$pass start-tls=yes file=(\$backupfile, \$exportfile, \$scriptfile) \\\r\
    \nsubject=(\"\$sysname Setup Script Backup (\" . [/system clock get date] . \\\r\
    \n\")\") body=(\"\$sysname Setup Script file see in attachment.\\nRouterOS \\\r\
    \nversion: \$sysver\\nTime and Date stamp: \" . [/system clock get time] . \" \\\r\
    \n\" . [/system clock get date]);\r\
    \n:log warning \"Setup Script file e-mail send\";\r\
    \n:delay 5;\r\
    \n  }\r\
    \n:return \"backup is done\"\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# lease tabl - > Telegram\r\
    \n# -----------------------------------\r\
    \n:set FuncLease do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:local count 0\r\
    \n:local txt\r\
    \n/ip dhcp-server lease\r\
    \n:if [/ip dhcp-server lease find] do={\r\
    \n:foreach i in=[find] do={\r\
    \n  :set count (\$count+1)\r\
    \n  :local add [get \$i address]\r\
    \n  :local mac [get \$i mac-address]\r\
    \n  :local host [get \$i host]\r\
    \n  :local com [get \$i comment]\r\
    \n  :local serv [get \$i server]\r\
    \n  :local bond [get \$i status]\r\
    \n  :local active [get \$i disabled]\r\
    \n  :local TT; :local WS\r\
    \n:if (\$active) do={:set WS \"enable\"; :set TT \"%F0%9F%94%B4\"} else={:set WS \"disable\"; :set TT \"%F0%9F%94%B5\"}\r\
    \n# :log warning (\"\$count  \".\"\$host   \".\"\$serv \".\"   \$add  \".\"\$com\".\"  \$mac \".\" \$bond\")\r\
    \n:set txt (\"\$txt\".\"\$count  \".\"\$TT \".\"\$com  \".\"\$add  \".\"  \$mac\".\"%0A%20%20%20%20\".\"host: \$host \".\" server: \$serv\".\"  status: \$bond\".\"%0A\")\r\
    \n} \r\
    \n} else={:set txt \"       empty\"}\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\"\$[/system identity get name]\".\" DHCP lease tabl:\".\"%0A\".\"\$txt\")]\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# report router`s to Telegram\r\
    \n# -----------------------------------------\r\
    \n:set FuncReport do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global ADMINMAIL\r\
    \n:global FuncMail\r\
    \n:global ADMINPHONE\r\
    \n:global FuncSMSsend\r\
    \n\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:if (([:len \$1]=0) or (\$1=\"tlgrm\")) do={\r\
    \n:do {\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\" Router \".\"\$[/system identity get name]\".\" ONLINE\")]\r\
    \n} on-error={:return \"ERROR tlgrm send\"}\r\
    \n:return \"tlgrm\";}\r\
    \n:if (\$1=\"mail\") do={\r\
    \n:do {\r\
    \n[\$FuncMail Email=\$ADMINMAIL Mailtext=(\"Router \".\"\$[/system identity get name]\".\" ONLINE\")]\r\
    \n} on-error={:return \"ERROR email send\"}\r\
    \n:return \$1}\r\
    \n:if (\$1=\"sms\") do={\r\
    \n:do {\r\
    \n[\$FuncSMSsend (\"Router \".\"\$[/system identity get name]\".\" ONLINE\") \$ADMINPHONE]\r\
    \n# /system routerboard usb power-reset duration=2s;\r\
    \n} on-error={:return \"ERROR sms send\"}\r\
    \n:return \$1}\r\
    \n:if (\$1=\"all\") do={\r\
    \n:do {\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\" Router \".\"\$[/system identity get name]\".\" ONLINE\")]\r\
    \n[\$FuncMail Email=\$ADMINMAIL Mailtext=(\"Router \".\"\$[/system identity get name]\".\" ONLINE\")]\r\
    \n[\$FuncSMSsend (\"Router \".\"\$[/system identity get name]\".\" ONLINE\") \$ADMINPHONE]\r\
    \n} on-error={:return \"\$0 all send\"}\r\
    \n:return \$1}\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# all resurces - > Telegram\r\
    \n# --------------------------------------\r\
    \n:set FuncStatus do={\r\
    \n  :if ([:len \$0]!=0) do={\r\
    \n    :global Emoji;\r\
    \n    :global FuncTelegramSender\r\
    \n    :local systemName       [/system identity get name];\r\
    \n    :local uptime           [/system resource get uptime];\r\
    \n    :local FreeMemory       [/system resource get free-memory];\r\
    \n    :local TotalMemory      [/system resource get total-memory];\r\
    \n    :local cpu              [/system resource get cpu];\r\
    \n    :local cpuCount         [/system resource get cpu-count];\r\
    \n    :local cpuFrequency     [/system resource get cpu-frequency];\r\
    \n    :local cpuLoad          [/system resource get cpu-load];\r\
    \n    :local freeHdd          [/system resource get free-hdd-space];\r\
    \n    :local totalHdd         [/system resource get total-hdd-space];\r\
    \n    :local architectureName [/system resource get arch]\r\
    \n#  :local license          [/system license get level];\r\
    \n    :local boardName        [/system resource get board-name];\r\
    \n    :local version          [/system resource get version];\r\
    \n\r\
    \n:local TXT (\"\$Emoji \".\"\$systemName\".\" status:\".\"%0A\".\"Uptime: \".\"\$uptime\".\"%0A\".\"Free Memory: \".\"\$FreeMemory\".\" B\".\"%0A\".\"Total Memory: \".\"\$TotalMemory\".\" B\".\"%0A\".\"CPU \". \"\$cpu\".\"%0A\".\"CPU Count: \".\"\$cpuCount\".\"%0A\".\"CPU Frequency: \".\"\$cpuFrequency\".\"MHz\".\"%0A\".\"CPU Load: \".\"\$cpuLoad\".\"% \".\"%0A\".\"Free HDD Space \".\"\$freeHdd\".\" B \".\"%0A\".\"Total HDD Space: \".\"\$totalHdd\".\" B\".\"%0A\".\"Architecture: \".\"\$architectureName \".\"%0A\".\"License Level: \".\"\$license\".\"%0A\".\"Board Name:  \".\"\$boardName\".\" %0A\".\"Version: \". \"\$version\")\r\
    \n:do {\r\
    \n[\$FuncTelegramSender \$TXT]\r\
    \n} on-error={}\r\
    \n:return [];\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# function VPN-tonnel scanning & Telegram chat send\r\
    \n# used: [\$FuncTonnel \"tonnelType\"]\r\
    \n# for example: [\$FuncTonnel \"pptp-client\"]\r\
    \n\r\
    \n:set FuncVPN do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:local FuncTonnel do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:local system [/system identity get name]\r\
    \n:local count 0\r\
    \n:local Cto\r\
    \n:local listVpn\r\
    \n:foreach Vpn in=[[:parse \"[/interface \$1 find]\"]] do={\r\
    \n  :local TT \"%F0%9F%94%B5\"\r\
    \n  :local nameVpn [[:parse \"[/interface \$1 get \$Vpn name]\"]]\r\
    \n  :local commentVpn [[:parse \"[/interface \$1 get \$Vpn comment]\"]]\r\
    \n  :local typeVpn [:pick [/interface get \$nameVpn type] ([:find [/interface get \$nameVpn type] \"-\"]+1) [:len [/interface get \$nameVpn type]]]\r\
    \n  :if (\$typeVpn=\"out\") do={:set Cto (\"connect to \".\"\$[[:parse \"[/interface \$1 get \$nameVpn connect-to]\"]]\")} else={:set Cto \"\"}\r\
    \n  :local VpnState [[:parse \"[/interface \$1 monitor \$Vpn once as-value]\"]]\r\
    \n  :local cuVpnStatus (\$VpnState->\"status\")\r\
    \n  :local ladr (\$VpnState->\"local-address\")\r\
    \n  :local radr (\$VpnState->\"remote-address\")\r\
    \n  :local uptime (\$VpnState->\"uptime\")\r\
    \n\r\
    \n    :if (\$cuVpnStatus~\"terminating\") do={\r\
    \n    :set cuVpnStatus \"disabled\";  set TT \"\"\r\
    \n    }\r\
    \n    :if ([:typeof \$cuVpnStatus]=\"nothing\") do={\r\
    \n    :set cuVpnStatus \"disconnected\";  set TT \"%F0%9F%94%B4\"\r\
    \n    }\r\
    \n    :if (\$cuVpnStatus=\"disabled\") do={ :set TT \"%F0%9F%94%B3\"\r\
    \n    }\r\
    \n  :set count (\$count+1)\r\
    \n :if ((\$cuVpnStatus=\"disconnected\") or (\$cuVpnStatus=\"disabled\")) do={\r\
    \n  :set listVpn (\$listVpn.\"\".\$count. \" \".\$TT.\" \".\$nameVpn.\" \".\$commentVpn.\": \".\$cuVpnStatus.\"%0A\")\r\
    \n} else={:set listVpn (\"\$listVpn\".\"\$count\".\" \$TT\".\" \$nameVpn\".\" \$commentVpn:\".\" \$cuVpnStatus\".\" uptime: \".\"\$uptime\".\"%0A\".\"          \$Cto\".\" local-address: \".\"\$ladr\".\" remote-address: \".\"\$radr\".\"%0A\")}\r\
    \n}\r\
    \n:if ([:len \$listVpn]!=0) do={\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\" \$system\".\" \$1:%0A\".\"\$listVpn\")]\r\
    \n }\r\
    \n}\r\
    \n:return []}\r\
    \n\r\
    \n\r\
    \n# main block of the script\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n[\$FuncTelegramSender (\"<b>\".\"\$Emoji \".\" \$system\".\" --- VPN Interface Informer --- : </b> %0A %0A\") \"html\"]\r\
    \n:log info \"\"\r\
    \n:log warning (\"\$system\".\"VPN Interface Informer script is start up ... \")\r\
    \n\r\
    \n[\$FuncTonnel \"l2tp-client\"]\r\
    \n[\$FuncTonnel \"l2tp-server\"]\r\
    \n[\$FuncTonnel \"pptp-client\"]\r\
    \n[\$FuncTonnel \"pptp-server\"]\r\
    \n[\$FuncTonnel \"ovpn-client\"]\r\
    \n[\$FuncTonnel \"ovpn-server\"]\r\
    \n[\$FuncTonnel \"ppp-client\"]\r\
    \n[\$FuncTonnel \"ppp-server\"]\r\
    \n[\$FuncTonnel \"sstp-client\"]\r\
    \n[\$FuncTonnel \"sstp-server\"]\r\
    \n[\$FuncTonnel \"pppoe-client\"]\r\
    \n[\$FuncTonnel \"pppoe-server\"]\r\
    \n\r\
    \n:log warning \"VPN Interface Informer scanning is done and Telegram chat send\"\r\
    \n:return \"done\"\r\
    \n}}\r\
    \n\r\
    \n\r\
    \n# print vpnuser seckret & active vpn user`s - > Telegram\r\
    \n# \E2\E5\F0\F1\E8\FF 01.10.2021\r\
    \n# ------------------------------------------------------------\r\
    \n:set FuncVpnUser do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:local name;\r\
    \n:local enc;\r\
    \n:local addr;\r\
    \n:local ltu;\r\
    \n:local pass;\r\
    \n:local type;\r\
    \n:local vpnuser\r\
    \n:local vpnuserT\r\
    \n:local vpnuserL\r\
    \n:local vpnuserTlg\r\
    \n:local calc\r\
    \n:global ADMINPHONE\r\
    \n:global Emoji\r\
    \n\r\
    \n\r\
    \n#:log info \"\";\r\
    \n#:log warning \"\CD\E0\F1\F2\F0\EE\E5\ED\ED\FB\E5 VPN-\EF\EE\EB\FC\E7\EE\E2\E0\F2\E5\EB\E8:\"\r\
    \n\r\
    \n:foreach i in=[/ppp secret find] do={\r\
    \n:set name [/ppp secret get \$i name]; :set pass [/ppp secret get \$name password]; set type [/ppp secret get \$i service]\r\
    \n:set calc (\$calc+1); \r\
    \n# :log info (\"\$calc \".\"\$name\".\" [\".\" \$type\".\"]\".\" \$pass\");\r\
    \n:set vpnuser (\"\$vpnuser\".\"\$calc\".\"  \$name\".\"  <\".\" \$type \".\">\".\" \$pass\".\"%0A\");\r\
    \n}\r\
    \n\r\
    \n# :log warning \$calc; :log info \"\";\r\
    \n:do {\r\
    \n:global FuncTelegramSender; [\$FuncTelegramSender (\"\$Emoji \".\"* \$[/system identity get name]*\".\" VPN-users name, type and password set:\".\"%0A------------------------------------------------------------------------------------%0A\".\"\$vpnuser\") \"markdown\"]\r\
    \n} on-error={:log error \"Error send to Telegram message\"}\r\
    \n\r\
    \n:set vpnuser;\r\
    \n:set calc\r\
    \n\r\
    \n#:log info \"\";\r\
    \n#:log warning \"\CF\EE\E4\EA\EB\FE\F7\E5\ED\ED\FB\E5 VPN-\EF\EE\EB\FC\E7\EE\E2\E0\F2\E5\EB\E8:\"\r\
    \n\r\
    \n:foreach i in=[/ppp active find] do={\r\
    \n:set \$name [/ppp active get \$i name]; :set \$type [/ppp active get \$i service]; :set \$enc [/ppp active get \$i encoding]; :set \$addr [/ppp active get \$i address]; :set \$ltu [/ppp active get \$i uptime]\r\
    \n# :log info (\"\$name\".\" [\".\"\$type\".\"]\".\" \$enc\".\" \$addr\");\r\
    \n:set \$vpnuser (\"\$vpnuser\".\"\$name\".\"\\n\");\r\
    \n:set vpnuserTlg (\"\$vpnuserTlg\".\"\$name\".\"  {\".\"\$type\".\"}\".\" \$addr\". \" uptime: \$ltu\".\"%0A\");\r\
    \n}\r\
    \n\r\
    \n:set calc [:len [/ppp active find]]\r\
    \n\r\
    \ndo {\r\
    \n:local SMSdevice [/tool sms get port];\r\
    \n/tool sms send \$SMSdevice  phone=\$ADMINPHONE message=(\"active VPN-users \".\"\$calc\".\":\".\"\\n\".\"\$vpnuser\");\r\
    \n} on-error={:log error \"Error send SMS message\"}\r\
    \n\r\
    \ndo {\r\
    \n:global FuncTelegramSender;\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\"* \$[/system identity get name]*\".\" VPN-active\". \" \$calc\".\" users: \".\"%0A-----------------------------------------------------------------------%0A\".\"\$vpnuserTlg\") \"markdown\"]\r\
    \n} on-error={:log error \"Error send to Telegram message\"}\r\
    \n  :return \$calc\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# print wifi Interfaces, SSID and Band to Telegram\r\
    \n# \E2\E5\F0\F1\E8\FF 06.03.2022\r\
    \n# ----------------------------------------------\r\
    \n:set FuncWifi do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:local system [/system identity get name]\r\
    \n:local WS\r\
    \n:local listWS\r\
    \n:local logWS\r\
    \n:local TT\r\
    \n:local count 0\r\
    \n\r\
    \n:foreach wirelessClient in=[/interface wireless find true] do={\r\
    \n:local WsName [/interface get \$wirelessClient name]\r\
    \n:local WsComment [/interface get \$wirelessClient comment]\r\
    \n:local WsSID [/interface wireless get \$wirelessClient ssid] \r\
    \n:local WsBand [/interface wireless get \$wirelessClient band] \r\
    \n:local WsMode [/interface wireless get \$wirelessClient mode] \r\
    \n:local WsState (![/interface get \$wirelessClient disabled])\r\
    \n:local WsProf  [/interface wireless get \$wirelessClient security-profile]\r\
    \n:local Ws2Key [/interface wireless security-profiles get \$WsProf wpa2-pre-shared-key];\r\
    \n:if ([:len \$WsBand]=0) do={:set WsMode \"virtual wifi\"}\r\
    \n:if (\$WsState) do={:set WS \"enable\"; :set TT \"%F0%9F%94%B5\"} else={:set WS \"disable\"; :set TT \"%F0%9F%94%B4\"}\r\
    \n# :local WD [/interface monitor \$wirelessClient once as-value]\r\
    \n:set count (\$count+1)\r\
    \n:set listWS (\"\$listWS\".\"\$count\".\" \$TT\".\" \$WsName\".\" \$WsComment\".\" [ \$WsMode ]\".\" SSID:\".\" \$WsSID\".\" \$WsBand\".\"%0A\")\r\
    \n:set logWS (\"\$logWS\".\"\$count\".\" \$WsSID \".\"\$Ws2Key\".\"\\n\")\r\
    \n}\r\
    \n\r\
    \n:if ([:len \$listWS]!=0) do={\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\" \$system\".\" wifi interface and SSID:%0A\".\"\$listWS\")]\r\
    \n   }\r\
    \n :return \$logWS;\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# wifiaccess tabl to Telegram\r\
    \n# ------------------------------------------\r\
    \n:set FuncWifiAccess do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:local identity [/system identity get name]\r\
    \n:local count\r\
    \n:local output;\r\
    \n:foreach activeIndex in=[/interface wireless access find true] do={\r\
    \n      :set count (\$count+1);\r\
    \n              :local RegVal [/interface wireless access get \$activeIndex]\r\
    \n                :local iFace (\$RegVal->\"interface\")\r\
    \n                :local MACAddr (\$RegVal->\"mac-address\")\r\
    \n                :local comment (\$RegVal->\"comment\")\r\
    \n                :local time (\$RegVal->\"time\")\r\
    \n     :if (\$RegVal->\"disabled\") do={\r\
    \n             :set output (\"\$output\".\"\$count\".\" %F0%9F%94%B4 \".\" \$comment\".\" \$iFace\".\" \$MACAddr\".\" \$time\".\"%0A\");\r\
    \n} else={ :set output (\"\$output\".\"\$count\".\" %F0%9F%94%B7  \".\" \$comment\".\" \$iFace\".\" \$MACAddr\".\" \$time\".\"%0A\");}\r\
    \n\r\
    \n          }\r\
    \n\r\
    \nif ([:len \$output] >0) do={[\$FuncTelegramSender (\"\$Emoji\".\" *Router\".\" \$identity\".\" wireless access-tabl:*\".\"%0A\".\"-------------------------------------------------------------------------------------------------------------- \".\"%0A\".\"\$output\") \"markdown\"]\r\
    \n} else={[\$FuncTelegramSender (\"\$Emoji\".\" *Router\".\" \$identity\".\" wireless access-tabl is empty*\") \"markdown\"]}\r\
    \n  :return \$count;\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# wifi users registry tabl - > Telegram\r\
    \n# -----------------------------------------------------\r\
    \n:set FuncWifiReg do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji;\r\
    \n:global botID;\r\
    \n:global myChatID;\r\
    \n:global FuncTelegramSender\r\
    \n:local count\r\
    \n:local identity [/system identity get name];\r\
    \n\r\
    \n:local output;\r\
    \n:foreach activeIndex in=[/interface wireless registration-table find] do={\r\
    \n            :if ([:typeof \$activeIndex]!=\"nothing\") do={\r\
    \n                         :local WifiFace [/interface wireless registration-table get value-name=\"interface\" \$activeIndex];\r\
    \n                         :local WifiComment [/interface wireless registration-table get value-name=\"comment\" \$activeIndex];\r\
    \n                         :local activeMACAddr [/interface wireless registration-table get value-name=\"mac-address\" \$activeIndex];\r\
    \n                         :local activeIPadr [/interface wireless registration-table get value-name=\"last-ip\" \$activeIndex];\r\
    \n                         :local WSignal [/interface wireless registration-table get value-name=\"signal-strength\" \$activeIndex];\r\
    \n                         :set count (\$count+1)\r\
    \n                         :set output (\"\$output\".\"\$count\".\"  \$WifiFace\".\" \$activeMACAddr \".\"\$activeIPadr\".\" \$WifiComment\".\"%0A\".\"      signal strength: \".\"\$WSignal\".\"%0A\");\r\
    \n                  }\r\
    \n          }\r\
    \n\r\
    \nif ([:len \$output] >0) do={[\$FuncTelegramSender (\"\$Emoji\".\" <b>Router  \$identity wireless registration-tabl:</b>\".\"%0A\".\" \$output1\") \"html\"]\r\
    \n} else={[\$FuncTelegramSender (\"\$Emoji\".\" <b>Router  \$identity wireless registration-tabl: is empty</b>\") \"html\"]}\r\
    \n:return \$count;\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# wifi SSID & pass - > Telegram and SMS \$ADMINPHONE\r\
    \n# ---------------------------------------------------------------------------------\r\
    \n:set FuncWifiPass do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:global ADMINPHONE\r\
    \n:global FuncWifi\r\
    \n:local SMSmessage [\$FuncWifi]\r\
    \n:log warning (\"\\n\".\"Router \".\"\$[/system identity get name]\".\" wlan SSID and passwords:\".\"\\n\".\"\$SMSmessage\")\r\
    \ndo {\r\
    \n:local SMSdevice [/tool sms get port];\r\
    \n /tool sms send \$SMSdevice  phone=\$ADMINPHONE message=(\"Router \".\"\$[/system identity get name]\".\" wifi:\".\"\\n\".\"\$SMSmessage\")\r\
    \n} on-error={:log error \"Error send SMS message\"}\r\
    \n   :return [];\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# function FuncScriptList ->Telegram\r\
    \n# ---------------------------------------------------\r\
    \n:set FuncScriptList do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji; :global FuncTelegramSender; :global fMirror\r\
    \n:local ScriptArray [:toarray \"\"]; :local CommentArray [:toarray \"\"]\r\
    \n:local nlist 900\r\
    \n:local name\r\
    \n:local comment\r\
    \n:local count 0\r\
    \n\r\
    \n# seek all scripts\r\
    \n:foreach i in=[system script find] do={:set \$name [/system script get \$i name]; set comment [/system script get \$i comment]\r\
    \n:set (\$ScriptArray->\$count) \$name; :set (\$CommentArray->\$count) \$comment;:set count (\$count+1);}\r\
    \n:local a \"\"; :local b; :local c; :local d;\r\
    \n:local block 0\r\
    \n:for i from=0 to=([:len \$ScriptArray]-1) do={:set \$c (\"\$ScriptArray\"->\"\$i\"); :set \$d (\"\$CommentArray\"->\"\$i\");:set b (\$i+1)\r\
    \n:if (\$fMirror) do={:set a (\"\$a\".\"\$b \".\"/\".\"\$c\".\" \$d\".\"%0A\")} else={:set a (\"\$a\".\"\$b \".\"\$c\".\" \$d\".\"%0A\")}\r\
    \n# \EE\E4\E8\ED \E2\FB\E2\EE\E4 \EE\E3\F0\E0\ED\E8\F7\E5\ED \EA\EE\EB\E8\F7\E5\F1\F2\E2\EE\EC nlist \F1\E8\EC\E2\EE\EB\EE\E2;\r\
    \n:if ([:len \$a]>\$nlist) do={:set block (\$block+1);\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\"\$[/system identity get name] repository script list < \$block >:\".\"%0A%0A\".\"\$a\")]\r\
    \n:set a \"\";\r\
    \n  }\r\
    \n}\r\
    \n:set block (\$block+1)\r\
    \n# \"\E4\EE\EF\E5\F7\E0\F2\EA\E0\" \EF\EE\F1\EB\E5\E4\ED\E5\E3\EE \E1\EB\EE\EA\E0 \E4\E0\ED\ED\FB\F5\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\"\$[/system identity get name] repository script list: < \$block >\".\"%0A%0A\".\"\$a\")]\r\
    \n  :return [:len \$ScriptArray]\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# function FuncFuncList ->Telegram\r\
    \n# ---------------------------------------------------\r\
    \n:set FuncFuncList do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji; :global FuncTelegramSender; :global fMirror;\r\
    \n:local ScriptArray [:toarray \"\"];\r\
    \n:local ValArray [:toarray \"\"];\r\
    \n:local nlist 900\r\
    \n:local name\r\
    \n:local val\r\
    \n:local comment\r\
    \n:local count 0\r\
    \n\r\
    \n# seek all global\r\
    \n:foreach i in=[/system script environment find] do={:set \$name [/system script environment get \$i name]; \r\
    \n:if (([/system script environment get \$i value]=\"(code\") or  ([:len [:find [/system script environment get \$i value] \"(eval\"]]>0)) do={\r\
    \n:set (\$ScriptArray->\$count) \$name;\r\
    \n:set count (\$count+1);\r\
    \n}}\r\
    \n:local a \"\"; :local b 0; :local c;\r\
    \n:local block 0\r\
    \n:for i from=0 to=([:len \$ScriptArray]-1) do={:set \$c (\"\$ScriptArray\"->\"\$i\");\r\
    \n:if ([:len \$c]!=0) do={\r\
    \n:if (\$fMirror) do={:set b (\$b+1); :set a (\"\$a\".\" - \".\"\$b  \".\"/\".\"\$c \".\"%0A\")} else={\r\
    \n:set b (\$b+1); :set a (\"\$a\".\" - \".\"\$b  \".\"\$c \".\"%0A\")}\r\
    \n}\r\
    \n# \EE\E4\E8\ED \E2\FB\E2\EE\E4 \EE\E3\F0\E0\ED\E8\F7\E5\ED \EA\EE\EB\E8\F7\E5\F1\F2\E2\EE\EC nlist \F1\E8\EC\E2\EE\EB\EE\E2;\r\
    \n:if ([:len \$a]>\$nlist) do={:set block (\$block+1);\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\"\$[/system identity get name] repository environment active Functions list < \$block >:\".\"%0A%0A\".\"\$a\")]\r\
    \n:set a \"\";\r\
    \n  }\r\
    \n}\r\
    \n:set block (\$block+1)\r\
    \n# \"\E4\EE\EF\E5\F7\E0\F2\EA\E0\" \EF\EE\F1\EB\E5\E4\ED\E5\E3\EE \E1\EB\EE\EA\E0 \E4\E0\ED\ED\FB\F5\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\"\$[/system identity get name] repository environment active Functions list: < \$block >\".\"%0A%0A\".\"\$a\")]\r\
    \n     :return \$count;\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# function FuncSchedList ->Telegram\r\
    \n# ---------------------------------------------------\r\
    \n\r\
    \n:set FuncSchedList do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji; :global FuncTelegramSender;\r\
    \n:local ScriptArray [:toarray \"\"]; :local CommentArray [:toarray \"\"]; :local StartTimeArray [:toarray \"\"]; :local IntervalArray [:toarray \"\"]; local StatusArray [:toarray \"\"];\r\
    \n:local nlist 900\r\
    \n:local count 0\r\
    \n# seek all scheduler\r\
    \n:foreach i in=[system scheduler find] do={\r\
    \n:set (\$StatusArray->\$count) [/system scheduler get \$i disabled]\r\
    \n:set (\$ScriptArray->\$count) [/system scheduler get \$i name]\r\
    \n:set (\$CommentArray->\$count) [/system scheduler get \$i comment]\r\
    \n:set (\$StartTimeArray->\$count) [/system scheduler get \$i \"start-time\"]\r\
    \n:set (\$IntervalArray->\$count) [/system scheduler get \$i interval]\r\
    \n:set count (\$count+1);}\r\
    \n\r\
    \n:local a \"\"; :local e; :local b; :local c; :local d; :local t; local v\r\
    \n:local block 0\r\
    \n:for i from=0 to=([:len \$ScriptArray]-1) do={:set \$c (\"\$ScriptArray\"->\"\$i\"); :set \$d (\"\$CommentArray\"->\"\$i\"); set \$t (\"\$StartTimeArray\"->\"\$i\"); set \$v (\"\$IntervalArray\"->\"\$i\"); \r\
    \n:if (\$StatusArray->\"\$i\") do={:set e \"%F0%9F%94%B4\"} else={:set e \"%F0%9F%94%B7\"}\r\
    \n:set b (\$i+1);\r\
    \n:set a (\"\$a\".\" \$e\".\" \$b\".\" \$c\".\" \$d\".\" [ \$t ]\".\" [ \$v ]\".\"%0A\")\r\
    \n# \EE\E4\E8\ED \E2\FB\E2\EE\E4 \EE\E3\F0\E0\ED\E8\F7\E5\ED \EA\EE\EB\E8\F7\E5\F1\F2\E2\EE\EC nlist \F1\E8\EC\E2\EE\EB\EE\E2;\r\
    \n:if ([:len \$a]>\$nlist) do={:set block (\$block+1);\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\"\$[/system identity get name] scheduler list < \$block >:\".\"%0A%0A\".\"\$a\")]\r\
    \n:set a \"\";\r\
    \n  }\r\
    \n}\r\
    \n:set block (\$block+1)\r\
    \n# \"\E4\EE\EF\E5\F7\E0\F2\EA\E0\" \EF\EE\F1\EB\E5\E4\ED\E5\E3\EE \E1\EB\EE\EA\E0 \E4\E0\ED\ED\FB\F5\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\"\$[/system identity get name] scheduler list: < \$block >\".\"%0A%0A\".\"\$a\")]\r\
    \n  :return [:len \$ScriptArray]\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# function FuncGlobalVarList ->Telegram\r\
    \n# ---------------------------------------------------------\r\
    \n:set FuncGlobalVarList do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji; :global FuncTelegramSender;\r\
    \n:local ScriptArray [:toarray \"\"];\r\
    \n:local ValArray [:toarray \"\"];\r\
    \n:local nlist 900\r\
    \n:local name\r\
    \n:local val\r\
    \n:local comment\r\
    \n:local count 0\r\
    \n# seek all global\r\
    \n:foreach i in=[/system script environment find] do={:set \$name [/system script environment get \$i name]; \r\
    \n:if (([/system script environment get \$i value]!=\"(code\") and  ([:len [:find [/system script environment get \$i value] \"(eval\"]]!=1)) do={\r\
    \n:set \$val [/system script environment get \$i value];} else={:set val; set name}\r\
    \n:set (\$ScriptArray->\$count) \$name; :set (\$ValArray->\$count) \$val;\r\
    \n:set count (\$count+1);\r\
    \n}\r\
    \n:local a \"\"; :local b 0; :local c; :local d;\r\
    \n:local block 0\r\
    \n:for i from=0 to=([:len \$ScriptArray]-1) do={:set \$c (\"\$ScriptArray\"->\"\$i\"); :set \$d (\"\$ValArray\"->\"\$i\");\r\
    \n:if ([:len \$c]!=0) do={:set b (\$b+1)\r\
    \n:set a (\"\$a\".\" - \".\"\$b  \".\"\$c \".\"\$d\".\"%0A\")}\r\
    \n# \EE\E4\E8\ED \E2\FB\E2\EE\E4 \EE\E3\F0\E0\ED\E8\F7\E5\ED \EA\EE\EB\E8\F7\E5\F1\F2\E2\EE\EC nlist \F1\E8\EC\E2\EE\EB\EE\E2;\r\
    \n:if ([:len \$a]>\$nlist) do={:set block (\$block+1);\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\"\$[/system identity get name] repository environment Global var list < \$block >:\".\"%0A%0A\".\"\$a\")]\r\
    \n:set a \"\";\r\
    \n  }\r\
    \n}\r\
    \n:set block (\$block+1)\r\
    \n# \"\E4\EE\EF\E5\F7\E0\F2\EA\E0\" \EF\EE\F1\EB\E5\E4\ED\E5\E3\EE \E1\EB\EE\EA\E0 \E4\E0\ED\ED\FB\F5\r\
    \n[\$FuncTelegramSender (\"\$Emoji\".\"\$[/system identity get name] repository environment Global var list: < \$block >\".\"%0A%0A\".\"\$a\")]\r\
    \n         :return \$b;\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n:log info \"  -    SATELLITE1 module is set\"\r\
    \n\r\
    \n"
/system script add comment="module 2 SATELLITE for TLGRM" dont-require-permissions=no name=SATELLITE2 owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#------------------------------------------------------------------------------------------------------------------------\r\
    \n# SATELLITE2 module  for TLGRM version 1.8 by Sertik (Serkov S.V.) 24/04/2022\r\
    \n#------------------------------------------------------------------------------------------------------------------------\r\
    \n\r\
    \n\r\
    \n# declare functions:\r\
    \n:global FuncDHCPclient\r\
    \n:global FuncWifiConnect\r\
    \n:global FuncUsers\r\
    \n:global FuncLog\r\
    \n:global FuncLogReset\r\
    \n:global FuncPingPong\r\
    \n:global FuncPing\r\
    \n:global FuncMail\r\
    \n:global FuncSMSsend\r\
    \n:global FuncModemInfo\r\
    \n:global FuncSATMirror\r\
    \n:global FuncSATClear\r\
    \n\r\
    \n\r\
    \n\r\
    \n\r\
    \n# DHCP-clients -> Telegram\r\
    \n# ---------------------------------------\r\
    \n:set FuncDHCPclient do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:local count\r\
    \n:local output\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n\r\
    \n:foreach i in=[ip dhcp-client find] do={\r\
    \n:local cuStatus [ip dhcp-client get \$i status]\r\
    \n:local cuComment [ip dhcp-client get \$i comment]\r\
    \n:local cuIP [ip dhcp-client get \$i address]\r\
    \n:local cuGW [ip dhcp-client get \$i gateway]\r\
    \n:local cuFace [ip dhcp-client get \$i interface]\r\
    \n:local cuAddDroute [ip dhcp-client get \$i add-default-route]\r\
    \n:local cuDistance [ip dhcp-client get \$i \"default-route-distance\"]\r\
    \n:set count (\$count+1)\r\
    \n\r\
    \n:set output (\"\$output\".\"\$count \".\"\$cuComment \".\"\$cuFace \".\"IP: \".\"\$cuIP \".\"getway:\".\" \$cuGW \".\"distance\".\" \$cuDistance \".\"\$cuStatus\".\"%0A\")\r\
    \n\r\
    \n   }\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\"Router \".\"\$[/system identity get name] \".\"DHCP-clients table:\".\"%0A\".\"\$output\")]\r\
    \n:return \$count\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n#  wifi connect table -> Telegram \r\
    \n# ------------------------------------------------------------\r\
    \n:set FuncWifiConnect do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:local identity [/system identity get name]\r\
    \n:local count\r\
    \n:local output;\r\
    \n:foreach activeIndex in=[/interface wireless connect find true] do={\r\
    \n      :set count (\$count+1);\r\
    \n              :local ConVal [/interface wireless connect get \$activeIndex]\r\
    \n                :local iFace (\$ConVal->\"interface\")\r\
    \n                :local MACAddr (\$ConVal->\"mac-address\")\r\
    \n                :local comment (\$ConVal->\"comment\")\r\
    \n                :local connect (\$ConVal->\"connect\")\r\
    \n                :local area (\$ConVal->\"area-prefix\")\r\
    \n                :local signal (\$ConVal->\"signal-range\")\r\
    \n                :local SSID (\$ConVal->\"ssid\")\r\
    \n                :local WP (\$ConVal->\"wireless-protocol\")\r\
    \n     :if (\$ConVal->\"disabled\") do={\r\
    \n             :set output (\"\$output\".\"\$count\".\" %F0%9F%94%B4 \".\" \$comment\".\" \$iFace\".\" \$MACAddr\".\"%0A\");\r\
    \n} else={ :set output (\"\$output\".\"\$count\".\" %F0%9F%94%B7  \".\" \$comment\".\" \$iFace\".\" \$MACAddr\".\" \$connect\".\" \$area\".\" \$signal\".\" \$SSID\".\" \$WP\".\"%0A\");}\r\
    \n\r\
    \n#      :log warning (\"\$count  \".\" \$comment\".\" \$iFace\".\" \$MACAddr\".\" \$connect\".\" \$area\".\" \$signal\".\" \$SSID\".\" \$WP\".\"\\n\")\r\
    \n          }\r\
    \n\r\
    \nif ([:len \$output] >0) do={[\$FuncTelegramSender (\"\$Emoji\".\" *Router\".\" \$identity\".\" wireless connect-tabl:*\".\"%0A\".\"-------------------------------------------------------------------------------------------------------------- \".\"%0A\".\"\$output\") \"markdown\"]\r\
    \n} else={[\$FuncTelegramSender (\"\$Emoji\".\" *Router\".\" \$identity\".\" wireless connect-tabl is empty*\") \"markdown\"]}\r\
    \n   :return \$count;\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n#  Router`s user table -> Telegram \r\
    \n# ------------------------------------------------------------\r\
    \n:set FuncUsers do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:local identity [/system identity get name]\r\
    \n:local count\r\
    \n:local output\r\
    \n:local output1\r\
    \n:foreach i in=[/user find true] do={\r\
    \n      :set count (\$count+1);\r\
    \n                :local UserVal [/user get \$i]\r\
    \n                :local Uname (\$UserVal->\"name\")\r\
    \n                :local Ugroup (\$UserVal->\"group\")\r\
    \n                :local comment (\$UserVal->\"comment\")\r\
    \n                :local Ulogget (\$UserVal->\"last-logget-in\")\r\
    \n\r\
    \n     :if (\$UserVal->\"disabled\") do={\r\
    \n             :set output (\"\$output\".\"\$count\".\" %F0%9F%94%B4 \".\"\$comment \".\"\$Uname \".\"\$Ugroup\".\" \$time\".\"%0A\");\r\
    \n} else={ :set output (\"\$output\".\"\$count\".\" %F0%9F%94%B7  \".\"\$comment \".\"\$Uname \".\"\$Ugroup\".\" \$time\".\"%0A\");}\r\
    \n\r\
    \n          }\r\
    \n\r\
    \n:set count\r\
    \nforeach i in [/user active find true] do={\r\
    \n      :set count (\$count+1);\r\
    \n              :local UserVal [/user active get \$i]\r\
    \n                :local Uname (\$UserVal->\"name\")\r\
    \n                :local Via (\$UserVal->\"via\")\r\
    \n  :set output1 (\"\$output1\".\"\$count\".\" \$Uname \".\"\$Via\".\"%0A\");\r\
    \n\r\
    \n}\r\
    \n\r\
    \nif ([:len \$output] >0) do={[\$FuncTelegramSender (\"\$Emoji\".\" *Router\".\" \$identity\".\"  users:*\".\"%0A\".\"-------------------------------------------------------------------------------------------------------------- \".\"%0A\".\"\$output\") \"markdown\"]\r\
    \n}\r\
    \nif ([:len \$output1] >0) do={[\$FuncTelegramSender (\"\$Emoji\".\" *Router\".\" \$identity\".\" active users:*\".\"%0A\".\"-------------------------------------------------------------------------------------------------------------- \".\"%0A\".\"\$output1\") \"markdown\"]\r\
    \n} else={[\$FuncTelegramSender (\"\$Emoji\".\" *Router\".\" \$identity\".\" no active users*\") \"markdown\"]}\r\
    \n  :return \$count;\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# Routers modem info -> Telegram\r\
    \n\r\
    \n:global FuncModemInfo do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n\r\
    \n# lte-modems\r\
    \n:local lteinfo\r\
    \n:local LteModem [:toarray \"\"]\r\
    \n\r\
    \n:local pinstatus\r\
    \n:local registrationstatus \r\
    \n:local functionality\r\
    \n:local manufacturer \r\
    \n:local model \r\
    \n:local revision \r\
    \n:local currentoperator \r\
    \n:local lac \r\
    \n:local currentcellid \r\
    \n:local enbid \r\
    \n:local sectorid \r\
    \n:local phycellid\r\
    \n:local accesstechnology\r\
    \n:local sessionuptime\r\
    \n:local imei \r\
    \n:local imsi \r\
    \n:local uicc\r\
    \n:local earfcn\r\
    \n:local rsrp \r\
    \n:local rsrq\r\
    \n:local sinr\r\
    \n\r\
    \n:if ([/interface lte find]) do={\r\
    \n:foreach i in=[/interface lte find] do={\r\
    \n:local lteiFace [/interface lte get \$i name]\r\
    \n:local lteComment [/interface lte get \$i comment]\r\
    \nif ([/interface lte get \$i value-name=disabled] = false) do={\r\
    \n\r\
    \n:set LteModem [/interface lte info [find name=\$lteiFace] once as-value]\r\
    \n\r\
    \n:set pinstatus (\$LteModem->\"pin-status\");\r\
    \n:set registrationstatus (\$LteModem->\"registration-status\");\r\
    \n:set functionality (\$LteModem->\"functionality\");\r\
    \n:set manufacturer (\$LteModem->\"manufacturer\");\r\
    \n:set model (\$LteModem->\"model\");\r\
    \n:set revision (\$LteModem->\"revision\");\r\
    \n:set currentoperator (\$LteModem->\"current-operator\");\r\
    \n:set lac (\$LteModem->\"lac\");\r\
    \n:set currentcellid (\$LteModem->\"current-cellid\");\r\
    \n:set enbid (\$LteModem->\"enb-id\");\r\
    \n:set sectorid (\$LteModem->\"sector-id\");\r\
    \n:set phycellid (\$LteModem->\"phy-cellid\");\r\
    \n:set accesstechnology (\$LteModem->\"access-technology\");\r\
    \n:set sessionuptime (\$LteModem->\"session-uptime\");\r\
    \n:set imei (\$LteModem->\"imei\");\r\
    \n:set imsi (\$LteModem->\"imsi\");\r\
    \n:set uicc (\$LteModem->\"uicc\");\r\
    \n:set earfcn (\$LteModem->\"earfcn\");\r\
    \n:set rsrp (\$LteModem->\"rsrp\");\r\
    \n:set rsrq (\$LteModem->\"rsrq\");\r\
    \n:set sinr (\$LteModem->\"sinr\");\r\
    \n\r\
    \n:set lteinfo (\"%E2%9C%8C\".\" LTE-modem \".\"\$lteiFace  info:\".\"%0A\".\"\$pinstatus\".\"%0A\".\"\$registrationstatus\".\"%0A\".\"\$functionality\".\"%0A\".\"\$manufacturer\".\"%0A\".\"\$model\".\"%0A\".\"\$revision\".\"%0A\".\"\$currentoperator\".\"%0A\".\"\$lac\".\"%0A\".\"\$currentcellid\".\"%0A\".\"\$enbid\".\"%0A\".\"\$sectorid\".\"%0A\".\"\$phycellid\".\"%0A\".\"\$accesstechnology\".\"%0A\".\"\$sessionuptime\".\"%0A\".\"\$imei\".\"%0A\".\"\$imsi\".\"%0A\".\"\$uicc\".\"%0A\".\"\$earfcn\".\"%0A\".\"\$rsrp\".\"%0A\".\"\$rsrq\".\"%0A\".\"\$sinr\")\r\
    \n\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\"\$[/system identity get name]\".\" \$lteinfo\")]\r\
    \n\r\
    \n  } else={[\$FuncTelegramSender (\"\$Emoji \".\"\$[/system identity get name] \".\"LTE-interface \".\"\$lteiFace \".\"\$lteComment \".\"disabled\")]}\r\
    \n }\r\
    \n} else={[\$FuncTelegramSender (\"\$Emoji \".\"\$[/system identity get name] \".\"no found lte modem\")]}\r\
    \n\r\
    \n# modems ppp-client\r\
    \n:local nameFind [:toarray \"\"]\r\
    \n:local calc 0\r\
    \n:foreach i in=[/interface ppp-client find] do={\r\
    \n:set  calc (\$calc+1)\r\
    \nif ([/interface ppp-client get \$i value-name=disabled] = false) do={\r\
    \n:local tmp [/interface ppp-client info \$i once as-value]\r\
    \n:set \$nameFind (\$nameFind, {{\"name\"=[/interface ppp-client get \$i value-name=name]; \"comment\"=[/interface ppp-client get \$i comment]; \"type\"=\"ppp-client\";\"manufacturer\"=(\$tmp->\"manufacturer\");\"model\"=(\$tmp->\"model\");\"revision\"=(\$tmp->\"revision\")}})\r\
    \n  } else={[\$FuncTelegramSender (\"\$Emoji \".\"\$[/system identity get name] \".\"ppp-client modem \".\"\$[/interface ppp-client get \$i name] \".\"\$[/interface ppp-client get \$i comment] \".\"disabled\")]}\r\
    \n}\r\
    \n\r\
    \n:if ([:len \$nameFind]!= 0) do={\r\
    \n:local mName\r\
    \n:local mType\r\
    \n:local mComment\r\
    \n:for i from=0 to ([:len \$nameFind]-1) do={\r\
    \n:set mName (\$nameFind->\$i->\"name\")\r\
    \n:set mComment (\$nameFind->\$i->\"comment\")\r\
    \n:set mType (\$nameFind->\$i->\"type\")\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\"\$[/system identity get name] \".\"\$mComment \".\"\$mName \".\"\$mType\")]\r\
    \n}\r\
    \n} else={\r\
    \n:if (\$calc=0) do={\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\"\$[/system identity get name] \".\"no found ppp-client modem\")]}}\r\
    \n:return []\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# - Log in-> Telegram\r\
    \n\r\
    \n:set FuncLog do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n\r\
    \n:global Emoji\r\
    \n:global botID\r\
    \n:global myChatID\r\
    \n:global FuncTelegramSender\r\
    \n\r\
    \n:local name [/system identity get name]\r\
    \n:local LogsAll [/log print count-only]\r\
    \n:local counter 0\r\
    \n:local log1\r\
    \n:local otstup \$2\r\
    \n:local logs \$1\r\
    \n\r\
    \n:if (\$otstup ~ \"[a-z|A-Z|_-|+/|*\?]\") do={:set otstup 0}\r\
    \n:foreach i in=[/log find] do={\r\
    \n  :if ((\$counter >= (\$LogsAll - \$otstup - \$logs)) and (\$counter < (\$LogsAll - \$otstup))) do={\r\
    \n  :local Log1Time [/log get \$i time]\r\
    \n  :local Log1Message [/log get \$i message]\r\
    \n    :set log1 (\$log1.\"|\".\$Log1Time.\" \".\$Log1Message.\"%0A\")\r\
    \n  }\r\
    \n  :set counter (\$counter + 1)\r\
    \n}\r\
    \n:set otstup 0\r\
    \n[\$FuncTelegramSender (\"\$Emoji \".\"\$name: \".\"\$logs line logs:\".\"%0A\".\"\$log1\")]\r\
    \n  :return \$counter\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# - Reset Logging and setup length log (\$1)\r\
    \n:set FuncLogReset do={\r\
    \nif ([:len \$0]!=0) do={\r\
    \n:local LineLog \r\
    \n:if ([:len \$1]=0) do={:set LineLog 1000} else={:set LineLog \$1}\r\
    \n/system logging action set memory memory-lines=1;\r\
    \n/system logging action set memory memory-lines=\$LineLog;\r\
    \n:log warning \"Logging is reset. A log of \$LineLog entries is set\"\r\
    \n:return \$LineLog\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# - FuncPingPong 15/04/2022 \D4\F3\ED\EA\F6\E8\FF \EF\F0\EE\E2\E5\F0\EA\E8 \E4\EE\F1\F2\F3\EF\ED\EE\F1\F2\E8 \F3\F1\F2\F0\EE\E9\F1\F2\E2\E0 \E2 \F1\E5\F2\E8\r\
    \n#   c \EE\EF\EE\E2\E5\F9\E5\ED\E8\E5\EC \E2 \D2\E5\EB\E5\E3\F0\E0\EC\EC. \C8\F1\EF\EE\EB\FC\E7\F3\E5\F2 FuncPing\r\
    \n\r\
    \n:set FuncPingPong do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:global FuncPing\r\
    \n:local PA; :local PC; :local PI; :local PRT; :local Hadr;\r\
    \n:if ([:len \$1]!=0) do={:set PA \$1} else={:set PA 8.8.8.8}\r\
    \n:if ([:len \$2]!=0) do={:set PC \$2} else={:set PC [:tonum \"3\"]}\r\
    \n:if ([:len \$3]!=0) do={:set PI \$3} else={:set PI \"\"}\r\
    \n:if ([:len \$4]!=0) do={:set PRT \$4} else={:set PRT \"main\"}\r\
    \n:local PingAns [\$FuncPing PingAdr=\$1 PingCount=\$2 PingInterface=\$3 PingRoutingTabl=\$4]\r\
    \n:if (\$PingAns=\"ERROR\") do={[\$FuncTelegramSender (\"\$Emoji \".\"Host \".\"\$PA \".\"not responded\")]; :return \"ERROR\"}\r\
    \n:if (\$PingAns=\"OK\") do={[\$FuncTelegramSender (\"\$Emoji \".\"Host \".\"\$PA \".\"ping OK\")]; :return \"OK\"}\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n:global FuncActIface do={\r\
    \n# Get address active gateway - in var \$activeGateway\r\
    \n/ip route\r\
    \n {   :local counter;\r\
    \n     :foreach counter in=[find dst-address=0.0.0.0/0] do={         \r\
    \n\t :if ([get \$counter active] = true) do={\r\
    \n\t :set \$activeGateway [get \$counter gateway]; :set \$Gdistance [get \$counter distance];\r\
    \n\t }  }}\r\
    \n:if (\$activeGateway!=nil) do={\r\
    \n\r\
    \n# Get Gateway with gateway-status active\r\
    \n:local GatewayStatus;\r\
    \n:set \$GatewayStatus [ :tostr [ /ip route get [ find gateway=\$activeGateway dst-address=0.0.0.0/0 distance=\$Gdistance] gateway-status ]];\r\
    \n\r\
    \n\r\
    \n:if ([:find \$GatewayStatus \"via\"] > 0) do={\r\
    \n# Seek Interface name in \$GatewayStatus (after \"via\" verb)\r\
    \n:local activeInterface;\r\
    \n:set \$activeInterface [ :pick \$GatewayStatus ( [ :len [ :pick \$GatewayStatus 0 [ :find \$GatewayStatus \"via\" ] ] ] + 5 ) [ :len \$GatewayStatus ] ]; :return \$activeInterface\r\
    \n} else={ \r\
    \n:set \$activeInterface [ :pick \$GatewayStatus 0 ([:find \$GatewayStatus \"reachable\"]-1)]; :return \$activeInterface;}\r\
    \n\r\
    \n} else={:local activeInterface \"not found\"; :return \$activeInterface;}\r\
    \n}\r\
    \n\r\
    \n\r\
    \n\r\
    \n# - FuncPing 15/03/2022 \D4\F3\ED\EA\F6\E8\FF \EF\F0\EE\E2\E5\F0\EA\E8 \E4\EE\F1\F2\F3\EF\ED\EE\F1\F2\E8 \F3\F1\F2\F0\EE\E9\F1\F2\E2\E0 \E2 \F1\E5\F2\E8\r\
    \n#  \E2\EE\E7\EC\EE\E6\ED\FB\E5 \E8\EC\E5\ED\EE\E2\E0\ED\ED\FB\E5 \EF\E0\F0\E0\EC\E5\F2\F0\FB:\r\
    \n# PingAdr -     \E0\E4\F0\E5\F1 \EF\E8\ED\E3\F3\E5\EC\EE\E3\EE \F5\EE\F1\F2\E0, \E5\F1\EB\E8 \ED\E5 \F3\EA\E0\E7\E0\ED \EF\E8\ED\E3\F3\E5\F2\F1\FF 8.8.8.8 (\E4\EE\F1\F2\F3\EF\ED\EE\F1\F2\FC \C8\ED\F2\E5\F0\ED\E5\F2\E0)\r\
    \n#                    \E4\EE\EF\F3\F1\EA\E0\E5\F2\F1\FF \EF\E5\F0\E5\E4\E0\F7\E0 PingAdr \F1 \F3\EA\E0\E7\E0\ED\E8\E5\EC \EF\EE\F0\F2\E0 (\EE\F2\F1\E5\EA\E0\E5\F2\F1\FF)\r\
    \n# PingCount - \F7\E8\F1\EB\EE \EF\E8\ED\E3\EE\E2, \E5\F1\F2\E8 \ED\E5 \F3\EA\E0\E7\E0\ED\EE, \EF\EE \F3\EC\EE\EB\F7\E0\ED\E8\FE \F3\F1\F2\E0\ED\E0\E2\EB\E8\E2\E0\E5\F2\F1\FF 3 \EF\E8\ED\E3\E0\r\
    \n# PingIntherface - \E8\ED\F2\E5\F0\F4\E5\E9\F1 \E4\EB\FF \EF\E8\ED\E3\E0, \EC\EE\E6\E5\F2 \E1\FB\F2\FC \ED\E5 \F3\EA\E0\E7\E0\ED, \F2\EE\E3\E4\E0 \E8\F1\EF\EE\EB\FC\E7\F3\E5\F2\F1\FF default gatway\r\
    \n# PingRoutingTabl - \F2\E0\E1\EB\E8\F6\E0 \EC\E0\F0\F8\F0\F3\F2\EE\E2 (\E5\F1\EB\E8 \ED\E5 \F3\EA\E0\E7\E0\ED\E0 \E8\F1\EF\EE\EB\FC\E7\F3\E5\F2\F1\FF \F2\E0\E1\EB\E8\F6\E0 main\r\
    \n\r\
    \n# \E2\F1\E5 \EF\E0\F0\E0\EC\EC\E5\F2\F0\FB \EF\E8\ED\E3\E0 \EC\EE\E3\F3\F2 \E1\FB\F2\FC \EF\E5\F0\E5\E4\E0\ED\FB \D2\CE\CB\DC\CA\CE ! \E2 \E8\EC\E5\ED\EE\E2\E0\ED\ED\FB\F5 \EF\E0\F0\E0\EC\E5\F2\F0\E0\F5\r\
    \n\r\
    \n# :put [\$FuncPing PingAdr=8.8.8.8 PingCount=3 PingInterface=ether1 PingRoutingTabl=main]\r\
    \n# :put [\$FuncPing PingAdr=8.8.8.8 PingCount=3 PingInterface=ether1]\r\
    \n# :put [\$FuncPing PingAdr=8.8.8.8 PingCount=3]\r\
    \n# :put [\$FuncPing PingAdr=8.8.8.8]\r\
    \n# :put [\$FuncPing]\r\
    \n\r\
    \n# \EE\F2\E2\E5\F2 \F4\F3\ED\EA\F6\E8\E8 \E2\EE\E7\E2\F0\E0\F9\E0\E5\F2\F1\FF \E2 \E2\E8\E4\E5:\r\
    \n# \"OK\" - \F3\F1\F2\F0\EE\E9\F1\F2\E2\EE \E4\EE\F1\F2\F3\EF\ED\EE \E2 \F1\E5\F2\E8\r\
    \n# \"ERROR\" - \F3\F1\F2\F0\EE\E9\F1\F2\E2\EE \ED\E5 \EE\F2\E2\E5\F7\E0\E5\F2 \ED\E0 \EF\E8\ED\E3\r\
    \n\r\
    \n:set FuncPing do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n:local PA; :local PC; :local PI; :local PRT; :local Hadr;\r\
    \n\r\
    \n:if ([:len \$PingAdr]!=0) do={:set PA \$PingAdr} else={:set PA 8.8.8.8}\r\
    \n:set Hadr \$PA\r\
    \n:if ([:len \$PingCount]!=0) do={:set PC \$PingCount} else={:set PC [:tonum \"3\"]}\r\
    \n:local PingCalc \$PC\r\
    \n:if ([:len \$PingInterface]!=0) do={:set PI \$PingInterface} else={:set PI \"\"}\r\
    \n:local PingIface\r\
    \n:if (\$PI=\"\") do={:set PingIface \"\";} else {:set PingIface (\"interface=\".\"\$PI\")}\r\
    \n:if ([:len \$PingRoutingTabl]!=0) do={:set PRT \$PingRoutingTabl} else={:set PRT \"main\"}\r\
    \n:local PingRT (\"routing-table=\".\"\$PRT\")\r\
    \n:if ([:find \$Hadr \":\"]>0) do={:set Hadr [:pick \$Hadr 0 [:find \$Hadr \":\"]];}\r\
    \n:local Result [[:parse \"[/ping \$Hadr count=\$PingCalc \$PingIface \$PingRT]\"]]\r\
    \n:beep frequency=300 length=494ms; :delay 70ms; :beep frequency=600 length=494ms; :delay 70ms; :beep frequency=900 length=494ms;\r\
    \n:local PingAnswer \"\"; :local MainIfInetOk false;\r\
    \n:set MainIfInetOk ((3*\$Result) >= (2 * \$PingCalc))\r\
    \nif (!\$MainIfInetOk) do={:return \"ERROR\"} else={:return \"OK\"}\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# - FuncMail - \D4\F3\ED\EA\F6\E8\FF \EE\F2\EF\F0\E0\E2\EA\E8 \EF\EE\F7\F2\FB \r\
    \n#    by Sergej Serkov 17/01/2021\r\
    \n#------------------------------------------------------\r\
    \n\r\
    \n# \CF\F0\E8\EC\E5\ED\E5\ED\E8\E5:\r\
    \n# [\$FuncMail Email=\"user@mail.ru\" Mailtext=\"test letter\"]\r\
    \n# \E2\EB\EE\E6\E5\ED\E8\E5 \F4\E0\E9\EB\EE\E2 \ED\E5 \EF\EE\E4\E4\E5\F0\E6\E8\E2\E0\E5\F2\F1\FF\r\
    \n\r\
    \n# \E4\EB\FF \EA\EE\F0\F0\E5\EA\F2\ED\EE\E9 \F0\E0\E1\EE\F2\FB \F4\F3\ED\EA\F6\E8\E8 \EF\EE\F7\F2\EE\E2\FB\E9 \F1\E5\F0\E2\E8\F1 Router OS /tool email \E4\EE\EB\E6\E5\ED \E1\FB\F2\FC \ED\E0\F1\F2\F0\EE\E5\ED \E2\E5\F0\ED\EE \EF\EE \F3\EC\EE\EB\F7\E0\ED\E8\FE\r\
    \n# \E0\E4\F0\E5\F1 \EF\EE\EB\F3\F7\E0\F2\E5\EB\FF \E8 \F2\E5\EA\F1\F2 \EF\E8\F1\FC\EC\E0 \EC\EE\E3\F3\F2 \E1\FB\F2\FC \EF\E5\F0\E5\E4\E0\ED\FB \E2 \E8\EC\E5\ED\EE\E2\E0\ED\ED\FB\F5 \EB\E8\E1\EE \EF\EE\E7\E8\F6\E8\EE\ED\ED\FB\F5 \EF\E0\F0\E0\EC\E5\F2\F0\E0\F5 (\E8\EB\E8/\E8\EB\E8)\r\
    \n# \E2 \F1\EB\F3\F7\E0\E5 \F1 \EF\EE\E7\E8\F6\E8\EE\ED\ED\FB\EC\E8 \EF\E0\F0\E0\EC\E5\F2\F0\E0\EC\E8 \$1 - \E0\E4\F0\E5\F1 \EF\EE\EB\F3\F7\E0\F2\E5\EB\FF; \$2 - \F2\E5\EA\F1\F2 \F1\EE\EE\E1\F9\E5\ED\E8\FF (\EC\E5\F1\F2\E0\EC\E8 \EC\E5\ED\FF\F2\FC \ED\E5\EB\FC\E7\FF)\r\
    \n# \EF\F0\E8 \EF\E5\F0\E5\E4\E0\F7\E5 \E0\E4\F0\E5\F1\E0 \E8 \F2\E5\EA\F1\F2\E0 \EF\E8\F1\FC\EC\E0 \E2 \E8\EC\E5\ED\EE\E2\E0\ED\ED\FB\F5 \EF\E0\F0\E0\EC\E5\F2\F0\E0\F5 (Email \E8 Mailtext) - \E8\F5 \EF\EE\F0\FF\E4\EE\EA \ED\E5 \E2\E0\E6\E5\ED\r\
    \n\r\
    \n# for example:\r\
    \n# :log info [\$FuncMail Email=\"user@mail.ru\" Mailtext=\"\CF\F0\E8\E2\E5\F2 !\"]; # (\F1 \E8\EC\E5\ED\EE\E2\E0\ED\ED\FB\EC\E8 \EF\E0\F0\E0\EC\E5\F2\F0\E0\EC\E8) \r\
    \n# :log info [\$FuncMail user@mail.ru \"\CF\F0\E8\E2\E5\F2 !\"]; # (c \EF\EE\E7\E8\F6\E8\EE\ED\ED\FB\EC\E8 \EF\E0\F0\E0\EC\E5\F2\F0\E0\EC\E8)\r\
    \n\r\
    \n:set FuncMail do={\r\
    \n:if ([:len \$0]!=0) do={ \r\
    \n:local Etls \"yes\"; # \E5\F1\EB\E8 TLS \ED\E5 \E8\F1\EF\EE\EB\FC\E7\F3\E5\F2\F1\FF \F3\F1\F2\E0\ED\EE\E2\E8\F2\FC \E2 \"no\"\r\
    \n:local smtpserv;\r\
    \ndo {\r\
    \n:set smtpserv [:resolve [/tool e-mail get address]];\r\
    \n} on-error={:log error (\"Call ERROR function \$0 not resolve email smtp server\"); :return (\"ERROR: \$0 < not resolve email smtp server >\")}\r\
    \n:local Eaccount [/tool e-mail get user];\r\
    \n:local pass [/tool e-mail get password];\r\
    \n:local Eport [/tool e-mail get port];\r\
    \n:local MA; :local MT\r\
    \n:if ([:len \$1]!=0) do={:set MA \$1} else={:set MA \$Email}\r\
    \n:if ([:len \$2]!=0) do={:set MT \$2} else={:set MT \$Mailtext}\r\
    \n:if ((any \$MA) and (any \$MT)) do={\r\
    \n:log info \" \"; :log warning \"FuncMail start mail sending ... to e-mail: \$Email\";\r\
    \ndo {[/tool e-mail send from=\"<\$Eaccount>\" to=\$MA server=\$smtpserv \\\r\
    \n port=\$Eport user=\$Eaccount password=\$pass start-tls=\$Etls subject=(\"from \$0 Router \$[/system identity get name]\") \\\r\
    \n body=\$MT;];\r\
    \n              } on-error={:log info \"\"; :log error (\"Call ERROR function \$0 ERROR e-mail send\"); \r\
    \n                                                                                      :return \"ERROR: <\$0 e-mail send>\"}\r\
    \n:log warning \"Mail send\"; :log info \" \"; :return \"OK: <mail send>\"\r\
    \n} else={:log error (\"Call ERROR function \$0 Email or Mailtext parametrs no defined\"); :return (\"ERROR: \$0 < necessary parameters are not set >\")}\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# FuncSMSsend \r\
    \n# -----------------------------------\r\
    \n\r\
    \n# [\$FuncSMSsend \"Hello \CF\F0\E8\E2\E5\F2 \EC\E8\F0\" +79104797777]\r\
    \n\r\
    \n# local function transliteration\r\
    \n# string for transliteration is set in the parametr name \"string\"\r\
    \n\r\
    \n\r\
    \n:set FuncSMSsend do={\r\
    \n\r\
    \n:local FuncSatTranslite do={\r\
    \n#  table of the codes of Russian letters Translite\r\
    \n:local rsimv [:toarray {\"\C0\"=\"A\"; \"\C1\"=\"B\"; \"\C2\"=\"V\"; \"\C3\"=\"G\"; \"\C4\"=\"D\"; \"\C5\"=\"E\"; \"\C6\"=\"ZH\"; \"\C7\"=\"Z\"; \"\C8\"=\"I\"; \"\C9\"=\"J\"; \"\CA\"=\"K\"; \"\CB\"=\"L\"; \"\CC\"=\"M\"; \"\CD\"=\"N\"; \"\CE\"=\"O\"; \"\CF\"=\"P\"; \"\D0\"=\"R\"; \"\D1\"=\"S\"; \"\D2\"=\"T\"; \"\D3\"=\"U\"; \"\D4\"=\"F\"; \"\D5\"=\"KH\"; \"\D6\"=\"C\"; \"\D7\"=\"CH\"; \"\D8\"=\"SH\"; \"\D9\"=\"SCH\"; \"\DA\"=\"``\"; \"\DB\"=\"Y`\"; \"\DC\"=\"`\"; \"\DD\"=\"E`\"; \"\DE\"=\"JU\"; \"\DF\"=\"YA\"; \"\E0\"=\"a\"; \"\E1\"=\"b\"; \"\E2\"=\"v\"; \"\E3\"=\"g\"; \"\E4\"=\"d\"; \"\E5\"=\"e\"; \"\E6\"=\"zh\"; \"\E7\"=\"z\"; \"\E8\"=\"i\"; \"\E9\"=\"j\"; \"\EA\"=\"k\"; \"\EB\"=\"l\"; \"\EC\"=\"m\"; \"\ED\"=\"n\"; \"\EE\"=\"o\"; \"\EF\"=\"p\"; \"\F0\"=\"r\"; \"\F1\"=\"s\"; \"\F2\"=\"t\"; \"\F3\"=\"u\"; \"\F4\"=\"f\"; \"\F5\"=\"kh\"; \"\F6\"=\"c\"; \"\F7\"=\"ch\"; \"\F8\"=\"sh\"; \"\F9\"=\"sch\"; \"\FA\"=\"``\"; \"\FB\"=\"y`\"; \"\FC\"=\"`\"; \"\FD\"=\"e`\"; \"\FE\"=\"ju\"; \"\FF\"=\"ya\"; \"\A8\"=\"Yo\"; \"\B8\"=\"yo\"; \"\B9\"=\"#\"}]\r\
    \n\r\
    \n# encoding of the symbols and \E0ssembly line\r\
    \n:local StrTele \"\"; :local code \"\";\r\
    \n:for i from=0 to=([:len \$string]-1) do={:local keys [:pick \$string \$i (1+\$i)];\r\
    \n\r\
    \n:local key (\$rsimv->\$keys); if ([:len \$key]!=0) do={:set \$code (\$rsimv->\$keys);} else={:set \$code \$keys};\r\
    \n\r\
    \n:if ((\$keys=\"\DC\")  and ([:pick \$string (\$i+1) (2+\$i)]=\"\C5\")) do={:set \$code \"I\"; :set \$i (\$i+1)}\r\
    \n:if ((\$keys=\"\FC\")  and ([:pick \$string (\$i+1) (2+\$i)]=\"\E5\")) do={:set \$code \"i\"; :set \$i (\$i+1)}\r\
    \n:if ((\$keys=\"\DC\")  and ([:pick \$string (\$i+1) (2+\$i)]=\"\E5\")) do={:set \$code \"I\"; :set \$i (\$i+1)}\r\
    \n:if ((\$keys=\"\FC\")  and ([:pick \$string (\$i+1) (2+\$i)]=\"\C5\")) do={:set \$code \"i\"; :set \$i (\$i+1)}\r\
    \n:if ((\$keys=\"\DB\")  and ([:pick \$string (\$i+1) (2+\$i)]=\"\C9\")) do={:set \$code \"I\"; :set \$i (\$i+1)}\r\
    \n:if ((\$keys=\"\FB\")  and ([:pick \$string (\$i+1) (2+\$i)]=\"\E9\")) do={:set \$code \"i\"; :set \$i (\$i+1)}\r\
    \n:if ((\$keys=\"\FB\")  and ([:pick \$string (\$i+1) (2+\$i)]=\"\C9\")) do={:set \$code \"i\"; :set \$i (\$i+1)}\r\
    \n:if ((\$keys=\"\DB\")  and ([:pick \$string (\$i+1) (2+\$i)]=\"\E9\")) do={:set \$code \"I\"; :set \$i (\$i+1)}\r\
    \n :set \$StrTele (\"\$StrTele\".\"\$code\")}\r\
    \n:return \$StrTele\r\
    \n}\r\
    \n\r\
    \n\r\
    \n         :if ([:len \$0]!=0) do={\r\
    \n         :local SMSdevice [/tool sms get port];\r\
    \n         :local NumPhone\r\
    \n         :global ADMINPHONE;\r\
    \n         :if ([:len \$2]!=0) do={:set NumPhone \$2} \\\r\
    \n              else={\r\
    \n                     :if ([:len \$ADMINPHONE]!=0) do={:set NumPhone \$ADMINPHONE} \\\r\
    \n                            else={\r\
    \n                                :local NumSMS [/tool sms get allowed-number];\r\
    \n                                     :if ([:len \$NumSMS]!=0) do={:set NumPhone (\$NumSMS->0)} \\\r\
    \n                                             else={:log error \"ERROR \$0 sms phone number not found\"; :return \"ERROR function \$0 sms phone number\"}\r\
    \n}}\r\
    \n\r\
    \n# must be performed translite\r\
    \n:set \$1 [\$FuncSatTranslite string=\$1]\r\
    \n\r\
    \n         :log info \"\"; :log warning \"Function \$0 start sms sending to \$NumPhone\";\r\
    \n             :do {\r\
    \n                [/tool sms send  \$SMSdevice phone=\$NumPhone message=\$1];\r\
    \n                } on-error={:log error \"ERROR \$0 sms send\"; :return \"ERROR sms\"}\r\
    \n          :log warning \"Function \$0 sms sent via modem\"; :log info \"\";\r\
    \n          :return \"done sms\"\r\
    \n    } else={:log error \"ERROR \$0 sms send but no message text\"; :return \"ERROR sms\" }\r\
    \n}\r\
    \n\r\
    \n# function FuncSATMirror\r\
    \n# ------------------------------------------------------------\r\
    \n\r\
    \n:set FuncSATMirror do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global fMirror;\r\
    \n\r\
    \n:if (!\$fMirror) do={\r\
    \n:global FuncSATLogo; :global SATLogo \$FuncSATLogo; :set FuncSATLogo\r\
    \n:global FuncSATList; :global SATList \$FuncSATList; :set FuncSATList \r\
    \n:global FuncArp; :global Arp \$FuncArp; :set FuncArp\r\
    \n:global FuncAddress; :global Address \$FuncAddress; :set FuncAddress\r\
    \n:global FuncBackup; :global Backup \$FuncBackup; :set FuncBackup\r\
    \n:global FuncLease; :global Lease \$FuncLease; :set FuncLease\r\
    \n:global FuncReport; :global Report \$FuncReport; :set FuncReport\r\
    \n:global FuncStatus; :global Status \$FuncStatus; :set FuncStatus\r\
    \n:global FuncVPN; :global VPN \$FuncVPN; :set FuncVPN\r\
    \n:global FuncVpnUser; :global VpnUser \$FuncVpnUser; :set FuncVpnUser\r\
    \n:global FuncWifi; :global Wifi \$FuncWifi; :set FuncWifi\r\
    \n:global FuncWifiReg; :global WifiReg \$FuncWifiReg; :set FuncWifiReg\r\
    \n:global FuncWifiAccess; :global WifiAccess \$FuncWifiAccess; :set FuncWifiAccess\r\
    \n:global FuncWifiConnect; :global WifiConnect \$FuncWifiConnect; :set FuncWifiConnect\r\
    \n:global FuncHealth; :global Health \$FuncHealth; :set FuncHealth\r\
    \n:global FuncDHCPclient; :global DHCPclient \$FuncDHCPclient; :set FuncDHCPclient\r\
    \n:global FuncDHCPclient; :global DHCPclient \$FuncDHCPclient; :set FuncDHCPclient\r\
    \n:global FuncUsers; :global Users \$FuncUsers; :set FuncUsers;\r\
    \n:global FuncScriptList; :global ScriptList \$FuncScriptList; :set FuncScriptList\r\
    \n:global FuncFuncList; :global FuncList \$FuncFuncList; :set FuncFuncList\r\
    \n:global FuncSchedList; :global SchedList \$FuncSchedList; :set FuncSchedList\r\
    \n:global FuncLog; :global Log \$FuncLog; :set FuncLog\r\
    \n:global FuncLogReset; :global LogReset \$FuncLogReset; :set FuncLogReset\r\
    \n:global FuncPingPong; :global PingPong \$FuncPingPong; :set FuncPingPong\r\
    \n:global FuncModemInfo; :global ModemInfo \$FuncModemInfo; :set FuncModemInfo\r\
    \n:global FuncGlobalVarList; :global GlobalVarList \$FuncGlobalVarList; :set FuncGlobalVarList\r\
    \n:global FuncSATMirror; :global SATMirror \$FuncSATMirror; :set FuncSATMirror\r\
    \n:global FuncSATClear; :global SATClear \$FuncSATClear; :set FuncSATClear\r\
    \n        :put  (\"\$[/system identity get name] \".\"function mirror reflected. Short names set\")\r\
    \n        :log error \"Conversion completed. Funcnames --> to short name\";\r\
    \n:global fMirror true\r\
    \n:global broadCast true;\r\
    \n        :return (\"library SATELLITE mirror is reflected. Short names set\")\r\
    \n} else={\r\
    \n:global SATLogo; :global FuncSATLogo \$SATlogo; :set SATLogo\r\
    \n:global SATList; :global FuncSATList \$SATList; :set SATList \r\
    \n:global Arp; :global FuncArp \$Arp; :set Arp\r\
    \n:global Address; :global FuncAddress \$Address; :set Address\r\
    \n:global Backup; :global FuncBackup \$Backup; :set Backup\r\
    \n:global Lease; :global FuncLease \$Lease; :set Lease\r\
    \n:global Report; :global FuncReport \$Report; :set Report\r\
    \n:global Status; :global FuncStatus \$Status; :set Status\r\
    \n:global VPN; :global FuncVPN \$VPN; :set VPN\r\
    \n:global VpnUser; :global FuncVpnUser \$VpnUser; :set VpnUser\r\
    \n:global Wifi; :global FuncWifi \$Wifi; :set Wifi\r\
    \n:global WifiReg; :global FuncWifiReg \$WifiReg; :set WifiReg\r\
    \n:global WifiAccess; :global FuncWifiAccess \$WifiAccess; :set WifiAccess\r\
    \n:global WifiConnect; :global FuncWifiConnect \$WifiConnect; :set WifiConnect\r\
    \n:global WifiPass; :global FuncWifiPass \$WifiPass; :set WifiPass\r\
    \n:global Health; :global FuncHealth \$Health; :set Health\r\
    \n:global DHCPclient; :global FuncDHCPclient \$DHCPclient; :set DHCPclient\r\
    \n:global Users; :global FuncUsers \$Users; :set Users;\r\
    \n:global ScriptList; :global FuncScriptList \$ScriptList; :set ScriptList\r\
    \n:global FuncList; :global FuncFuncList \$FuncList; :set FuncList\r\
    \n:global SchedList; :global FuncSchedList \$SchedList; :set SchedList\r\
    \n:global Log; :global FuncLog \$Log; :set Log\r\
    \n:global LogReset; :global FuncLogReset \$LogReset; :set LogReset\r\
    \n:global PingPong; :global FuncPingPong \$PingPong; :set PingPong\r\
    \n:global ModemInfo; :global FuncModemInfo \$ModemInfo; :set ModemInfo\r\
    \n:global GlobalVarList; :global FuncGlobalVarList \$GlobalVarList; :set GlobalVarList\r\
    \n:global SATMirror; :global FuncSATMirror \$SATMirror; :set SATMirror\r\
    \n:global SATClear; :global FuncSATClear \$SATClear; :set SATClear\r\
    \n        :put  (\"\$[/system identity get name] \".\"function \".\"\$0 \".\"function long names restored\")\r\
    \n        :log warning \"Conversion completed short names --> to Funcnames\";\r\
    \n:global fMirror false\r\
    \n:global broadCast false;\r\
    \n        :return (\"library SATELLITE function \".\"\$0 \".\"function long names restored\")}\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# function FuncSATClear \r\
    \n# ------------------------------------------------------------\r\
    \n:set FuncSATClear do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n\r\
    \n:global fMirror\r\
    \n:if ([:len [/system script environment find name=\"SATMirror\"]]!=0) do={\r\
    \n:if (\$fMirror=true) do={:global SATMirror; [\$SATMirror]; :delay 2s}}\r\
    \n:global FuncSATLogo; :set FuncSATLogo\r\
    \n:global FuncSATList; :set FuncSATList \r\
    \n:global FuncArp; :set FuncArp\r\
    \n:global FuncAddress; :set FuncAddress\r\
    \n:global FuncBackup; :set FuncBackup\r\
    \n:global FuncLease; :set FuncLease\r\
    \n:global FuncReport; :set FuncReport\r\
    \n:global FuncStatus; :set FuncStatus\r\
    \n:global FuncVPN; :set FuncVPN\r\
    \n:global FuncVpnUser; :set FuncVpnUser\r\
    \n:global FuncWifi; :set FuncWifi\r\
    \n:global FuncWifiReg; :set FuncWifiReg\r\
    \n:global FuncWifiAccess; :set FuncWifiAccess\r\
    \n:global FuncWifiConnect; :set FuncWifiConnect\r\
    \n:global FuncWifiPass; :set FuncWifiPass\r\
    \n:global FuncHealth; :set FuncHealth\r\
    \n:global FuncDHCPclient; :set FuncDHCPclient\r\
    \n:global FuncUsers; :set FuncUsers;\r\
    \n:global FuncScriptList; :set FuncScriptList\r\
    \n:global FuncSchedList; :set FuncSchedList\r\
    \n:global FuncFuncList; :set FuncFuncList\r\
    \n:global FuncLog; :set FuncLog\r\
    \n:global FuncLogReset; :set FuncLogReset\r\
    \n:global FuncPingPong; :set FuncPingPong\r\
    \n:global FuncModemInfo; :set FuncModemInfo\r\
    \n:global FuncGlobalVarList; :set FuncGlobalVarList\r\
    \n     :if (\$1=\"all\") do={\r\
    \n:global FuncPing; :set FuncPing; \r\
    \n:global FuncMail; :set FuncMail;\r\
    \n:global FuncSMSsend; :set FuncSMSsend;\r\
    \n:global FuncSchedFuncAdd; :set FuncSchedFuncAdd;\r\
    \n:global FuncSchedScriptAdd; :set FuncSchedScriptAdd;\r\
    \n:global FuncSchedRemove; :set FuncSchedRemove;\r\
    \n:global FuncUnixTimeToFormat; :set FuncUnixTimeToFormat;\r\
    \n:global FuncEpochTime; :set FuncEpochTime;\r\
    \n:global FuncSATMirror; :set FuncSATMirror;\r\
    \n:global FuncTelegramSender; :set FuncTelegramSender;\r\
    \n:global fMirror; :set fMirror;\r\
    \n:global broadCast; :set broadCast;\r\
    \n}\r\
    \n:global FuncSATClear; :set FuncSATClear\r\
    \n:global SATClear; :set SATClear\r\
    \n        :put  (\"\$[/system identity get name]\".\" \$0 unload\")\r\
    \n        :return (\"library \$0 \".\" is unload\")\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n:log info \"  -    SATELLITE2 module is set\""
/system script add comment="module 3 SATELLITE for TLGRM" dont-require-permissions=no name=SATELLITE3 owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#------------------------------------------------------------------------------------------------------------------------\r\
    \n# SATELLITE3 module  for TLGRM version 1.8 by Sertik (Serkov S.V.) 24/04/2022\r\
    \n#------------------------------------------------------------------------------------------------------------------------\r\
    \n\r\
    \n\r\
    \n# declare functions:\r\
    \n:global FuncTelegramSender\r\
    \n:global FuncSchedFuncAdd\r\
    \n:global FuncSchedScriptAdd\r\
    \n\r\
    \n# function FuncTelegramSender\r\
    \n# ---------------------------------------------\r\
    \n:global FuncTelegramSender\r\
    \n:if (!any \$FuncTelegramSender) do={ :global FuncTelegramSender do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:global Emoji\r\
    \n:global botID;\r\
    \n:global myChatID;\r\
    \n:local Tstyle\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:if ([:len \$2]=0) do={} else={:set \$Tstyle \$2} \r\
    \n:if ((\$2=\"html\") or (\$2=\"markdown\") or (\$2=\"markdownV2\") or ([:len \$2]=0)) do={\r\
    \n\r\
    \n:local string; :set \$string \$1;\r\
    \n\r\
    \n#  table of the codes of Russian letters UTF8 + some characters are not supported by Telegram\r\
    \n\r\
    \n:local rsimv [:toarray {\"\C0\"=\"D090\"; \"\C1\"=\"D091\"; \"\C2\"=\"D092\"; \"\C3\"=\"D093\"; \"\C4\"=\"D094\"; \"\C5\"=\"D095\"; \"\C6\"=\"D096\"; \"\C7\"=\"D097\"; \"\C8\"=\"D098\"; \"\C9\"=\"D099\"; \"\CA\"=\"D09A\"; \"\CB\"=\"D09B\"; \"\CC\"=\"D09C\"; \"\CD\"=\"D09D\"; \"\CE\"=\"D09E\"; \"\CF\"=\"D09F\"; \"\D0\"=\"D0A0\"; \"\D1\"=\"D0A1\"; \"\D2\"=\"D0A2\"; \"\D3\"=\"D0A3\"; \"\D4\"=\"D0A4\"; \"\D5\"=\"D0A5\"; \"\D6\"=\"D0A6\"; \"\D7\"=\"D0A7\"; \"\D8\"=\"D0A8\"; \"\D9\"=\"D0A9\"; \"\DA\"=\"D0AA\"; \"\DB\"=\"D0AB\"; \"\DC\"=\"D0AC\"; \"\DD\"=\"D0AD\"; \"\DE\"=\"D0AE\"; \"\DF\"=\"D0AF\"; \"\E0\"=\"D0B0\"; \"\E1\"=\"D0B1\"; \"\E2\"=\"D0B2\"; \"\E3\"=\"D0B3\"; \"\E4\"=\"D0B4\"; \"\E5\"=\"D0B5\"; \"\E6\"=\"D0B6\"; \"\E7\"=\"D0B7\"; \"\E8\"=\"D0B8\"; \"\E9\"=\"D0B9\"; \"\EA\"=\"D0BA\"; \"\EB\"=\"D0BB\"; \"\EC\"=\"D0BC\"; \"\ED\"=\"D0BD\"; \"\EE\"=\"D0BE\"; \"\EF\"=\"D0BF\"; \"\F0\"=\"D180\"; \"\F1\"=\"D181\"; \"\F2\"=\"D182\"; \"\F3\"=\"D183\"; \"\F4\"=\"D184\"; \"\F5\"=\"D185\"; \"\F6\"=\"D186\"; \"\F7\"=\"D187\"; \"\F8\"=\"D188\"; \"\F9\"=\"D189\"; \"\FA\"=\"D18A\"; \"\FB\"=\"D18B\"; \"\FC\"=\"D18C\"; \"\FD\"=\"D18D\"; \"\FE\"=\"D18E\"; \"\FF\"=\"D18F\"; \"\A8\"=\"D001\"; \"\B8\"=\"D191\"; \"\B9\"=\"0023\"; \" \"=\"0020\"; \"&\"=\"0026\"; \"`\"=\"0027\"; \"+\"=\"002B\";\"[\"=\"005B\"; \"\\\"=\"005C\"; \"]\"=\"005D\"; \"_\"=\"005F\"; \"'\"=\"0060\"}]\r\
    \n\r\
    \n# encoding of the symbols and \E0ssembly line\r\
    \n:local StrTele \"\"; :local code \"\";\r\
    \n:for i from=0 to=([:len \$string]-1) do={:local keys [:pick \$string \$i (1+\$i)]; :local key (\$rsimv->\$keys); if ([:len \$key]!=0) do={:set \$code (\"%\".\"\$[:pick (\$rsimv->\$keys) 0 2]\".\"%\".\"\$[:pick (\$rsimv->\$keys) 2 4]\");:if ([pick \$code 0 3] =\"%00\") do={:set \$code [:pick \$code 3 6]}} else={:set \$code \$keys}; :set \$StrTele (\"\$StrTele\".\"\$code\")}\r\
    \n\r\
    \ndo {\r\
    \n\r\
    \n/tool fetch url=\"https://api.telegram.org/\$botID/sendmessage\\\?chat_id=\$myChatID&parse_mode=\$Tstyle&text=\$StrTele\" keep-result=no; :return \"Done\"\r\
    \n} on-error={:log info; :log error \"Error function \$0 fetch\"; :log info \"\"; :return \"Error fetch\"}\r\
    \n    } else={:log info; log error \"Parametrs function \$0 mismatch\"; :log info \"\"; :return \"Error parametrs mismatch\"}\r\
    \n  }\r\
    \n}}}\r\
    \n\r\
    \n#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\
    \n# \D4\F3\ED\EA\F6\E8\FF  FuncSchedScriptAdd \E4\EE\E1\E0\E2\EB\E5\ED\E8\FF \E7\E0\E4\E0\ED\E8\FF \ED\E0 \E2\FB\EF\EE\EB\ED\E5\ED\E8\E5 \EF\F0\EE\E8\E7\E2\EE\EB\FC\ED\EE\E3\EE \F1\EA\F0\E8\EF\F2\E0 \E2 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA\r\
    \n#  by Sertik 26/02/2021 version 1.0\r\
    \n#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\
    \n\r\
    \n\r\
    \n# usage [\$FuncSchedScriptAdd \"script name\"  \"\E4\E0\F2\E0 \E2 \F4\EE\F0\EC\E0\F2\E5 Feb/06/2021\" \"\E2\F0\E5\EC\FF (00:00:00 or startup)\" \"\E8\ED\F2\E5\F0\E2\E0\EB (00:00:00)\"]\r\
    \n# examples:\r\
    \n# :local ScriptFunc [\$FuncSchedScriptAdd \"script name\"  \"Feb/06/2021\" \"21:06:30\" \"00:00:00\"]\r\
    \n# \E5\F1\EB\E8 \E2\F0\E5\EC\FF \F1\F0\E0\E1\E0\F2\FB\E2\E0\ED\E8\FF \F1\F2\EE\E8\F2 startup, \F2\EE date \F3\F1\F2\E0\ED\E0\E2\EB\E8\E2\E0\E5\F2\F1\FF \F2\E5\EA\F3\F9\E8\EC \E4\ED\B8\EC (\F2\E0\EA \F0\E0\E1\EE\F2\E0\E5\F2 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA)\r\
    \n# [\$FuncSchedScriptAdd \"script name\"  \"Feb/06/2021\" \"startup\" \"00:01:00\"]\r\
    \n# [\$FuncSchedScriptAdd \"script name\"]\r\
    \n#\r\
    \n\r\
    \n:set FuncSchedScriptAdd do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n    :if ([:len \$1]!=0) do={\r\
    \n         :if ([:len [/system script find name=\$1]]!=0) do={\r\
    \n:if ([:len \$4]=0) do={:set \$4 \"00:00:00\"}\r\
    \n:local timedelay 10\r\
    \n:local time [/system clock get time]; :local date [/system clock get date];\r\
    \n:global FuncEpochTime; :global FuncUnixTimeToFormat;\r\
    \n:local tm [\$FuncUnixTimeToFormat ([\$FuncEpochTime]+\$timedelay) 5]\r\
    \n:local sdate \"\";\r\
    \n:if ([:len \$2]>0) do={:set sdate \$2} else={:set sdate [:pick \$tm 0 [:find \$tm \"-\"]]}\r\
    \n:if ([:len \$3]>0) do={} else={:set \$3 [:pick \$tm ([:find \$tm \"-\"]+1) [:len \$tm]]}\r\
    \n                   :local insertend;\r\
    \n        :do {\r\
    \n                        :if (\$4!=\"00:00:00\") do={:set insertend \"\";}  else={:set insertend \":global FuncSchedRemove; [\\\$FuncSchedRemove \\\"Run script \$1-\$2-\$time\\\"]\"}\r\
    \n                   :local strscr (\":do {\".\"/system script run \".\"\$1;\".\"\$insertend\".\"} on-error={:log info \\\"\\\"; :log error \\\"ERROR when executing a scheduled run script \$1\\\"; :log info \\\"\\\" }\");\r\
    \n                    [/system scheduler add name=(\"Run script \".\"\$1\".\"-\".\"\$2\".\"-\".\"\$time\") start-time=[:totime \$3] on-event=\$strscr interval=[:totime \$4] start-date=\$sdate comment=(\"added by function \".\"\$[:pick \$0 1 [:len \$0]]\")];\r\
    \n        } on-error={:log error \"ERROR function \$0 Sheduller is not set\"; :return \"ERROR function \$0 Sheduller is not set\"};\r\
    \n:log info \"\"; :put \"\";\r\
    \n:log warning (\"Function \$0 added task run script \$1-\$2-\$time to the scheduler\")\r\
    \n:put (\"Function \$0 added task run script \$1-\$2-\$time to the scheduler\")\r\
    \n:log info \"\"; :put \"\";\r\
    \n    :return \"OK\";\r\
    \n      } else={:return \"ERROR function \$0 script \$1 not find in repository\"}\r\
    \n   } else={:return \"ERROR parametr \$1 <ScriptName>\"}\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\
    \n# \D4\F3\ED\EA\F6\E8\FF  FuncSchedFuncAdd \E4\EE\E1\E0\E2\EB\E5\ED\E8\FF \E7\E0\E4\E0\ED\E8\FF \ED\E0 \E2\FB\EF\EE\EB\ED\E5\ED\E8\E5 \EF\F0\EE\E8\E7\E2\EE\EB\FC\ED\EE\E9 \F4\F3\ED\EA\F6\E8\E8 \F1 \EF\F0\EE\F1\F2\FB\EC\E8 \EF\E0\F0\E0\EC\E5\F2\F0\E0\EC\E8 \E2 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA\r\
    \n#  by Sertik 26/02/2021 version 1.0\r\
    \n#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\
    \n\r\
    \n#usage [\$FuncSchedFuncAdd \"\EF\EE\EB\ED\E0\FF \F1\F2\F0\EE\EA\E0 \F4\F3\ED\EA\F6\E8\E8 c \EF\E0\F0\E0\EC\E5\F2\F0\E0\EC\E8 \E8\EB\E8 \E1\E5\E7\"  \"\E4\E0\F2\E0 \E2 \F4\EE\F0\EC\E0\F2\E5 Feb/06/2021\" \"\E2\F0\E5\EC\FF (00:00:00 or startup)\" \"\E8\ED\F2\E5\F0\E2\E0\EB (00:00:00)\"]\r\
    \n# examples:\r\
    \n# :local ScriptFunc [\$FuncSchedFuncAdd \"FuncName par1 par2\"  \"Feb/06/2021\" \"21:06:30\" \"00:00:00\"]\r\
    \n# \E5\F1\EB\E8 \E2\F0\E5\EC\FF \F1\F0\E0\E1\E0\F2\FB\E2\E0\ED\E8\FF \F1\F2\EE\E8\F2 startup, \F2\EE date \F3\F1\F2\E0\ED\E0\E2\EB\E8\E2\E0\E5\F2\F1\FF \F2\E5\EA\F3\F9\E8\EC \E4\ED\B8\EC (\F2\E0\EA \F0\E0\E1\EE\F2\E0\E5\F2 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA)\r\
    \n# [\$FuncSchedFuncAdd \"FuncName\"  \"Feb/06/2021\" \"startup\" \"00:01:00\"]\r\
    \n# [\$FuncSchedFuncAdd \"FuncName par1 par 2 par 3\"]\r\
    \n#\r\
    \n\r\
    \n:set FuncSchedFuncAdd do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:if ([:len \$1]!=0) do={\r\
    \n:if ([:len \$4]=0) do={:set \$4 \"00:00:00\"}\r\
    \n:local timedelay 10\r\
    \n:local time [/system clock get time]; :local date [/system clock get date];\r\
    \n:global FuncEpochTime; :global FuncUnixTimeToFormat;\r\
    \n:local tm [\$FuncUnixTimeToFormat ([\$FuncEpochTime]+\$timedelay) 5]\r\
    \n:local sdate \"\";\r\
    \n:if ([:len \$2]>0) do={:set sdate \$2} else={:set sdate [:pick \$tm 0 [:find \$tm \"-\"]]}\r\
    \n:if ([:len \$3]>0) do={} else={:set \$3 [:pick \$tm ([:find \$tm \"-\"]+1) [:len \$tm]]}\r\
    \n                      :local insert;\r\
    \n            :do {\r\
    \n                      :local FuncName;\r\
    \n                          :if ([:typeof [:find \$1 \" \"]]!=\"nil\") do={:set FuncName [:pick \$1 0 [:find \$1 \" \"]]} else={:set FuncName [:pick \$1 0 [:len \$1]]}\r\
    \n                           :local strfunc (\":global \".\"\$FuncName\".\";\".\":do {[\\\$\$1];} on-error={:log info \\\"\\\"; :log error \\\"ERROR when executing a scheduled function \$FuncName task\\\"; :log info \\\"\\\" }\");\r\
    \n                           :if (\$4!=\"00:00:00\") do={:set insert \"\"} else={:set insert \"; :global FuncSchedRemove; :do {[\\\$FuncSchedRemove \\\"Run function \$1-\$2-\$time\\\"]} on-error={}\"}\r\
    \n                           [/system scheduler add name=(\"Run function \".\"\$1\".\"-\".\"\$2\".\"-\".\"\$time\") start-time=[:totime \$3] on-event=(\"\$strfunc\".\"\$insert\") interval=[:totime \$4] start-date=\$sdate comment=(\"added by function \".\"\$[:pick \$0 1 [:len \$0]]\")]\r\
    \n                } on-error={:log error \"ERROR function \$0 Sheduller is not set\"; :return \"ERROR function \$0 Sheduller is not set\"}\r\
    \n:log info \"\"; :put \"\";\r\
    \n:log warning (\"Function \$0 added task run function \$1-\$2-\$time to the scheduler\");\r\
    \n:put (\"Function \$0 added task run function \$1-\$2-\$time to the scheduler\");\r\
    \n:log info \"\"; :put \"\";\r\
    \n:return \"OK\";\r\
    \n       } else={:return \"ERROR parametr \$1 <\$FuncName>\"}\r\
    \n  }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# \D4\F3\ED\EA\F6\E8\FF FuncSchedRemove - \F3\E4\E0\EB\E5\ED\E8\FF \E7\E0\E4\E0\ED\E8\FF \E8\E7 \CF\EB\E0\ED\E8\F0\EE\E2\F9\E8\EA\E0\r\
    \n# usage [\$FuncSchedRemove \"task1\"]\r\
    \n\r\
    \n:global FuncSchedRemove\r\
    \nif (!any \$FuncSchedRemove) do={:global FuncSchedRemove do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n:do {\r\
    \n/system scheduler remove \"\$1\"} on-error={}\r\
    \n }\r\
    \n}\r\
    \n}\r\
    \n\r\
    \n# \D4\F3\ED\EA\F6\E8\FF FuncEpochTime - \E2\FB\F7\E8\F1\EB\E5\ED\E8\FF \E0\E1\F1\EE\EB\FE\F2\ED\EE\E3\EE \E2\F0\E5\EC\E5\ED\E8 UNIXTIME\r\
    \n\r\
    \n# \EE\E3\F0\E0\ED\E8\F7\E5\ED\E0 2000-2199 \E3\EE\E4\E0\EC\E8\r\
    \n# \E1\E5\E7 \EF\E0\F0\E0\EC\E5\F2\F0\EE\E2 - \E2\EE\E7\E2\F0\E0\F9\E0\E5\F2 timeStamp (UnixTime)\r\
    \n# c \EF\E0\F0\E0\EC\E5\F2\F0\E0\EC\E8 \$1 - \ED\F3\E6\ED\EE \F3\F7\E8\F2\FB\E2\E0\F2\FC gmt \E8\EB\E8 \ED\E5\F2\r\
    \n# \E2\EE\E7\E2\F0\E0\F9\E0\E5\F2 UnixTime \FD\F2\EE\E9 \E2\F0\E5\EC\E5\ED\ED\EE\E9 \F2\EE\F7\EA\E8\r\
    \n# \E5\F1\EB\E8 \$2 \ED\E5 \E7\E0\E4\E0\ED - \E1\E5\F0\E5\F2\F1\FF \F2\E5\EA\F3\F9\E0\FF \E4\E0\F2\E0 \E8\E7 /system clock\r\
    \n# \E5\F1\EB\E8 \$3 \ED\E5 \E7\E0\E4\E0\ED - \E1\E5\F0\E5\F2\F1\FF \F2\E5\EA\F3\F9\E5\E5 \E2\F0\E5\EC\FF \E0\ED\E0\EB\EE\E3\E8\F7\ED\EE\r\
    \n\r\
    \n:global FuncEpochTime\r\
    \nif (!any \$FuncEpochTime) do={:global FuncEpochTime do={\r\
    \n:local gmtofset 0\r\
    \n:local ds\r\
    \n:local ts\r\
    \n :if ([:len \$1]=0) do={:set gmtofset [/system clock get gmt-offset]} else={:set gmtofset 0}\r\
    \n :if (\$1=\"gmtoffset\") do={:set gmtofset [/system clock get gmt-offset]} else={:set gmtofset 0}\r\
    \n :if (\$1=\"nogmt\") do={:set gmtofset 0}\r\
    \n :if ([:len \$2]=0) do={:set ds [/system clock get date]} else={:set ds \$2}\r\
    \n :if ([:len \$3]=0) do={:set ts [/system clock get time]} else={:set ts \$3}\r\
    \n\r\
    \n#   :local ds [/system clock get date];\r\
    \n   :local months;\r\
    \n   :if ((([:pick \$ds 9 11]-1)/4) != (([:pick \$ds 9 11])/4)) do={\r\
    \n      :set months {\"an\"=0;\"eb\"=31;\"ar\"=60;\"pr\"=91;\"ay\"=121;\"un\"=152;\"ul\"=182;\"ug\"=213;\"ep\"=244;\"ct\"=274;\"ov\"=305;\"ec\"=335};\r\
    \n   } else={\r\
    \n      :set months {\"an\"=0;\"eb\"=31;\"ar\"=59;\"pr\"=90;\"ay\"=120;\"un\"=151;\"ul\"=181;\"ug\"=212;\"ep\"=243;\"ct\"=273;\"ov\"=304;\"ec\"=334};\r\
    \n   }\r\
    \n:local year [:tonum [:pick \$ds 7 9]]\r\
    \n   :set ds (([:pick \$ds 9 11]*365)+(([:pick \$ds 9 11]-1)/4)+(\$months->[:pick \$ds 1 3])+[:pick \$ds 4 6]);\r\
    \n#   :local ts [/system clock get time];\r\
    \n   :set ts (([:pick \$ts 0 2]*60*60)+([:pick \$ts 3 5]*60)+[:pick \$ts 6 8]);\r\
    \n#   :return (\$ds*24*60*60 + \$ts + 946684800 - \$gmtofset);\r\
    \n:if (\$year=20) do={\r\
    \n   :return (\$ds*24*60*60 + \$ts + 946684800 - \$gmtofset);}\r\
    \n:if (\$year=21) do={\r\
    \n   :return ((\$ds-1)*24*60*60 + \$ts + 4102444800 - \$gmtofset);\r\
    \n} else={:return 0}\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n# \D4\F3\ED\EA\F6\E8\FF FuncUnixTimeToFormat - \EA\EE\ED\E2\E5\F0\F2\E5\F0 UNIXTIME \E2 \ED\EE\F0\EC\E0\EB\FC\ED\EE\E5 \E2\F0\E5\EC\FF\r\
    \n\r\
    \n# \E3\EE\E4 \ED\E5 \EE\E3\F0\E0\ED\E8\F7\E5\ED \F1\F2\EE\EB\E5\F2\E8\E5\EC\r\
    \n# usial [\$FuncUnixTimeToFormat \"timeStamp\", \"type\"]\r\
    \n\r\
    \n# example:\r\
    \n#:global FuncEpochTime \r\
    \n#:local nowtime [\$FuncEpochTime \"nogmt\" \"Oct/26/2021\"]\r\
    \n#:log warning [\$FuncUnixTimeToFormat \$nowtime]\r\
    \n\r\
    \n# type:\r\
    \n\r\
    \n# \"unspecified\" - month/dd/yyyy <only> ((Mikrotik sheduller format)\r\
    \n# 1 - yyyy/mm/dd hh:mm:ss\r\
    \n# 2 - dd:mm:yyyy hh:mm:ss\r\
    \n# 3 - dd month yyy hh mm ss\r\
    \n# 4 - yyyy month dd hh mm ss\r\
    \n#5 - month/dd/yyyy-hh:mm:ss (Mikrotik sheduller format)\r\
    \n\r\
    \n:global FuncUnixTimeToFormat;\r\
    \nif (!any \$FuncUnixTimeToFormat ) do={:global FuncUnixTimeToFormat  do={\r\
    \n\r\
    \n:local decodedLine \"\"\r\
    \n:local timeStamp \$1\r\
    \n\r\
    \n:local timeS (\$timeStamp % 86400)\r\
    \n:local timeH (\$timeS / 3600)\r\
    \n:local timeM (\$timeS % 3600 / 60)\r\
    \n:set \$timeS (\$timeS - \$timeH * 3600 - \$timeM * 60)\r\
    \n:local dateD (\$timeStamp / 86400)\r\
    \n:local dateM 2\r\
    \n:local dateY 1970\r\
    \n:local leap false\r\
    \n:while ((\$dateD / 365) > 0) do={\r\
    \n:set \$dateD (\$dateD - 365)\r\
    \n:set \$dateY (\$dateY + 1)\r\
    \n:set \$dateM (\$dateM + 1) \r\
    \n:if (\$dateM = 4) do={:set \$dateM 0\r\
    \n:if ((\$dateY % 400 = 0) or (\$dateY % 100 != 0)) do={:set \$leap true\r\
    \n:set \$dateD (\$dateD - 1)}} else={:set \$leap false}}\r\
    \n:local months [:toarray (0,31,28,31,30,31,30,31,31,30,31,30,31)]\r\
    \n:if (leap) do={:set \$dateD (\$dateD + 1); :set (\$months->2) 29}\r\
    \ndo {\r\
    \n:for i from=1 to=12 do={:if ((\$months->\$i) >= \$dateD) do={:set \$dateM \$i; :set \$dateD (\$dateD + 1); break;} else={:set \$dateD (\$dateD - (\$months->\$i))}}\r\
    \n} on-error={}\r\
    \n:local tmod\r\
    \n:if ([:len \$2]!=0) do={:set \$tmod \$2} else={:set \$tmod (:nothing)}\r\
    \n:local s \"/\"\r\
    \n:local nf true\r\
    \n:local mstr {\"jan\";\"feb\";\"mar\";\"apr\";\"may\";\"jun\";\"jul\";\"aug\";\"sep\";\"oct\";\"nov\";\"dec\"}\r\
    \n:local strY [:tostr \$dateY]\r\
    \n:local strMn\r\
    \n:local strD\r\
    \n:local strH\r\
    \n:local strM\r\
    \n:local strS\r\
    \n:if (\$nf) do={\r\
    \n:if (\$dateM > 9) do={:set \$strMn [:tostr \$dateM]} else={:set \$strMn (\"0\".[:tostr \$dateM])}\r\
    \n:if (\$dateD > 9) do={:set \$strD [:tostr \$dateD]} else={:set \$strD (\"0\".[:tostr \$dateD])}\r\
    \n:if (\$timeH > 9) do={:set \$strH [:tostr \$timeH]} else={:set \$strH (\"0\".[:tostr \$timeH])}\r\
    \n:if (\$timeM > 9) do={:set \$strM [:tostr \$timeM]} else={:set \$strM (\"0\".[:tostr \$timeM])}\r\
    \n:if (\$timeS > 9) do={:set \$strS [:tostr \$timeS]} else={:set \$strS (\"0\".[:tostr \$timeS])}\r\
    \n} else={\r\
    \n:set strMn [:tostr \$dateM]\r\
    \n:set strD [:tostr \$dateD]\r\
    \n:set strH [:tostr \$timeH]\r\
    \n:set strM [:tostr \$timeM]\r\
    \n:set strS [:tostr \$timeS]\r\
    \n}\r\
    \ndo {\r\
    \n:if ([:len \$tmod]=0) do={:local mt (\$mstr->(\$dateM - 1)); :set \$decodedLine (\"\$mt/\".\"\$strD/\".\"\$strY\"); break;}\r\
    \n:if (\$tmod = 1) do={:set \$decodedLine \"\$strY\$s\$strMn\$s\$strD \$strH:\$strM:\$strS\"; break;}\r\
    \n:if (\$tmod = 2) do={:set \$decodedLine \"\$strD\$s\$strMn\$s\$strY \$strH:\$strM:\$strS\"; break;}\r\
    \n:if (\$tmod = 3) do={:set \$decodedLine (\"\$strD \".(\$mstr->(\$dateM - 1)).\" \$strY \$strH:\$strM:\$strS\"); break;}\r\
    \n:if (\$tmod = 4) do={:set \$decodedLine (\"\$strY \".(\$mstr->(\$dateM - 1)).\" \$strD \$strH:\$strM:\$strS\"); break;}\r\
    \n:if (\$tmod = 5) do={:local m (\$mstr->(\$dateM - 1)); :set \$decodedLine (\"\$m/\".\"\$strD/\".\"\$strY\".\"-\$strH:\$strM:\$strS\"); break;}\r\
    \n\r\
    \n} on-error={}\r\
    \n:return \$decodedLine;\r\
    \n}\r\
    \n}\r\
    \n\r\
    \n:log info \"  -    SATELLITE3 module is set\"\r\
    \n"
/system script add dont-require-permissions=no name=TLGRMcall owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# Name: TLGRMcall\r\
    \n# Description: Start script TLGRM, w/WatchDog\r\
    \n\r\
    \nlocal jobScript \"TLGRM\"\r\
    \nif ([len [system script job find script=\$\"jobScript\"]] !=0) do={\r\
    \n} else={\r\
    \nsystem script run \$jobScript\r\
    \n}"
/system script add dont-require-permissions=no name=SATELLITE1ext owner=TLGRMSAT policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#------------------------------------------------------------------------------------------------------------------------\r\
    \n# SATELLITE1ext module  for TLGRM version 1.8 by Sertik (Serkov S.V.) 24/04/2022\r\
    \n#------------------------------------------------------------------------------------------------------------------------\r\
    \n\r\
    \n# declare functions:\r\
    \n\r\
    \n:global FuncHealth\r\
    \n\r\
    \n\r\
    \n# health Router ->Telegram\r\
    \n# ---------------------------------------\r\
    \n\r\
    \n:set FuncHealth do={\r\
    \n:if ([:len \$0]!=0) do={\r\
    \n\r\
    \n# Script view health of device by Enternight\r\
    \n# https://forummikrotik.ru/viewtopic.php\?t=7924\r\
    \n# tested on ROS 6.49.5\r\
    \n# updated 2022/04/21\r\
    \n\r\
    \n:global Emoji\r\
    \n:global FuncTelegramSender\r\
    \n\r\
    \n:do {\r\
    \n    :local hddTotal [/system resource get total-hdd-spac];\r\
    \n    :local hddFree  [/system resource get free-hdd-space];\r\
    \n   :local badBlock [/system resource get bad-blocks    ];\r\
    \n    :local memTotal [/system resource get total-memory  ];\r\
    \n    :local memFree  [/system resource get free-memory   ];\r\
    \n    :local cpuA     [/system resource get cpu];\r\
    \n    :local arhA      [/system resource get arch];\r\
    \n    :local cpuZ     [/system resource get cpu-load      ];\r\
    \n    :local currFW   [/system routerbo get upgrade-firmwa];\r\
    \n    :local upgrFW   [/system routerbo get current-firmwa];\r\
    \n    :if ([/system resource get board-name]!=\"CHR\") do={\r\
    \n         :local tempC    [/system health   get temperature   ];\r\
    \n         :local volt     [/system health   get voltage       ];\r\
    \n          }\r\
    \n    :local smplVolt (\$volt/10);\r\
    \n    :local lowVolt  ((\$volt-(\$smplVolt*10))*10);\r\
    \n    :local inVolt   (\"\$smplVolt.\$[:pick \$lowVolt 0 3]\");\r\
    \n    :set   hddFree  (\$hddFree/(\$hddTotal/100));\r\
    \n    :set   memFree  (\$memFree/(\$memTotal/100));\r\
    \n    :local message  (\"\$Emoji \$[system identity get name] Health report:\");\r\
    \n    :set   message  (\"\$message %0AModel \$[system resource get board-name]\");\r\
    \n    :set   message  (\"\$message %0ACPU \$cpuA\");\r\
    \n    :set   message  (\"\$message %0Aarchitecture \$arhA\");\r\
    \n    :set   message  (\"\$message %0AROS v.\$[system resource get version]\");\r\
    \n    :if (\$currFW != \$upgrFW) do={set message (\"\$message %0A*FW is not updated*\")}\r\
    \n    :set   message  (\"\$message %0AUptime \$[system resource get uptime]\");\r\
    \n    :if (\$cpuZ < 90) do={:set message (\"\$message %0ACPU load \$cpuZ%\");\r\
    \n    } else={:set message (\"\$message %0A*Large CPU usage \$cpuZ%*\")}\r\
    \n    :if (\$memFree > 17) do={:set message (\"\$message %0AMem free \$memFree%\");\r\
    \n    } else={:set message (\"\$message %0A*Low free mem \$memFree%*\")}\r\
    \n    :if (\$hddFree > 6) do={:set message (\"\$message %0AHDD free \$hddFree%\");\r\
    \n    } else={:set message (\"\$message %0A*Low free HDD \$hddFree%*\")}\r\
    \n    :if ([:len \$badBlock] > 0) do={\r\
    \n        :if (\$badBlock = 0) do={:set message (\"\$message %0ABad blocks \$badBlock%\");\r\
    \n        } else={:set message (\"\$message %0A*Present bad blocks \$badBlock%*\")} }\r\
    \n    :if ([:len \$volt] > 0) do={\r\
    \n        :if (\$smplVolt > 4 && \$smplVolt < 50) do={:set message (\"\$message %0AVoltage \$inVolt V\");\r\
    \n        } else={:set message (\"\$message %0A*Bad voltage \$inVolt V*\")} }\r\
    \n    :if ([:len \$tempC] > 0) do={\r\
    \n        :if (\$tempC > 10 && \$tempC < 40) do={:set message (\"\$message %0ATemp \$tempC C\");\r\
    \n        } else={:set message (\"\$message %0A*Abnorm temp \$tempC C*\")} }\r\
    \n\r\
    \n    :local gwList [:toarray \"\"];\r\
    \n    :local count 0;\r\
    \n    :local routeISP [/ip route find dst-address=0.0.0.0/0];\r\
    \n    :if ([:len \$routeISP] > 0) do={\r\
    \n\r\
    \n        # Listing all gateways\r\
    \n        :foreach inetGate in=\$routeISP do={\r\
    \n            :local gwStatus [:tostr [/ip route get \$inetGate gateway-status]];\r\
    \n            :if (([:len [:find \$gwStatus \"unreachable\"]]=0) && ([:len [:find \$gwStatus \"inactive\"]]=0)) do={\r\
    \n\r\
    \n                # Formation of interface name\r\
    \n                :local ifaceISP \"\";\r\
    \n                :foreach idName in=[/interface find] do={\r\
    \n                    :local ifName [/interface get \$idName name];\r\
    \n                    :if ([:len [find key=\$ifName in=\$gwStatus]] > 0) do={:set ifaceISP \$ifName}\r\
    \n                }\r\
    \n                :if ([:len \$ifaceISP] > 0) do={\r\
    \n\r\
    \n                    # Checking the interface for entering the Bridge\r\
    \n                    :if ([:len [/interface bridge find name=\$ifaceISP]] > 0) do={\r\
    \n#                        :local ipAddrGate [:pick \$gwStatus 0 ([:find \$gwStatus \"reachable\"] -1)];\r\
    \n                        :local ipAddrGate [:tostr [/ip route get \$inetGate gateway]];\r\
    \n                        :if ([:find \$ipAddrGate \"%\"] > 0) do={\r\
    \n                            :set \$ipAddrGate [:pick \$ipAddrGate ([:len [:pick \$ipAddrGate 0 [:find \$ipAddrGate \"%\"]] ] +1) [:len \$ipAddrGate]];\r\
    \n                        }\r\
    \n                        :if (\$ipAddrGate~\"[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}\") do={\r\
    \n                            :local mcAddrGate [/ip arp get [find address=\$ipAddrGate interface=\$ifaceISP] mac-address];\r\
    \n                            :if (\$mcAddrGate~\"[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]\") do={\r\
    \n                               :set ifaceISP [/interface bridge host get [find mac-address=\$mcAddrGate] interface];\r\
    \n                           } else={:set ifaceISP \"\"}\r\
    \n                       } else={:set ifaceISP \"\"}\r\
    \n                    }\r\
    \n                    :if ([:len \$ifaceISP] > 0) do={\r\
    \n\r\
    \n                        # Checking the repetition of interface name\r\
    \n                        :if ([:len [find key=\$ifaceISP in=\$gwList]] = 0) do={\r\
    \n                            :set (\$gwList->\$count) \$ifaceISP;\r\
    \n                            :set count (\$count+1);\r\
    \n                            :local rxByte [/interface get \$ifaceISP rx-byte];\r\
    \n                            :local txByte [/interface get \$ifaceISP tx-byte];\r\
    \n                            :local simpleGbRxReport (\$rxByte/1073741824);\r\
    \n                            :local simpleGbTxReport (\$txByte/1073741824);\r\
    \n                            :local lowGbRxReport (((\$rxByte-(\$simpleGbRxReport*1073741824))*1000000000)/1048576);\r\
    \n                            :local lowGbTxReport (((\$txByte-(\$simpleGbTxReport*1073741824))*1000000000)/1048576);\r\
    \n                            :local gbRxReport (\"\$simpleGbRxReport.\$[:pick \$lowGbRxReport 0 2]\");\r\
    \n                            :local gbTxReport (\"\$simpleGbTxReport.\$[:pick \$lowGbTxReport 0 2]\");\r\
    \n                            :set message (\"\$message %0ATraffic via '\$ifaceISP' Rx/Tx \$gbRxReport/\$gbTxReport Gb\");\r\
    \n                        }\r\
    \n                    }\r\
    \n                }\r\
    \n            }\r\
    \n        }\r\
    \n    } else={:set message (\"\$message %0AWAN iface not found\")}\r\
    \n\r\
    \n    :if ([/ppp active find]) do={\r\
    \n   :foreach i in=[/ppp active find] do={\r\
    \n   :set \$name [/ppp active get \$i name]; :set \$type [/ppp active get \$i service]; :set \$enc [/ppp active get \$i encoding]; :set \$addr [/ppp active get \$i address]; :set \$ltu [/ppp active get \$i uptime]\r\
    \n   :set \$vpnuser (\"\$vpnuser\".\"\$name\".\" {\".\"\$type\".\"}\".\" \$addr\".\" uptime: \".\"\$ltu\".\"%0A\");}\r\
    \n   :set \$message (\"\$message\".\"%0A\".\"\$vpnuser\")\r\
    \n   } else={:set message (\"\$message %0ANo active VPN-channels\")}\r\
    \n   [\$FuncTelegramSender \$message]\r\
    \n   :return []\r\
    \n} on-error={:log warning (\"Error, can't show health status\"); :return \"ERROR\"}\r\
    \n }\r\
    \n}\r\
    \n\r\
    \n:log info \"  -    SATELLITE1ext module is set\""
/system script add dont-require-permissions=no name=TLGRM owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# TLGRM - combined notifications script & launch of commands (scripts & functions) via Telegram\r\
    \n# Script uses ideas by Sertik, Virtue, Pepelxl, Dimonw, Jotne, Alice Tails, drPioneer, Chupakabra\r\
    \n# https://forummikrotik.ru/viewtopic.php\?p=81945#p81945\r\
    \n# tested on ROS 6.49.5\r\
    \n# updated 2022/04/01\r\
    \n\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"TLGRM\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n\r\
    \n:global Emoji;\r\
    \n:global botID\r\
    \n:global myChatID\r\
    \n:global broadCast;\r\
    \n\r\
    \n:do {\r\
    \n    :local launchScr true;\r\
    \n    :local launchFnc true;\r\
    \n    :local launchCmd true;\r\
    \n\r\
    \n    # Function of searching comments for MAC-address\r\
    \n    # https://forummikrotik.ru/viewtopic.php\?p=73994#p73994\r\
    \n    :local FindMacAddr do={\r\
    \n        :if (\$1~\"[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]\") do={\r\
    \n            :foreach idx in=[/ip dhcp-server lease find dynamic=no disabled=no] do={\r\
    \n                :local mac  [/ip dhcp-server lease get \$idx mac-address];\r\
    \n                :if (\$1~\"\$mac\") do={ \r\
    \n                    :return (\"\$1 [\$[/ip dhcp-server lease get \$idx address]/\$[/ip dhcp-server lease get \$idx comment]].\"); \r\
    \n                } \r\
    \n            }\r\
    \n            :foreach idx in=[/interface bridge host find] do={\r\
    \n                :local mac  [/interface bridge host get \$idx mac-address];\r\
    \n                :if (\$1~\"\$mac\") do={:return (\"\$1 [\$[/interface bridge host get \$idx on-interface]].\")}\r\
    \n            }\r\
    \n        }\r\
    \n        :return (\$1);\r\
    \n    }\r\
    \n\r\
    \n    # Function of converting CP1251 to UTF8\r\
    \n    # https://forummikrotik.ru/viewtopic.php\?p=81457#p81457\r\
    \n    :local CP1251toUTF8 do={\r\
    \n        :local cp1251 [:toarray {\"\\20\";\"\\01\";\"\\02\";\"\\03\";\"\\04\";\"\\05\";\"\\06\";\"\\07\";\"\\08\";\"\\09\";\"\\0A\";\"\\0B\";\"\\0C\";\"\\0D\";\"\\0E\";\"\\0F\"; \\\r\
    \n                                 \"\\10\";\"\\11\";\"\\12\";\"\\13\";\"\\14\";\"\\15\";\"\\16\";\"\\17\";\"\\18\";\"\\19\";\"\\1A\";\"\\1B\";\"\\1C\";\"\\1D\";\"\\1E\";\"\\1F\"; \\\r\
    \n                                 \"\\21\";\"\\22\";\"\\23\";\"\\24\";\"\\25\";\"\\26\";\"\\27\";\"\\28\";\"\\29\";\"\\2A\";\"\\2B\";\"\\2C\";\"\\2D\";\"\\2E\";\"\\2F\";\"\\3A\"; \\\r\
    \n                                 \"\\3B\";\"\\3C\";\"\\3D\";\"\\3E\";\"\\3F\";\"\\40\";\"\\5B\";\"\\5C\";\"\\5D\";\"\\5E\";\"\\5F\";\"\\60\";\"\\7B\";\"\\7C\";\"\\7D\";\"\\7E\"; \\\r\
    \n                                 \"\\C0\";\"\\C1\";\"\\C2\";\"\\C3\";\"\\C4\";\"\\C5\";\"\\C6\";\"\\C7\";\"\\C8\";\"\\C9\";\"\\CA\";\"\\CB\";\"\\CC\";\"\\CD\";\"\\CE\";\"\\CF\"; \\\r\
    \n                                 \"\\D0\";\"\\D1\";\"\\D2\";\"\\D3\";\"\\D4\";\"\\D5\";\"\\D6\";\"\\D7\";\"\\D8\";\"\\D9\";\"\\DA\";\"\\DB\";\"\\DC\";\"\\DD\";\"\\DE\";\"\\DF\"; \\\r\
    \n                                 \"\\E0\";\"\\E1\";\"\\E2\";\"\\E3\";\"\\E4\";\"\\E5\";\"\\E6\";\"\\E7\";\"\\E8\";\"\\E9\";\"\\EA\";\"\\EB\";\"\\EC\";\"\\ED\";\"\\EE\";\"\\EF\"; \\\r\
    \n                                 \"\\F0\";\"\\F1\";\"\\F2\";\"\\F3\";\"\\F4\";\"\\F5\";\"\\F6\";\"\\F7\";\"\\F8\";\"\\F9\";\"\\FA\";\"\\FB\";\"\\FC\";\"\\FD\";\"\\FE\";\"\\FF\"; \\\r\
    \n                                 \"\\A8\";\"\\B8\";\"\\B9\"}];\r\
    \n        :local utf8   [:toarray {\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"000A\";\"0020\";\"0020\";\"000D\";\"0020\";\"0020\"; \\\r\
    \n                                 \"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\";\"0020\"; \\\r\
    \n                                 \"0021\";\"0022\";\"0023\";\"0024\";\"0025\";\"0026\";\"0027\";\"0028\";\"0029\";\"002A\";\"002B\";\"002C\";\"002D\";\"002E\";\"002F\";\"003A\"; \\\r\
    \n                                 \"003B\";\"003C\";\"003D\";\"003E\";\"003F\";\"0040\";\"005B\";\"005C\";\"005D\";\"005E\";\"005F\";\"0060\";\"007B\";\"007C\";\"007D\";\"007E\"; \\\r\
    \n                                 \"D090\";\"D091\";\"D092\";\"D093\";\"D094\";\"D095\";\"D096\";\"D097\";\"D098\";\"D099\";\"D09A\";\"D09B\";\"D09C\";\"D09D\";\"D09E\";\"D09F\"; \\\r\
    \n                                 \"D0A0\";\"D0A1\";\"D0A2\";\"D0A3\";\"D0A4\";\"D0A5\";\"D0A6\";\"D0A7\";\"D0A8\";\"D0A9\";\"D0AA\";\"D0AB\";\"D0AC\";\"D0AD\";\"D0AE\";\"D0AF\"; \\\r\
    \n                                 \"D0B0\";\"D0B1\";\"D0B2\";\"D0B3\";\"D0B4\";\"D0B5\";\"D0B6\";\"D0B7\";\"D0B8\";\"D0B9\";\"D0BA\";\"D0BB\";\"D0BC\";\"D0BD\";\"D0BE\";\"D0BF\"; \\\r\
    \n                                 \"D180\";\"D181\";\"D182\";\"D183\";\"D184\";\"D185\";\"D186\";\"D187\";\"D188\";\"D189\";\"D18A\";\"D18B\";\"D18C\";\"D18D\";\"D18E\";\"D18F\"; \\\r\
    \n                                 \"D001\";\"D191\";\"2116\"}];\r\
    \n        :local convStr \"\"; \r\
    \n        :local code    \"\";\r\
    \n        :for i from=0 to=([:len \$1]-1) do={\r\
    \n            :local symb [:pick \$1 \$i (\$i+1)]; \r\
    \n            :local idx  [:find \$cp1251 \$symb];\r\
    \n            :local key  (\$utf8->\$idx);\r\
    \n            :if ([:len \$key] != 0) do={\r\
    \n                :set \$code (\"%\$[:pick (\$key) 0 2]%\$[:pick (\$key) 2 4]\");\r\
    \n                :if ([pick \$code 0 3] = \"%00\") do={:set \$code ([:pick \$code 3 6])}\r\
    \n            } else={:set code (\$symb)}; \r\
    \n            :set \$convStr (\$convStr.\$code);\r\
    \n        }\r\
    \n        :return (\$convStr);\r\
    \n    }\r\
    \n\r\
    \n    # Telegram messenger response parsing function\r\
    \n    # https://habr.com/ru/post/482802/\r\
    \n    :local MsgParser do={\r\
    \n        :local variaMod (\"\\\"\".\$2.\"\\\"\");\r\
    \n        :if ([:len [:find \$1 \$variaMod -1]]=0) do={:return (\"'unknown'\")}\r\
    \n        :local startLoc ([:find \$1 \$variaMod -1] + [:len \$variaMod] +1);\r\
    \n        :local commaLoc ([:find \$1 \",\" \$startLoc]);\r\
    \n        :local brakeLoc ([:find \$1 \"}\" \$startLoc]);\r\
    \n        :local endLoc \$commaLoc;\r\
    \n        :local startSymbol [:pick \$1 \$startLoc];\r\
    \n        :if (\$brakeLoc != 0 and (\$commaLoc = 0 or \$brakeLoc < \$commaLoc)) do={:set endLoc \$brakeLoc};\r\
    \n        :if (\$startSymbol = \"{\") do={:set endLoc (\$brakeLoc + 1)};\r\
    \n        :if (\$3 = true) do={\r\
    \n            :set startLoc (\$startLoc + 1);\r\
    \n            :set endLoc   (\$endLoc   - 1);\r\
    \n        }\r\
    \n        :if (\$endLoc < \$startLoc) do={:set endLoc (\$startLoc + 1)};\r\
    \n        :return ([:pick \$1 \$startLoc \$endLoc]);\r\
    \n    }\r\
    \n    \r\
    \n    # Time translation function to UNIX-time\r\
    \n    # https://forum.mikrotik.com/viewtopic.php\?t=75555#p790745\r\
    \n    # Usage: \$EpochTime [time input]\r\
    \n    # Get current time: put [\$EpochTime]\r\
    \n    # Read log time in one of three format: \"hh:mm:ss\", \"mmm/dd hh:mm:ss\" or \"mmm/dd/yyyy hh:mm:ss\"\r\
    \n    :local EpochTime do={\r\
    \n        :local ds [/system clock get date];\r\
    \n        :local ts [/system clock get time];\r\
    \n        :if ([:len \$1] > 19) do={\r\
    \n            :set ds \"\$[:pick \$1 0 11]\";\r\
    \n            :set ts [:pick \$1 12 20];\r\
    \n        }\r\
    \n        :if ([:len \$1] > 8 && [:len \$1] < 20) do={\r\
    \n            :set ds \"\$[:pick \$1 0 6]/\$[:pick \$ds 7 11]\";\r\
    \n            :set ts [:pick \$1 7 15];\r\
    \n        }\r\
    \n        :local yesterday false;\r\
    \n        :if ([:len \$1] = 8) do={\r\
    \n            :if ([:totime \$1] > ts) do={:set yesterday (true)}\r\
    \n            :set ts \$1;\r\
    \n        }\r\
    \n        :local months;\r\
    \n        :if ((([:pick \$ds 9 11]-1)/4) != (([:pick \$ds 9 11])/4)) do={\r\
    \n            :set months {\"an\"=0;\"eb\"=31;\"ar\"=60;\"pr\"=91;\"ay\"=121;\"un\"=152;\"ul\"=182;\"ug\"=213;\"ep\"=244;\"ct\"=274;\"ov\"=305;\"ec\"=335};\r\
    \n        } else={\r\
    \n            :set months {\"an\"=0;\"eb\"=31;\"ar\"=59;\"pr\"=90;\"ay\"=120;\"un\"=151;\"ul\"=181;\"ug\"=212;\"ep\"=243;\"ct\"=273;\"ov\"=304;\"ec\"=334};\r\
    \n        }\r\
    \n        :set ds (([:pick \$ds 9 11]*365)+(([:pick \$ds 9 11]-1)/4)+(\$months->[:pick \$ds 1 3])+[:pick \$ds 4 6]);\r\
    \n        :set ts (([:pick \$ts 0 2]*3600)+([:pick \$ts 3 5]*60)+[:pick \$ts 6 8]);\r\
    \n        :if (yesterday) do={:set ds (\$ds-1)}\r\
    \n        :return (\$ds*86400 + \$ts + 946684800 - [/system clock get gmt-offset]);\r\
    \n    }\r\
    \n\r\
    \n    # Time conversion function from UNIX-time\r\
    \n    # https://forummikrotik.ru/viewtopic.php\?t=11636\r\
    \n    # usage: [\$UnixTimeToFormat \"timeStamp\" \"type\"]\r\
    \n    # type: \"unspecified\" - month/dd/yyyy <only>    (Mikrotik sheduller format)\r\
    \n    #                   1 - yyyy/mm/dd hh:mm:ss\r\
    \n    #                   2 - dd:mm:yyyy hh:mm:ss\r\
    \n    #                   3 - dd month yyy hh mm ss\r\
    \n    #                   4 - yyyy month dd hh mm ss\r\
    \n    #                   5 - month/dd/yyyy-hh:mm:ss  (Mikrotik sheduller format)\r\
    \n    :local UnixTimeToFormat do={\r\
    \n        :local decodedLine \"\";\r\
    \n        :local timeStamp \$1;\r\
    \n        :local timeS (\$timeStamp % 86400);\r\
    \n        :local timeH (\$timeS / 3600);\r\
    \n        :local timeM (\$timeS % 3600 / 60);\r\
    \n        :set  \$timeS (\$timeS - \$timeH * 3600 - \$timeM * 60);\r\
    \n        :local dateD (\$timeStamp / 86400);\r\
    \n        :local dateM 2;\r\
    \n        :local dateY 1970;\r\
    \n        :local leap false;\r\
    \n        :while ((\$dateD / 365) > 0) do={\r\
    \n            :set \$dateD (\$dateD - 365);\r\
    \n            :set \$dateY (\$dateY + 1);\r\
    \n            :set \$dateM (\$dateM + 1);\r\
    \n            :if (\$dateM = 4) do={\r\
    \n                :set \$dateM 0;\r\
    \n                :if ((\$dateY % 400 = 0) or (\$dateY % 100 != 0)) do={\r\
    \n                    :set \$leap true;\r\
    \n                    :set \$dateD (\$dateD - 1);\r\
    \n                }\r\
    \n            } else={:set \$leap false}\r\
    \n        }\r\
    \n        :local months [:toarray (0,31,28,31,30,31,30,31,31,30,31,30,31)];\r\
    \n        :if (leap) do={\r\
    \n            :set \$dateD (\$dateD + 1);\r\
    \n            :set (\$months->2) 29;\r\
    \n        }\r\
    \n        :do {\r\
    \n            :for i from=1 to=12 do={\r\
    \n                :if ((\$months->\$i) > \$dateD) do={\r\
    \n                    :set \$dateM \$i;\r\
    \n                    :set \$dateD (\$dateD + 1);\r\
    \n                    break;\r\
    \n                } else={:set \$dateD (\$dateD - (\$months->\$i))}\r\
    \n            }\r\
    \n        } on-error={}\r\
    \n        :local tmod;\r\
    \n        :if ([:len \$2]!=0) do={:set \$tmod \$2} else={:set \$tmod (:nothing)}\r\
    \n        :local s \"/\";\r\
    \n        :local nf true;\r\
    \n        :local mstr {\"jan\";\"feb\";\"mar\";\"apr\";\"may\";\"jun\";\"jul\";\"aug\";\"sep\";\"oct\";\"nov\";\"dec\"};\r\
    \n        :local strY [:tostr \$dateY];\r\
    \n        :local strMn;\r\
    \n        :local strD;\r\
    \n        :local strH;\r\
    \n        :local strM;\r\
    \n        :local strS;\r\
    \n        :if (\$nf) do={\r\
    \n            :if (\$dateM > 9) do={:set \$strMn [:tostr \$dateM]} else={:set \$strMn (\"0\".[:tostr \$dateM])}\r\
    \n            :if (\$dateD > 9) do={:set \$strD  [:tostr \$dateD]} else={:set \$strD  (\"0\".[:tostr \$dateD])}\r\
    \n            :if (\$timeH > 9) do={:set \$strH  [:tostr \$timeH]} else={:set \$strH  (\"0\".[:tostr \$timeH])}\r\
    \n            :if (\$timeM > 9) do={:set \$strM  [:tostr \$timeM]} else={:set \$strM  (\"0\".[:tostr \$timeM])}\r\
    \n            :if (\$timeS > 9) do={:set \$strS  [:tostr \$timeS]} else={:set \$strS  (\"0\".[:tostr \$timeS])}\r\
    \n        } else={\r\
    \n            :set strMn [:tostr \$dateM];\r\
    \n            :set strD  [:tostr \$dateD];\r\
    \n            :set strH  [:tostr \$timeH];\r\
    \n            :set strM  [:tostr \$timeM];\r\
    \n            :set strS  [:tostr \$timeS];\r\
    \n        }\r\
    \n        :do {\r\
    \n            :if ([:len \$tmod]=0) do={:local mt (\$mstr->(\$dateM - 1)); :set \$decodedLine (\"\$mt/\".\"\$strD/\".\"\$strY\"); break}\r\
    \n            :if (\$tmod = 1) do={:set \$decodedLine \"\$strY\$s\$strMn\$s\$strD \$strH:\$strM:\$strS\"; break}\r\
    \n            :if (\$tmod = 2) do={:set \$decodedLine \"\$strD\$s\$strMn\$s\$strY \$strH:\$strM:\$strS\"; break}\r\
    \n            :if (\$tmod = 3) do={:set \$decodedLine (\"\$strD \".(\$mstr->(\$dateM - 1)).\" \$strY \$strH:\$strM:\$strS\"); break}\r\
    \n            :if (\$tmod = 4) do={:set \$decodedLine (\"\$strY \".(\$mstr->(\$dateM - 1)).\" \$strD \$strH:\$strM:\$strS\"); break}\r\
    \n            :if (\$tmod = 5) do={:local m (\$mstr->(\$dateM - 1)); :set \$decodedLine (\"\$m/\".\"\$strD/\".\"\$strY\".\"-\$strH:\$strM:\$strS\"); break}\r\
    \n        } on-error={}\r\
    \n        :return (\$decodedLine);\r\
    \n    }\r\
    \n\r\
    \n    # Main body of the script\r\
    \n    :global timeAct;\r\
    \n    :global timeLog;\r\
    \n    :local  nameID [/system identity get name];\r\
    \n    :local  timeOf [/system clock get gmt-offset];\r\
    \n    :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Start of TLGRM-script on '\$nameID' router.\");\r\
    \n    :if ([:len \$timeAct] > 0) do={:put (\"\$[\$UnixTimeToFormat (\$timeAct + \$timeOf) 1] - Time when the last command was launched.\")}\r\
    \n    :if ([:len \$timeLog] > 0) do={:put (\"\$[\$UnixTimeToFormat (\$timeLog + \$timeOf) 1] - Time when the log entries were last sent.\")}\r\
    \n\r\
    \n    # Part of the script body to launch via Telegram\r\
    \n    # https://forummikrotik.ru/viewtopic.php\?p=78085\r\
    \n    :local  timeStamp [\$EpochTime];\r\
    \n    :local  urlString \"https://api.telegram.org/\$botID/getUpdates\\\?offset=-1&limit=1&allowed_updates=message\";\r\
    \n    :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - *** Stage of launch scripts, function & commands via Telegram:\");\r\
    \n    :if ([:len \$timeAct] = 0) do={\r\
    \n        :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Time of the last launch of the command was not found.\");\r\
    \n        :set timeAct \$timeStamp;\r\
    \n    } else={\r\
    \n        :local httpResp [/tool fetch url=\$urlString as-value output=user];\r\
    \n        :local content (\$httpResp->\"data\");\r\
    \n        :if ([:len \$content] > 30) do={\r\
    \n            :local msgTxt   [\$MsgParser \$content \"text\" true];\r\
    \n            :set   msgTxt  ([:pick \$msgTxt  ([:find \$msgTxt \"/\" -1] +1)  [:len \$msgTxt]]);\r\
    \n            :local msgAddr \"\";\r\
    \n            :if (\$broadCast) do={:set \$msgAddr \$nameID} else={\r\
    \n                :set msgAddr ([:pick \$msgTxt 0 [:find \$msgTxt \" \" -1]]);\r\
    \n                :if ([:len [:find \$msgTxt \" \"]]=0) do={:set msgAddr (\"\$msgTxt \")}\r\
    \n                :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Recipient of the Telegram message: '\$msgAddr'\");\r\
    \n                :set msgTxt ([:pick \$msgTxt ([:find \$msgTxt \$msgAddr -1] + [:len \$msgAddr] +1) [:len \$msgTxt]]);\r\
    \n            }\r\
    \n            :if (\$msgAddr=\$nameID or \$msgAddr=\"forall\") do={\r\
    \n                :local chat     [\$MsgParser \$content \"chat\"];\r\
    \n                :local chatId   [\$MsgParser \$chat    \"id\"];\r\
    \n                :local userName [\$MsgParser \$content \"username\"];\r\
    \n                :set  timeStamp [\$MsgParser \$content \"date\"];\r\
    \n                :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Sender of the Telegram message: \$userName\");\r\
    \n                :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Command to execute: '\$msgTxt'\");\r\
    \n                :local restline [];\r\
    \n                :if ([:len [:find \$msgTxt \" \"]] !=0) do={\r\
    \n                    :set restline [:pick \$msgTxt  ([:find \$msgTxt \" \"] +1) [:len \$msgTxt]];\r\
    \n                    :set msgTxt [:pick \$msgTxt 0 [:find \$msgTxt \" \"]];\r\
    \n                }\r\
    \n                :if (\$chatId=\$myChatID && \$timeAct<\$timeStamp) do={\r\
    \n                    :set timeAct \$timeStamp;\r\
    \n                    :if ([/system script environment find name=\$msgTxt]!=\"\" && \$launchFnc=true) do={   \r\
    \n                        :if (([/system script environment get [/system script environment find name=\$msgTxt] value]=\"(code)\") \\\r\
    \n                            or  ([:len [:find [/system script environment get [/system script environment find name=\$msgTxt] value] \"(eval\"]]>0)) do={\r\
    \n                            :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Telegram user \$userName launches function '\$msgTxt'.\");\r\
    \n                            :log warning (\"Telegram user \$userName launches function '\$msgTxt'.\");\r\
    \n                            [:parse \":global \$msgTxt; [\\\$\$msgTxt \$restline]\"];\r\
    \n                        } else={\r\
    \n                            :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - '\$msgTxt' is a global variable and not a function - no execute.\");\r\
    \n                            :log warning (\"'\$msgTxt' is a global variable and not a function - no execute.\");\r\
    \n                        }\r\
    \n                    }\r\
    \n                    :if ([/system script find name=\$msgTxt]!=\"\" && \$launchScr=true) do={\r\
    \n                        :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Telegram user \$userName activates script '\$msgTxt'.\");\r\
    \n                        :log warning (\"Telegram user \$userName activates script '\$msgTxt'.\");\r\
    \n                        [[:parse \"[:parse [/system script get \$msgTxt source]] \$restline\"]];\r\
    \n                    }\r\
    \n                    :if ([/system script find name=\$msgTxt]=\"\" && [/system script environment find name=\$msgTxt;]=\"\" && \$launchCmd=true) do={\r\
    \n                        :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Telegram user \$userName is trying to execute command '\$msgTxt'.\");\r\
    \n                        :log warning (\"Telegram user \$userName is trying to execute command '\$msgTxt'.\");\r\
    \n                        :do {[:parse \"/\$msgTxt \$restline\"]} on-error={}\r\
    \n                    }\r\
    \n                } else={:put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Wrong time to launch.\")}\r\
    \n            } else={:put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - No command found for this device.\")}\r\
    \n        } else={:put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Completion of response from Telegram.\")}\r\
    \n    }\r\
    \n\r\
    \n    # Part of the script body for notifications in Telegram\r\
    \n    # https://www.reddit.com/r/mikrotik/comments/onusoj/sending_log_alerts_to_telegram/\r\
    \n    :local outMsg \"\";\r\
    \n    :local logGet [:toarray [/log find (\$topics~\"warning\" or \$topics~\"error\" or \$topics~\"critical\" or \$topics~\"caps\" or \\\r\
    \n        \$topics~\"wireless\" or \$message~\"logged in\" or \$message~\"TCP connection\")]];\r\
    \n    :local logCnt [:len \$logGet];\r\
    \n    :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - *** Stage of sending notifications to Telegram:\");\r\
    \n    :if ([:len \$timeLog] = 0) do={ \r\
    \n        :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Time of the last log entry was not found.\");\r\
    \n        :set outMsg (\">\$[/system clock get time] Telegram notification started.\");\r\
    \n    }\r\
    \n    :if (\$logCnt > 0) do={\r\
    \n        :local lastTime [\$EpochTime [/log get [:pick \$logGet (\$logCnt-1)] time]];\r\
    \n        :local index 0;\r\
    \n        :local tempTime;\r\
    \n        :local tempMessage;\r\
    \n        :local tempTopic;\r\
    \n        :local unixTime;\r\
    \n        :do {\r\
    \n            :set index        (\$index + 1); \r\
    \n            :set tempTime     [/log get [:pick \$logGet (\$logCnt - \$index)]    time];\r\
    \n            :set tempTopic    [/log get [:pick \$logGet (\$logCnt - \$index)]  topics];\r\
    \n            :set tempMessage  [/log get [:pick \$logGet (\$logCnt - \$index)] message];\r\
    \n            :set tempMessage  (\">\".\$tempTime.\" \".\$tempMessage);\r\
    \n            :local findMacMsg ([\$FindMacAddr \$tempMessage]);\r\
    \n            :set unixTime [\$EpochTime \$tempTime];\r\
    \n            :if ((\$unixTime > \$timeLog) && (!((\$tempTopic~\"caps\" or \$tempTopic~\"wireless\" or \$tempTopic~\"dhcp\") \\\r\
    \n                && (\$tempMessage != \$findMacMsg)))) do={\r\
    \n                :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Found log entry: \$findMacMsg\");\r\
    \n                :set outMsg (\$findMacMsg.\"\\n\".\$outMsg);\r\
    \n            }\r\
    \n        } while=((\$unixTime > \$timeLog) && (\$index < \$logCnt));\r\
    \n        :if (([:len \$timeLog] < 1) or (([:len \$timeLog] > 0) && (\$timeLog != \$lastTime) && ([:len \$outMsg] > 8) )) do={\r\
    \n            :set timeLog \$lastTime;\r\
    \n            :if ([:len \$outMsg] > 4096) do={:set outMsg ([:pick \$outMsg 0 4096])}\r\
    \n            :set outMsg [\$CP1251toUTF8 \$outMsg];\r\
    \n            :set outMsg (\"\$Emoji \".\"\$nameID\".\":\".\"%0A\".\"\$outMsg\");\r\
    \n            :local urlString (\"https://api.telegram.org/\$botID/sendmessage\\\?chat_id=\$myChatID&text=\$outMsg\");\r\
    \n            :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Generated string for Telegram:\\r\\n\".\$urlString);\r\
    \n            /tool fetch url=\$urlString as-value output=user;\r\
    \n        } else={:put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - There are no log entries to send.\")}\r\
    \n    } else={:put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - Necessary log entries were not found.\")}\r\
    \n    :put (\"\$[\$UnixTimeToFormat ([\$EpochTime] + \$timeOf) 1] - End of TLGRM-script on '\$nameID' router.\");\r\
    \n} on-error={ \r\
    \n    :put (\"Script error: something didn't work when sending a request to Telegram.\");\r\
    \n    :put (\"*** First, check the correctness of the values of the variables botID & myChatID. ***\"); \r\
    \n}\r\
    \n\r\
    \n"
/tool bandwidth-server set enabled=no
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com password=zgejdmvndvorrmsn port=587 start-tls=yes user=defm.kopcap@gmail.com
/tool graphing set page-refresh=50
/tool graphing interface add
/tool graphing resource add
/tool mac-server set allowed-interface-list=none
/tool mac-server mac-winbox set allowed-interface-list=list-winbox-allowed
/tool netwatch add comment="miniAlx status check" down-script="\r\
    \n:put \"info: Netwatch UP\"\r\
    \n:log info \"Netwatch UP\"\r\
    \n\r\
    \n:global NetwatchHostName \"miniAlx\";\r\
    \n/system script run doNetwatchHost;" host=192.168.90.180 up-script="\r\
    \n:put \"info: Netwatch UP\"\r\
    \n:log info \"Netwatch UP\"\r\
    \n\r\
    \n:global NetwatchHostName \"miniAlx\";\r\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-interface=ip-mapping-br filter-operator-between-entries=and streaming-server=192.168.90.170
