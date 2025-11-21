# 2025-11-21 21:13:02 by RouterOS 7.20
# software id = IA5H-12KT
#
# model = RB5009UPr+S+
# serial number = HCY086PZ6XZ
/caps-man channel add band=2ghz-b/g/n comment=CH1 control-channel-width=20mhz extension-channel=disabled frequency=2412 name=common-chnls-2Ghz reselect-interval=10h skip-dfs-channels=yes tx-power=17
/caps-man channel add band=5ghz-a/n/ac comment="20Mhz + Ce = 40Mhz, reselect interval from 5180, 5220, 5745, 5785 once per 10h" control-channel-width=20mhz extension-channel=Ce frequency=5180,5220,5745,5785 name=common-chnls-5Ghz reselect-interval=10h tx-power=15
/caps-man configuration add mode=ap name=empty
/interface bridge add name=docker-infrastructure-br port-cost-mode=short
/interface bridge add dhcp-snooping=yes igmp-snooping=yes name=guest-infrastructure-br port-cost-mode=short
/interface bridge add arp=proxy-arp fast-forward=no name=ip-mapping-br port-cost-mode=short
/interface bridge add admin-mac=48:8F:5A:D4:5F:69 arp=reply-only auto-mac=no dhcp-snooping=yes igmp-snooping=yes name=main-infrastructure-br port-cost-mode=short
/interface bridge add arp=proxy-arp fast-forward=no name=ospf-loopback-br
/interface ethernet set [ find default-name=ether2 ] arp=disabled comment="to WB (wire)" loop-protect=on name="lan A" poe-out=forced-on
/interface ethernet set [ find default-name=ether3 ] arp=disabled comment="to miniAlx (wire)" loop-protect=on name="lan B"
/interface ethernet set [ find default-name=ether4 ] arp=disabled comment="to MbpAlxm (wire)" loop-protect=on name="lan C"
/interface ethernet set [ find default-name=ether5 ] arp=disabled name="lan D"
/interface ethernet set [ find default-name=ether6 ] arp=disabled comment="to capxl(wire)" loop-protect=on name="lan E"
/interface ethernet set [ find default-name=ether7 ] arp=disabled comment="to PC(wire)" loop-protect=on name="lan F"
/interface ethernet set [ find default-name=ether8 ] comment="to ATV(wire)" loop-protect=on name="lan G"
/interface ethernet set [ find default-name=sfp-sfpplus1 ] disabled=yes name=optic
/interface ethernet set [ find default-name=ether1 ] arp=proxy-arp mac-address=20:CF:30:DE:7B:2A name="wan A" poe-out=off
/interface veth add address=192.168.80.2/24 dhcp=no gateway=192.168.80.1 gateway6="" mac-address=02:23:29:BF:B3:C8 name=bydpi-tunnel
/caps-man datapath add arp=proxy-arp bridge=guest-infrastructure-br client-to-client-forwarding=no name=2CapsMan-guest
/caps-man datapath add arp=reply-only bridge=main-infrastructure-br client-to-client-forwarding=yes name=2CapsMan-private
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps name="5GHz Rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps vht-basic-mcs=mcs0-9 vht-supported-mcs=mcs0-9
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps ht-basic-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 ht-supported-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 name="2GHz rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps
/caps-man security add authentication-types=wpa2-psk comment="2GHz/5GHz Security" encryption=aes-ccm group-encryption=aes-ccm group-key-update=1h name=private passphrase=mikrotik
/caps-man security add authentication-types="" comment="2GHz/5GHz FREE" encryption="" group-key-update=5m name=guest
/disk set usb slot=usb
/disk add comment=container-disk parent=usb partition-number=1 partition-offset=65536 partition-size=5000000000 slot=usb-docker type=partition
/disk add parent=usb partition-number=2 partition-offset=5000069120 partition-size=1000000000 slot=usb-swap swap=yes type=partition
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
/interface list add comment="infrastructure OSPF interfaces" name=list-ospf-master
/interface list add comment="support OSPF interfaces" name=list-ospf-bearing
/interface list add comment="mangle rule: redirect to docker" name=list-mangle-byedpi
/caps-man configuration add channel=common-chnls-2Ghz country=russia datapath=2CapsMan-private datapath.interface-list=list-2ghz-caps-private distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-2Ghz-private rx-chains=0,1,2,3 security=private ssid="WiFi 2Ghz PRIVATE" tx-chains=0,1,2,3
/caps-man configuration add channel=common-chnls-5Ghz country=russia datapath=2CapsMan-private datapath.interface-list=list-5ghz-caps-private disconnect-timeout=9s distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-5Ghz-private rx-chains=0,1,2,3 security=private ssid="WiFi 5Ghz PRIVATE" tx-chains=0,1,2,3
/caps-man configuration add channel=common-chnls-2Ghz country=russia datapath=2CapsMan-guest datapath.interface-list=list-2ghz-caps-guest distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-2Ghz-guest rx-chains=0,1,2,3 security=guest ssid="WiFi 2Ghz FREE" tx-chains=0,1,2,3
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=anna
/interface wireless security-profiles add authentication-types=wpa2-psk eap-methods="" group-key-update=1h management-protection=allowed mode=dynamic-keys name=private supplicant-identity="" wpa-pre-shared-key=mikrotik wpa2-pre-shared-key=mikrotik
/interface wireless security-profiles add authentication-types=wpa-psk,wpa2-psk eap-methods="" management-protection=allowed name=public supplicant-identity=""
/iot lora servers add address=eu1.cloud.thethings.industries name="TTS Cloud (eu1)" protocol=UDP
/iot lora servers add address=nam1.cloud.thethings.industries name="TTS Cloud (nam1)" protocol=UDP
/iot lora servers add address=au1.cloud.thethings.industries name="TTS Cloud (au1)" protocol=UDP
/iot lora servers add address=eu1.cloud.thethings.network name="TTN V3 (eu1)" protocol=UDP
/iot lora servers add address=nam1.cloud.thethings.network name="TTN V3 (nam1)" protocol=UDP
/iot lora servers add address=au1.cloud.thethings.network name="TTN V3 (au1)" protocol=UDP
/ip dhcp-server add authoritative=after-2sec-delay interface=main-infrastructure-br lease-time=1d name=main-dhcp-server
/ip dhcp-server option add code=15 force=yes name=DomainName_Windows value="s'home'"
/ip dhcp-server option add code=119 force=yes name=DomainName_LinuxMac value="s'home'"
/ip dns forwarders add doh-servers=https://dns.google/dns-query name=DOH-Google
/ip dns forwarders add doh-servers=https://cloudflare-dns.com/dns-query name=DOH-CloudFlare
/ip dns forwarders add doh-servers=https://dns.quad9.net/dns-query name=DOH-Quad9
/ip dns forwarders add dns-servers=8.8.8.8 name=DNS-Google8 verify-doh-cert=no
/ip dns forwarders add doh-servers=https://router.comss.one/dns-query name=DOH-Comss
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
/ip ipsec profile set [ find default=yes ] dh-group=modp1024 dpd-interval=2m dpd-maximum-failures=5
/ip ipsec profile add dh-group=modp1024 dpd-interval=2m dpd-maximum-failures=5 enc-algorithm=aes-256 hash-algorithm=sha256 name=ROUTEROS
/ip ipsec peer add address=185.13.148.14/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, outer-tunnel encryption, RSA)" exchange-mode=ike2 local-address=10.20.225.166 name=CHR-external profile=ROUTEROS
/ip ipsec peer add address=10.0.0.1/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, traffic-only encryption)" local-address=10.0.0.3 name=CHR-internal profile=ROUTEROS
/ip ipsec proposal set [ find default=yes ] enc-algorithms=aes-256-cbc,aes-192-cbc,aes-128-cbc,3des lifetime=1h
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip kid-control add fri=0s-1d mon=0s-1d name=totals sat=0s-1d sun=0s-1d thu=0s-1d tue=0s-1d wed=0s-1d
/ip pool add name=pool-main ranges=192.168.90.100-192.168.90.200
/ip pool add name=pool-guest ranges=192.168.98.200-192.168.98.230
/ip pool add name=pool-virtual-machines ranges=192.168.90.0/26
/ip pool add name=pool-vendor ranges=192.168.90.2-192.168.90.10
/ip dhcp-server add add-arp=yes address-pool=pool-guest authoritative=after-2sec-delay interface=guest-infrastructure-br lease-script="\r\
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
/ip smb users set [ find default=yes ] disabled=yes
/ppp profile add address-list=alist-l2tp-active-clients comment=to-CHR interface-list=list-l2tp-tunnels local-address=10.0.0.3 name=l2tp-no-encrypt-site2site only-one=no remote-address=10.0.0.1
/ppp profile add bridge-learning=no change-tcp-mss=no local-address=0.0.0.0 name=null only-one=yes remote-address=0.0.0.0 session-timeout=1s use-compression=no use-encryption=no use-mpls=no use-upnp=no
/interface l2tp-client add allow=mschap2 connect-to=185.13.148.14 disabled=no max-mru=1360 max-mtu=1360 name=chr-tunnel password=123 profile=l2tp-no-encrypt-site2site user=vpn-remote-anna
/queue simple add comment=dtq,50:DE:06:25:C2:FC,iPadProAlx name="iPadAlxPro@main-dhcp-server (50:DE:06:25:C2:FC)" queue=default/default target=192.168.90.130/32 total-queue=default
/queue simple add comment=dtq,B0:34:95:50:A1:6A, name="AudioATV(blocked)@guest-dhcp-server (B0:34:95:50:A1:6A)" queue=default/default target=192.168.98.231/32 total-queue=default
/queue simple add comment=dtq,90:DD:5D:C8:46:AB,AlxATV name="AlxATV (wireless)@main-dhcp-server (90:DD:5D:C8:46:AB)" queue=default/default target=192.168.90.200/32 total-queue=default
/queue simple add comment=dtq,B0:34:95:50:A1:6A, name="AudioATV (wireless)@main-dhcp-server (B0:34:95:50:A1:6A)" queue=default/default target=192.168.90.210/32 total-queue=default
/queue simple add comment=dtq,10:DD:B1:9E:19:5E,miniAlx name="miniAlx (wire)@main-dhcp-server (10:DD:B1:9E:19:5E)" queue=default/default target=192.168.90.70/32 total-queue=default
/queue simple add comment=dtq,00:11:32:2C:A7:85, name="NAS@main-dhcp-server (00:11:32:2C:A7:85)" queue=default/default target=192.168.90.40/32 total-queue=default
/queue simple add comment=dtq,FC:F5:C4:79:ED:D8, name="Twinkle@main-dhcp-server (FC:F5:C4:79:ED:D8)" queue=default/default target=192.168.90.170/32 total-queue=default
/queue simple add comment=dtq,FC:F5:C4:79:ED:D8, name="Twinkle(blocked)@guest-dhcp-server (FC:F5:C4:79:ED:D8)" queue=default/default target=192.168.98.170/32 total-queue=default
/queue simple add comment=dtq,54:35:30:05:9B:BD, name="ASUS(wireless)@main-dhcp-server (54:35:30:05:9B:BD)" queue=default/default target=192.168.90.88/32 total-queue=default
/queue simple add comment=dtq,54:35:30:05:9B:BD, name="ASUS(wireless)(blocked)@guest-dhcp-server (54:35:30:05:9B:BD)" queue=default/default target=192.168.98.88/32 total-queue=default
/queue simple add comment=dtq,BC:D0:74:0A:B2:6A,MbpAlxm name="MbpAlxm (wireless)@main-dhcp-server (BC:D0:74:0A:B2:6A)" queue=default/default target=192.168.90.75/32 total-queue=default
/queue simple add comment=dtq,BC:D0:74:0A:B2:6A, name="MbpAlxm(blocked)@guest-dhcp-server (BC:D0:74:0A:B2:6A)" queue=default/default target=192.168.98.75/32 total-queue=default
/queue simple add comment=dtq,48:65:EE:19:3C:0D,MbpAlxm name="MbpAlxm (wire)@main-dhcp-server (48:65:EE:19:3C:0D)" queue=default/default target=192.168.90.85/32 total-queue=default
/queue simple add comment=dtq,48:65:EE:19:3C:0D, name="MbpAlxm(blocked)@guest-dhcp-server (48:65:EE:19:3C:0D)" queue=default/default target=192.168.98.85/32 total-queue=default
/queue simple add comment=dtq,F8:3F:51:0D:88:0B,localhost name="SamsungTV(wire)@main-dhcp-server (F8:3F:51:0D:88:0B)" queue=default/default target=192.168.90.205/32 total-queue=default
/queue simple add comment=dtq,F8:3F:51:0D:88:0B, name="SamsungTV(wire)(blocked)@guest-dhcp-server (F8:3F:51:0D:88:0B)" queue=default/default target=192.168.98.205/32 total-queue=default
/queue simple add comment=dtq,88:88:88:88:87:88,DESKTOP-QMUE5PH name="Hare's AsusPC(wire)@main-dhcp-server (88:88:88:88:87:88)" queue=default/default target=192.168.90.100/32 total-queue=default
/queue simple add comment=dtq,88:88:88:88:87:88, name="AsusPC(wire)(blocked)@guest-dhcp-server (88:88:88:88:87:88)" queue=default/default target=192.168.98.100/32 total-queue=default
/queue simple add comment=dtq,90:DD:5D:CA:8F:B0,AlxATV name="AlxATV(wire)@main-dhcp-server (90:DD:5D:CA:8F:B0)" queue=default/default target=192.168.90.201/32 total-queue=default
/queue simple add comment=dtq,90:DD:5D:CA:8F:B0, name="AlxATV(wire)(blocked)@guest-dhcp-server (90:DD:5D:CA:8F:B0)" queue=default/default target=192.168.98.201/32 total-queue=default
/queue simple add comment=dtq,04:F1:69:8E:12:B6,HONOR_9X-dbcb7b0850fde5c5 name="Hare's Honor9x(wireless)@main-dhcp-server (04:F1:69:8E:12:B6)" queue=default/default target=192.168.90.140/32 total-queue=default
/queue simple add comment=dtq,04:F1:69:8E:12:B6, name="Hare's Honor9x(wireless)(blocked)@guest-dhcp-server (04:F1:69:8E:12:B6)" queue=default/default target=192.168.98.140/32 total-queue=default
/queue simple add comment=dtq,B8:87:6E:19:90:33,yandex-mini2-ZGNK name="Alice(wireless)@main-dhcp-server (B8:87:6E:19:90:33)" queue=default/default target=192.168.90.220/32 total-queue=default
/queue simple add comment=dtq,B8:87:6E:19:90:33, name="Alice(wireless)(blocked)@guest-dhcp-server (B8:87:6E:19:90:33)" queue=default/default target=192.168.98.220/32 total-queue=default
/queue simple add comment=dtq,D4:A6:51:C9:54:A7, name="Tuya(wireless)@main-dhcp-server (D4:A6:51:C9:54:A7)" queue=default/default target=192.168.90.180/32 total-queue=default
/queue simple add comment=dtq,D4:A6:51:C9:54:A7, name="Tuya(wireless)(blocked)@guest-dhcp-server (D4:A6:51:C9:54:A7)" queue=default/default target=192.168.98.180/32 total-queue=default
/queue simple add comment=dtq,D4:3B:04:87:C7:47,DESKTOP-G3RE47G name="HareDell@main-dhcp-server (D4:3B:04:87:C7:47)" queue=default/default target=192.168.90.77/32 total-queue=default
/queue simple add comment=dtq,D4:3B:04:87:C7:47, name="HareDell(blocked)@guest-dhcp-server (D4:3B:04:87:C7:47)" queue=default/default target=192.168.98.77/32 total-queue=default
/queue simple add comment=dtq,50:DE:06:25:C2:FC, name="iPadAlxPro(blocked)@guest-dhcp-server (50:DE:06:25:C2:FC)" queue=default/default target=192.168.98.130/32 total-queue=default
/queue simple add comment=dtq,40:80:E1:5B:41:B8,nspanel name="NSPanel(wireless)@main-dhcp-server (40:80:E1:5B:41:B8)" queue=default/default target=192.168.90.165/32 total-queue=default
/queue simple add comment=dtq,40:80:E1:5B:41:B8, name="NSPanel(wireless)(blocked)@guest-dhcp-server (40:80:E1:5B:41:B8)" queue=default/default target=192.168.98.165/32 total-queue=default
/queue simple add comment=dtq,DC:10:57:2D:39:7B,iPhoneAlxr name="iPhoneAlxr(wireless)@main-dhcp-server (DC:10:57:2D:39:7B)" queue=default/default target=192.168.90.150/32 total-queue=default
/queue simple add comment=dtq,00:1C:42:FE:E3:AB,W11 name="W11Parallels@main-dhcp-server (00:1C:42:FE:E3:AB)" queue=default/default target=192.168.90.35/32 total-queue=default
/queue simple add comment=dtq,00:1C:42:FE:E3:AB, name="W11Parallels(blocked)@guest-dhcp-server (00:1C:42:FE:E3:AB)" queue=default/default target=192.168.98.35/32 total-queue=default
/queue simple add comment=dtq,00:85:01:01:50:0E,wb name="WB (wire)@main-dhcp-server (00:85:01:01:50:0E)" queue=default/default target=192.168.90.2/32 total-queue=default
/queue simple add comment=dtq,00:85:01:01:50:0E, name="WB (wire)(blocked)@guest-dhcp-server (00:85:01:01:50:0E)" queue=default/default target=192.168.98.2/32 total-queue=default
/queue simple add comment=dtq,CA:FE:0F:0B:19:3A,wb name="WB (wireless)@main-dhcp-server (CA:FE:0F:0B:19:3A)" queue=default/default target=192.168.90.3/32 total-queue=default
/queue simple add comment=dtq,CA:FE:0F:0B:19:3A, name="WB (wireless)(blocked)@guest-dhcp-server (CA:FE:0F:0B:19:3A)" queue=default/default target=192.168.98.3/32 total-queue=default
/queue simple add comment=dtq,18:FD:74:94:FD:70,capxl name="capxl(wire)@main-dhcp-server (18:FD:74:94:FD:70)" queue=default/default target=192.168.90.10/32 total-queue=default
/queue simple add comment=dtq,88:53:95:30:68:9F, name="miniAlx(wireless)@main-dhcp-server (88:53:95:30:68:9F)" queue=default/default target=192.168.90.80/32 total-queue=default
/queue simple add comment=dtq,88:53:95:30:68:9F, name="miniAlx(wireless)(blocked)@guest-dhcp-server (88:53:95:30:68:9F)" queue=default/default target=192.168.98.80/32 total-queue=default
/queue simple add comment=dtq,BC:74:4B:E8:9B:61, name="nSwitch(wereless)@main-dhcp-server (BC:74:4B:E8:9B:61)" queue=default/default target=192.168.90.199/32 total-queue=default
/queue simple add comment=dtq,BC:74:4B:E8:9B:61, name="nSwitch(wereless)(blocked)@guest-dhcp-server (BC:74:4B:E8:9B:61)" queue=default/default target=192.168.98.199/32 total-queue=default
/queue simple add comment=dtq,F4:2B:8C:AF:34:20,nadezda-phone name="SamsungS23(wereless)@main-dhcp-server (F4:2B:8C:AF:34:20)" queue=default/default target=192.168.90.135/32 total-queue=default
/queue simple add comment=dtq,F4:2B:8C:AF:34:20, name="SamsungS23(wereless)(blocked)@guest-dhcp-server (F4:2B:8C:AF:34:20)" queue=default/default target=192.168.98.135/32 total-queue=default
/queue simple add comment=dtq,00:0E:2D:1A:73:36,ast25b name="AST(wire)@main-dhcp-server (00:0E:2D:1A:73:36)" queue=default/default target=192.168.90.203/32 total-queue=default
/queue simple add comment=dtq,00:0E:2D:1A:73:36, name="AST(wire)(blocked)@guest-dhcp-server (00:0E:2D:1A:73:36)" queue=default/default target=192.168.98.203/32 total-queue=default
/queue simple add comment=dtq,2C:0B:97:C1:A8:C8,Redmi-Note-13-Pro name="Elvira(wireless)@main-dhcp-server (2C:0B:97:C1:A8:C8)" queue=default/default target=192.168.90.133/32 total-queue=default
/queue simple add comment=dtq,2C:0B:97:C1:A8:C8, name="Elvira(wireless)(blocked)@guest-dhcp-server (2C:0B:97:C1:A8:C8)" queue=default/default target=192.168.98.133/32 total-queue=default
/queue simple add comment=dtq,BC:B2:CC:5F:9D:C4,A55-pol-zovatela-Sergej name="Serg(wireless)@main-dhcp-server (BC:B2:CC:5F:9D:C4)" queue=default/default target=192.168.90.134/32 total-queue=default
/queue simple add comment=dtq,BC:B2:CC:5F:9D:C4, name="Serg(wireless)(blocked)@guest-dhcp-server (BC:B2:CC:5F:9D:C4)" queue=default/default target=192.168.98.134/32 total-queue=default
/queue simple add comment=dtq,34:5A:60:89:1C:E1,NWS-116 name="MSI(wire)@main-dhcp-server (34:5A:60:89:1C:E1)" queue=default/default target=192.168.90.66/32 total-queue=default
/queue simple add comment=dtq,34:5A:60:89:1C:E1, name="MSI(wire)(blocked)@guest-dhcp-server (34:5A:60:89:1C:E1)" queue=default/default target=192.168.98.66/32 total-queue=default
/queue simple add comment=dtq,22:26:E9:CA:87:BA, name="Tomm(wireless)@main-dhcp-server (22:26:E9:CA:87:BA)" queue=default/default target=192.168.90.143/32 total-queue=default
/queue simple add comment=dtq,22:26:E9:CA:87:BA, name="Tomm(wireless)(blocked)@guest-dhcp-server (22:26:E9:CA:87:BA)" queue=default/default target=192.168.98.143/32 total-queue=default
/queue simple add comment=dtq,C8:90:8A:9A:50:A1,A54-pol-zovatela-Natalya name="Froloff(wireless)@main-dhcp-server (C8:90:8A:9A:50:A1)" queue=default/default target=192.168.90.142/32 total-queue=default
/queue simple add comment=dtq,C8:90:8A:9A:50:A1, name="Froloff(wireless)(blocked)@guest-dhcp-server (C8:90:8A:9A:50:A1)" queue=default/default target=192.168.98.142/32 total-queue=default
/queue simple add comment=dtq,2C:D2:6B:42:D5:54, name="@guest-dhcp-server (2C:D2:6B:42:D5:54)" queue=default/default target=192.168.98.227/32 total-queue=default
/queue tree add comment="FILE download control" name="Total Bandwidth" parent=global queue=default
/queue tree add name=RAR packet-mark=rar-mark parent="Total Bandwidth" queue=default
/queue tree add name=EXE packet-mark=exe-mark parent="Total Bandwidth" queue=default
/queue tree add name=7Z packet-mark=7z-mark parent="Total Bandwidth" queue=default
/queue tree add name=ZIP packet-mark=zip-mark parent="Total Bandwidth" queue=default
/routing id add comment="OSPF Common" disabled=no id=10.255.255.3 name=anna-10.255.255.3
/routing ospf instance add comment="OSPF Common - inject into \"main\" table" disabled=no in-filter-chain=ospf-in name=routes-inject-into-main originate-default=always redistribute="" router-id=anna-10.255.255.3 routing-table=rmark-vpn-redirect
/routing ospf area add disabled=no instance=routes-inject-into-main name=backbone
/routing ospf area add area-id=0.0.0.3 default-cost=10 disabled=no instance=routes-inject-into-main name=anna-space-main no-summaries type=stub
/routing table add comment="tunnel swing" fib name=rmark-vpn-redirect
/routing table add comment="dpi swing" disabled=no fib name=rmark-docker-redirect
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action set 1 disk-file-name=journal
/system logging action set 3 remote=0.0.0.0
/system logging action add name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=1 disk-file-name=ScriptsDiskLog disk-lines-per-file=300 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=20 disk-file-name=ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add name=OnScreenLog target=memory
/system logging action add name=DHCPOnScreenLog target=memory
/system logging action add name=DNSOnScreenLog target=memory
/system logging action add name=RouterControlLog target=memory
/system logging action add name=OSPFOnscreenLog target=memory
/system logging action add name=L2TPOnScreenLog target=memory
/system logging action add disk-file-count=20 disk-file-name=AuthDiskLog disk-lines-per-file=300 name=AuthDiskLog target=disk
/system logging action add name=CertificatesOnScreenLog target=memory
/system logging action add name=ParseMemoryLog target=memory
/system logging action add name=CAPSOnScreenLog target=memory
/system logging action add name=FirewallOnScreenLog target=memory
/system logging action add name=SSHOnScreenLog target=memory
/system logging action add name=PoEOnscreenLog target=memory
/system logging action add name=EmailOnScreenLog target=memory
/system logging action add name=DockerRemoteLog remote=minialx.home remote-log-format=syslog syslog-facility=local0 target=remote
/system logging action add name=TransfersOnscreenLog target=memory
/system logging action add disk-file-count=1 disk-file-name=PKGInstallationLog disk-lines-per-file=100 name=PKGInstallationLog target=disk
/system logging action add disk-file-count=1 disk-file-name=REBOOTLog disk-lines-per-file=100 name=REBOOTLog target=disk
/system logging action add name=DockerOnscreenLog target=memory
/system logging action add cef-event-delimiter="" name=AlloyRemoteLog remote=minialx.home remote-log-format=cef remote-protocol=tcp syslog-facility=local0 target=remote
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!write,!policy,!sensitive
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!policy,!sensitive
/user group add name=mktxp policy=read,api,!local,!telnet,!ssh,!ftp,!reboot,!write,!policy,!test,!winbox,!password,!web,!sniff,!sensitive,!romon,!rest-api
/caps-man access-list add action=reject allow-signal-out-of-range=10s comment="Drop any when poor signal rate, https://support.apple.com/en-us/HT203068" disabled=no signal-range=-120..-80 ssid-regexp=WiFi
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Froloff(wireless)" disabled=no mac-address=B8:94:E7:61:3F:08 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Froloff(wireless)" disabled=no mac-address=C8:90:8A:9A:50:A1 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Tomm(wireless)" disabled=no mac-address=22:26:E9:CA:87:BA ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="MSI(wire)" disabled=no mac-address=34:5A:60:89:1C:E1 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Serg(wireless)" disabled=no mac-address=BC:B2:CC:5F:9D:C4 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Elvira(wireless)" disabled=no mac-address=2C:0B:97:C1:A8:C8 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="SamsungS23(wereless)" disabled=no mac-address=F6:12:A6:71:59:08 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="SamsungS23(wereless)" disabled=no mac-address=F4:2B:8C:AF:34:20 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="AST(wire)" disabled=no mac-address=00:0E:2D:1A:73:36 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="nSwitch(wereless)" disabled=no mac-address=BC:74:4B:E8:9B:61 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=iPadAlxPro disabled=no mac-address=50:DE:06:25:C2:FC ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="miniAlx(wireless)" disabled=no mac-address=88:53:95:30:68:9F ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=W11Parallels disabled=yes mac-address=00:1C:42:FE:E3:AB ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="iPhoneAlxr(wireless)" disabled=no mac-address=DC:10:57:2D:39:7B ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="NSPanel(wireless)" disabled=no mac-address=40:80:E1:5B:41:B8 ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=HareDell disabled=no mac-address=D4:3B:04:87:C7:47 ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Tuya(wireless)" disabled=no mac-address=D4:A6:51:C9:54:A7 ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Alice(wireless)" disabled=no mac-address=B8:87:6E:19:90:33 ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Hare's Honor9x(wireless)" disabled=no mac-address=04:F1:69:8E:12:B6 ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="WB (wireless)" disabled=no mac-address=CA:FE:0F:0B:19:3A ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="MbpAlxm(wireless)" disabled=no mac-address=BC:D0:74:0A:B2:6A ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="android(wireless)" disabled=no mac-address=00:27:15:CE:B8:DD ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="ASUS(wireless)" disabled=no mac-address=54:35:30:05:9B:BD ssid-regexp="WiFi 2Ghz PRIV"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="Twinkle(wireless)" disabled=no mac-address=FC:F5:C4:79:ED:D8 ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="AudioATV(wireless)" disabled=no mac-address=B0:34:95:50:A1:6A ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="AlxATV(wireless)" disabled=no mac-address=90:DD:5D:C8:46:AB ssid-regexp="WiFi 5"
/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment="iPhoneAlxr(wireless)" disabled=no mac-address=54:2B:8D:77:38:A0 ssid-regexp=WiFi
/caps-man access-list add action=accept allow-signal-out-of-range=10s comment="Allow any other on guest wireless" disabled=no ssid-regexp=FREE
/caps-man access-list add action=reject allow-signal-out-of-range=10s comment="Drop any other on private wireless" disabled=no ssid-regexp=PRIVATE
/caps-man manager set certificate=C.anna.capsman@CHR enabled=yes require-peer-certificate=yes
/caps-man manager interface set [ find default=yes ] comment="Deny CapsMan on All"
/caps-man manager interface add comment="Deny WAN CapsMan" disabled=no forbid=yes interface="wan A"
/caps-man manager interface add comment="Do CapsMan on private" disabled=no interface=main-infrastructure-br
/caps-man manager interface add comment="Do CapsMan on guest" disabled=no interface=guest-infrastructure-br
/caps-man provisioning add action=create-dynamic-enabled comment="2Ghz private/guest" hw-supported-modes=gn identity-regexp=capxl master-configuration=zone-2Ghz-private name-format=prefix-identity name-prefix=2Ghz slave-configurations=zone-2Ghz-guest
/caps-man provisioning add action=create-dynamic-enabled comment="5Ghz private" hw-supported-modes=ac identity-regexp=capxl master-configuration=zone-5Ghz-private name-format=prefix-identity name-prefix=5Ghz
/caps-man provisioning add action=create-dynamic-enabled comment="2Ghz private/guest (self-cap)" hw-supported-modes=gn identity-regexp=anna master-configuration=zone-2Ghz-private name-format=prefix-identity name-prefix=2Ghz slave-configurations=zone-2Ghz-guest
/caps-man provisioning add action=create-dynamic-enabled comment="5Ghz private (self-cap)" hw-supported-modes=ac identity-regexp=anna master-configuration=zone-5Ghz-private name-format=prefix-identity name-prefix=5Ghz
/caps-man provisioning add comment=DUMMY master-configuration=empty name-format=prefix-identity name-prefix=dummy
/container add cmd="-K u -a 5 --auto=none -Kt,h -d1 -s0+s -d3+s -s6+s -d9+s -s12+s -d15+s -s20+s -d25+s -s30+s -d35+s -An -Ku -a1 -An --debug 1" comment="YouTube freedom" envlists=BYEDPI_QUIC_REJECT interface=bydpi-tunnel logging=yes name=byedpi-hev-socks5-tunnel:mikro remote-image=wiktorbgu/byedpi-hev-socks5-tunnel:mikro root-dir=/usb-docker/docker/byedpi-hev-socks5-tunnel start-on-boot=yes workdir=/
/container config set memory-high=768.0MiB registry-url=https://registry-1.docker.io tmpdir=/usb-docker/docker/pull
/container envs add key=QUIC list=BYEDPI_QUIC_REJECT value=REJECT
/disk settings set auto-media-interface=main-infrastructure-br
/ip smb set domain=HNW enabled=no interfaces=main-infrastructure-br
/interface bridge port add bridge=main-infrastructure-br interface="lan D" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan A" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan B" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan C" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan E" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan F" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan G" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=docker-infrastructure-br interface=bydpi-tunnel
/interface bridge settings set use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes udp-timeout=10s
/ip neighbor discovery-settings set discover-interface-list=list-neighbors-lookup
/ip settings set accept-source-route=yes rp-filter=loose tcp-syncookies=yes
/ipv6 settings set disable-ipv6=yes
/interface detect-internet set detect-interface-list=all internet-interface-list=list-autodetect-INTERNET lan-interface-list=list-autodetect-LAN wan-interface-list=list-autodetect-WAN
/interface l2tp-server server set keepalive-timeout=disabled
/interface list member add comment="MGTS, GPON via Huavei" interface="wan A" list=list-untrusted
/interface list member add comment="GUEST WLAN" interface=guest-infrastructure-br list=list-guest-wireless
/interface list member add comment="LAN, WLAN" interface=main-infrastructure-br list=list-trusted
/interface list member add comment="neighbors lookup" interface=main-infrastructure-br list=list-neighbors-lookup
/interface list member add comment="FW: winbox allowed" interface=main-infrastructure-br list=list-winbox-allowed
/interface list member add comment="neighbors lookup" interface=chr-tunnel list=list-neighbors-lookup
/interface list member add comment="FW: drop invalid" interface="wan A" list=list-drop-invalid-connections
/interface list member add comment=OSPF interface=chr-tunnel list=list-ospf-bearing
/interface list member add comment=OSPF interface=main-infrastructure-br list=list-ospf-master
/interface list member add comment=OSPF interface=ospf-loopback-br list=list-ospf-bearing
/interface list member add comment="redirect to docker" interface=main-infrastructure-br list=list-mangle-byedpi
/interface wireless snooper set receive-errors=yes
/ip address add address=192.168.90.1/24 comment="local ip" interface=main-infrastructure-br network=192.168.90.0
/ip address add address=192.168.98.1/24 comment="local guest wifi" interface=guest-infrastructure-br network=192.168.98.0
/ip address add address=10.255.255.3 comment="ospf router-id binding" interface=ospf-loopback-br network=10.255.255.3
/ip address add address=172.16.0.16/30 comment="GRAFANA IP redirect" interface=ip-mapping-br network=172.16.0.16
/ip address add address=172.16.0.17/30 comment="INFLUXDB IP redirect" interface=ip-mapping-br network=172.16.0.16
/ip address add address=10.20.225.166/24 comment="wan via ACADO edge router" interface="wan A" network=10.20.225.0
/ip address add address=192.168.80.1/24 comment="docker network" interface=docker-infrastructure-br network=192.168.80.0
/ip arp add address=192.168.90.200 comment="AlxATV (wireless)" interface=main-infrastructure-br mac-address=90:DD:5D:C8:46:AB
/ip arp add address=192.168.90.90 comment="MbpAlx (wire)" interface=main-infrastructure-br mac-address=38:C9:86:51:D2:B3
/ip arp add address=192.168.90.40 comment=NAS interface=main-infrastructure-br mac-address=00:11:32:2C:A7:85
/ip arp add address=192.168.90.10 comment="capxl(wire)" interface=main-infrastructure-br mac-address=18:FD:74:94:FD:70
/ip arp add address=192.168.90.70 comment="miniAlx (wire)" interface=main-infrastructure-br mac-address=10:DD:B1:9E:19:5E
/ip arp add address=192.168.90.210 comment=AudioATV interface=main-infrastructure-br mac-address=B0:34:95:50:A1:6A
/ip arp add address=192.168.90.170 comment=Twinkle interface=main-infrastructure-br mac-address=FC:F5:C4:79:ED:D8
/ip arp add address=192.168.90.88 comment="ASUS(wireless)" interface=main-infrastructure-br mac-address=54:35:30:05:9B:BD
/ip arp add address=192.168.90.75 comment="MbpAlxm (wireless)" interface=main-infrastructure-br mac-address=BC:D0:74:0A:B2:6A
/ip arp add address=192.168.90.85 comment="MbpAlxm (wire)" interface=main-infrastructure-br mac-address=48:65:EE:19:3C:0D
/ip arp add address=192.168.90.2 comment="WB (wire)" interface=main-infrastructure-br mac-address=00:85:01:01:50:0E
/ip arp add address=192.168.90.3 comment="WB (wireless)" interface=main-infrastructure-br mac-address=CA:FE:0F:0B:19:3A
/ip arp add address=10.20.225.166 comment="wan via ACADO edge router" interface="wan A" mac-address=20:CF:30:DE:7B:2A
/ip arp add address=192.168.90.205 comment="SamsungTV(wire)" interface=main-infrastructure-br mac-address=F8:3F:51:0D:88:0B
/ip arp add address=192.168.90.100 comment="AsusPC(wire)" interface=main-infrastructure-br mac-address=88:88:88:88:87:88
/ip arp add address=192.168.90.201 comment="AlxATV(wire)" interface=main-infrastructure-br mac-address=90:DD:5D:CA:8F:B0
/ip arp add address=192.168.90.140 comment="Hare's Honor9x(wireless)" interface=main-infrastructure-br mac-address=04:F1:69:8E:12:B6
/ip arp add address=192.168.90.220 comment="Alice(wireless)" interface=main-infrastructure-br mac-address=B8:87:6E:19:90:33
/ip arp add address=192.168.90.180 comment="Tuya(wireless)" interface=main-infrastructure-br mac-address=D4:A6:51:C9:54:A7
/ip arp add address=192.168.90.77 comment=HareDell interface=main-infrastructure-br mac-address=D4:3B:04:87:C7:47
/ip arp add address=192.168.90.165 comment="NSPanel(wireless)" interface=main-infrastructure-br mac-address=40:80:E1:5B:41:B8
/ip arp add address=192.168.90.150 comment="iPhoneAlxr(wireless)" interface=main-infrastructure-br mac-address=DC:10:57:2D:39:7B
/ip arp add address=192.168.90.35 comment=W11Parallels interface=main-infrastructure-br mac-address=00:1C:42:FE:E3:AB
/ip arp add address=192.168.90.80 comment="miniAlx(wireless)" interface=main-infrastructure-br mac-address=88:53:95:30:68:9F
/ip arp add address=192.168.90.130 comment=iPadAlxPro interface=main-infrastructure-br mac-address=50:DE:06:25:C2:FC
/ip arp add address=192.168.90.199 comment="nSwitch(wereless)" interface=main-infrastructure-br mac-address=BC:74:4B:E8:9B:61
/ip arp add address=192.168.90.135 comment="SamsungS23(wereless)" interface=main-infrastructure-br mac-address=F4:2B:8C:AF:34:20
/ip arp add address=192.168.90.203 comment="AST(wire)" interface=main-infrastructure-br mac-address=00:0E:2D:1A:73:36
/ip arp add address=192.168.90.133 comment="Elvira(wireless)" interface=main-infrastructure-br mac-address=2C:0B:97:C1:A8:C8
/ip arp add address=192.168.90.134 comment="Serg(wireless)" interface=main-infrastructure-br mac-address=BC:B2:CC:5F:9D:C4
/ip arp add address=192.168.90.66 comment="MSI(wire)" interface=main-infrastructure-br mac-address=34:5A:60:89:1C:E1
/ip arp add address=192.168.90.143 comment="Tomm(wireless)" interface=main-infrastructure-br mac-address=22:26:E9:CA:87:BA
/ip arp add address=192.168.90.142 comment="Froloff(wireless)" interface=main-infrastructure-br mac-address=C8:90:8A:9A:50:A1
/ip cloud set ddns-enabled=yes ddns-update-interval=10m
/ip dhcp-client add add-default-route=no dhcp-options=clientid,hostname disabled=yes interface="wan A" use-peer-dns=no use-peer-ntp=no
/ip dhcp-server lease add address=192.168.90.200 comment="AlxATV (wireless)" mac-address=90:DD:5D:C8:46:AB server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.40 comment=NAS mac-address=00:11:32:2C:A7:85 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.210 comment="AudioATV (wireless)" mac-address=B0:34:95:50:A1:6A server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.231 block-access=yes comment="AudioATV(blocked)" mac-address=B0:34:95:50:A1:6A server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.10 comment="capxl(wire)" mac-address=18:FD:74:94:FD:70 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.70 address-lists=alist-osx-hosts client-id=1:10:dd:b1:9e:19:5e comment="miniAlx (wire)" mac-address=10:DD:B1:9E:19:5E server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.170 comment=Twinkle mac-address=FC:F5:C4:79:ED:D8 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.170 block-access=yes comment="Twinkle(blocked)" disabled=yes mac-address=FC:F5:C4:79:ED:D8 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.88 comment="ASUS(wireless)" mac-address=54:35:30:05:9B:BD server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.88 block-access=yes comment="ASUS(wireless)(blocked)" mac-address=54:35:30:05:9B:BD server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.75 comment="MbpAlxm (wireless)" mac-address=BC:D0:74:0A:B2:6A server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.75 block-access=yes comment="MbpAlxm(blocked)" mac-address=BC:D0:74:0A:B2:6A server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.85 comment="MbpAlxm (wire)" mac-address=48:65:EE:19:3C:0D server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.85 block-access=yes comment="MbpAlxm(blocked)" mac-address=48:65:EE:19:3C:0D server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.2 comment="WB (wire)" mac-address=00:85:01:01:50:0E server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.2 block-access=yes comment="WB (wire)(blocked)" mac-address=00:85:01:01:50:0E server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.3 comment="WB (wireless)" mac-address=CA:FE:0F:0B:19:3A server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.3 block-access=yes comment="WB (wireless)(blocked)" mac-address=CA:FE:0F:0B:19:3A server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.205 comment="SamsungTV(wire)" mac-address=F8:3F:51:0D:88:0B server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.205 block-access=yes comment="SamsungTV(wire)(blocked)" mac-address=F8:3F:51:0D:88:0B server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.100 comment="Hare's AsusPC(wire)" mac-address=88:88:88:88:87:88 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.100 block-access=yes comment="AsusPC(wire)(blocked)" mac-address=88:88:88:88:87:88 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.201 comment="AlxATV(wire)" mac-address=90:DD:5D:CA:8F:B0 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.201 block-access=yes comment="AlxATV(wire)(blocked)" mac-address=90:DD:5D:CA:8F:B0 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.140 comment="Hare's Honor9x(wireless)" mac-address=04:F1:69:8E:12:B6 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.140 block-access=yes comment="Hare's Honor9x(wireless)(blocked)" mac-address=04:F1:69:8E:12:B6 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.220 comment="Alice(wireless)" mac-address=B8:87:6E:19:90:33 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.220 block-access=yes comment="Alice(wireless)(blocked)" mac-address=B8:87:6E:19:90:33 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.180 comment="Tuya(wireless)" mac-address=D4:A6:51:C9:54:A7 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.180 block-access=yes comment="Tuya(wireless)(blocked)" mac-address=D4:A6:51:C9:54:A7 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.77 comment=HareDell mac-address=D4:3B:04:87:C7:47 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.77 block-access=yes comment="HareDell(blocked)" mac-address=D4:3B:04:87:C7:47 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.165 comment="NSPanel(wireless)" mac-address=40:80:E1:5B:41:B8 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.165 block-access=yes comment="NSPanel(wireless)(blocked)" mac-address=40:80:E1:5B:41:B8 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.150 comment="iPhoneAlxr(wireless)" mac-address=DC:10:57:2D:39:7B server=main-dhcp-server
/ip dhcp-server lease add address=192.168.90.35 comment=W11Parallels mac-address=00:1C:42:FE:E3:AB server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.35 block-access=yes comment="W11Parallels(blocked)" mac-address=00:1C:42:FE:E3:AB server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.80 comment="miniAlx(wireless)" mac-address=88:53:95:30:68:9F server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.80 block-access=yes comment="miniAlx(wireless)(blocked)" mac-address=88:53:95:30:68:9F server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.130 comment=iPadAlxPro mac-address=50:DE:06:25:C2:FC server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.130 block-access=yes comment="iPadAlxPro(blocked)" mac-address=50:DE:06:25:C2:FC server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.199 comment="nSwitch(wereless)" mac-address=BC:74:4B:E8:9B:61 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.199 block-access=yes comment="nSwitch(wereless)(blocked)" mac-address=BC:74:4B:E8:9B:61 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.135 comment="SamsungS23(wereless)" mac-address=F4:2B:8C:AF:34:20 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.135 block-access=yes comment="SamsungS23(wereless)(blocked)" mac-address=F4:2B:8C:AF:34:20 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.203 comment="AST(wire)" mac-address=00:0E:2D:1A:73:36 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.203 block-access=yes comment="AST(wire)(blocked)" mac-address=00:0E:2D:1A:73:36 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.133 comment="Elvira(wireless)" mac-address=2C:0B:97:C1:A8:C8 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.133 block-access=yes comment="Elvira(wireless)(blocked)" mac-address=2C:0B:97:C1:A8:C8 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.134 comment="Serg(wireless)" mac-address=BC:B2:CC:5F:9D:C4 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.134 block-access=yes comment="Serg(wireless)(blocked)" mac-address=BC:B2:CC:5F:9D:C4 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.66 comment="MSI(wire)" mac-address=34:5A:60:89:1C:E1 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.66 block-access=yes comment="MSI(wire)(blocked)" mac-address=34:5A:60:89:1C:E1 server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.143 comment="Tomm(wireless)" mac-address=22:26:E9:CA:87:BA server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.143 block-access=yes comment="Tomm(wireless)(blocked)" mac-address=22:26:E9:CA:87:BA server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.142 comment="Froloff(wireless)" mac-address=C8:90:8A:9A:50:A1 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.142 block-access=yes comment="Froloff(wireless)(blocked)" mac-address=C8:90:8A:9A:50:A1 server=guest-dhcp-server
/ip dhcp-server matcher add address-pool=pool-vendor code=60 matching-type=exact name=vendor-mikrotik-caps server=main-dhcp-server value=mikrotik-cap
/ip dhcp-server network add address=192.168.90.0/27 caps-manager=192.168.90.1 comment="Network devices, CCTV" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.32/27 caps-manager=192.168.90.1 comment="Virtual machines" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.64/26 caps-manager=192.168.90.1 comment="Mac, Pc" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.128/27 caps-manager=192.168.90.1 comment="Phones, tablets" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.160/27 caps-manager=192.168.90.1 comment="IoT, intercom" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.192/27 caps-manager=192.168.90.1 comment="TV, projector, boxes" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.224/27 caps-manager=192.168.90.1 comment="Reserved, special" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.98.0/24 comment="Guest DHCP leasing (Yandex protected DNS)" dns-server=77.88.8.7 gateway=192.168.98.1 ntp-server=192.168.98.1
/ip dns set allow-remote-requests=yes cache-max-ttl=1d cache-size=4096KiB doh-max-concurrent-queries=100 doh-max-server-connections=20 max-concurrent-queries=200 max-concurrent-tcp-sessions=30 mdns-repeat-ifaces=main-infrastructure-br query-server-timeout=3s servers=217.10.36.5 use-doh-server=https://1.1.1.1/dns-query verify-doh-cert=yes
/ip dns static add name=special-remote-CHR-ipsec-policy-comment text=ANNA-OUTER-IP-REMOTE-CONTROLLABLE type=TXT
/ip dns static add cname=anna.home name=anna type=CNAME
/ip dns static add address=192.168.90.1 name=anna.home type=A
/ip dns static add cname=wb.home name=wb type=CNAME
/ip dns static add address=192.168.90.2 name=wb.home type=A
/ip dns static add cname=influxdb.home name=influxdb type=CNAME
/ip dns static add address=172.16.0.17 name=influxdb.home type=A
/ip dns static add cname=minialx.home name=influxdbsvc.home type=CNAME
/ip dns static add cname=grafana.home name=grafana type=CNAME
/ip dns static add address=172.16.0.16 name=grafana.home type=A
/ip dns static add cname=minialx.home name=grafanasvc.home type=CNAME
/ip dns static add cname=chr.home name=chr type=CNAME
/ip dns static add address=192.168.97.1 name=chr.home type=A
/ip dns static add cname=mikrouter.home name=mikrouter type=CNAME
/ip dns static add address=192.168.99.1 name=mikrouter.home type=A
/ip dns static add cname=minialx.home name=nas.home type=CNAME
/ip dns static add cname=nas.home name=nas type=CNAME
/ip dns static add address=192.168.100.1 name=gateway.home type=A
/ip dns static add address=192.168.90.10 name=capxl.home type=A
/ip dns static add cname=capxl.home name=capxl type=CNAME
/ip dns static add address=192.168.90.100 name=hare.home ttl=5m type=A
/ip dns static add cname=hare.home name=hare ttl=5m type=CNAME
/ip dns static add address=192.168.90.165 name=nspanel.home type=A
/ip dns static add cname=nspanel.home name=nspanel type=CNAME
/ip dns static add address=192.168.90.70 name=miniAlx.home type=A
/ip dns static add address=95.213.159.180 name=atv.qello.com type=A
/ip dns static add address=95.213.159.180 name=atv.package2.qello.com type=A
/ip dns static add address=192.168.90.85 comment=<AUTO:DHCP:main-dhcp-server> name=MbpAlxm.home ttl=5m type=A
/ip dns static add address=192.168.90.201 comment=<AUTO:DHCP:main-dhcp-server> name=AlxATV.home ttl=5m type=A
/ip dns static add comment="OpenNIC - dns relay (DoH should not be configured)" forward-to=185.121.177.177,51.15.98.97,2a01:4f8:1c0c:80c9::1 regexp=".*(\\.bbs|\\.chan|\\.cyb|\\.dyn|\\.geek|\\.gopher|\\.indy|\\.libre|\\.neo|\\.null|\\.o)\$" type=FWD
/ip dns static add comment="OpenNIC - dns relay (DoH should not be configured)" forward-to=185.121.177.177,51.15.98.97,2a01:4f8:1c0c:80c9::1 regexp=".*(\\.oss|\\.oz|\\.parody|\\.pirate|\\.opennic.glue|\\.dns\\.opennic\\.glue)\$" type=FWD
/ip dns static add comment="OpenNIC - dns relay (DoH should not be configured)" forward-to=185.121.177.177,51.15.98.97,2a01:4f8:1c0c:80c9::1 regexp=".*(\\.bazar|\\.coin|\\.emc|\\.lib|\\.fur1|\\.bit|\\.ku|\\.te|\\.ti|\\.uu)\$" type=FWD
/ip dns static add address=192.168.90.130 comment=<AUTO:DHCP:main-dhcp-server> name=iPadProAlx.home ttl=5m type=A
/ip dns static add address=1.1.1.1 comment="Forwarder bind - DNS CloudFlare" name=cloudflare-dns.com type=A
/ip dns static add address=192.168.90.35 comment=<AUTO:DHCP:main-dhcp-server> name=W11.home ttl=5m type=A
/ip dns static add address=8.8.8.8 comment="Forwarder bind - DNS CloudFlare" name=dns.google type=A
/ip dns static add address=8.8.4.4 comment="Forwarder bind - DNS CloudFlare" name=dns.google type=A
/ip dns static add cname=miniAlx.home name=miniAlx type=CNAME
/ip dns static add address=192.168.90.220 comment=<AUTO:DHCP:main-dhcp-server> name=yandex-mini2-ZGNK.home ttl=5m type=A
/ip dns static add address=192.168.90.150 comment=<AUTO:DHCP:main-dhcp-server> name=iPhoneAlxr.home ttl=5m type=A
/ip dns static add address=192.168.90.205 comment=<AUTO:DHCP:main-dhcp-server> name=localhost.home ttl=5m type=A
/ip dns static add address=192.168.90.135 comment=<AUTO:DHCP:main-dhcp-server> name=nadezda-phone.home ttl=5m type=A
/ip dns static add address=192.168.90.100 comment=<AUTO:DHCP:main-dhcp-server> name=DESKTOP-QMUE5PH.home ttl=5m type=A
/ip dns static add address=192.168.90.140 comment=<AUTO:DHCP:main-dhcp-server> name=HONOR9X-dbcb7b0850fde5c5.home ttl=5m type=A
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=cloudflare-ech.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=googlevideo.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=googleapis.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" disabled=yes forward-to=localhost match-subdomain=yes name=youtube.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=ytimg.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=youtu.be type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=ggpht.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=rutracker.org type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=rutracker.cc type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=fb.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=facebook.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=fbcdn.net type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=fbcdn.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=x.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=twitter.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=linkedin.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=prntscr.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=prnt.sc type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=t.co type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=protonvpn.com type=FWD
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN Hack" forward-to=localhost match-subdomain=yes name=nnmclub.to type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI  Hack" forward-to=DOH-Comss match-subdomain=yes name=ntc.party type=FWD
/ip dns static add cname=box.ntc.party comment="DPI  Hack" name=ntc.party type=CNAME
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN  Hack" forward-to=localhost match-subdomain=yes name=medium.com type=FWD
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN  Hack" forward-to=localhost match-subdomain=yes name=www.canva.com type=FWD
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN  Hack" forward-to=localhost match-subdomain=yes name=www.tinkercad.com type=FWD
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN  Hack" forward-to=localhost match-subdomain=yes name=xvideos.com type=FWD
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN  Hack" forward-to=localhost match-subdomain=yes name=xhamster.com type=FWD
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN  Hack" forward-to=localhost match-subdomain=yes name=www.parallels.com type=FWD
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN  Hack" forward-to=localhost match-subdomain=yes name=radarr.video type=FWD
/ip dns static add address-list=alist-mangle-byedpi-PH comment="DPI Hack PH" forward-to=localhost match-subdomain=yes name=pornhub.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-PH comment="DPI Hack PH" forward-to=localhost match-subdomain=yes name=rt.pornhub.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-PH comment="DPI Hack PH" forward-to=localhost match-subdomain=yes name=ei.phncdn.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-PH comment="DPI Hack PH" forward-to=localhost match-subdomain=yes name=phncdn.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-PH comment="DPI Hack PH" forward-to=localhost match-subdomain=yes name=ew.phncdn.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-PH comment="DPI Hack PH" forward-to=localhost match-subdomain=yes name=ss.phncdn.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-PH comment="DPI Hack PH" forward-to=localhost match-subdomain=yes name=cdn1d-static-shared.phncdn.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=cdninstagram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=deviantart.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=parastorage.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi comment="DPI Hack" forward-to=localhost match-subdomain=yes name=wixstatic.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-TV comment="DPI Hack: specific list for TVs to fix mss" forward-to=DOH-Google match-subdomain=yes name=youtube.com type=FWD
/ip dns static add address-list=alist-mangle-vpn-tunneled-sites comment="VPN Hack" forward-to=DOH-Comss match-subdomain=yes name=chatgpt.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 regexp=instagram type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=bookstagram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=carstagram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=chickstagram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=ig.me type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=igcdn.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=igsonar.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=igtv.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=imstagram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=imtagram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instaadder.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instachecker.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instafallow.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instafollower.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagainer.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagda.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagify.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagmania.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagor.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagran.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagranm.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagrem.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagrm.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagtram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instagy.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instamgram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instangram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instanttelegram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instaplayer.net type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instastyle.tv type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=instgram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=intagram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=intagrm.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=intgram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=kingstagram.com type=FWD
/ip dns static add address-list=alist-mangle-byedpi-IG comment="DPI hack Instagram" forward-to=DOH-Quad9 match-subdomain=yes name=lnstagram-help.com type=FWD
/ip dns static add address=192.168.90.133 comment=<AUTO:DHCP:main-dhcp-server> name=Redmi-Note-13-Pro.home ttl=5m type=A
/ip dns static add address=192.168.90.203 comment=<AUTO:DHCP:main-dhcp-server> name=ast25b.home ttl=5m type=A
/ip dns static add address=192.168.90.134 comment=<AUTO:DHCP:main-dhcp-server> name=A55-pol-zovatela-Sergej.home ttl=5m type=A
/ip dns static add address=192.168.90.77 comment=<AUTO:DHCP:main-dhcp-server> name=DESKTOP-G3RE47G.home ttl=5m type=A
/ip dns static add address=192.168.90.66 comment=<AUTO:DHCP:main-dhcp-server> name=NWS-116.home ttl=5m type=A
/ip dns static add address=192.168.90.142 comment=<AUTO:DHCP:main-dhcp-server> name=A54-pol-zovatela-Natalya.home ttl=5m type=A
/ip dns static add address=1.0.0.1 comment="Forwarder bind - DNS CloudFlare" name=cloudflare-dns.com type=A
/ip dns static add address=9.9.9.9 comment="Forwarder bind - DNS Quad9" name=dns.quad9.net type=A
/ip dns static add address=149.112.112.112 comment="Forwarder bind - DNS Quad9" name=dns.quad9.net type=A
/ip dns static add address=195.133.25.16 comment="Forwarder bind - DNS Comss" name=router.comss.one type=A
/ip dns static add address=46.39.51.206 name=ftpserver.org type=A
/ip firewall address-list add address=192.168.90.0/24 list=alist-fw-local-subnets
/ip firewall address-list add address=192.168.90.0/24 list=alist-nat-local-subnets
/ip firewall address-list add address=100.64.0.0/10 comment="RFC 6598 (Shared Address Space)" list=alist-fw-rfc-special
/ip firewall address-list add address=169.254.0.0/16 comment="RFC 3927 (Dynamic Configuration of IPv4 Link-Local Addresses)" list=alist-fw-rfc-special
/ip firewall address-list add address=172.16.0.0/12 comment="RFC 1918 (Private Use IP Space)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.0.0.0/24 comment="RFC 6890 (IETF Protocol Assingments)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.0.2.0/24 comment="RFC 5737 (Test-Net-1)" list=alist-fw-rfc-special
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
/ip firewall address-list add address=10.0.0.0/24 list=alist-fw-local-subnets
/ip firewall address-list add address=10.0.0.0/24 list=alist-nat-local-subnets
/ip firewall address-list add address=172.16.0.16/30 list=alist-fw-local-subnets
/ip firewall address-list add address=172.16.0.16/30 list=alist-nat-local-subnets
/ip firewall address-list add address=192.168.98.0/24 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=telegram.org list=alist-fw-telegram-servers
/ip firewall address-list add address=grafana.home list=alist-nat-grafana-server
/ip firewall address-list add address=grafanasvc.home list=alist-nat-grafana-service
/ip firewall address-list add address=influxdb.home list=alist-nat-influxdb-server
/ip firewall address-list add address=influxdbsvc.home list=alist-nat-influxdb-service
/ip firewall address-list add address=192.168.90.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=lostfilm.tv disabled=yes list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=10.0.0.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=185.13.148.14 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=192.168.90.0/24 comment="Port scan entire LAN allow" list=alist-fw-port-scanner-allow
/ip firewall address-list add address=2ip.ru list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.100.7 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=217.10.36.5 comment="AKADO official DNS server" list=alist-fw-dns-allow
/ip firewall address-list add address=217.10.34.2 comment="AKADO official DNS server" list=alist-fw-dns-allow
/ip firewall address-list add address=192.168.99.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=192.168.90.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=tmdb.org disabled=yes list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=themoviedb.org disabled=yes list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=autodesk.com disabled=yes list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=accounts.autodesk.com disabled=yes list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=binaryronin.io disabled=yes list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.80.2 list=alist-mangle-docker-space
/ip firewall address-list add address=46.39.51.206 list=alist-nat-external-ip
/ip firewall address-list add address=103.224.182.238 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=103.224.182.253 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=103.224.212.131 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.17.10.106 comment=pip4-xhamsterlive.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.17.11.106 comment=pip4-xhamsterlive.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.17.111.106 comment=pip4-xhamsterlive.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.17.112.106 comment=pip4-xhamsterlive.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.17.117.12 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.17.118.12 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.17.34.109 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.17.35.109 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.18.146.40 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.18.147.40 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.18.32.43 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.18.36.123 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.18.42.152 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.20.43.5 comment=pip4-rule34.xxx list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.112.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.16.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.32.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.48.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.56.86 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.64.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.79.118 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.80.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.21.96.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.22.18.113 comment=pip4-rule34.xxx list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.22.19.113 comment=pip4-rule34.xxx list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.26.12.144 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=104.26.13.144 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=109.61.41.62 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=109.61.88.166 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=109.61.92.8 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=109.61.92.9 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=121.127.45.89 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=121.127.45.90 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=13.229.114.252 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.14.36 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.14.37 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.14.48 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.14.49 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.15.35 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.15.36 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.20.245 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.20.246 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.20.248 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.20.249 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.26.16 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.26.22 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.26.54 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.26.57 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.26.7 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.37.28 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.37.43 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.37.44 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.5.14 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.5.15 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.5.6 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=138.199.57.82 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.138 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.147 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.149 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.152 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.153 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.156 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.157 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.159 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.161 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.169 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.173 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.33.179 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.51.200 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.51.201 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.51.215 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.51.216 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.56.1 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.56.13 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.56.14 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.56.15 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.56.7 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.57.38 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.57.44 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.57.47 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=143.244.57.48 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=152.195.34.118 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.33.137 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.33.138 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.33.140 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.33.141 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.33.168 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.33.169 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.33.170 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.35.196 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.35.197 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.35.207 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.35.208 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.35.213 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.35.214 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.36.12 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.38.29 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.38.30 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.38.32 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.38.33 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.53.12 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.59.222 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.61.130 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.61.131 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.61.133 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.61.134 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.61.142 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=156.146.61.143 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=169.150.214.134 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=169.150.214.135 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=169.150.237.34 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=169.150.237.35 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=169.150.237.37 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=169.150.237.38 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=169.150.252.37 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=169.150.252.38 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.233.219.123 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.233.219.49 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.233.219.55 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.233.219.78 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.234.212.122 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.236.123.101 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.237.146.25 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.237.146.38 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.237.146.8 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.64.145.104 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.64.151.133 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.64.155.213 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.66.156.23 comment=pip4-rule34.xxx list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.67.170.134 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.67.181.179 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.67.4.152 comment=pip4-rule34.xxx list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.67.68.97 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=18.141.199.30 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=18.141.222.153 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.102.217.104 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.102.217.105 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.102.217.37 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.102.217.40 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.102.217.41 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.110.92.40 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.110.92.41 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.180.12.22 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.180.12.23 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.180.13.213 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.180.13.214 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.180.13.216 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.180.13.217 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.185.15.5 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.207.236.138 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.207.236.139 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.246.208.13 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.246.208.14 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.246.208.27 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.246.208.28 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.246.208.6 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.246.211.25 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.246.211.3 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.59.222.11 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.59.222.12 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.61.148.21 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.11 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.12 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.18 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.19 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.21 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.22 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.23 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.24 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.25 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.26 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.27 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.4 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.5 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.7 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.76.9.8 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.10 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.100 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.11 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.110 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.2 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.3 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.4 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.5 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.53 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.54 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.55 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.56 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.57 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.58 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.59 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.6 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.60 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.7 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.8 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.88.181.9 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.93.2.2 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=185.93.2.23 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.96.0 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.96.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.96.10 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.96.12 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.96.3 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.96.4 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.96.7 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.96.9 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.97.0 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.97.1 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.97.10 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.97.12 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.97.3 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.97.4 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.97.7 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.97.9 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.98.224 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.98.228 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.98.229 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.98.232 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.98.233 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.98.235 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.98.236 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.99.224 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.99.228 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.99.229 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.99.232 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.99.233 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.99.235 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=188.114.99.236 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.162.6 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.166.14 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.166.15 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.170.26 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.170.27 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.172.2 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.172.3 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.172.5 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.172.6 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.175.10 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.175.15 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.175.16 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.175.18 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.175.19 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=195.181.175.9 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=199.59.243.228 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=207.211.213.108 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=207.211.213.109 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=208.99.84.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.54.206 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.54.207 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.54.212 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.54.213 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.55.131 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.55.132 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.55.142 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.55.143 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.55.157 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.55.158 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.56.165 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.56.166 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.56.167 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.56.175 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.56.176 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.56.181 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=212.102.56.182 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=216.18.191.192 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=216.18.191.193 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=216.18.191.194 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=216.18.191.195 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=216.18.191.196 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=216.18.191.197 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=216.18.191.198 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=216.18.191.199 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.194.77 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.194.78 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.202.26 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.202.27 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.202.35 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.202.36 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.202.38 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.202.39 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.202.44 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.202.45 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.203.48 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.203.49 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.203.51 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.203.52 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.208.35 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.208.59 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.218.82 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=37.19.218.83 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=45.133.44.22 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=45.133.44.23 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=45.133.44.26 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=45.133.44.27 comment=pip4-beeg.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=45.133.44.3 comment=pip4-hqporner.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=45.133.44.4 comment=pip4-hqporner.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=45.82.101.62 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=46.151.194.30 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=46.151.194.36 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=46.151.194.37 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=54.169.253.230 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.112 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.113 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.114 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.115 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.116 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.117 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.118 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.119 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.144 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.145 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.146 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.147 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.148 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.149 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.150 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.135.151 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.136.1 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.147.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.147.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.1 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.18 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.19 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.2 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.20 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.21 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.22 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.23 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.3 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.4 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.5 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.6 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.156.7 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.158.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.210.158.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.245.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.18 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.19 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.20 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.21 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.22 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.23 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.32 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.33 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.34 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.35 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.36 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.37 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.38 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.246.39 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.254.160 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=64.88.254.161 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.114.238 comment=pip4-redtube.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.114.41 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.18 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.19 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.20 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.21 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.22 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.23 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.32 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.33 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.34 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.35 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.36 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.37 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.38 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=66.254.122.39 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.48.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.48.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.1 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.18 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.19 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.2 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.20 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.21 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.22 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.23 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.3 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.4 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.5 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.6 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.50.7 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.18 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.19 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.20 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.21 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.22 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.23 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.32 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.33 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.34 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.35 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.36 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.37 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.38 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.51.39 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.16 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.18 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.19 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.20 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.21 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.22 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.23 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.32 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.33 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.34 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.35 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.36 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.37 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.38 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.52.39 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.55.17 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.56.0 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.56.1 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.56.2 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.56.3 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.56.4 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.56.5 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.56.6 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.56.7 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.57.192 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.57.193 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.57.194 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.57.195 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.57.196 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.57.197 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.57.198 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=67.22.57.199 comment=pip4-pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.178.164 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.178.172 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.178.173 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.203.24 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.203.25 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.203.27 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.203.28 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.203.30 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.203.31 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.216.222 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.216.223 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.216.225 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.216.226 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.216.228 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=79.127.216.229 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.47.69.0 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.47.69.4 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.47.69.6 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.47.69.8 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.47.69.9 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.6.112.0 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.6.112.4 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.6.112.6 comment=pip4-redgifs.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.6.112.8 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=8.6.112.9 comment=pip4-reddxxx.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.50.10 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.50.12 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.50.55 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.50.56 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.57.19 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.57.20 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.57.22 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.57.23 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.59.16 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=84.17.59.17 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=87.249.131.106 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=87.249.131.107 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=87.249.131.2 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=87.249.131.3 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=88.208.29.180 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=88.208.35.41 comment=pip4-hqporner.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=88.208.60.136 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.130 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.133 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.137 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.140 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.142 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.145 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.149 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.36 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.37 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.41 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.53 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.162.54 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.163.101 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.163.113 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.163.82 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.165.7 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.165.8 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.167.24 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.171.28 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.187.183.31 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.203 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.204 comment=pip4-xhamster.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.209 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.210 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.212 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.213 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.215 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.216 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.218 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.219 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.221 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=89.222.125.222 comment=pip4-xnxx-ru.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=91.206.163.163 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=92.223.40.62 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=93.123.17.252 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=93.123.17.254 comment=pip4-xvideos.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=94.140.112.80 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=95.215.46.63 comment=pip4-pornolab.net list=alist-mangle-vpn-tunneled-sites
/ip firewall filter add action=drop chain=input comment="Drop Invalid Connections (HIGH PRIORIRY RULE)" connection-state=invalid in-interface-list=list-drop-invalid-connections
/ip firewall filter add action=drop chain=forward comment="Drop Invalid Connections (HIGH PRIORIRY RULE)" connection-state=invalid dst-address-list=!alist-fw-vpn-subnets
/ip firewall filter add action=accept chain=forward comment="Accept Related or Established Connections (HIGH PRIORIRY RULE)" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=accept chain=input comment="OSFP neighbour-ing allow" log-prefix=~~~OSFP protocol=ospf
/ip firewall filter add action=accept chain=input comment=API log-prefix=~~~API port=8728 protocol=tcp
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
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-dns-amp-block address-list-timeout=10h chain=chain-dns-amp-attack comment="Add DNS Amplification to Blacklist" log=yes log-prefix=~~~~DNS port=53 protocol=udp src-address-list=!alist-fw-dns-allow
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
/ip firewall mangle add action=change-mss chain=forward comment="DPI Hack: specific  for TVs to fix mss" dst-address-list=alist-mangle-byedpi-TV new-mss=88 protocol=tcp tcp-flags=syn
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" in-interface=all-ppp new-mss=1360 protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" new-mss=1360 out-interface=all-ppp protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=output comment="fix MSS for l2tp/ipsec (self)" new-mss=1360 protocol=tcp src-address-list=alist-fw-vpn-subnets tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=mark-connection chain=prerouting comment="DPI Hack" connection-mark=no-mark dst-address-list=alist-mangle-byedpi in-interface-list=list-mangle-byedpi new-connection-mark=cmark-docker-connection
/ip firewall mangle add action=mark-connection chain=prerouting comment="DPI Hack PH" connection-mark=no-mark dst-address-list=alist-mangle-byedpi-PH in-interface-list=list-mangle-byedpi new-connection-mark=cmark-docker-connection
/ip firewall mangle add action=mark-connection chain=prerouting comment="DPI Hack IG" connection-mark=no-mark dst-address-list=alist-mangle-byedpi-IG in-interface-list=list-mangle-byedpi new-connection-mark=cmark-docker-connection
/ip firewall mangle add action=mark-connection chain=prerouting comment="DPI Hack TV" connection-mark=no-mark dst-address-list=alist-mangle-byedpi-TV in-interface-list=list-mangle-byedpi new-connection-mark=cmark-docker-connection
/ip firewall mangle add action=mark-connection chain=prerouting comment="Mark l2tp" connection-mark=no-mark connection-state=new dst-address-list=alist-mangle-vpn-tunneled-sites new-connection-mark=cmark-tunnel-connection
/ip firewall mangle add action=mark-connection chain=prerouting comment="Mark l2tp (telegram)" connection-mark=no-mark connection-state=new dst-address-list=alist-fw-telegram-servers new-connection-mark=cmark-tunnel-connection
/ip firewall mangle add action=mark-routing chain=prerouting comment="DPI hack" connection-mark=cmark-docker-connection in-interface-list=list-mangle-byedpi new-routing-mark=rmark-docker-redirect passthrough=no routing-mark=!rmark-docker-redirect
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self)" dst-address-list=alist-mangle-vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self, telegram notify)" dst-address-list=alist-fw-telegram-servers log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites" connection-mark=cmark-tunnel-connection dst-address-list=alist-mangle-vpn-tunneled-sites log=yes log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites (telegram)" connection-mark=cmark-tunnel-connection dst-address-list=alist-fw-telegram-servers log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-connection chain=output comment="VPN (pure IPSEC)" connection-mark=no-mark dst-port=500,4500 new-connection-mark=cmark-ipsec protocol=udp
/ip firewall mangle add action=mark-connection chain=output comment="VPN (pure IPSEC)" connection-mark=no-mark new-connection-mark=cmark-ipsec protocol=ipsec-esp
/ip firewall mangle add action=mark-routing chain=output comment="VPN (pure IPSEC)" connection-mark=cmark-ipsec dst-address-list=alist-mangle-vpn-tunneled-sites new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=passthrough chain=prerouting comment=DUMMY
/ip firewall mangle add action=mark-connection chain=prerouting comment="7Z DL CONN mark" connection-mark=no-mark layer7-protocol=7Z new-connection-mark=conn-7z-download
/ip firewall mangle add action=mark-packet chain=prerouting comment=7z connection-mark=conn-7z-download layer7-protocol=7Z log-prefix=~~~DL_7z new-packet-mark=7z-mark protocol=tcp
/ip firewall mangle add action=mark-connection chain=prerouting comment="EXE DL CONN mark" connection-mark=no-mark layer7-protocol=EXE new-connection-mark=conn-exe-download
/ip firewall mangle add action=mark-packet chain=prerouting comment=exe connection-mark=conn-exe-download layer7-protocol=EXE log-prefix=~~~DL_exe new-packet-mark=exe-mark protocol=tcp
/ip firewall mangle add action=mark-connection chain=prerouting comment="RAR DL CONN mark" connection-mark=no-mark layer7-protocol=RAR new-connection-mark=conn-rar-download
/ip firewall mangle add action=mark-packet chain=prerouting comment=rar connection-mark=conn-rar-download layer7-protocol=RAR log-prefix=~~~DL_rar new-packet-mark=rar-mark protocol=tcp
/ip firewall mangle add action=mark-connection chain=prerouting comment="ZIP DL CONN mark" connection-mark=no-mark layer7-protocol=ZIP new-connection-mark=conn-zip-download
/ip firewall mangle add action=mark-packet chain=prerouting comment=zip connection-mark=conn-zip-download layer7-protocol=ZIP log-prefix=~~~DL_zip new-packet-mark=zip-mark protocol=tcp
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
/ip firewall nat add action=netmap chain=dstnat comment="FTP pass through" dst-port=1111 in-interface="wan A" log-prefix=~~~FTP protocol=tcp to-addresses=192.168.90.40 to-ports=21
/ip firewall nat add action=netmap chain=dstnat comment="FTP pass through PASV" dst-port=65000-65050 in-interface="wan A" log-prefix=~~~FTP protocol=tcp to-addresses=192.168.90.40 to-ports=65000-65050
/ip firewall nat add action=dst-nat chain=dstnat comment="FTP NAT loopback" dst-address-list=alist-nat-external-ip dst-address-type="" dst-port=21 in-interface=main-infrastructure-br log-prefix=~~~LOOP protocol=tcp src-address-list=alist-nat-local-subnets to-addresses=192.168.90.80 to-ports=21
/ip firewall nat add action=netmap chain=dstnat comment="RDP pass through" dst-address-type=local dst-port=3333 in-interface="wan A" log-prefix=~~~RDP protocol=tcp to-addresses=192.168.90.80 to-ports=3389
/ip firewall nat add action=dst-nat chain=dstnat comment="RDP NAT loopback" dst-address-list=alist-nat-external-ip dst-address-type="" dst-port=3389 in-interface=main-infrastructure-br log-prefix=~~~LOOP protocol=tcp src-address-list=alist-nat-local-subnets to-addresses=192.168.90.80 to-ports=3389
/ip firewall nat add action=masquerade chain=srcnat comment="all WAN allowed" dst-address-list=!alist-fw-vpn-subnets out-interface="wan A"
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip hotspot service-port set ftp disabled=yes
/ip ipsec identity add auth-method=digital-signature certificate=C.anna.ipsec@CHR comment=to-CHR-outer-tunnel-encryption-RSA peer=CHR-external policy-template-group=outside-ipsec-encryption
/ip ipsec identity add comment=to-CHR-traffic-only-encryption-PSK peer=CHR-internal policy-template-group=inside-ipsec-encryption remote-id=ignore secret=123
/ip ipsec policy set 0 proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip ipsec policy add comment="Common IPSEC TRANSPORT (outer-tunnel encryption)" dst-address=185.13.148.14/32 dst-port=1701 peer=CHR-external proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=10.20.225.166/32 src-port=1701
/ip ipsec policy add comment="Common IPSEC TUNNEL (traffic-only encryption)" dst-address=192.168.97.0/29 peer=CHR-internal proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" src-address=192.168.90.0/24 tunnel=yes
/ip kid-control device add mac-address=10:DD:B1:9E:19:5E name=miniAlx user=totals
/ip proxy set cache-administrator=defm.kopcap@gmail.com max-client-connections=10 max-fresh-time=20m max-server-connections=10 parent-proxy=0.0.0.0 port=8888 serialize-connections=yes
/ip proxy access add action=redirect action-data=grafana:3000 dst-host=grafana
/ip proxy access add action=redirect action-data=influxdb:8000 dst-host=influxdb
/ip route add comment="GLOBAL AKADO" disabled=no distance=50 dst-address=0.0.0.0/0 gateway=10.20.225.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add comment="BYE DPI HACK" disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.80.2%docker-infrastructure-br pref-src="" routing-table=rmark-docker-redirect scope=30 suppress-hw-offload=no target-scope=10
/ip service set telnet disabled=yes
/ip service set api address=192.168.90.0/24
/ip service set api-ssl disabled=yes
/ip smb shares set [ find default=yes ] directory=/pub
/ip ssh set ciphers=aes-gcm,aes-ctr,aes-cbc,3des-cbc,null forwarding-enabled=remote
/ip tftp add real-filename=NAS/ req-filename=.*
/ip traffic-flow set cache-entries=64k enabled=yes interfaces="wan A"
/ip upnp set enabled=yes
/ip upnp interfaces add interface="wan A" type=external
/ip upnp interfaces add interface=main-infrastructure-br type=internal
/ip upnp interfaces add interface=guest-infrastructure-br type=internal
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_TOKEN password=798290125:AAE3gfeLKdtai3RPtnHRLbE8quNgAh7iC8M profile=null service=async
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_CHAT_ID password=-1001798127067 profile=null service=async
/routing filter rule add chain=ospf-in comment="discard intra area routes" disabled=no rule="if ( protocol ospf && ospf-type intra) { set comment DISCARDED-INTRA-AREA ; reject; }"
/routing filter rule add chain=ospf-in comment="accept DEFAULT ROUTE" disabled=no rule="if ( protocol ospf && dst-len==0) { set comment GLOBAL-VPN ; set pref-src 10.0.0.3 ; accept; }"
/routing filter rule add chain=ospf-in comment="accept inter area routes" disabled=no rule="if ( protocol ospf && ospf-type inter) { set comment LOCAL-AREA ; set pref-src 10.0.0.3 ; accept; }"
/routing filter rule add chain=ospf-in comment="DROP OTHERS" disabled=no rule="reject;"
/routing ospf interface-template add area=backbone disabled=no interfaces=chr-tunnel type=ptp
/routing ospf interface-template add area=anna-space-main disabled=no interfaces=main-infrastructure-br networks=192.168.90.0/24 passive
/routing rule add action=unreachable comment="LAN/GUEST isolation" disabled=no dst-address=192.168.98.0/24 src-address=192.168.90.0/24
/routing rule add action=unreachable comment="LAN/GUEST isolation" disabled=no dst-address=192.168.90.0/24 src-address=192.168.98.0/24
/routing rule add action=lookup-only-in-table comment=API.TELEGRAM.ORG disabled=yes dst-address=185.85.121.15/24 table=rmark-vpn-redirect
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces=main-infrastructure-br trap-version=2
/system clock set time-zone-name=Europe/Moscow
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
/system logging add action=ParseMemoryLog topics=warning
/system logging add action=CAPSOnScreenLog topics=caps
/system logging add action=FirewallOnScreenLog topics=firewall
/system logging add action=CAPSOnScreenLog topics=wireless
/system logging add action=ParseMemoryLog topics=system
/system logging add action=SSHOnScreenLog topics=ssh
/system logging add action=PoEOnscreenLog topics=poe-out
/system logging add action=EmailOnScreenLog topics=e-mail
/system logging add action=ParseMemoryLog topics=error
/system logging add action=ParseMemoryLog topics=account
/system logging add action=ParseMemoryLog topics=critical
/system logging add action=DockerRemoteLog prefix=RLOG topics=!debug
/system logging add action=TransfersOnscreenLog topics=fetch
/system logging add action=PKGInstallationLog regex="^.*install.*\$"
/system logging add action=REBOOTLog regex="^.*reboot.*\$"
/system logging add action=PKGInstallationLog regex="^.*package.*\$"
/system logging add action=DockerOnscreenLog topics=container
/system logging add action=AlloyRemoteLog prefix=ALOG topics=!debug
/system note set note="Ipsec:         okay \
    \nRoute:     10.20.225.1 \
    \nVersion:         7.20 \
    \nUptime:        3w6d21:54:49  \
    \nTime:        2025-11-21 21:10:12  \
    \nPing:    5 ms  \
    \nChr:        185.13.148.14  \
    \nMik:        178.65.91.156  \
    \nAnna:        46.39.51.206  \
    \nClock:        synchronized  \
    \n * rose-storage  \
    \n * iot  \
    \n * container  \
    \n * wireless  \
    \n * routeros  \
    \n" show-at-cli-login=yes
/system ntp client set enabled=yes
/system ntp server set broadcast=yes enabled=yes multicast=yes
/system ntp client servers add address=85.21.78.91
/system ntp client servers add address=ru.pool.ntp.org
/system scheduler add interval=7m name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2017-01-30 start-time=18:57:09
/system scheduler add interval=10h name=doIpsecPolicyUpd on-event="/system script run doIpsecPolicyUpd" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2017-02-21 start-time=15:31:13
/system scheduler add interval=1d name=doUpdateStaticDNSviaDHCP on-event="/system script run doUpdateStaticDNSviaDHCP" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2017-03-21 start-time=19:19:59
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-03-01 start-time=15:55:00
/system scheduler add interval=5d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-06-26 start-time=21:13:00
/system scheduler add interval=30m name=doHeatFlag on-event="/system script run doHeatFlag" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-07-10 start-time=15:10:00
/system scheduler add interval=1h name=doCollectSpeedStats on-event="/system script run doCollectSpeedStats" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-07-13 start-time=03:25:00
/system scheduler add interval=1h name=doCheckPingRate on-event="/system script run doCheckPingRate" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-07-13 start-time=02:40:00
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=07:00:00
/system scheduler add interval=1m name=doPeriodicLogDump on-event="/system script run doPeriodicLogDump" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2019-02-07 start-time=11:31:24
/system scheduler add interval=1d name=doCreateTrafficAccountingQueues on-event="/system script run doCreateTrafficAccountingQueues" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=08:00:00
/system scheduler add interval=15m name=doCPUHighLoadReboot on-event="/system script run doCPUHighLoadReboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2019-02-07 start-time=06:05:00
/system scheduler add interval=10m name=doIPSECPunch on-event="/system script run doIPSECPunch" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=08:00:00
/system scheduler add interval=10m name=doCoolConsole on-event="/system script run doCoolConsole" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=07:00:00
/system scheduler add interval=1d name=doFlushLogs on-event="/system script run doFlushLogs" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-05-02 start-time=02:00:00
/system scheduler add interval=10m name=doPushStatsToInfluxDB on-event="/system script run doPushStatsToInfluxDB" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=08:00:00
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript;" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
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
/system script add comment="Updates address-list that contains my external IP" dont-require-permissions=yes name=doUpdateExternalDNS owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doUpdateExternalDNS\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n:local payLoad false;\
    \n:local state \"\";\
    \n\
    \n:local content\
    \n:local IPv4\
    \n:global LastIPv4\
    \n\
    \n# parsing the current IPv4 result\
    \n/ip cloud force-update;\
    \n:delay 7s;\
    \n:set IPv4 [/ip cloud get public-address];\
    \n\
    \n:if ([:len \$IPv4] > 0) do={\
    \n        :if ([ :typeof [ :toip \$IPv4 ] ] != \"ip\" ) do={\
    \n\
    \n        :set state \"No cloud-DNS IP recieved\";\
    \n         \$globalNoteMe value=\$state;\
    \n        :set itsOk false;\
    \n   \
    \n        }\
    \n    }\
    \n\
    \n:if ((\$LastIPv4 != \$IPv4) || (\$force = true)) do={\
    \n\
    \n    :set state \"External IP changed: current - (\$IPv4), last - (\$LastIPv4)\";\
    \n    \$globalNoteMe value=\$state;\
    \n\
    \n    /ip firewall address-list remove [find list~\"alist-nat-external-ip\"];\
    \n    /ip firewall address-list add list=\"alist-nat-external-ip\" address=\$IPv4;\
    \n   \
    \n    /ip dns static remove [/ip dns static find name=ftpserver.org];\
    \n    /ip dns static add name=ftpserver.org address=\$IPv4;\
    \n \
    \n    :set LastIPv4 \$IPv4;\
    \n    :set payLoad true; \
    \n\
    \n    :local count [:len [/system script find name=\"doSuperviseCHRviaSSH\"]];\
    \n    :if (\$count > 0) do={\
    \n       \
    \n        :set state \"Refreshing VPN server (CHR) IPSEC policies\";\
    \n        \$globalNoteMe value=\$state;\
    \n        /system script run doSuperviseCHRviaSSH;\
    \n    \
    \n     }\
    \n   }\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk and \$payLoad ) do={\
    \n  :set inf \"\$scriptname on \$sysname: external IP address change detected, refreshed\"\
    \n}\
    \n\
    \n:if (\$itsOk and !\$payLoad ) do={\
    \n  :set inf \"\$scriptname on \$sysname: no external IP address update needed\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n  :error \$inf; \
    \n  \
    \n}\
    \n\
    \n\
    \n\
    \n"
/system script add comment="Runs once on startup and makes console welcome message pretty" dont-require-permissions=yes name=doCoolConsole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \"doCoolConsole\";\
    \n\
    \n:global globalNoteMe;\
    \n\
    \n:local logcontenttemp \"\";\
    \n:local logcontent \"\";\
    \n:local state \"\"\
    \n\
    \n:local rosVer [:tonum [:pick [/system resource get version] 0 1]];\
    \n\
    \n# reset current\
    \n:set state \"Flush global note\"\
    \n\$globalNoteMe value=\$state;\
    \n/system note set note=\"Pending\";\
    \n\
    \n:local sysver \"NA\";\
    \n:if ( [ :len [ /system package find where name=\"system\" and disabled=no ] ] > 0 and \$rosVer = 6 ) do={\
    \n  :set sysver [/system package get system version];\
    \n}\
    \n:if ( [ :len [ /system package find where name=\"routeros\" and disabled=no ] ] > 0 and \$rosVer = 7 ) do={\
    \n  :set sysver [/system package get routeros version];\
    \n}\
    \n\
    \n:set state \"Picking default route\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:local defaultRoute \"unreachable\";\
    \n/ip route {\
    \n    :foreach i in=[find where dst-address=\"0.0.0.0/0\" and active and routing-table=main] do={\
    \n        :set defaultRoute [:tostr [/ip route get \$i gateway] ];\
    \n    }\
    \n}\
    \n\
    \n:set state \"Picking ipsec\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:local ipsecState \"okay\";\
    \n/ip ipsec policy {\
    \n  :foreach vpnEndpoint in=[find (!disabled and !template)] do={\
    \n    :local ph2state [get value-name=ph2-state \$vpnEndpoint]\
    \n\
    \n    :if (\$ph2state != \"established\") do={\
    \n        :local ipsecState \"issues found\";\
    \n    }\
    \n  }\
    \n}\
    \n\
    \n:set logcontenttemp \"Ipsec:         \$ipsecState\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" \\n\") \
    \n:set logcontenttemp \"Route:     \$defaultRoute\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" \\n\") \
    \n:set logcontenttemp \"Version:         \$sysver\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" \\n\")\
    \n:set logcontenttemp \"Uptime:        \$[/system resource get uptime]\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\
    \n\
    \n:local SafeResolve do={\
    \n\
    \n    :if ([:len \$0]!=0) do={\
    \n        :if ([:len \$1]!=0) do={\
    \n            :do {\
    \n                :local host [:resolve \"\$1\"];\
    \n                :log warning \"Resolving: \$1\";\
    \n                :put \"Resolving: \$1 - Ok\"\
    \n                :return \$host;\
    \n            } on-error= {\
    \n                :log error \"FAIL resolving: \$1\";\
    \n                :put \"FAIL resolving: \$1\";\
    \n                :return \"ERROR\";\
    \n            };\
    \n        }\
    \n    } \
    \n    :log error \"FAIL resolving: \$1\";\
    \n    :put \"FAIL resolving: \$1\";\
    \n    :return \"ERROR\";\
    \n}\
    \n\
    \n:local avgRttA 0;\
    \n:local numPing 6;\
    \n:local latency \"NA\";\
    \n\
    \n:set state \"Yandex connection test\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:local latencySite \"Ya.ru\";\
    \n:local yaResolve [\$SafeResolve \$latencySite];\
    \n\
    \n:set state \"Picking latency\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:if (\$yaResolve != \"ERROR\" ) do {\
    \n    \
    \n    :for tmpA from=1 to=\$numPing step=1 do={\
    \n        /tool flood-ping count=1 size=38 address=\$yaResolve do={ :set avgRttA (\$\"avg-rtt\" + \$avgRttA); }\
    \n        :delay 1s;\
    \n    }\
    \n    :set latency [:tostr (\$avgRttA / \$numPing )];\
    \n\
    \n} else={\
    \n    :set latency \"unreachable\";\
    \n}\
    \n\
    \n:set state \"Resolving CHR, MIK, ANNA\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:local hostname \"accb195e0dffc6bb.sn.mynetname.net\";\
    \n:local chrResolve [\$SafeResolve \$hostname];\
    \n:if (\$chrResolve = \"ERROR\" ) do {    \
    \n    :set chrResolve \"unreachable\";\
    \n}\
    \n\
    \n:local hostname \"673706ed7949.sn.mynetname.net\";\
    \n:local mikResolve [\$SafeResolve \$hostname];\
    \n:if (\$mikResolve = \"ERROR\" ) do {    \
    \n    :set mikResolve \"unreachable\";\
    \n}\
    \n\
    \n:local hostname \"hcy086pz6xz.sn.mynetname.net\";\
    \n:local annaResolve [\$SafeResolve \$hostname];\
    \n:if (\$annaResolve = \"ERROR\" ) do {    \
    \n    :set annaResolve \"unreachable\";\
    \n}\
    \n\
    \n:set logcontenttemp \"Time:        \$[/system clock get date] \$[/system clock get time]\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\
    \n:set logcontenttemp \"Ping:    \$latency ms\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\
    \n\
    \n:set logcontenttemp \"Chr:        \$chrResolve\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\
    \n:set logcontenttemp \"Mik:        \$mikResolve\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\
    \n:set logcontenttemp \"Anna:        \$annaResolve\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\
    \n\
    \n:set logcontenttemp \"Clock:        \$[/system ntp client get status]\"\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\
    \n\
    \n:set state \"Listing packages\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n/system/package {\
    \n  :foreach pkg in=[find (!disabled)] do={\
    \n    :local pkgName [get value-name=name \$pkg]\
    \n    \
    \n    :set logcontent (\"\$logcontent\" .\" * \$pkgName\" .\"  \\n\");\
    \n\
    \n    }\
    \n  }\
    \n\
    \n\
    \n:set state \"Setting global note\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n/system note set note=\"\$logcontent\"  \
    \n\
    \n"
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
    \n\r\
    \n\r\
    \n"
/system script add comment="Checks device temperature and warns on overheat" dont-require-permissions=yes name=doHeatFlag owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doHeatFlag\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:global globalNoteMe;\
    \n\
    \n:local maxTemp;\
    \n:local currentTemp [/system/health get [find name=cpu-temperature] value];\
    \n\
    \n:set maxTemp 68;\
    \n\
    \n#\
    \n\
    \n:if (\$currentTemp > \$maxTemp) do= {\
    \n\
    \n:local inf \"\$scriptname on \$sysname: system overheat at \$currentTemp C\"  \
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:global globalTgMessage;\
    \n\$globalTgMessage value=\$inf;\
    \n\
    \n\
    \n/beep length=.1\
    \n :delay 250ms\
    \n /beep length=.1\
    \n :delay 800ms\
    \n /beep length=.1\
    \n :delay 250ms\
    \n /beep length=.1\
    \n :delay 800ms\
    \n\
    \n\
    \n};\
    \n\r\
    \n"
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
    \n:local stats \"\$ds-\$ts upload: \$txAvg Mbps - download: \$rxAvg Mbps\";\r\
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
    \n\r\
    \n\r\
    \n"
/system script add comment="Runs at morning to get flashes back (swith on all LEDs)" dont-require-permissions=yes name=doLEDon owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doLEDon\";\r\
    \n\r\
    \n/system leds settings set all-leds-off=never;\r\
    \n\r\
    \n\r\
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
    \n    /ip dhcp-server lease;\r\
    \n    :foreach i in=[find dynamic=yes] do={\r\
    \n        :local dhcpip \r\
    \n        :set dhcpip [ get \$i address ];\r\
    \n        :local clientid\r\
    \n        :set clientid [get \$i host-name];\r\
    \n\r\
    \n        :if (\$GleaseActIP = \$dhcpip) do={\r\
    \n            :local comment \"New IP\"\r\
    \n            :set comment ( \$comment . \": \" .  \$dhcpip . \": \" . \$clientid);\r\
    \n            /log error \$comment;\r\
    \n\r\
    \n                                        :local newGuest \"%D0%9A%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%20%D0%B3%D0%BE%D1%81%D1%82%D0%B5%D0%B2%D0%BE%D0%B3%D0%BE%20wi-fi%3A%20\";\r\
    \n                                        :global TelegramMessage \"\$newGuest \$comment\";\r\
    \n                                         /system script run doTelegramNotify;\r\
    \n\r\
    \n                                         /system script run doWestminister;\r\
    \n        }\r\
    \n    }\r\
    \n}"
/system script add comment="Flushes all global variables on Startup" dont-require-permissions=yes name=doEnvironmentClearance owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n#clear all global variables\
    \n/system script environment remove [find];\
    \n\r\
    \n"
/system script add comment="Startup script" dont-require-permissions=yes name=doStartupScript owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# reset current\
    \n/system note set note=\"Pending\";\
    \n\
    \n:do {\
    \n\
    \n    # Track sync time (avoid CHR initial clock bug), with this we are also checking if internet comes up\
    \n\
    \n    :local successSyncState \"synchronized\";\
    \n    :local syncOk false;\
    \n    :local syncState \"\";\
    \n    :local timeSpent 0;\
    \n    :local ticks 0;\
    \n    :local maxTicks 40;\
    \n    :local break false;\
    \n    :do {\
    \n        :set syncState [/system ntp client get status];\
    \n        :set syncOk (\$syncState = \$successSyncState);\
    \n\
    \n        :log info \"Waiting 15s for clock sync using NTP.. (\$ticks/\$maxTicks, \$syncState)\";\
    \n        :put \"Waiting 15s for clock sync using NTP.. (\$ticks/\$maxTicks, \$syncState)\";\
    \n        \
    \n        :if (!\$syncOk) do={\
    \n\
    \n            :delay 15s;        \
    \n            :set timeSpent (\$timeSpent + 15);\
    \n            :set break (\$ticks >= \$maxTicks);\
    \n\
    \n        } else={\
    \n            :set break true;\
    \n        };\
    \n\
    \n        :set ticks (\$ticks + 1);\
    \n\
    \n    } while=(! \$break )\
    \n\
    \n    :if (\$syncOk) do={\
    \n        :log warning \"Successful clock sync using NTP in \$timeSpent seconds\";\
    \n        :put \"Successful clock sync using NTP in \$timeSpent seconds\";\
    \n        \
    \n    } else={\
    \n        :log error \"Error when clock sync using NTP in \$timeSpent seconds\";\
    \n        :put \"Error when clock sync using NTP in \$timeSpent seconds\";\
    \n\
    \n    };\
    \n    \
    \n} on-error={\
    \n\
    \n    :log error \"Error when tracking clock sync using NTP\";\
    \n    :put \"Error when tracking clock sync using NTP\";\
    \n\
    \n};\
    \n\
    \n:local SafeScriptCall do={\
    \n\
    \n    :if ([:len \$0]!=0) do={\
    \n        :if ([:len \$1]!=0) do={\
    \n            :if ([:len [/system script find name=\$1]]!=0) do={\
    \n\
    \n                :do {\
    \n                    :log warning \"Starting script: \$1\";\
    \n                    :put \"Starting script: \$1\"\
    \n                    /system script run \$1;\
    \n                } on-error= {\
    \n                    :log error \"FAIL Starting script: \$1\";\
    \n                    :put \"FAIL Starting script: \$1\"\
    \n                };\
    \n\
    \n            }\
    \n        }\
    \n    } \
    \n\
    \n}\
    \n\
    \n\$SafeScriptCall \"doEnvironmentClearance\";\
    \n\$SafeScriptCall \"doEnvironmentSetup\";\
    \n\$SafeScriptCall \"doImperialMarch\";\
    \n\$SafeScriptCall \"doCoolConsole\";\
    \n\
    \n# wait some for all tunnels to come up after reboot and VPN to work\
    \n\
    \n:local inf \"Wait some for all tunnels to come up after reboot and VPN to work..\" ;\
    \n:global globalNoteMe;\
    \n:global globalTgMessage;\
    \n:if (any \$globalNoteMe ) do={ \$globalNoteMe value=\$inf; }\
    \n\
    \n:delay 15s;\
    \n\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doStartupScript\";\
    \n\
    \n:local inf \"\$scriptname on \$sysname: system restart detected\" ;\
    \n:if (any \$globalNoteMe ) do={ \$globalNoteMe value=\$inf; }\
    \n:if (any \$globalTgMessage ) do={ \$globalTgMessage value=\$inf; }\
    \n      \
    \n\
    \n\
    \n"
/system script add comment="Updates remote VPN server (CHR) IPSEC policies for this mikrotik client via SSH when external IP changed" dont-require-permissions=yes name=doSuperviseCHRviaSSH owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doSuperviseCHRviaSSH\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n:local state \"n/d\";\
    \n\
    \n:local exitCode 0;\
    \n\
    \n:local callSSH do={\
    \n\
    \n    # reading params\
    \n    :local cmd \$1;\
    \n\
    \n    # ssh server attr\
    \n    :local dst \"185.13.148.14\";\
    \n    :local port 2222;\
    \n    :local user \"automation\";\
    \n\
    \n    :local errorDef \"\";\
    \n\
    \n    :do {\
    \n \
    \n        #password-less (RSA keys) connection should be set up before\
    \n        :local callResult ([/system ssh-exec address=\$dst user=\$user port=\$port command=\$cmd as-value]);\
    \n        :local exitCode ([\$callResult]->\"exit-code\");\
    \n\
    \n        :if (\$exitCode != 0) do={\
    \n\
    \n            :set errorDef \"RPC: script parameter setup returns exit code (\$exitCode)\";\
    \n\
    \n        } else={\
    \n\
    \n            # success\
    \n\
    \n        }\
    \n\
    \n    } on-error= {\
    \n        :set errorDef \"Remote SSH session gets unexperted error\";\
    \n    };\
    \n\
    \n    :return \$errorDef;\
    \n\
    \n};\
    \n\
    \n:do {\
    \n    \
    \n    :local policyComment [/ip dns static get value-name=text [find where type=TXT and name=\"special-remote-CHR-ipsec-policy-comment\"]]\
    \n    :local remoteCommand \":global globalPolicyComment \$policyComment\";\
    \n\
    \n    :set state \"Calling --- \$remoteCommand\";\
    \n    \$globalNoteMe value=\$state;\
    \n\
    \n    :local errorDef [\$callSSH \$remoteCommand];\
    \n\
    \n    :if ([:len \$errorDef] > 0) do={\
    \n\
    \n        :set state \$errorDef;\
    \n        \$globalNoteMe value=\$state;\
    \n        :set itsOk false;\
    \n\
    \n    } else={\
    \n\
    \n        :set state \"RPC: set remote preferred policy comment variable: (\$policyComment) - Ok\";\
    \n        \$globalNoteMe value=\$state;\
    \n    \
    \n    }\
    \n\
    \n};\
    \n\
    \n:if (\$itsOk) do={\
    \n\
    \n    :do {\
    \n        \
    \n        :local wanIp [/ip cloud get public-address];\
    \n        :local remoteCommand \":global globalRemoteIp \$wanIp/32\";\
    \n\
    \n        :set state \"Calling --- \$remoteCommand\";\
    \n        \$globalNoteMe value=\$state;\
    \n       \
    \n        :local errorDef [\$callSSH \$remoteCommand];\
    \n\
    \n        :if ([:len \$errorDef] > 0) do={\
    \n\
    \n            :set state \$errorDef;\
    \n            \$globalNoteMe value=\$state;\
    \n            :set itsOk false;\
    \n\
    \n        } else={\
    \n\
    \n            :set state \"RPC: set remote preferred policy IP variable: (\$wanIp) - Ok\";\
    \n            \$globalNoteMe value=\$state;\
    \n        \
    \n        }\
    \n\
    \n    };\
    \n\
    \n}\
    \n\
    \n:if (\$itsOk) do={\
    \n\
    \n    :do {\
    \n        \
    \n        :local remoteCommand \"/system script run doUpdatePoliciesRemotely\";\
    \n\
    \n        :set state \"Calling --- \$remoteCommand\";\
    \n        \$globalNoteMe value=\$state;\
    \n       \
    \n        :local errorDef [\$callSSH \$remoteCommand];\
    \n\
    \n        :if ([:len \$errorDef] > 0) do={\
    \n\
    \n            :set state \$errorDef;\
    \n            \$globalNoteMe value=\$state;\
    \n            :set itsOk false;\
    \n\
    \n        } else={\
    \n\
    \n            :set state \"RPC: call remote script: doUpdatePoliciesRemotely - Ok\";\
    \n            \$globalNoteMe value=\$state;\
    \n        \
    \n        }\
    \n\
    \n    };\
    \n\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: remote policies refreshed Successfully\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n  :error \$inf; \
    \n \
    \n}\
    \n\
    \n\
    \n\
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
/system script add comment="Mikrotik system log dump, collects new entries once per minute. You should have 'ParseMemoryLog' buffer at your 'system-logging'. Calls 'doPeriodicLogParse' when new logs available" dont-require-permissions=yes name=doPeriodicLogDump owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\
    \n:local scriptname \"doPeriodicLogDump\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\r\
    \n"
/system script add comment="Mikrotik system log analyzer, called manually by 'doPeriodicLogDump' script, checks 'interesting' conditions and does the routine" dont-require-permissions=yes name=doPeriodicLogParse owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\
    \n:local scriptname \"doPeriodicLogParse\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\r\
    \n"
/system script add comment="Punches IPSEC policies when they're not in 'established' state" dont-require-permissions=yes name=doIPSECPunch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\
    \n:local scriptname \"doIPSECPunch\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n\
    \n:local state \"\";\
    \n:local punched \"\";\
    \n\
    \n\
    \n/ip ipsec policy {\
    \n  :foreach vpnEndpoint in=[find (!disabled and !template)] do={\
    \n\
    \n    :local ph2state [get value-name=ph2-state \$vpnEndpoint]\
    \n    :local isTunnel [get value-name=tunnel \$vpnEndpoint]\
    \n    :local peerPoint [get \$vpnEndpoint peer]\
    \n    :local dstIp;\
    \n\
    \n    :if (\$isTunnel) do={\
    \n      :set dstIp [get value-name=sa-dst-address \$vpnEndpoint]\
    \n    } else {\
    \n      :set dstIp [get value-name=dst-address \$vpnEndpoint]\
    \n    }\
    \n\
    \n    :if ((\$itsOk) and (\$ph2state != \"established\")) do={\
    \n\
    \n      :set state \"Non-established IPSEC policy found for destination IP \$dstIp. Checking active peers..\"\
    \n      \$globalNoteMe value=\$state;\
    \n\
    \n      :local actPeerProcessed 0;\
    \n\
    \n      /ip ipsec active-peers {\
    \n        :foreach actPeer in=[find remote-address=\$dstIp] do={\
    \n\
    \n          :local peerId [get \$actPeer id];\
    \n          :local peer \"\";\
    \n\
    \n          :if ([:typeof \$peerId] != \"nil\") do={\
    \n            :set peer \"\$peerId\"\
    \n          } else {\
    \n            :set peer \"\$dstIp\"\
    \n          }\
    \n\
    \n          :do {\
    \n\
    \n            :set state \"Active peer \$peer found Non-established IPSEC policy. Kill it..\"\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            [remove \$actPeer];\
    \n\
    \n            :set state (\"IPSEC tunnel got a punch after down for \$dstIp \");\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            #waiting for tunnel to come up, because Telegram notes goes through tunnel\
    \n            :delay 10;\
    \n\
    \n            :set punched (\$punched . \"\$peer\");\
    \n          \
    \n          } on-error= {\
    \n\
    \n            :set state \"Error When \$state\"\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            :set itsOk false;\
    \n            \
    \n          }\
    \n\
    \n          :set actPeerProcessed (\$actPeerProcessed + 1);\
    \n        }\
    \n\
    \n      }\
    \n\
    \n      #there were no active peers with such remote-address\
    \n      #This is the most common case if the policy is non-established\
    \n\
    \n      :if (\$actPeerProcessed = 0) do={\
    \n\
    \n        #should not flush InstalledSA, because ot flushes the whole policies\
    \n        #just make disable-enable cycle\
    \n        \
    \n        :set state (\"There were no active peers with \$dstIp destination IP, but policy is non-established.\");\
    \n        \$globalNoteMe value=\$state;\
    \n\
    \n        :set state (\"Making disable-enable cycle for policy to clear InstalledSA\");\
    \n        \$globalNoteMe value=\$state;\
    \n\
    \n        :delay 2;\
    \n\
    \n        [set \$vpnEndpoint disabled=yes];\
    \n        \
    \n        #waiting for tunnel to come up, because Telegram notes goes through tunnel\
    \n        :delay 15;\
    \n\
    \n        [set \$vpnEndpoint disabled=no];\
    \n\
    \n       :delay 5;\
    \n\
    \n        :local peerId (\$peerPoint -> \"id\");\
    \n        :local peer \"\";\
    \n\
    \n        :put \$peerId;        \
    \n\
    \n        :if ([:typeof \$peerId] != \"nil\") do={\
    \n          :set peer \"\$peerId\"\
    \n        } else {\
    \n          :set peer \"\$dstIp\"\
    \n        }\
    \n\
    \n        :set punched (\$punched . \"\$peer\");\
    \n\
    \n      }      \
    \n\
    \n    }\
    \n  }\
    \n}\
    \n\
    \n:local inf \"\"\
    \n\
    \n:if ((\$itsOk) and (\$punched = \"\")) do={\
    \n  :set inf \"\$scriptname on \$sysname: IPSEC tunnels are fine\"\
    \n}\
    \n\
    \n:if ((\$itsOk) and (\$punched != \"\")) do={\
    \n  :set inf \"\$scriptname on \$sysname: IPSEC tunnels refreshed for \$punched\"\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: \$state\"  \
    \n  \
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n  :error \$inf; \
    \n\
    \n}\
    \n\
    \n\
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
/system script add comment="Setups global functions, called by the other scripts (runs once on startup)" dont-require-permissions=yes name=doEnvironmentSetup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n\
    \n:global globalNoteMe;\
    \n:if (!any \$globalNoteMe) do={\
    \n\
    \n  :global globalNoteMe do={\
    \n\
    \n  :local scriptname [:jobname] ;\
    \n  ## outputs \$value using both :put and :log info\
    \n  ## example \$outputInfo value=\"12345\"\
    \n\
    \n  :local state \"\$scriptname: \$value\";\
    \n  :put \"\$state\"\
    \n  :log info \"\$state\"\
    \n\
    \n  }\
    \n}\
    \n\
    \n\
    \n:global globalScriptBeforeRun;\
    \n:if (!any \$globalScriptBeforeRun) do={\
    \n  :global globalScriptBeforeRun do={\
    \n\
    \n    :global globalNoteMe;\
    \n    :if ([:len \$1] > 0) do={\
    \n\
    \n           :local scriptname [:jobname] ;\
    \n           :local state \"\$scriptname instance already running - prevent new instance\";\
    \n\
    \n           :if ([/system script job print count-only as-value where script=\$scriptname] > 1) do={\
    \n              :log error \$state\
    \n               \$globalNoteMe value=\$state;\
    \n               :error \$state\
    \n            }\
    \n\
    \n      :local state \"Starting script: \$scriptname\";\
    \n      \$globalNoteMe value=\$state;\
    \n\
    \n    }\
    \n  }\
    \n}\
    \n\
    \n### \$SECRET\
    \n#   get <name>\
    \n#   set <name> password=<password>\
    \n# . remove <name\
    \n#   print\
    \n:if (!any \$SECRET) do={\
    \n:global SECRET do={\
    \n\
    \n    # helpers\
    \n    :local fixprofile do={\
    \n        :if ([/ppp profile find name=\"null\"]) do={:put \"nothing\"} else={\
    \n            /ppp profile add bridge-learning=no change-tcp-mss=no local-address=0.0.0.0 name=\"null\" only-one=yes remote-address=0.0.0.0 session-timeout=1s use-compression=no use-encryption=no use-mpls=no use-upnp=no\
    \n        }\
    \n    }\
    \n    :local lppp [:len [/ppp secret find where name=\$2]]\
    \n    :local checkexist do={\
    \n        :if (lppp=0) do={\
    \n            :error \"\\\$SECRET: cannot find \$2 in secret store\"\
    \n        }\
    \n    }\
    \n\
    \n    # \$SECRET\
    \n    :if ([:typeof \$1]!=\"str\") do={\
    \n        :put \"\\\$SECRET\"\
    \n        :put \"   uses /ppp/secrets to store stuff like REST apikeys, or other sensative data\"\
    \n        :put \"\\t\\\$SECRET print - prints stored secret passwords\"\
    \n        :put \"\\t\\\$SECRET get <name> - gets a stored secret\"\
    \n        :put \"\\t\\\$SECRET set <name> password=\\\"YOUR_SECRET\\\" - sets a secret password\" \
    \n        :put \"\\t\\\$SECRET remove <name> - removes a secret\" \
    \n    }\
    \n\
    \n    # \$SECRET print\
    \n    :if (\$1~\"^pr\") do={\
    \n        /ppp secret print where comment~\"\\\\\\\$SECRET\"\
    \n        :return [:nothing] \
    \n    }\
    \n\
    \n    # \$SECRET get\
    \n    :if (\$1~\"get\") do={\
    \n        \$checkexist\
    \n       :return [/ppp secret get \$2 password] \
    \n    }\
    \n\
    \n    # \$SECRET set\
    \n    :if (\$1~\"set|add\") do={\
    \n        :if ([:typeof \$password]=\"str\") do={} else={:error \"\\\$SECRET: password= required\"}\
    \n        :if (lppp=0) do={\
    \n            /ppp secret add name=\$2 password=\$password \
    \n        } else={\
    \n            /ppp secret set \$2 password=\$password\
    \n        }\
    \n        \$fixprofile\
    \n        /ppp secret set \$2 comment=\"used by \\\$SECRET\"\
    \n        /ppp secret set \$2 profile=\"null\"\
    \n        /ppp secret set \$2 service=\"async\"\
    \n        :return [\$SECRET get \$2]\
    \n    } \
    \n\
    \n    # \$SECRET remove\
    \n    :if (\$1~\"rm|rem|del\") do={\
    \n        \$checkexist\
    \n        :return [/ppp secret remove \$2]\
    \n    }\
    \n    :error \"\\\$SECRET: bad command\"\
    \n}\
    \n}\
    \n\
    \n\
    \n:global globalTgMessage;\
    \n:if (!any \$globalTgMessage) do={\
    \n  :global globalTgMessage do={\
    \n\
    \n    :global globalNoteMe;\
    \n    :global SECRET;\
    \n\
    \n    \$SECRET set TELEGRAM_TOKEN password=\"798290125:AAE3gfeLKdtai3RPtnHRLbE8quNgAh7iC8M\";\
    \n    \$SECRET set TELEGRAM_CHAT_ID password=\"-1001798127067\";\
    \n\
    \n    :local tToken \"\$[\$SECRET get TELEGRAM_TOKEN]\";\
    \n    :local tGroupID \"\$[\$SECRET get TELEGRAM_CHAT_ID]\";\
    \n    :local tURL \"https://api.telegram.org/bot\$tToken/sendMessage\\\?chat_id=\$tGroupID\";\
    \n\
    \n    :local sysname (\"#\" . [/system identity get name]);\
    \n    :local scriptname [:jobname] ;\
    \n\
    \n    :local tgmessage  (\"\$scriptname %C2%A9%EF%B8%8F \$sysname: \$value\");  \
    \n\
    \n    :local state (\"Sending telegram message... \$tgmessage\");\
    \n    \$globalNoteMe value=\$tgmessage;\
    \n\
    \n    :do {\
    \n      /tool fetch http-method=post mode=https url=\"\$tURL\" http-data=\"text=\$tgmessage\" keep-result=no;\
    \n    } on-error= {\
    \n      :local state (\"Telegram notify error\");\
    \n      \$globalNoteMe value=\$state;\
    \n    };\
    \n  }\
    \n}\
    \n\
    \n:global globalIPSECPolicyUpdateViaSSH;\
    \n:if (!any \$globalIPSECPolicyUpdateViaSSH) do={\
    \n  :global globalIPSECPolicyUpdateViaSSH do={\
    \n\
    \n    :global globalRemoteIp;\
    \n    :global globalNoteMe;\
    \n\
    \n    :if ([:len \$1] > 0) do={\
    \n      :global globalRemoteIp (\"\$1\" . \"/32\");\
    \n    }\
    \n\
    \n    :if (!any \$globalRemoteIp) do={\
    \n      :global globalRemoteIp \"0.0.0.0/32\"\
    \n    } else={\
    \n    }\
    \n\
    \n    :local state (\"RPC... \$value\");\
    \n    \$globalNoteMe value=\$state;\
    \n    :local count [:len [/system script find name=\"doUpdatePoliciesRemotely\"]];\
    \n    :if (\$count > 0) do={\
    \n       :local state (\"Starting policies process... \$globalRemoteIp \");\
    \n       \$globalNoteMe value=\$state;\
    \n       /system script run doUpdatePoliciesRemotely;\
    \n     }\
    \n  }\
    \n}\
    \n\
    \n#Example call\
    \n#\$globalNewNetworkMember ip=192.168.90.130 mac=50:DE:06:25:C2:FC gip=192.168.98.130 comm=iPadAlxPro ssid=\"WiFi 5\"\
    \n:global globalNewNetworkMember;\
    \n:if (!any \$globalNewNetworkMember) do={\
    \n  :global globalNewNetworkMember do={\
    \n\
    \n    :global globalNoteMe;\
    \n\
    \n    #to prevent connection\
    \n    :local guestDHCP \"guest-dhcp-server\";\
    \n\
    \n    #to allow connection\
    \n    :local mainDHCP \"main-dhcp-server\";\
    \n\
    \n    #when DHCP not using (add arp for leases)\
    \n    :local arpInterface \"main-infrastructure-br\";\
    \n    :local state (\"Adding new network member... \");\
    \n\
    \n    \$globalNoteMe value=\$state;\
    \n\
    \n    # incoming named params\
    \n    :local newIp [ :tostr \$ip ];\
    \n    :local newBlockedIp [ :tostr \$gip ];\
    \n    :local newMac [ :tostr \$mac ];\
    \n    :local comment [ :tostr \$comm ];\
    \n    :local newSsid [ :tostr \$ssid ];\
    \n    :if ([:len \$newIp] > 0) do={\
    \n        :if ([ :typeof [ :toip \$newIp ] ] != \"ip\" ) do={\
    \n\
    \n            :local state (\"Error: bad IP parameter passed - (\$newIp)\");\
    \n            \$globalNoteMe value=\$state;\
    \n            :return false;\
    \n\
    \n        }\
    \n    } else={\
    \n\
    \n        :local state (\"Error: bad IP parameter passed - (\$newIp)\");\
    \n        \$globalNoteMe value=\$state;\
    \n        :return false;\
    \n\
    \n    }\
    \n\
    \n    :do {\
    \n\
    \n        :local state (\"Removing existing DHCP configuration for (\$newIp/\$newMac) on \$mainDHCP\");\
    \n        \$globalNoteMe value=\$state;       \
    \n        /ip dhcp-server lease remove [find address=\$newIp];\
    \n        /ip dhcp-server lease remove [find mac-address=\$newMac];\
    \n\
    \n        :local state (\"Adding DHCP configuration for (\$newIp/\$newMac) on \$mainDHCP\");\
    \n        \$globalNoteMe value=\$state;\
    \n        \
    \n       :if ([ :len [ /ip dhcp-server find where name=\"\$mainDHCP\" ] ] > 0) do={\
    \n            /ip dhcp-server lease add address=\$newIp mac-address=\$newMac server=\$mainDHCP comment=\$comment;\
    \n            :local state (\"Done.\");\
    \n            \$globalNoteMe value=\$state;\
    \n       } else={\
    \n        :local state (\"Cant find DHCP server \$mainDHCP. SKIPPED.\");\
    \n        \$globalNoteMe value=\$state;\
    \n       }\
    \n\
    \n    } on-error={\
    \n\
    \n        :local state (\"Error: something fail on DHCP configuration 'allow' step for (\$newIp/\$newMac) on \$mainDHCP\");\
    \n        \$globalNoteMe value=\$state;\
    \n        :return false;\
    \n\
    \n    }\
    \n\
    \n    :do {\
    \n\
    \n        /ip dhcp-server lease remove [find address=\$newBlockedIp];\
    \n        :local state (\"Adding DHCP configuration for (\$newBlockedIp/\$newMac) on \$guestDHCP (preventing connections to guest network)\");\
    \n        \$globalNoteMe value=\$state;\
    \n\
    \n       :if ([ :len [ /ip dhcp-server find where name=\"\$guestDHCP\" ] ] > 0) do={\
    \n          /ip dhcp-server lease add address=\$newBlockedIp block-access=yes mac-address=\$newMac server=\$guestDHCP comment=(\$comment . \"(blocked)\");\
    \n          :local state (\"Done.\");\
    \n          \$globalNoteMe value=\$state;\
    \n       } else={\
    \n        :local state (\"Cant find DHCP server \$guestDHCP. SKIPPED.\");\
    \n        \$globalNoteMe value=\$state;\
    \n       }\
    \n\
    \n    } on-error={\
    \n\
    \n        :local state (\"Error: something fail on DHCP configuration 'block' step for (\$newBlockedIp/\$newMac) on \$guestDHCP\");\
    \n        \$globalNoteMe value=\$state;\
    \n        :return false;\
    \n\
    \n    }\
    \n\
    \n    :do {\
    \n\
    \n        :local state (\"Adding ARP static entries for (\$newBlockedIp/\$newMac) on \$mainDHCP\");\
    \n        \$globalNoteMe value=\$state;\
    \n        /ip arp remove [find address=\$newIp];\
    \n        /ip arp remove [find address=\$newBlockedIp];\
    \n        /ip arp remove [find mac-address=\$newMac];\
    \n\
    \n     :if ([ :len [ /interface find where name=\"\$arpInterface\" ] ] > 0) do={\
    \n        /ip arp add address=\$newIp interface=\$arpInterface mac-address=\$newMac comment=\$comment\
    \n        :local state (\"Done.\");\
    \n        \$globalNoteMe value=\$state;\
    \n       } else={\
    \n        :local state (\"Cant find interface \$arpInterface. SKIPPED.\");\
    \n        \$globalNoteMe value=\$state;\
    \n       }\
    \n\
    \n    } on-error={\
    \n\
    \n        :local state (\"Error: something fail on ARP configuration step\");\
    \n        \$globalNoteMe value=\$state;\
    \n        :return false;\
    \n\
    \n    }\
    \n\
    \n    :do {\
    \n\
    \n        :local state (\"Adding CAPs ACL static entries for (\$newBlockedIp/\$newMac) on \$newSsid\");\
    \n        \$globalNoteMe value=\$state;\
    \n        \
    \n         # avoid parce errors using Execute when no wireless package installed\
    \n       :if ( [ :len [ /system package find where name=\"wireless\" and disabled=no ] ] > 0  ) do={\
    \n          :local Cmd \"/caps-man access-list remove [find mac-address=\$newMac];\";\
    \n          :local jobid [:execute script=\$Cmd];\
    \n\
    \n          :local Cmd \"/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=\$comment disabled=no mac-address=\$newMac ssid-regexp='\$newSsid' place-before=1;\";\
    \n          :local jobid [:execute script=\$Cmd];\
    \n\
    \n          }\
    \n\
    \n    } on-error={\
    \n\
    \n        :local state (\"Error: something fail on CAPS configuration step\");\
    \n        \$globalNoteMe value=\$state;\
    \n        :return false;\
    \n\
    \n    }\
    \n\
    \n    :return true;\
    \n\
    \n  }\
    \n}\
    \n\
    \n\
    \n\
    \n#Example call\
    \n#\$globalNewClientCert argClients=\"anna.ipsec, mikrouter.ipsec\" argUsage=\"tls-client,digital-signature,key-encipherment\"\
    \n#\$globalNewClientCert argClients=\"anna.capsman, mikrouter.capsman\" argUsage=\"digital-signature,key-encipherment\"\
    \n#\$globalNewClientCert argClients=\"185.13.148.14\" argUsage=\"tls-server\" argBindAsIP=\"any\"\
    \n:if (!any \$globalNewClientCert) do={\
    \n  :global globalNewClientCert do={\
    \n\
    \n    # generates IPSEC certs CLIENT TEMPLATE, then requests SCEP to sign it\
    \n    # This script is a SCEP-client, it request the server to provide a new certificate\
    \n    # it ONLY form the request via API to remote SCEP server\
    \n\
    \n    # incoming named params\
    \n    :local clients [ :tostr \$argClients ];\
    \n    :local prefs  [ :tostr \$argUsage ];\
    \n    :local asIp  \$argBindAsIP ;\
    \n\
    \n    # scope global functions\
    \n    :global globalNoteMe;\
    \n    :global globalScriptBeforeRun;\
    \n\
    \n    :if ([:len \$clients] > 0) do={\
    \n      :if ([ :typeof [ :tostr \$clients ] ] != \"str\" ) do={\
    \n\
    \n          :local state (\"Error: bad 'cients' parameter passed - (\$clients)\");\
    \n          \$globalNoteMe value=\$state;\
    \n          :return false;\
    \n\
    \n      }\
    \n    } else={\
    \n\
    \n        :local state (\"Error: bad 'cients' parameter passed - (\$clients\");\
    \n        \$globalNoteMe value=\$state;\
    \n        :return false;\
    \n\
    \n    }\
    \n\
    \n    :do {\
    \n\
    \n      #clients\
    \n      :local IDs [:toarray \"\$clients\"];\
    \n      :local fakeDomain \"myvpn.fake.org\"\
    \n      :local scepAlias \"CHR\"\
    \n      :local state (\"Started requests generation\");\
    \n\
    \n      \$globalNoteMe value=\$state;\
    \n\
    \n      ## this fields should be empty IPSEC/ike2/RSA to work, i can't get it functional with filled fields\
    \n      :local COUNTRY \"RU\"\
    \n      :local STATE \"MSC\"\
    \n      :local LOC \"Moscow\"\
    \n      :local ORG \"IKEv2 Home\"\
    \n      :local OU \"IKEv2 Mikrotik\"\
    \n\
    \n      # :local COUNTRY \"\"\
    \n      # :local STATE \"\"\
    \n      # :local LOC \"\"\
    \n      # :local ORG \"\"\
    \n      # :local OU \"\"\
    \n\
    \n\
    \n      :local KEYSIZE \"2048\"\
    \n\
    \n      :local scepUrl \"http://185.13.148.14/scep/grant\";\
    \n      :local itsOk true;\
    \n\
    \n      :local tname \"\";\
    \n      :foreach USERNAME in=\$IDs do={\
    \n\
    \n        ## create a client certificate (that will be just a template while not signed)\
    \n        :if (  [:len \$asIp ] > 0 ) do={\
    \n\
    \n                :local state \"CLIENT TEMPLATE certificates generation as IP...  \$USERNAME\";\
    \n                \$globalNoteMe value=\$state;\
    \n\
    \n                :set tname \"S.\$USERNAME@\$scepAlias\";\
    \n\
    \n                :if ([ :len [ /certificate find where name=\"\$tname\" ] ] > 0) do={\
    \n\
    \n                  :local state (\"Error: found certificate named (\$tname) -  cannot create the same one\");\
    \n                  \$globalNoteMe value=\$state;\
    \n                  :return false;\
    \n\
    \n                } else={\
    \n\
    \n                  /certificate add name=\"\$tname\" common-name=\"\$USERNAME@\$scepAlias\" subject-alt-name=\"IP:\$USERNAME,DNS:\$fakeDomain\" key-usage=\$prefs country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365;\
    \n\
    \n                };\
    \n\
    \n            } else={\
    \n\
    \n                :local state \"CLIENT TEMPLATE certificates generation as EMAIL...  \$USERNAME\";\
    \n                \$globalNoteMe value=\$state;\
    \n\
    \n                :set tname \"C.\$USERNAME@\$scepAlias\";\
    \n\
    \n                :if ([ :len [ /certificate find where name=\"\$tname\" ] ] > 0) do={\
    \n\
    \n                  :local state (\"Error: found certificate named (\$tname) -  cannot create the same one\");\
    \n                  \$globalNoteMe value=\$state;\
    \n                  :return false;\
    \n\
    \n                } else={\
    \n\
    \n                  /certificate add name=\"\$tname\" common-name=\"\$USERNAME@\$scepAlias\" subject-alt-name=\"email:\$USERNAME@\$fakeDomain\" key-usage=\$prefs  country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365\
    \n\
    \n                };\
    \n\
    \n            }\
    \n\
    \n        :local state \"Pushing sign request...\";\
    \n        \$globalNoteMe value=\$state;\
    \n        /certificate add-scep template=\"\$tname\" scep-url=\"\$scepUrl\";\
    \n\
    \n        :delay 6s\
    \n\
    \n        ## we now have to wait while on remote [mikrotik] this request will be granted and pushed back ready-to-use certificate\
    \n        :local state \"We now have to wait while on remote [mikrotik] this request will be granted and pushed back ready-to-use certificate... \";\
    \n        \$globalNoteMe value=\$state;\
    \n\
    \n        :local state \"Proceed to remote SCEP please, find this request and appove it. I'll wait 30 seconds\";\
    \n        \$globalNoteMe value=\$state;\
    \n\
    \n        :delay 30s\
    \n\
    \n        :local baseLength 5;\
    \n        :for j from=1 to=\$baseLength do={\
    \n          :if ([ :len [ /certificate find where status=\"idle\" name=\"\$tname\" ] ] > 0) do={\
    \n\
    \n            :local state \"Got it at last. Exporting to file\";\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            /certificate set trusted=yes [find where name=\"\$tname\" and status=\"idle\"]\
    \n\
    \n            ## export the CA, client certificate, and private key\
    \n            /certificate export-certificate [find where name=\"\$tname\" and status=\"idle\"] export-passphrase=\"1234567890\" type=pkcs12\
    \n\
    \n            :return true;\
    \n\
    \n          } else={\
    \n\
    \n            :local state \"Waiting for mikrotik to download the certificate...\";\
    \n            \$globalNoteMe value=\$state;\
    \n            :delay 8s\
    \n\
    \n          };\
    \n        }\
    \n      };\
    \n\
    \n      :return false;\
    \n\
    \n    } on-error={\
    \n\
    \n        :local state (\"Error: something fail on SCEP certifcates issuing step\");\
    \n        \$globalNoteMe value=\$state;\
    \n        :return false;\
    \n\
    \n    }\
    \n  }\
    \n}\
    \n\
    \n\
    \n\
    \n:if (!any \$globalCallFetch) do={\
    \n  :global globalCallFetch do={\
    \n\
    \n    # this one calls Fetch and catches its errors\
    \n    :global globalNoteMe;\
    \n    :if ([:len \$1] > 0) do={\
    \n\
    \n        # something like \"/tool fetch address=nas.home port=21 src-path=scripts/doSwitchDoHOn.rsc.txt user=git password=git dst-path=/REPO/doSwitchDoHOn.rsc.txt mode=ftp upload=yes\"\
    \n        :local fetchCmd \"\$1\";\
    \n\
    \n        :local state \"I'm now putting: \$fetchCmd\";\
    \n        \$globalNoteMe value=\$state;\
    \n\
    \n        /file remove [find where name=\"fetch.log.txt\"]\
    \n        {\
    \n            :local jobid [:execute file=fetch.log.txt script=\$fetchCmd]\
    \n\
    \n            :local state \"Waiting the end of process for file fetch.log to be ready, max 20 seconds...\";\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            :global Gltesec 0\
    \n            :while (([:len [/sys script job find where .id=\$jobid]] = 1) && (\$Gltesec < 20)) do={\
    \n                :set Gltesec (\$Gltesec + 1)\
    \n                :delay 1s\
    \n\
    \n                :local state \"waiting... \$Gltesec\";\
    \n                \$globalNoteMe value=\$state;\
    \n\
    \n            }\
    \n\
    \n            :local state \"Done. Elapsed Seconds: \$Gltesec\\r\\n\";\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            :if ([:len [/file find where name=\"fetch.log.txt\"]] = 1) do={\
    \n                :local filecontent [/file get [/file find where name=\"fetch.log.txt\"] contents]\
    \n                :put \"Result of Fetch:\\r\\n****************************\\r\\n\$filecontent\\r\\n****************************\"\
    \n            } else={\
    \n                :put \"File not created.\"\
    \n            }\
    \n        }\
    \n    }\
    \n  }\
    \n}\
    \n\
    \n#:put [\$simplercurrdatetimestr]\
    \n:if (!any \$simplercurrdatetimestr) do={\
    \n:global simplercurrdatetimestr do={\
    \n    /system clock\
    \n    :local vdate [get date]\
    \n    :local vtime [get time]\
    \n    :local vdoff [:toarray \"0,4,5,7,8,10\"]\
    \n    :local MM    [:pick \$vdate (\$vdoff->2) (\$vdoff->3)]\
    \n    :local M     [:tonum \$MM]\
    \n    :if (\$vdate ~ \".../../....\") do={\
    \n        :set vdoff [:toarray \"7,11,1,3,4,6\"]\
    \n        :set M     ([:find \"xxanebarprayunulugepctovecANEBARPRAYUNULUGEPCTOVEC\" [:pick \$vdate (\$vdoff->2) (\$vdoff->3)] -1] / 2)\
    \n        :if (\$M>12) do={:set M (\$M - 12)}\
    \n        :set MM    [:pick (100 + \$M) 1 3]\
    \n    }\
    \n    :local yyyy [:pick \$vdate (\$vdoff->0) (\$vdoff->1)]\
    \n    :local dd   [:pick \$vdate (\$vdoff->4) (\$vdoff->5)]\
    \n    :local HH   [:pick \$vtime 0  2]\
    \n    :local mm   [:pick \$vtime 3  5]\
    \n    :local ss   [:pick \$vtime 6  8]\
    \n\
    \n    :return \"\$yyyy\$MM\$dd-\$HH\$mm\$ss\"\
    \n}\
    \n\
    \n}\
    \n\
    \n"
/system script add comment="Creates simple queues based on DHCP leases, i'm using it just for per-host traffic statistic and periodically send counters to Grafana" dont-require-permissions=yes name=doCreateTrafficAccountingQueues owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\
    \n:local scriptname \"doCreateTrafficAccountingQueues\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n#a part of queue comment to locate queues to be processed\
    \n:local qCommentMark \"dtq\";\
    \n\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n\
    \n:local state \"\";\
    \n \
    \n/ip dhcp-server lease\
    \n:foreach x in=[find] do={\
    \n   \
    \n  # grab variables for use below\
    \n  :local dhcpIp ([get \$x address])\
    \n  :local dhcpMac [get \$x mac-address]\
    \n  :local dhcpHost [get \$x host-name]\
    \n  :local dhcpComment [get \$x comment]\
    \n  :local dhcpServer [get \$x server]\
    \n  :local qComment \"\"\
    \n   \
    \n  :local leaseinqueue false\
    \n\
    \n  /queue simple\
    \n  :foreach y in=[find where comment~\"\$qCommentMark\"] do={\
    \n     \
    \n    #grab variables for use below\
    \n    :local qIp [get \$y target]\
    \n    :set qComment [get \$y comment]\
    \n\
    \n    :local skip false;\
    \n  \
    \n    :if ( (\$qIp->0) != nil ) do={\
    \n      :set qIp (\$qIp->0) \
    \n      :set qIp ( [:pick \$qIp 0 [:find \$qIp \"/\" -1]] ) ;\
    \n    } else {\
    \n      :set skip true;\
    \n    }\
    \n         \
    \n    # Isolate information  from the comment field (MAC, Hostname)\
    \n    :local qMac [:pick \$qComment 4 21]\
    \n    :local qHost [:pick \$qComment 22 [:len \$qComment]]\
    \n\
    \n    # If MAC from lease matches the queue MAC and IPs are the same - then refresh the queue item\
    \n    :if (\$qMac = \$dhcpMac and \$qIp = \$dhcpIp and !\$skip) do={\
    \n\
    \n      # build a comment field\
    \n      :set qComment (\$qCommentMark . \",\" . \$dhcpMac . \",\" . \$dhcpHost)\
    \n\
    \n      set \$y target=\$dhcpIp comment=\$qComment\
    \n\
    \n      :if (\$dhcpComment != \"\") do= {\
    \n        set \$y name=(\$dhcpComment . \"@\" . \$dhcpServer . \" (\" . \$dhcpMac . \")\")\
    \n      } else= {\
    \n        :if (\$dhcpHost != \"\") do= {\
    \n          set \$y name=(\$dhcpHost . \"@\" . \$dhcpServer . \" (\" . \$dhcpMac . \")\")\
    \n        } else= {\
    \n          set \$y name=(\$dhcpMac . \"@\" . \$dhcpServer)\
    \n        }\
    \n      }\
    \n\
    \n      :local queuename [get \$y name]\
    \n\
    \n      :set state \"Queue \$queuename updated\"\
    \n      \$globalNoteMe value=\$state;\
    \n\
    \n      :set leaseinqueue true\
    \n    } \
    \n  }\
    \n\
    \n  # There was not an existing entry so add one for this lease\
    \n  :if (\$leaseinqueue = false) do={\
    \n\
    \n    # build a comment field\
    \n    :set qComment (\$qCommentMark . \",\" . \$dhcpMac . \",\" . \$dhcpHost)\
    \n\
    \n    # build command (queue names should be unique)\
    \n    :local cmd \"/queue simple add target=\$dhcpIp comment=\$qComment queue=default/default total-queue=default\"\
    \n    :if (\$dhcpComment != \"\") do={ \
    \n      :set cmd \"\$cmd name=\\\"\$dhcpComment@\$dhcpServer (\$dhcpMac)\\\"\" \
    \n    } else= {\
    \n      :if (\$dhcpHost != \"\") do={\
    \n        :set cmd \"\$cmd name=\\\"\$dhcpHost@\$dhcpServer (\$dhcpMac)\\\"\"\
    \n      } else= {\
    \n        :set cmd \"\$cmd name=\\\"\$dhcpMac@\$dhcpServer\\\"\"\
    \n      }\
    \n    }\
    \n\
    \n    :execute \$cmd\
    \n\
    \n    :set state \"Queue \$qComment created\"\
    \n    \$globalNoteMe value=\$state;\
    \n\
    \n  }\
    \n}\
    \n\
    \n# Cleanup Routine - remove dynamic entries that no longer exist in the lease table\
    \n/queue simple\
    \n:foreach z in=[find where comment~\"\$qCommentMark\"] do={\
    \n\
    \n  :local qComment [get \$z comment]\
    \n  :local qMac [:pick \$qComment 4 21]\
    \n\
    \n  :local qIp [get \$z target]\
    \n  :local skip false\
    \n\
    \n  :if ( (\$qIp->0) != nil ) do={\
    \n    :set qIp (\$qIp->0) \
    \n    :set qIp ( [:pick \$qIp 0 [:find \$qIp \"/\" -1]] ) ;\
    \n  } else {\
    \n    :set skip true;\
    \n  }\
    \n\
    \n  :if (\$itsOk and !\$skip) do={\
    \n    :if ( [/ip dhcp-server lease find address=\$qIp and mac-address=\$qMac] = \"\") do={\
    \n      :set state \"Queue \$qComment dropped as stale\"\
    \n      \$globalNoteMe value=\$state;\
    \n      remove \$z\
    \n    }\
    \n  }    \
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: refreshed traffic accounting queues Succesfully\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;  \
    \n  :error \$inf; \
    \n\
    \n  \
    \n}\
    \n"
/system script add comment="Common backup script to ftp/email using both raw/plain formats. Can also be used to collect Git config history" dont-require-permissions=yes name=doBackup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \"doBackup\";\
    \n\
    \n:local sysname [/system identity get name];\
    \n:local rosVer [:tonum [:pick [/system resource get version] 0 1]]\
    \n\
    \n:local sysver \"NA\"\
    \n:if ( [ :len [ /system package find where name=\"system\" and disabled=no ] ] > 0 and \$rosVer = 6 ) do={\
    \n  :set sysver [/system package get system version]\
    \n}\
    \n:if ( [ :len [ /system package find where name=\"routeros\" and disabled=no ] ] > 0 and \$rosVer = 7 ) do={\
    \n  :set sysver [/system package get routeros version]\
    \n}\
    \n\
    \n:global globalNoteMe;\
    \n:global globalCallFetch;\
    \n:global simplercurrdatetimestr;\
    \n\
    \n\
    \n:local scriptname \"doBackup\"\
    \n:local saveSysBackup true\
    \n:local encryptSysBackup false\
    \n:local saveRawExport true\
    \n:local verboseRawExport false\
    \n:local state \"\"\
    \n\
    \n#directories have to exist!\
    \n:local FTPEnable true;\
    \n:local FTPServer \"nas.home\";\
    \n:local FTPPort 2022;\
    \n:local FTPUser \"git\";\
    \n:local FTPPass \"git\";\
    \n:local FTPRoot \"REPO/backups/\";\
    \n:local FTPGitEnable true;\
    \n:local FTPRawGitName \"REPO/raw/rawconf_\$sysname_latest.rsc\";\
    \n\
    \n:local sysnote [/system note get note];\
    \n\
    \n:local stamp [\$simplercurrdatetimestr];\
    \n\
    \n:local SMTPEnable true;\
    \n:local SMTPAddress \"defm.kopcap@gmail.com\";\
    \n:local SMTPSubject (\"\$sysname Full Backup (\$stamp)\");\
    \n:local SMTPBody (\"\$sysname full Backup file see in attachment.\\n \$sysnote\");\
    \n:local itsOk true;\
    \n\
    \n:do {\
    \n  :local smtpserv [:resolve \"\$FTPServer\"];\
    \n} on-error={ \
    \n  :set state \"FTP server looks like to be unreachable\"\
    \n  \$globalNoteMe value=\$state;\
    \n  :set itsOk false;\
    \n}\
    \n\
    \n\
    \n:local fname (\"BACKUP-\$sysname-\$stamp\")\
    \n\
    \n:if (\$saveSysBackup and \$itsOk) do={\
    \n  :if (\$encryptSysBackup = true) do={ /system backup save name=(\$fname.\".backup\") }\
    \n  :if (\$encryptSysBackup = false) do={ /system backup save dont-encrypt=yes name=(\$fname.\".backup\") }\
    \n  :delay 2s;\
    \n  \$globalNoteMe value=\"System Backup Finished\"\
    \n}\
    \n\
    \n:if (\$saveRawExport and \$itsOk) do={\
    \n  :if (\$FTPGitEnable ) do={\
    \n     # show sensitive data\
    \n     :if (\$verboseRawExport = true) do={ /export show-sensitive terse verbose file=(\$fname.\".safe.rsc\") }\
    \n     :if (\$verboseRawExport = false) do={ /export show-sensitive terse file=(\$fname.\".safe.rsc\") }\
    \n     :delay 2s;\
    \n  }\
    \n  \$globalNoteMe value=\"Raw configuration script export Finished\"\
    \n}\
    \n\
    \n:delay 5s\
    \n\
    \n:local buFile \"\"\
    \n\
    \n:foreach backupFile in=[/file find] do={\
    \n  \
    \n  :set buFile ([/file get \$backupFile name])\
    \n  \
    \n  :if ([:typeof [:find \$buFile \$fname]] != \"nil\") do={\
    \n    \
    \n    :local itsSRC ( \$buFile ~\".safe.rsc\")\
    \n    \
    \n     if (\$FTPEnable) do={\
    \n        :do {\
    \n        :set state \"Uploading \$buFile to FTP (\$FTPRoot\$buFile)\"\
    \n        \$globalNoteMe value=\$state\
    \n \
    \n        :local dst \"\$FTPRoot\$buFile\";\
    \n        :local fetchCmd \"/tool fetch url=sftp://\$FTPServer:\$FTPPort/\$dst src-path=\$buFile user=\$FTPUser password=\$FTPPass upload=yes\"\
    \n\
    \n        \$globalCallFetch \$fetchCmd;\
    \n\
    \n        \$globalNoteMe value=\"Done\"\
    \n\
    \n        } on-error={ \
    \n          :set state \"Error When \$state\"\
    \n          \$globalNoteMe value=\$state;\
    \n          :set itsOk false;\
    \n       }\
    \n\
    \n        #special ftp upload for git purposes\
    \n        if (\$itsSRC and \$FTPGitEnable) do={\
    \n            :do {\
    \n            :set state \"Uploading \$buFile to GIT-FTP (RAW, \$FTPRawGitName)\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            :local dst \"\$FTPRawGitName\";\
    \n            :local fetchCmd \"/tool fetch url=sftp://\$FTPServer:\$FTPPort/\$dst src-path=\$buFile user=\$FTPUser password=\$FTPPass upload=yes\"\
    \n \
    \n        \$globalCallFetch \$fetchCmd;\
    \n\
    \n            \$globalNoteMe value=\"Done\"\
    \n            } on-error={ \
    \n              :set state \"Error When \$state\"\
    \n              \$globalNoteMe value=\$state;\
    \n              :set itsOk false;\
    \n           }\
    \n        }\
    \n\
    \n    }\
    \n    if (\$SMTPEnable and !\$itsSRC) do={\
    \n        :do {\
    \n        :set state \"Uploading \$buFile to SMTP\"\
    \n        \$globalNoteMe value=\$state\
    \n\
    \n        #email works in background, delay needed\
    \n        /tool e-mail send to=\$SMTPAddress body=\$SMTPBody subject=\$SMTPSubject file=\$buFile tls=starttls\
    \n\
    \n        #waiting for email to be delivered\
    \n        :delay 15s;\
    \n\
    \n        :local emlResult ([/tool e-mail get last-status] = \"succeeded\")\
    \n\
    \n        if (!\$emlResult) do={\
    \n\
    \n          :set state \"Error When \$state\"\
    \n          \$globalNoteMe value=\$state;\
    \n          :set itsOk false;\
    \n\
    \n        } else={\
    \n\
    \n          \$globalNoteMe value=\"Done\"\
    \n       \
    \n        }\
    \n\
    \n        } on-error={ \
    \n          :set state \"Error When \$state\"\
    \n          \$globalNoteMe value=\$state;\
    \n          :set itsOk false;\
    \n       }\
    \n    }\
    \n\
    \n    :delay 2s;\
    \n    #/file remove \$backupFile;\
    \n\
    \n  }\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: Automatic Backup Completed Successfully\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n  :error \$inf; \
    \n \
    \n}\
    \n\
    \n\
    \n"
/system script add comment="Periodically renews password for some user accounts and sends a email" dont-require-permissions=yes name=doRandomGen owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local scriptname \"doRandomGen\"\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:global globalNoteMe;\
    \n:local state \"\";\
    \n\
    \n:global simplercurrdatetimestr;\
    \n\
    \n:local stamp [\$simplercurrdatetimestr];\
    \n\
    \n:local sysname [/system identity get name];\
    \n:local rosVer [:tonum [:pick [/system resource get version] 0 1]]\
    \n\
    \n:local sysver \"NA\"\
    \n:if ( [ :len [ /system package find where name=\"system\" and disabled=no ] ] > 0 and \$rosVer = 6 ) do={\
    \n  :set sysver [/system package get system version]\
    \n}\
    \n:if ( [ :len [ /system package find where name=\"routeros\" and disabled=no ] ] > 0 and \$rosVer = 7 ) do={\
    \n  :set sysver [/system package get routeros version]\
    \n}\
    \n\
    \n:local SMTPAddress \"defm.kopcap@gmail.com\";\
    \n:local SMTPSubject (\"\$sysname pwd restoration (\$stamp)\");\
    \n:local SMTPBody;\
    \n\
    \n:local itsOk true;\
    \n\
    \n:set state \"Starting reserve password generator Script...\";\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n# special password appendix - current month 3chars\
    \n:local pfx [:pick [/system clock get date] 0 3 ];\
    \n:local newPassword \"\";\
    \n\
    \n:set newPassword [:rndstr length=6 from=\"0123456789dglpqwBHNTQV\"];\
    \n\
    \n:set state \"Randomized: '\$newPassword'\";\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n# doing simple salt\
    \n:set newPassword (\$pfx . \$newPassword);\
    \n\
    \n/user set [find name=reserved] password=\$newPassword\
    \n\
    \n# crop appendix\
    \n:local halfPass [:pick [\$newPassword] 3 11 ];\
    \n\
    \n:do {\
    \n    :set state \"Sending backup password\"\
    \n    \$globalNoteMe value=\$state\
    \n\
    \n    :set SMTPBody (\"Device additional password: '***\$halfPass'\")\
    \n\
    \n    #email works in background, delay needed\
    \n    /tool e-mail send to=\$SMTPAddress body=\$SMTPBody subject=\$SMTPSubject tls=starttls\
    \n\
    \n    #waiting for email to be delivered\
    \n    :delay 15s;\
    \n\
    \n    :local emlResult ([/tool e-mail get last-status] = \"succeeded\")\
    \n\
    \n    if (!\$emlResult) do={\
    \n\
    \n            :set state \"Error When \$state\"\
    \n            \$globalNoteMe value=\$state;\
    \n            :set itsOk false;\
    \n\
    \n        } else={\
    \n\
    \n            \$globalNoteMe value=\"Done\"\
    \n    \
    \n        }\
    \n\
    \n    } on-error={ \
    \n        :set state \"Error When \$state\"\
    \n        \$globalNoteMe value=\$state;\
    \n        :set itsOk false;\
    \n    }\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: pwd restoration Completed Successfully\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n  :error \$inf; \
    \n  \
    \n}"
/system script add comment="Dumps all the scripts from you device to *.rsc.txt files, loads to FTP (all scripts in this Repo made with it)" dont-require-permissions=yes name=doDumpTheScripts owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doDumpTheScripts\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:global globalCallFetch;\
    \n\
    \n#directories have to exist!\
    \n:local FTPRoot \"REPO/raw/\"\
    \n\
    \n#This subdir will be created locally to put exported scripts in\
    \n#and it must exist under \$FTPRoot to upload scripts to\
    \n:local SubDir \"scripts/\"\
    \n\
    \n:local FTPEnable true\
    \n:local FTPServer \"nas.home\"\
    \n:local FTPPort 2022\
    \n:local FTPUser \"git\"\
    \n:local FTPPass \"git\"\
    \n\
    \n:global globalCallFetch;\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n:local state \"\";\
    \n:global globalScriptId;\
    \n:global createPath;\
    \n\
    \n:do {\
    \n  :local smtpserv [:resolve \"\$FTPServer\"];\
    \n} on-error={\
    \n  :set state \"FTP server looks like to be unreachable\";\
    \n   \$globalNoteMe value=\$state;\
    \n  :set itsOk false;    \
    \n}\
    \n\
    \n:foreach backupFile in=[/file find where name~\"^\$SubDir\"] do={\
    \n    /file remove \$backupFile;\
    \n}\
    \n\
    \n# Just to sure (or create) if \$SubDir exist\
    \n  /file/add name=\"\$SubDir/foo.txt\" contents=\"Feel free to remove this\";\
    \n\
    \n \$globalNoteMe value=\"Scripts source export..\";\
    \n\
    \n:foreach scriptId in [/system script find] do={\
    \n  :if (\$itsOk) do={\
    \n\
    \n    :local scriptSource [/system script get \$scriptId source];\
    \n    :local theScript [/system script get \$scriptId name];\
    \n    :local scriptSourceLength [:len \$scriptSource];\
    \n    :local path \"\$SubDir\$theScript.rsc.txt\";\
    \n\
    \n    :set \$globalScriptId \$scriptId;\
    \n\
    \n    :if (\$scriptSourceLength >= 4096) do={\
    \n      :set state \"Please keep care about '\$theScript' consistency - its size over 4096 bytes\";\
    \n      \$globalNoteMe value=\$state;\
    \n    }\
    \n\
    \n    :do {\
    \n      /file print file=\$path where 1=0;\
    \n      #filesystem delay\
    \n      :delay 1s;\
    \n\
    \n      # Due to max variable size 4096 bytes - this scripts should be reworked, but now using :put hack\
    \n      /execute script=\":global globalScriptId; :put [/system script get \$globalScriptId source];\" file=\$path;\
    \n      :set state \"Exported '\$theScript' to '\$path'\";\
    \n      \$globalNoteMe value=\$state;\
    \n    } on-error={ \
    \n      :set state \"Error When Exporting '\$theScript' Script to '\$path'\";\
    \n      \$globalNoteMe value=\$state;\
    \n      :set itsOk false;\
    \n    }\
    \n  }\
    \n}\
    \n\
    \n\
    \n:delay 5s\
    \n\
    \n:local buFile \"\"\
    \n\
    \n \$globalNoteMe value=\"Scripts source pushing..\";\
    \n\
    \n:if (\$itsOk) do={\
    \n  :foreach backupFile in=[/file find where name~\"^\$SubDir\"] do={\
    \n    :set buFile ([/file get \$backupFile name]);\
    \n    :if ([:typeof [:find \$buFile \".rsc.txt\"]] != \"nil\") do={\
    \n      :local rawfile ( \$buFile ~\".rsc.txt\");\
    \n      #special ftp upload for git purposes\
    \n      if (\$FTPEnable) do={\
    \n        :local dst \"\$FTPRoot\$buFile\";\
    \n        :do {\
    \n          :set state \"Uploading \$buFile' to '\$dst'\";\
    \n          \$globalNoteMe value=\$state;\
    \n          \
    \n         :local fetchCmd \"/tool fetch url=sftp://\$FTPServer:\$FTPPort/\$dst src-path=\$buFile user=\$FTPUser password=\$FTPPass upload=yes\"\
    \n       \
    \n          \$globalCallFetch \$fetchCmd;\
    \n\
    \n          \$globalNoteMe value=\"Done\";\
    \n        } on-error={ \
    \n          :set state \"Error When Uploading '\$buFile' to '\$dst'\";\
    \n          \$globalNoteMe value=\$state;\
    \n          :set itsOk false;\
    \n        }\
    \n      }\
    \n    }\
    \n  }\
    \n}\
    \n\
    \n:delay 5s\
    \n\
    \n \$globalNoteMe value=\"Housekeeping..\";\
    \n\
    \n:foreach backupFile in=[/file find where name~\"^\$SubDir\"] do={\
    \n  :if ([:typeof [:find \$buFile \".rsc.txt\"]] != \"nil\") do={\
    \n    /file remove \$backupFile;\
    \n  }\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: scripts dump done Successfully\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n  :error \$inf; \
    \n  \
    \n}\
    \n"
/system script add comment="Updates chosen scripts from Git/master (sheduler entry with the same name have to exist)" dont-require-permissions=yes name=doFreshTheScripts owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doFreshTheScripts\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:local GitHubUserName \"Defm\";\
    \n:local GitHubRepoName \"mikrobackups\";\
    \n\
    \n#should be used for private repos\
    \n:local GitHubAccessToken \"\";\
    \n\
    \n:local RequestUrl \"https://\$GitHubAccessToken@raw.githubusercontent.com/\$GitHubUserName/\$GitHubRepoName/master/scripts/\";\
    \n\
    \n:local UseUpdateList true;\
    \n:local UpdateList [:toarray \"doBackup,doEnvironmentSetup,doEnvironmentClearance,doRandomGen,doFreshTheScripts,doCertificatesIssuing,doNetwatchHost, doIPSECPunch,doStartupScript,doHeatFlag,doPeriodicLogDump,doPeriodicLogParse,doTelegramNotify,doLEDoff,doLEDon,doCPUHighLoadReboot,doUpdatePoliciesRemotely,doUpdateExternalDNS,doSuperviseCHRviaSSH,doCoolConsole,doFlushLogs\"];\
    \n\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n:local state \"\";\
    \n\
    \n:foreach scriptName in=\$UpdateList do={\
    \n\
    \n    :if ([:len [/system script find name=\$scriptName]] = 0) do={\
    \n\
    \n      :set state \"Script '\$scriptName' skipped due to absence\";\
    \n      \$globalNoteMe value=\$state;\
    \n\
    \n    }\
    \n}\
    \n  \
    \n:foreach scriptId in [/system script find] do={\
    \n\
    \n  :local code \"\";\
    \n  :local theScript [/system script get \$scriptId name];\
    \n  :local skip false;\
    \n\
    \n  :if ( \$UseUpdateList ) do={\
    \n    :if ( [:len [find key=\$theScript in=\$UpdateList ]] > 0 ) do={\
    \n    } else={\
    \n      :set state \"Script '\$theScript' skipped due to setup\";\
    \n      \$globalNoteMe value=\$state;\
    \n      :set skip true;\
    \n    }\
    \n  } else={\
    \n  }\
    \n\
    \n  :if ( \$itsOk and !\$skip) do={\
    \n    :do {\
    \n\
    \n      :set state \"/tool fetch url=\$RequestUrl\$\$theScript.rsc.txt output=user as-value\";\
    \n      \$globalNoteMe value=\$state;\
    \n \
    \n      #Please keep care about consistency if size over 4096 bytes\
    \n      :local answer ([ /tool fetch url=\"\$RequestUrl\$\$theScript.rsc.txt\" output=user as-value]);\
    \n      :set code ( \$answer->\"data\" );\
    \n      \$globalNoteMe value=\"Done\";\
    \n\
    \n    } on-error= { \
    \n      :set state \"Error When Downloading Script '\$theScript' From GitHub\";\
    \n      \$globalNoteMe value=\$state;\
    \n      :set itsOk false;\
    \n    }\
    \n  }\
    \n\
    \n  :if ( \$itsOk and !\$skip) do={\
    \n    :do {\
    \n      :set state \"Setting Up Script source for '\$theScript'\";\
    \n      \$globalNoteMe value=\$state;\
    \n      /system script set \$theScript source=\"\$code\";\
    \n      \$globalNoteMe value=\"Done\";\
    \n    } on-error= { \
    \n      :set state \"Error When Setting Up Script source for '\$theScript'\";\
    \n      \$globalNoteMe value=\$state;\
    \n      :set itsOk false;\
    \n    }\
    \n  }\
    \n\
    \n  :delay 1s\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: scripts refreshed Successfully\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n  :error \$inf; \
    \n  \
    \n}\
    \n\
    \n"
/system script add comment="Uses INFLUX DB http/rest api to push some stats to" dont-require-permissions=yes name=doPushStatsToInfluxDB owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doPushStatsToInfluxDB\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n#a part of queue comment to locate queues to be processed\
    \n:local queueCommentMark \"dtq\";\
    \n\
    \n#influxDB service URL (beware about port when /fetch)\
    \n:local tURL \"http://nas.home/api/v2/write\\\?bucket=httpapi&org=home\"\
    \n:local tPingURL \"http://nas.home/ping\"\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n\
    \n\
    \n:local useBandwidthTest false;\
    \n\
    \n:local state \"\";\
    \n\
    \n:do {\
    \n\
    \n  :set state (\"Checking if INFLUXDB Service online\");\
    \n  \$globalNoteMe value=\$state;\
    \n\
    \n  :local result [/tool fetch http-method=get port=8086 user=\"mikrotik\" password=\"mikrotik\" mode=http url=\"\$tPingURL\"  as-value output=user];\
    \n \
    \n} on-error={\
    \n  \
    \n  :set state (\"INFLUXDB: Service Failed!\");\
    \n  \$globalNoteMe value=\$state;\
    \n\
    \n  :local inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n\
    \n  :global globalTgMessage;\
    \n  # do not spam via Tg on this error - just log error\
    \n\
    \n  :error \$inf;\
    \n}\
    \n\
    \n:local state \"\";\
    \n\
    \n:local authHeader (\"Authorization: Token nh-mJylW1FCluBlUGXYZq_s5zne_QjzkHcc56y8v6AIlUOOiOm4bU2652r2Vkv3Vp6WzgQT7WPsi4yF0RvdElg==\"); \
    \n\
    \n\
    \n:if ( \$useBandwidthTest  ) do={\
    \n\
    \n:local txAvg 0\
    \n:local rxAvg 0\
    \n\
    \n:local btServer 192.168.97.1;\
    \n\
    \n:set state (\"Starting VPN bandwidth test\");\
    \n\$globalNoteMe value=\$state;\
    \n\
    \ntool bandwidth-test protocol=tcp direction=transmit user=btest password=btest address=\$btServer duration=15s do={\
    \n:set txAvg (\$\"tx-total-average\" / 1048576 );\
    \n}\
    \n\
    \ntool bandwidth-test protocol=tcp direction=receive user=btest password=btest address=\$btServer duration=15s do={\
    \n:set rxAvg (\$\"rx-total-average\" / 1048576 );\
    \n}\
    \n\
    \n:global globalCallFetch;\
    \n:local fetchCmd  \"/tool fetch http-method=post port=8086 mode=http url=\\\"\$tURL\\\" http-header-field=\\\"\$authHeader, content-type: text/plain\\\" http-data=\\\"bandwidth,host=\$sysname,target=CHR transmit=\$txAvg,recieve=\$rxAvg\\\" keep-result=no\";\
    \n\
    \n\$globalCallFetch \$fetchCmd;\
    \n\
    \n}\
    \n \
    \n/queue simple\
    \n\
    \n:foreach z in=[find where comment~\"\$queueCommentMark\"] do={\
    \n\
    \n  :local skip false;\
    \n\
    \n  :local queuecomment [get \$z comment]\
    \n  :local ip [get \$z target]\
    \n\
    \n  :if ( \$itsOk ) do={\
    \n\
    \n    :if ( (\$ip->0) != nil ) do={\
    \n      :set state (\"Locating queue target IP for queue \$queuecomment\");\
    \n      \$globalNoteMe value=\$state;\
    \n      :set ip (\$ip->0) \
    \n      :set ip ( [:pick \$ip 0 [:find \$ip \"/\" -1]] ) ;\
    \n      \$globalNoteMe value=\"Done\";\
    \n    } else {\
    \n      :set state \"Cant locate queue target IP for queue \$queuecomment. Skip it.\"\
    \n      \$globalNoteMe value=\$state;\
    \n      :set skip true;\
    \n    }\
    \n\
    \n  }\
    \n\
    \n  :local hostName \"\"\
    \n  :local upload 0\
    \n  :local download 0\
    \n\
    \n  :if ( \$itsOk and !\$skip) do={\
    \n    :local bytes [get \$z bytes]\
    \n    :set upload (\$upload + [:pick \$bytes 0 [:find \$bytes \"/\"]])\
    \n    :set download (\$download + [:pick \$bytes ([:find \$bytes \"/\"]+1) [:len \$bytes]])\
    \n  }\
    \n\
    \n  :if ( \$itsOk and !\$skip) do={\
    \n    :do {\
    \n      #dhcp server for IP->name translation\
    \n      :set state (\"Picking host name for \$ip via DHCP\");\
    \n      \$globalNoteMe value=\$state;\
    \n      :set hostName [/ip dhcp-server lease get [find (address=\$ip)] host-name]\
    \n\
    \n      :local typeOfValue [:typeof \$hostName]\
    \n\
    \n      :if ((\$typeOfValue = \"nothing\") or (\$typeOfValue = \"nil\")) do={\
    \n        :set state \"Got empty host name. Skip it.\"\
    \n        \$globalNoteMe value=\$state;\
    \n        :set skip true;\
    \n      } else={\
    \n        :set state \"Got it \$hostName\"\
    \n        \$globalNoteMe value=\$state;\
    \n      }\
    \n\
    \n    } on-error= {\
    \n      :set state \"Error When \$state\"\
    \n      \$globalNoteMe value=\$state;\
    \n      :set skip true;\
    \n    }\
    \n  }\
    \n\
    \n  :if ( \$itsOk and !\$skip) do={\
    \n    :do {\
    \n      :set state (\"Pushing stats to influxDB about \$hostName: UP = \$upload, DOWN=\$download\");\
    \n     \$globalNoteMe value=\$state;\
    \n      /tool fetch http-method=post port=8086 mode=http url=\"\$tURL\" http-header-field=\"\$authHeader, content-type: text/plain\" http-data=\"traffic,host=\$sysname,target=\$hostName upload=\$upload,download=\$download\" keep-result=no;\
    \n      \$globalNoteMe value=\"Done\";\
    \n    } on-error= {\
    \n      :set state \"Error When \$state\"\
    \n      \$globalNoteMe value=\$state;\
    \n      :set itsOk false;\
    \n    }\
    \n  }\
    \n  \
    \n  :if (\$itsOk and !\$skip) do={\
    \n    :set state \"Flushing stats..\"\
    \n    \$globalNoteMe value=\$state;\
    \n    reset-counters \$z\
    \n  }  \
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: stats pushed Succesfully\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: \$state\"  \
    \n  \
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;\
    \n  :error \$inf; \
    \n\
    \n\
    \n}\
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
    \n\r\
    \n\r\
    \n"
/system script add comment="A very special script for CFG restore from *.rsc files (not from backup). This one should be placed at flash/perfectrestore.rsc, your config should be at flash/backup.rsc. Run 'Reset confuguration' with 'no default config', choose 'flash/perfectrestore.rsc' as 'run after reset. Pretty logs will be at flash/import.log and flash/perfectrestore.log" dont-require-permissions=yes name=doPerfectRestore owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="{\r\r\
    \n:global targetfile \"backup.rsc\"\r\r\
    \n:global importlog \"import.log\"\r\r\
    \n:global debuglog \"perfectrestore.log\"\r\r\
    \n:global rosVer [:tonum [:pick [/system resource get version] 0 1]]\r\r\
    \n/file remove [find name ~\"\$importlog\"]\r\r\
    \n/file remove [find name ~\"\$debuglog\"]\r\r\
    \n# Wait for interfaces to initialize\r\r\
    \n:delay 5s\r\r\
    \n# Beep Functions\r\r\
    \n :local doStartBeep [:parse \":beep frequency=1000 length=300ms;:delay 150ms;:beep frequency=1500 length=300ms;\"];\r\r\
    \n :local doFinishBeep [:parse \":beep frequency=1000 length=.6;:delay .5s;:beep frequency=1600 length=.6;:delay .5s;:beep frequency=2100 length=.3;:delay .3s;:beep frequency=2500 length=.3;:delay .3s;:beep frequency=2400 length=1;\"];\r\r\
    \n# Setup temporary logging to disk\r\r\
    \n/system logging action remove [find where name~\"perfect\"]\r\r\
    \n/system logging action add disk-file-count=1 disk-file-name=\$debuglog disk-lines-per-file=4096 name=perfectrestore target=disk\r\r\
    \n/system logging remove [find where action~\"perfect\"]\r\r\
    \n/system logging add action=perfectrestore topics=system,info\r\r\
    \n/system logging add action=perfectrestore topics=script,info\r\r\
    \n/system logging add action=perfectrestore topics=warning\r\r\
    \n/system logging add action=perfectrestore topics=error\r\r\
    \n/system logging add action=perfectrestore topics=critical\r\r\
    \n/system logging add action=perfectrestore topics=debug,!packet\r\r\
    \n# checks if specific packages exist\r\r\
    \n:if ( [ :len [ /system package find where name=\"ntp\" and disabled=no ] ] = 0 and \$rosVer = 6 ) do={\r\r\
    \n  :log error \"NTP package should be installed for NTP-server to work\";\r\r\
    \n  :error \"NTP package should be installed for NTP-server to work\";\r\r\
    \n}\r\r\
    \n:if ( [ :len [ /system package find where name=\"iot\" and disabled=no ] ] = 0 and \$rosVer = 6 ) do={\r\r\
    \n  :log error \"IOT package should be installed\";\r\r\
    \n  :error \"IOT package should be installed\";\r\r\
    \n}\r\r\
    \n:if ( [ :len [ /system package find where name=\"lora\" and disabled=no ] ] = 0 and \$rosVer = 6 ) do={\r\r\
    \n  :log error \"LORA package should be installed\";\r\r\
    \n  :error \"LORA package should be installed\";\r\r\
    \n}\r\r\
    \n# Play Audible Start Sequence\r\r\
    \n\$doStartBeep\r\r\
    \n:log warning \"GO -----------------------------------------------------------------------------\";\r\r\
    \n/user active print detail file=activeUsers.txt;\r\r\
    \n:global currentUsers [/file get activeUsers.txt contents];\r\r\
    \n:log warning \"ENVIRONMENT IS \$currentUsers\";\r\r\
    \n# bug 6.49.6 - lora servers stay OK after /system reset-configuration no-defaults=yes\r\r\
    \n#/lora servers remove [find]\r\r\
    \n\r\r\
    \n:log warning \"CREATING ASYNC WRAPPER -----------------------------------------------------------------------------\";\r\r\
    \n:local AcyncAwait do={\r\r\
    \n  # this one calls Fetch and catches its errors\r\r\
    \n  :if (([:len \$1] > 0) and ([:len \$2] > 0)) do={\r\r\
    \n      # something like \r\r\
    \n      # \"/tool fetch address=nas.home port=21 src-path=scripts/doSwitchDoHOn.rsc.txt user=git password=git dst-path=/REPO/doSwitchDoHOn.rsc.txt mode=ftp upload=yes\"\r\r\
    \n      # or\r\r\
    \n      # \":import file-name=\$targetfile verbose=yes\"\r\r\
    \n      :local Cmd \"\$1\";\r\r\
    \n      :local outputFile \"\$2\";\r\r\
    \n      :local state \"AS-AW--------------------------: I'm now calling and waiting result for: \$Cmd\";\r\r\
    \n      :log info \$state;\r\r\
    \n      /file remove [find where name=\"\$outputFile\"]\r\r\
    \n      {\r\r\
    \n          :local jobid [:execute file=\"\$outputFile\" script=\$Cmd]\r\r\
    \n          :local state \"AS-AW----------------------: Waiting the end of process for file \$outputFile to be ready, max 40 seconds...\";\r\r\
    \n          :log info \$state;\r\r\
    \n          :global Gltesec 0\r\r\
    \n          :while (([:len [/sys script job find where .id=\$jobid]] = 1) && (\$Gltesec < 40)) do={\r\r\
    \n              :set Gltesec (\$Gltesec + 1)\r\r\
    \n              :delay 1s\r\r\
    \n              :local state \"AS-AW-------------------: waiting... \$Gltesec\";\r\r\
    \n              :log info \$state;\r\r\
    \n          }\r\r\
    \n          :local state \"AS-AW------------------------: Done. Elapsed Seconds: \$Gltesec\\r\\n\";\r\r\
    \n          :log info \$state;\r\r\
    \n          :if ([:len [/file find where name=\"\$outputFile\"]] = 1) do={\r\r\
    \n              :local filecontent [/file get [/file find where name=\"\$outputFile\"] contents]\r\r\
    \n              :log warning \"AS-AW--------------------: Result of CALL:\\r\\n****************************\\r\\n\$filecontent\\r\\n****************************\"\r\r\
    \n          } else={\r\r\
    \n              :log info \"AS-AW-----------------------: File not created.\"\r\r\
    \n          }\r\r\
    \n      }\r\r\
    \n  }\r\r\
    \n}\r\r\
    \n\r\r\
    \n:do {\r\r\
    \n  :log warning \"CERT  -----------------------------------------------------------------------------\";\r\r\
    \n  # IPSEC\\CAPSMAN\\DoH\\Etc certs have to be imported before the other config is restored\r\r\
    \n  # should be located in Files root\r\r\
    \n  # look through your backup.rsc before \r\r\
    \n  # certificates in '*.p12' format without password protection (without private keys)\r\r\
    \n  :local certImportListPublicKeys [:toarray \"ca@CHR\"];\r\r\
    \n  # certificates in '*.p12' format protected using password (containing private keys), set the password to '1234567890' or rewrite the script\r\r\
    \n  :local certImportListPrivateKeys [:toarray \"anna.capsman@CHR,anna.ipsec@CHR\"];\r\r\
    \n  :foreach certFile in=\$certImportListPublicKeys do={\r\r\
    \n    :local certFileName \"\$certFile.p12\";\r\r\
    \n    :if ([:len [/file find name=\$certFileName]] > 0) do={\r\r\
    \n    :log info \"GOT PUB CERTIFICATE '\$certFile'\";\r\r\
    \n    /certificate import file-name=\$certFileName name=\$certFile passphrase=\"\";\r\r\
    \n    } else={\r\r\
    \n      :log error \"CANT GET PUB CERTIFICATE FOR '\$certFile'\";\r\r\
    \n    }\r\r\
    \n  }\r\r\
    \n  :foreach certFile in=\$certImportListPrivateKeys do={\r\r\
    \n    :local certFileName \"\$certFile.p12\";\r\r\
    \n    :if ([:len [/file find name=\$certFileName]] > 0) do={\r\r\
    \n    :log info \"GOT PRIV CERTIFICATE '\$certFile'\";\r\r\
    \n    /certificate import file-name=\$certFileName name=\$certFile passphrase=\"1234567890\";\r\r\
    \n    } else={\r\r\
    \n      :log error \"CANT GET PRIV CERTIFICATE FOR '\$certFile'\";\r\r\
    \n    }\r\r\
    \n  }\r\r\
    \n  :local content [/file get [/file find name=\"\$targetfile\"] contents] ;\r\r\
    \n  :local contentLen [ :len \$content ] ;\r\r\
    \n  :if ([:len \$contentLen] = 0) do={\r\r\
    \n     :log error (\"Could not retrieve \$targetfile contents (file size limitation)\")\r\r\
    \n  }\r\r\
    \n  :local certNameStart 0;\r\r\
    \n  :local certName \"\";\r\r\
    \n  :local certNameEnd 0;\r\r\
    \n  :local lastEnd 0;\r\r\
    \n  :local key \"certificate=\";\r\r\
    \n  :do {\r\r\
    \n    :put \"Lookup.. \$key starting at \$lastEnd out of \$contentLen\"\r\r\
    \n    :set certNameStart [:find \$content \$key \$lastEnd ] ;\r\r\
    \n    :if ( [:typeof \$certNameStart] != \"nil\") do={\r\r\
    \n      :set certNameEnd [:find \$content \" \" \$certNameStart] ;\r\r\
    \n      :if ( [:typeof \$certNameEnd ] != \"nil\" ) do={\r\r\
    \n        :set certName [:pick \$content \$certNameStart \$certNameEnd ] ;\r\r\
    \n        :set lastEnd ( \$certNameEnd + 2 ) ; \r\r\
    \n        :log info \"Certificate needed \$certname\"; \r\r\
    \n        :global entry [:pick \$line 0 \$lineEnd ]\r\r\
    \n      } else={\r\r\
    \n       # no more occurenses found\r\r\
    \n       :set lastEnd \$contentLen ; \r\r\
    \n      }\r\r\
    \n    } else={\r\r\
    \n        # no more occurenses found\r\r\
    \n        :set lastEnd \$contentLen ; \r\r\
    \n    }\r\r\
    \n  } while (\$lastEnd < ( \$contentLen -2 ) )\r\r\
    \n} on-error={\r\r\
    \n:log error \"CERT ERROR  -----------------------------------------------------------------------------\"\r\r\
    \n}\r\r\
    \n:do {\r\r\
    \n  # Import the rsc file\r\r\
    \n  :log warning \" IMPORT -----------------------------------------------------------------------------\"\r\r\
    \n  :local importCmd \":import file-name=\$targetfile verbose=yes\"\r\r\
    \n  :log info \"RESTORE START\";\r\r\
    \n  # DO IT ASYNC!! So we have to wait for it\r\r\
    \n  \$AcyncAwait \$importCmd \"import.log.txt\";\r\r\
    \n  # wait for confuguration beeng applied\r\r\
    \n  :log info \"POST IMPORT DELAY FOR CONFIGURATION BEING APPLIED\";\r\r\
    \n  :delay 10s;\r\r\
    \n  :log info \"END IMPORT file=\$targetfile  -----------------------------------------------------------------------------\"\r\r\
    \n} on-error={\r\r\
    \n:log error \"ERROR IMPORT  -----------------------------------------------------------------------------\"\r\r\
    \n}\r\r\
    \n:do {\r\r\
    \n  :log warning \"USERS -----------------------------------------------------------------------------\"\r\r\
    \n  :local mgmtUsername \"owner\"; # main administrator\r\r\
    \n  :log info \"CREATING MAIN ADMIN USER. new username W/O password (SET IT AFTER FIRST LOGON)- '\$mgmtUsername'\";\r\r\
    \n  /user remove [/user find name=\$mgmtUsername];\r\r\
    \n  /user add name=\$mgmtUsername group=full comment=\"management user\" password=\"\";\r\r\
    \n  :local mgmtUsername \"reserved\"; # additional admin user, it has its own script to periodically regenerate password\r\r\
    \n  :local thePass ([/certificate scep-server otp generate minutes-valid=0 as-value]->\"password\");\r\r\
    \n  :log info \"CREATING ADDITIONAL ADMIN USER. new username - '\$mgmtUsername':'\$thePass'\";\r\r\
    \n  /user remove [/user find name=\$mgmtUsername];\r\r\
    \n  /user add name=\$mgmtUsername group=full comment=\"additional admin\" password=\"\$thePass\";\r\r\
    \n  :local mgmtUsername \"automation\"; # user for /system ssh-exec\r\r\
    \n  :local thePass ([/certificate scep-server otp generate minutes-valid=0 as-value]->\"password\");\r\r\
    \n  :log info \"CREATING NEW USER AND CHANGING SCRIPTS AND SCHEDULES OWNAGE. new username - '\$mgmtUsername':'\$thePass'\";\r\r\
    \n  /user remove [/user find name=\$mgmtUsername];\r\r\
    \n  /user add name=\$mgmtUsername group=full comment=\"outgoing SSH user\" password=\"\$thePass\";\r\r\
    \n  :log warning \"USERS - OK\"\r\r\
    \n} on-error={ \r\r\
    \n  :log error \"USERS - ERROR\"\r\r\
    \n}\r\r\
    \n:do {\r\r\
    \n  :log warning \"SSH KEYS -----------------------------------------------------------------------------\"\r\r\
    \n  # SSH KEYS\r\r\
    \n  # HOWTO on linux host\r\r\
    \n  # ssh-keygen -t rsa -b 4096 -C \"defm.ssh@mbpalxm\" -f ~/.ssh/defm.ssh@mbpalxm -m pem\r\r\
    \n  # USERS must exist!!\r\r\
    \n  # public, 1 file in '*.pub', for decryption when connecting TO router. Mapping is MikrotikUser=ImportFileName\r\r\
    \n  :local PublicKeys [:toarray {\"owner\"=\"defm.ssh@mbpalxm\"}];\r\r\
    \n  # privates + publics, 2 files, for encryption when connecting FROM router (via /system ssh-exec), set the password to '1234567890' or rewrite the script\r\r\
    \n  :local PrivateKeys [:toarray {\"owner\"=\"automation.ssh@anna\"}];\r\r\
    \n  :foreach username,filename in=\$PublicKeys do={\r\r\
    \n    :local keyFileName \"\$filename.pub\";\r\r\
    \n    :if ([:len [/file find name=\$keyFileName]] > 0 and [:len [/user find name=\$username]] > 0) do={\r\r\
    \n      :log info \"GOT PUB KEY FOR '\$username' AS '\$keyFileName'\";\r\r\
    \n      /user ssh-keys import user=\"\$username\" public-key-file=\"\$keyFileName\";    \r\r\
    \n    } else={\r\r\
    \n      :log error \"CANT GET PUB KEY FOR '\$username' AS '\$keyFileName'\";\r\r\
    \n    }\r\r\
    \n  }\r\r\
    \n  :foreach username,filename in=\$PrivateKeys do={\r\r\
    \n    :local keyFileName \"\$filename.pub\";\r\r\
    \n    :if ([:len [/file find name=\$keyFileName]] > 0 and [:len [/file find name=\$filename]] > 0 and [:len [/user find name=\$username]] > 0) do={\r\r\
    \n    :log info \"GOT PRIV KEY FOR '\$username' AS '\$keyFileName'\";\r\r\
    \n      /user ssh-keys private import user=\"\$username\" private-key-file=\"\$filename\"\r\r\
    \n    } else={\r\r\
    \n      :log error \"CANT GET PUB KEY FOR '\$username' AS '\$keyFileName'\";\r\r\
    \n    }\r\r\
    \n  }\r\r\
    \n} on-error={\r\r\
    \n:log error \"SSH KEYS ERROR  -----------------------------------------------------------------------------\"\r\r\
    \n}\r\r\
    \n# Play Audible Finish Sequence\r\r\
    \n\$doFinishBeep\r\r\
    \n# remove system Admin\r\r\
    \n/user remove [/user find name=\"admin\"];\r\r\
    \n# Teardown temporary logging to disk\r\r\
    \n/system logging remove [/system logging find where action=perfectrestore]\r\r\
    \n/system logging action remove [/system logging action find where name=perfectrestore]\r\r\
    \n/system script environment remove [find name=\"targetfile\"]\r\r\
    \n/system script environment remove [find name=\"importlog\"]\r\r\
    \n/system script environment remove [find name=\"debuglog\"]\r\r\
    \n# new startup scripts maybe restored so...\r\r\
    \n/system reboot\r\r\
    \n}"
/system script add comment="A server-side script, that is called via global function using ssh-exec from another mikrotik-client to update it's IPSEC policy IP address" dont-require-permissions=yes name=doUpdatePoliciesRemotely owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doUpdatePoliciesRemotely\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n:local state \"\";\
    \n\
    \n# variables should be set before via remote SSH call\
    \n:global globalRemoteIp;\
    \n:global globalPolicyComment;\
    \n\
    \n\
    \n:do {\
    \n    :if ([:len \$globalRemoteIp] > 0) do={\
    \n\
    \n    :local peerID \$globalPolicyComment;\
    \n\
    \n    /ip ipsec policy {\
    \n        :foreach vpnEndpoint in=[find (!disabled and template and comment=\"\$peerID\")] do={\
    \n        \
    \n            :local dstIp;\
    \n            :set dstIp [get value-name=dst-address \$vpnEndpoint];\
    \n\
    \n            :if ((\$itsOk) and (\$globalRemoteIp != \$dstIp )) do={\
    \n\
    \n                [set \$vpnEndpoint disabled=yes];\
    \n\
    \n                :set state \"IPSEC policy template found with wrong IP (\$dstIp). Going change it to (\$globalRemoteIp)\";\
    \n                \$globalNoteMe value=\$state;\
    \n\
    \n                /ip ipsec peer {\
    \n                    :foreach thePeer in=[find name=\$peerID] do={\
    \n\
    \n                        :if (\$itsOk) do={\
    \n\
    \n                            :set state \"Setting up peer remote address..\"\
    \n                            \$globalNoteMe value=\$state;\
    \n\
    \n                            [set \$thePeer disabled=yes];\
    \n\
    \n                            :delay 5;\
    \n\
    \n                            [set \$thePeer disabled=no address=\$globalRemoteIp];\
    \n\
    \n                          \
    \n                        }\
    \n\
    \n                    }\
    \n\
    \n                }\
    \n\
    \n                :delay 5;\
    \n                \
    \n                [set \$vpnEndpoint dst-address=\$globalRemoteIp disabled=no];\
    \n\
    \n            }\
    \n\
    \n        }\
    \n\
    \n    }\
    \n    \
    \n    }\
    \n} on-error= {\
    \n    :local state (\"globalIPSECPolicyUpdateViaSSH error\");\
    \n    \$globalNoteMe value=\$state;\
    \n    :set itsOk false;\
    \n};\
    \n\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: policies refreshed Successfully\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n\
    \n  :global globalTgMessage;\
    \n  \$globalTgMessage value=\$inf;  \
    \n  :error \$inf; \
    \n\
    \n  \
    \n}\
    \n\
    \n\
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
    \n    } while=([/certificate print count-only where fingerprint=\"4348a0e9444c78cb265e058d5e8944b4d84f9662bd26db257f8934a443c70161\"]=0);\r\
    \n} if=([/certificate print count-only where name=\"DigiCertGlobalRootCA.crt.pem\"]=0);"
/system script add comment="keeps scripts and schedules owner constant" dont-require-permissions=yes name=doKeepScriptsOwner owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \"doKeepScriptsOwner\";\
    \n\
    \n:local state \"\";\
    \n:local mgmtUsername \"owner\"; # main administrator \
    \n:global globalCallFetch;\
    \n:global globalNoteMe;\
    \n\
    \n:local impersonate false; # user password needed when true\
    \n:local thePass \"\";\
    \n\
    \n:do {\
    \n\
    \n    # We now need to change script and schedules ownage from *sys user\
    \n    # This can be done via ftp impersonation - here is the trick (the only way to change SCHEDULE owner is to recreate entry UNDER this user)\
    \n    # In RouterOS it is possible to automatically execute scripts - your script file has to be named anything.auto.rsc \
    \n    # once this file is uploaded using FTP to the router, it will automatically be executed, just like with the '/import' command. \
    \n    # This method only works with FTP\
    \n\
    \n    :local scriptCount [:len [/system script find where owner!=\"\$mgmtUsername\"]];\
    \n    :local schedCount  [:len [/system scheduler find where owner!=\"\$mgmtUsername\"]];\
    \n\
    \n    :if (\$scriptCount = 0 and \$schedCount = 0) do={\
    \n        :set state \"No scripts and schedules owner change needed\";\
    \n        \$globalNoteMe value=\$state;\
    \n        :error \$state;\
    \n    };    \
    \n\
    \n    :if ([:len [/user find name=\"\$mgmtUsername\"]] > 0) do={\
    \n \
    \n        :if (\$impersonate) do={\
    \n\
    \n            :local buffer \"\\r\\ \
    \n                            \\n # we can change script owner as usual\\r\\\
    \n                            \\n /system script set owner=\\\"\$mgmtUsername\\\" [find where owner!=\\\"\$mgmtUsername\\\"];\\r\\\
    \n                            \\n\\r\\ \
    \n                            \\n # the only way to change schedule owner is to recreate entry\\r\\\
    \n                            \\n /system scheduler;\\r\\ \
    \n                            \\n :foreach schEndpoint in=[find  where owner!=\\\"\$mgmtUsername\\\"] do={\\r\\\
    \n                            \\n  :local name [get value-name=name \\\$schEndpoint];\\r\\\
    \n                            \\n      :local startTime [get value-name=start-time \\\$schEndpoint];\\r\\\
    \n                            \\n      :local onEvent [get value-name=on-event \\\$schEndpoint];\\r\\\
    \n                            \\n      :local interval [get value-name=interval \\\$schEndpoint];\\r\\\
    \n                            \\n      :local startDate [get value-name=start-date \\\$schEndpoint];\\r\\\
    \n                            \\n      :local comment [get value-name=comment \\\$schEndpoint];\\r\\\
    \n                            \\n      remove \\\$schEndpoint;\\r\\\
    \n                            \\n      add name=\\\"\\\$name\\\" start-time=\\\"\\\$startTime\\\"  on-event=\\\"\\\$onEvent\\\" interval=\\\"\\\$interval\\\" start-date=\\\"\\\$startDate\\\" comment=\\\"\\\$comment\\\";\\r\\\
    \n                            \\n      }\\r\\\
    \n                            \\n;\";\
    \n\
    \n            # delete all previous files\
    \n            :local rsc \"ownage.rsc.txt\";\
    \n            /file remove [/file find where name=\"\$rsc\"];\
    \n            # create the file as it doesn't exist yet\
    \n            /file print file=\"\$rsc\";\
    \n            # wait for filesystem to create file\
    \n            :delay 6;\
    \n            # write the buffer into it\
    \n            :set state \"Creating script file '\$rsc' with commands '\$buffer'\";\
    \n            \$globalNoteMe value=\$state;\
    \n            # i will not remove this file later to got a chance to manually reproduce fetch if it fail via this script\
    \n            /file set [/file find where name=\"\$rsc\"] contents=\"\$buffer\";    \
    \n            :local filecontent [/file get [/file find where name=\"\$rsc\"] contents];\
    \n            :set state \"Created command file '\$rsc' with content '\$filecontent'\";\
    \n            \$globalNoteMe value=\$state;\
    \n            # push it and and autorun under mgmtUsername account\
    \n            :set state \"Pushing autorun command file as user '\$mgmtUsername' via FTP\";\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            :local fetchCmd  \"/tool fetch address=127.0.0.1 mode=ftp src-path=\$rsc dst-path=ownage.auto.rsc user=\\\"\$mgmtUsername\\\" password=\\\"\$thePass\\\" host=\\\"\\\" upload=\\\"yes\\\"\";\
    \n\
    \n            \$globalCallFetch \$fetchCmd;\
    \n\
    \n            /file remove [/file find where name=\"\$rsc\"];\
    \n\
    \n            :set state \"Changing scripts and schedules ownage - OK\";\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n        } else={\
    \n\
    \n            /system script set owner=\"\$mgmtUsername\" [find where owner!=\"\$mgmtUsername\"];\
    \n            # the only way to change schedule owner is to recreate entry\\r\\\
    \n            /system scheduler;\
    \n            :foreach schEndpoint in=[find  where owner!=\"\$mgmtUsername\"] do={\
    \n              :local name [get value-name=name \$schEndpoint];\
    \n                  :local startTime [get value-name=start-time \$schEndpoint];\
    \n                  :local onEvent [get value-name=on-event \$schEndpoint];\
    \n                  :local interval [get value-name=interval \$schEndpoint];\
    \n                  :local startDate [get value-name=start-date \$schEndpoint];\
    \n                  :local comment [get value-name=comment \$schEndpoint];\
    \n                  remove \$schEndpoint;\
    \n                  add name=\"\$name\" start-time=\"\$startTime\"  on-event=\"\$onEvent\" interval=\"\$interval\" start-date=\"\$startDate\" comment=\"\$comment\";\
    \n                  };\
    \n\
    \n            :set state \"Changing scripts and schedules ownage - OK\";\
    \n            \$globalNoteMe value=\$state;\
    \n        }  \
    \n\
    \n\
    \n    } else={\
    \n        :set state \"Cant find user '\$mgmtUsername' for impersonation call\";\
    \n        \$globalNoteMe value=\$state;\
    \n    }\
    \n\
    \n} on-error={ \
    \n    :set state \"Changing scripts and schedules ownage - ERROR\";\
    \n    \$globalNoteMe value=\$state;\
    \n}"
/system script add comment="periodically Wipes memory-configered logging buffers" dont-require-permissions=yes name=doFlushLogs owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \"doFlushLogs\";\
    \n\
    \n:global globalNoteMe;\
    \n:local state \"\"\
    \n\
    \n:set state \"FLUSHING logs..\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n/system/logging/action {\
    \n  :foreach memAction in=[find target=memory] do={\
    \n    :local actName [get value-name=name \$memAction]\
    \n\
    \n    clear action=\$actName;\
    \n\
    \n    }\
    \n  }\
    \n\
    \n\
    \n"
/tool bandwidth-server set enabled=no
/tool e-mail set from=defm.kopcap@gmail.com password=lpnaabjwbvbondrg port=587 server=smtp.gmail.com tls=yes user=defm.kopcap@gmail.com
/tool graphing set page-refresh=50
/tool graphing interface add
/tool graphing resource add
/tool mac-server set allowed-interface-list=none
/tool mac-server mac-winbox set allowed-interface-list=list-winbox-allowed
/tool netwatch add comment="miniAlx status check" disabled=no down-script="\
    \n:put \"info: Netwatch UP\"\
    \n:log info \"Netwatch UP\"\
    \n\
    \n:global NetwatchHostName \"miniAlx\";\
    \n/system script run doNetwatchHost;" host=192.168.90.70 name=miniAlx test-script="" type=simple up-script="\
    \n:put \"info: Netwatch UP\"\
    \n:log info \"Netwatch UP\"\
    \n\
    \n:global NetwatchHostName \"miniAlx\";\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-ip-protocol=icmp filter-src-ip-address=185.85.121.15/32 streaming-server=192.168.90.170
