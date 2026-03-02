# 2026-03-02 16:27:16 by RouterOS 7.22rc2
# software id = IA5H-12KT
#
# model = RB5009UPr+S+
# serial number = HCY086PZ6XZ
/caps-man channel add band=2ghz-b/g/n comment=CH1 control-channel-width=20mhz extension-channel=disabled frequency=2412 name=common-chnls-2Ghz reselect-interval=10h skip-dfs-channels=yes tx-power=17
/caps-man channel add band=5ghz-a/n/ac comment="20Mhz + Ce = 40Mhz, reselect interval from 5180, 5220, 5745, 5785 once per 10h" control-channel-width=20mhz extension-channel=Ce frequency=5180,5220,5745,5785 name=common-chnls-5Ghz reselect-interval=10h tx-power=15
/caps-man configuration add mode=ap name=empty
/interface bridge add name=docker-infrastructure-br port-cost-mode=short protocol-mode=none
/interface bridge add dhcp-snooping=yes igmp-snooping=yes name=guest-infrastructure-br port-cost-mode=short
/interface bridge add arp=proxy-arp fast-forward=no name=ip-mapping-br port-cost-mode=short
/interface bridge add admin-mac=48:8F:5A:D4:5F:69 arp=reply-only auto-mac=no dhcp-snooping=yes igmp-snooping=yes name=main-infrastructure-br port-cost-mode=short
/interface bridge add arp=proxy-arp fast-forward=no name=ospf-loopback-br
/interface ethernet
# poe-out status: short_circuit
set [ find default-name=ether2 ] arp=disabled l2mtu=1514 loop-protect=on name="lan A" poe-out=forced-on
/interface ethernet set [ find default-name=ether3 ] arp=disabled l2mtu=1514 loop-protect=on name="lan B"
/interface ethernet set [ find default-name=ether4 ] advertise=10M-baseT-half,10M-baseT-full,100M-baseT-half,100M-baseT-full,1G-baseT-half,1G-baseT-full,2.5G-baseT,2.5G-baseX arp=disabled l2mtu=1514 loop-protect=on name="lan C"
/interface ethernet set [ find default-name=ether5 ] arp=disabled l2mtu=1514 name="lan D"
/interface ethernet set [ find default-name=ether6 ] arp=disabled l2mtu=1514 loop-protect=on name="lan E"
/interface ethernet set [ find default-name=ether7 ] arp=disabled l2mtu=1514 loop-protect=on name="lan F"
/interface ethernet set [ find default-name=ether8 ] l2mtu=1514 loop-protect=on name="lan G"
/interface ethernet set [ find default-name=sfp-sfpplus1 ] disabled=yes l2mtu=1514 name=optic
/interface ethernet set [ find default-name=ether1 ] arp=proxy-arp l2mtu=1514 mac-address=20:CF:30:DE:7B:2A name="wan A" poe-out=off
/interface veth add address=192.168.80.2/24 container-mac-address=48:01:92:49:E4:C5 dhcp=no gateway=192.168.80.1 gateway6="" mac-address=48:01:92:49:E4:C4 name=byedpi-tunnel
/interface veth add address=192.168.80.161/24 container-mac-address=22:46:AB:91:A7:32 dhcp=no gateway=192.168.80.1 gateway6="" mac-address=22:46:AB:91:A7:31 name=veth-netquality
/interface veth add address=192.168.80.160/24 container-mac-address=44:D9:9B:83:FB:91 dhcp=no gateway=192.168.80.1 gateway6="" mac-address=44:D9:9B:83:FB:90 name=veth-victoria-logs
/caps-man datapath add arp=proxy-arp bridge=guest-infrastructure-br client-to-client-forwarding=no name=2CapsMan-guest
/caps-man datapath add arp=reply-only bridge=main-infrastructure-br client-to-client-forwarding=yes name=2CapsMan-private
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps name="5GHz Rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps vht-basic-mcs=mcs0-9 vht-supported-mcs=mcs0-9
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps ht-basic-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 ht-supported-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 name="2GHz rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps
/caps-man security add authentication-types=wpa2-psk comment="2GHz/5GHz Security" encryption=aes-ccm group-encryption=aes-ccm group-key-update=1h name=private passphrase=mikrotik
/caps-man security add authentication-types="" comment="2GHz/5GHz FREE" encryption="" group-key-update=5m name=guest
/disk add comment=Ramdisk slot=RAM tmpfs-max-size=40000000 type=tmpfs
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
/interface list add comment="mangle rule: redirect to byedpi" name=list-mangle-redirect-byedpi
/interface list add comment="mangle rule: redirect to vpn" name=list-mangle-redirect-vpn
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
/ip dhcp-server add authoritative=after-2sec-delay interface=main-infrastructure-br lease-time=1d name=main-dhcp-server use-reconfigure=yes
/ip dhcp-server option add code=15 force=yes name=DomainName_Windows value="s'home'"
/ip dhcp-server option add code=119 force=yes name=DomainName_LinuxMac value="s'home'"
/ip dhcp-server option add code=6 name=DNSServer_Statis_DHCP value="'192.168.90.1'"
/ip dns forwarders add doh-servers=https://dns.google/dns-query name=DOH-Google
/ip dns forwarders add doh-servers=https://cloudflare-dns.com/dns-query name=DOH-CloudFlare
/ip dns forwarders add doh-servers=https://dns.quad9.net/dns-query name=DOH-Quad9
/ip dns forwarders add dns-servers=8.8.8.8 name=DNS-Google8 verify-doh-cert=no
/ip dns forwarders add doh-servers=https://router.comss.one/dns-query name=DOH-Comss
/ip firewall layer7-protocol add name="resolve local" regexp=".home|[0-9]+.[0-9]+.168.192.in-addr.arpa"
/ip firewall layer7-protocol add name=ECH regexp="A\\x01\$"
/ip ipsec mode-config set [ find default=yes ] connection-mark=cmark-tunnel-connection src-address-list=alist-mangle-vpn-tunneled-sites
/ip ipsec policy group add name=inside-ipsec-encryption
/ip ipsec policy group add name=outside-ipsec-encryption
/ip ipsec profile set [ find default=yes ] dh-group=modp1024 dpd-interval=2m dpd-maximum-failures=5
/ip ipsec profile add dh-group=modp1024 dpd-interval=2m dpd-maximum-failures=5 enc-algorithm=aes-256 hash-algorithm=sha256 name=ROUTEROS
/ip ipsec peer add address=185.13.148.14/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, outer-tunnel encryption, RSA)" disabled=yes exchange-mode=ike2 local-address=10.20.225.166 name=CHR-external profile=ROUTEROS
/ip ipsec peer add address=10.0.0.1/32 comment="IPSEC IKEv2 VPN PHASE1 (MIS, traffic-only encryption)" disabled=yes local-address=10.0.0.3 name=CHR-internal profile=ROUTEROS
/ip ipsec proposal set [ find default=yes ] auth-algorithms=sha256 enc-algorithms=aes-256-cbc,aes-192-cbc,aes-128-cbc,3des lifetime=1h
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip kid-control add fri=0s-1d mon=0s-1d name=totals sat=0s-1d sun=0s-1d thu=0s-1d tue=0s-1d wed=0s-1d
/ip pool add name=pool-main ranges=192.168.90.100-192.168.90.200
/ip pool add name=pool-guest ranges=192.168.98.200-192.168.98.230
/ip pool add name=pool-virtual-machines ranges=192.168.90.0/26
/ip pool add name=pool-vendor ranges=192.168.90.2-192.168.90.10
/ip pool add name=pool-containers ranges=192.168.80.160/28
/ip dhcp-server add add-arp=yes address-pool=pool-guest authoritative=after-2sec-delay interface=guest-infrastructure-br lease-script="\
    \n# Globals\
    \n#\
    \n:global GleaseBound;\
    \n:global GleaseServerName;\
    \n:global GleaseActMAC;\
    \n:global GleaseActIP;\
    \n\
    \n:set GleaseBound \$leaseBound;\
    \n:set GleaseServerName \$leaseServerName;\
    \n:set GleaseActMAC \$leaseActMAC;\
    \n:set GleaseActIP \$leaseActIP;\
    \n\
    \n/system script run doDHCPLeaseTrack;" lease-time=3h name=guest-dhcp-server use-reconfigure=yes
/ip dhcp-server add add-arp=yes address-pool=pool-containers authoritative=after-2sec-delay interface=docker-infrastructure-br lease-time=1d name=docker-dhcp-server use-reconfigure=yes
/ip smb users set [ find default=yes ] disabled=yes
/ip socksify add disabled=no name=byedpi socks5-server=192.168.80.2
/ppp profile add address-list=alist-l2tp-active-clients change-tcp-mss=no comment=to-CHR interface-list=list-l2tp-tunnels local-address=10.0.0.3 name=l2tp-no-encrypt-site2site only-one=no remote-address=10.0.0.1 use-ipv6=no
/ppp profile add bridge-learning=no change-tcp-mss=no comment="used by \$SECRET" local-address=0.0.0.0 name=null only-one=yes remote-address=0.0.0.0 session-timeout=1s use-compression=no use-encryption=no use-mpls=no use-upnp=no
/interface l2tp-client add allow=mschap2 connect-to=185.13.148.14 disabled=no max-mru=1360 max-mtu=1360 name=chr-tunnel password=123 profile=l2tp-no-encrypt-site2site user=vpn-remote-anna
/queue simple add comment=dtq,50:DE:06:25:C2:FC,iPad name="iPadAlxPro@main-dhcp-server (50:DE:06:25:C2:FC)" queue=default/default target=192.168.90.130/32 total-queue=default
/queue simple add comment=dtq,B0:34:95:50:A1:6A, name="AudioATV(blocked)@guest-dhcp-server (B0:34:95:50:A1:6A)" queue=default/default target=192.168.98.231/32 total-queue=default
/queue simple add comment=dtq,90:DD:5D:C8:46:AB, name="AlxATV (wireless)@main-dhcp-server (90:DD:5D:C8:46:AB)" queue=default/default target=192.168.90.200/32 total-queue=default
/queue simple add comment=dtq,B0:34:95:50:A1:6A, name="AudioATV (wireless)@main-dhcp-server (B0:34:95:50:A1:6A)" queue=default/default target=192.168.90.210/32 total-queue=default
/queue simple add comment=dtq,10:DD:B1:9E:19:5E,miniAlx name="miniAlx (wire)@main-dhcp-server (10:DD:B1:9E:19:5E)" queue=default/default target=192.168.90.70/32 total-queue=default
/queue simple add comment=dtq,00:11:32:2C:A7:85, name="NAS@main-dhcp-server (00:11:32:2C:A7:85)" queue=default/default target=192.168.90.40/32 total-queue=default
/queue simple add comment=dtq,FC:F5:C4:79:ED:D8, name="Twinkle@main-dhcp-server (FC:F5:C4:79:ED:D8)" queue=default/default target=192.168.90.170/32 total-queue=default
/queue simple add comment=dtq,FC:F5:C4:79:ED:D8, name="Twinkle(blocked)@guest-dhcp-server (FC:F5:C4:79:ED:D8)" queue=default/default target=192.168.98.170/32 total-queue=default
/queue simple add comment=dtq,54:35:30:05:9B:BD, name="ASUS(wireless)@main-dhcp-server (54:35:30:05:9B:BD)" queue=default/default target=192.168.90.88/32 total-queue=default
/queue simple add comment=dtq,54:35:30:05:9B:BD, name="ASUS(wireless)(blocked)@guest-dhcp-server (54:35:30:05:9B:BD)" queue=default/default target=192.168.98.88/32 total-queue=default
/queue simple add comment=dtq,BC:D0:74:0A:B2:6A, name="MbpAlxm (wireless)@main-dhcp-server (BC:D0:74:0A:B2:6A)" queue=default/default target=192.168.90.75/32 total-queue=default
/queue simple add comment=dtq,BC:D0:74:0A:B2:6A, name="MbpAlxm(wireless)(blocked)@guest-dhcp-server (BC:D0:74:0A:B2:6A)" queue=default/default target=192.168.98.75/32 total-queue=default
/queue simple add comment=dtq,F8:3F:51:0D:88:0B,localhost name="SamsungTV(wire)@main-dhcp-server (F8:3F:51:0D:88:0B)" queue=default/default target=192.168.90.205/32 total-queue=default
/queue simple add comment=dtq,F8:3F:51:0D:88:0B, name="SamsungTV(wire)(blocked)@guest-dhcp-server (F8:3F:51:0D:88:0B)" queue=default/default target=192.168.98.205/32 total-queue=default
/queue simple add comment=dtq,88:88:88:88:87:88,DESKTOP-QMUE5PH name="Hare's AsusPC(wire)@main-dhcp-server (88:88:88:88:87:88)" queue=default/default target=192.168.90.100/32 total-queue=default
/queue simple add comment=dtq,88:88:88:88:87:88, name="AsusPC(wire)(blocked)@guest-dhcp-server (88:88:88:88:87:88)" queue=default/default target=192.168.98.100/32 total-queue=default
/queue simple add comment=dtq,90:DD:5D:CA:8F:B0,AlxATV name="AlxATV(wire)@main-dhcp-server (90:DD:5D:CA:8F:B0)" queue=default/default target=192.168.90.201/32 total-queue=default
/queue simple add comment=dtq,90:DD:5D:CA:8F:B0, name="AlxATV(wire)(blocked)@guest-dhcp-server (90:DD:5D:CA:8F:B0)" queue=default/default target=192.168.98.201/32 total-queue=default
/queue simple add comment=dtq,04:F1:69:8E:12:B6, name="Hare's Honor9x(wireless)@main-dhcp-server (04:F1:69:8E:12:B6)" queue=default/default target=192.168.90.140/32 total-queue=default
/queue simple add comment=dtq,04:F1:69:8E:12:B6, name="Hare's Honor9x(wireless)(blocked)@guest-dhcp-server (04:F1:69:8E:12:B6)" queue=default/default target=192.168.98.140/32 total-queue=default
/queue simple add comment=dtq,B8:87:6E:19:90:33,yandex-mini2-ZGNK name="Alice(wireless)@main-dhcp-server (B8:87:6E:19:90:33)" queue=default/default target=192.168.90.220/32 total-queue=default
/queue simple add comment=dtq,B8:87:6E:19:90:33, name="Alice(wireless)(blocked)@guest-dhcp-server (B8:87:6E:19:90:33)" queue=default/default target=192.168.98.220/32 total-queue=default
/queue simple add comment=dtq,D4:A6:51:C9:54:A7, name="Tuya(wireless)@main-dhcp-server (D4:A6:51:C9:54:A7)" queue=default/default target=192.168.90.180/32 total-queue=default
/queue simple add comment=dtq,D4:A6:51:C9:54:A7, name="Tuya(wireless)(blocked)@guest-dhcp-server (D4:A6:51:C9:54:A7)" queue=default/default target=192.168.98.180/32 total-queue=default
/queue simple add comment=dtq,D4:3B:04:87:C7:47, name="HareDell@main-dhcp-server (D4:3B:04:87:C7:47)" queue=default/default target=192.168.90.77/32 total-queue=default
/queue simple add comment=dtq,D4:3B:04:87:C7:47, name="HareDell(blocked)@guest-dhcp-server (D4:3B:04:87:C7:47)" queue=default/default target=192.168.98.77/32 total-queue=default
/queue simple add comment=dtq,50:DE:06:25:C2:FC, name="iPadAlxPro(blocked)@guest-dhcp-server (50:DE:06:25:C2:FC)" queue=default/default target=192.168.98.130/32 total-queue=default
/queue simple add comment=dtq,40:80:E1:5B:41:B8,nspanel name="NSPanel(wireless)@main-dhcp-server (40:80:E1:5B:41:B8)" queue=default/default target=192.168.90.165/32 total-queue=default
/queue simple add comment=dtq,40:80:E1:5B:41:B8, name="NSPanel(wireless)(blocked)@guest-dhcp-server (40:80:E1:5B:41:B8)" queue=default/default target=192.168.98.165/32 total-queue=default
/queue simple add comment=dtq,DC:10:57:2D:39:7B,iPhoneAlxr name="iPhoneAlxr(wireless)@main-dhcp-server (DC:10:57:2D:39:7B)" queue=default/default target=192.168.90.150/32 total-queue=default
/queue simple add comment=dtq,00:1C:42:FE:E3:AB, name="W11Parallels@main-dhcp-server (00:1C:42:FE:E3:AB)" queue=default/default target=192.168.90.35/32 total-queue=default
/queue simple add comment=dtq,00:1C:42:FE:E3:AB, name="W11Parallels(blocked)@guest-dhcp-server (00:1C:42:FE:E3:AB)" queue=default/default target=192.168.98.35/32 total-queue=default
/queue simple add comment=dtq,00:85:01:01:50:0E,wb name="WB (wire)@main-dhcp-server (00:85:01:01:50:0E)" queue=default/default target=192.168.90.2/32 total-queue=default
/queue simple add comment=dtq,00:85:01:01:50:0E, name="WB (wire)(blocked)@guest-dhcp-server (00:85:01:01:50:0E)" queue=default/default target=192.168.98.2/32 total-queue=default
/queue simple add comment=dtq,CA:FE:0F:0B:19:3A, name="WB (wireless)@main-dhcp-server (CA:FE:0F:0B:19:3A)" queue=default/default target=192.168.90.3/32 total-queue=default
/queue simple add comment=dtq,CA:FE:0F:0B:19:3A, name="WB (wireless)(blocked)@guest-dhcp-server (CA:FE:0F:0B:19:3A)" queue=default/default target=192.168.98.3/32 total-queue=default
/queue simple add comment=dtq,18:FD:74:94:FD:70,capxl name="capxl(wire)@main-dhcp-server (18:FD:74:94:FD:70)" queue=default/default target=192.168.90.10/32 total-queue=default
/queue simple add comment=dtq,88:53:95:30:68:9F, name="miniAlx(wireless)@main-dhcp-server (88:53:95:30:68:9F)" queue=default/default target=192.168.90.80/32 total-queue=default
/queue simple add comment=dtq,88:53:95:30:68:9F, name="miniAlx(wireless)(blocked)@guest-dhcp-server (88:53:95:30:68:9F)" queue=default/default target=192.168.98.80/32 total-queue=default
/queue simple add comment=dtq,BC:74:4B:E8:9B:61, name="nSwitch(wereless)@main-dhcp-server (BC:74:4B:E8:9B:61)" queue=default/default target=192.168.90.199/32 total-queue=default
/queue simple add comment=dtq,BC:74:4B:E8:9B:61, name="nSwitch(wereless)(blocked)@guest-dhcp-server (BC:74:4B:E8:9B:61)" queue=default/default target=192.168.98.199/32 total-queue=default
/queue simple add comment=dtq,F4:2B:8C:AF:34:20,nadezda-phone name="SamsungS23(wereless)@main-dhcp-server (F4:2B:8C:AF:34:20)" queue=default/default target=192.168.90.135/32 total-queue=default
/queue simple add comment=dtq,F4:2B:8C:AF:34:20, name="SamsungS23(wereless)(blocked)@guest-dhcp-server (F4:2B:8C:AF:34:20)" queue=default/default target=192.168.98.135/32 total-queue=default
/queue simple add comment=dtq,00:0E:2D:1A:73:36, name="AST(wire)@main-dhcp-server (00:0E:2D:1A:73:36)" queue=default/default target=192.168.90.203/32 total-queue=default
/queue simple add comment=dtq,00:0E:2D:1A:73:36, name="AST(wire)(blocked)@guest-dhcp-server (00:0E:2D:1A:73:36)" queue=default/default target=192.168.98.203/32 total-queue=default
/queue simple add comment=dtq,2C:0B:97:C1:A8:C8, name="Elvira(wireless)@main-dhcp-server (2C:0B:97:C1:A8:C8)" queue=default/default target=192.168.90.133/32 total-queue=default
/queue simple add comment=dtq,2C:0B:97:C1:A8:C8, name="Elvira(wireless)(blocked)@guest-dhcp-server (2C:0B:97:C1:A8:C8)" queue=default/default target=192.168.98.133/32 total-queue=default
/queue simple add comment=dtq,BC:B2:CC:5F:9D:C4, name="Serg(wireless)@main-dhcp-server (BC:B2:CC:5F:9D:C4)" queue=default/default target=192.168.90.134/32 total-queue=default
/queue simple add comment=dtq,BC:B2:CC:5F:9D:C4, name="Serg(wireless)(blocked)@guest-dhcp-server (BC:B2:CC:5F:9D:C4)" queue=default/default target=192.168.98.134/32 total-queue=default
/queue simple add comment=dtq,34:5A:60:89:1C:E1, name="MSI(wire)@main-dhcp-server (34:5A:60:89:1C:E1)" queue=default/default target=192.168.90.66/32 total-queue=default
/queue simple add comment=dtq,34:5A:60:89:1C:E1, name="MSI(wire)(blocked)@guest-dhcp-server (34:5A:60:89:1C:E1)" queue=default/default target=192.168.98.66/32 total-queue=default
/queue simple add comment=dtq,22:26:E9:CA:87:BA, name="Tomm(wireless)@main-dhcp-server (22:26:E9:CA:87:BA)" queue=default/default target=192.168.90.143/32 total-queue=default
/queue simple add comment=dtq,22:26:E9:CA:87:BA, name="Tomm(wireless)(blocked)@guest-dhcp-server (22:26:E9:CA:87:BA)" queue=default/default target=192.168.98.143/32 total-queue=default
/queue simple add comment=dtq,C8:90:8A:9A:50:A1, name="Froloff(wireless)@main-dhcp-server (C8:90:8A:9A:50:A1)" queue=default/default target=192.168.90.142/32 total-queue=default
/queue simple add comment=dtq,C8:90:8A:9A:50:A1, name="Froloff(wireless)(blocked)@guest-dhcp-server (C8:90:8A:9A:50:A1)" queue=default/default target=192.168.98.142/32 total-queue=default
/queue simple add comment=dtq,44:D9:9B:83:FB:91, name="victoria(docker)@docker-dhcp-server (44:D9:9B:83:FB:91)" queue=default/default target=192.168.80.160/32 total-queue=default
/queue simple add comment=dtq,6C:1F:F7:60:69:71,MbpAlxm name="MbpAlxm (wire)@main-dhcp-server (6C:1F:F7:60:69:71)" queue=default/default target=192.168.90.85/32 total-queue=default
/queue simple add comment=dtq,6C:1F:F7:60:69:71, name="MbpAlxm(wire)(blocked)@guest-dhcp-server (6C:1F:F7:60:69:71)" queue=default/default target=192.168.98.85/32 total-queue=default
/queue simple add comment=dtq,22:46:AB:91:A7:32, name="netq(docker)@docker-dhcp-server (22:46:AB:91:A7:32)" queue=default/default target=192.168.80.161/32 total-queue=default
/queue simple add comment=dtq,DC:10:57:2D:39:7B, name="iPhoneAlxr(wireless)(blocked)@guest-dhcp-server (DC:10:57:2D:39:7B)" queue=default/default target=192.168.98.150/32 total-queue=default
/queue simple add comment=dtq,B8:2D:28:0A:39:0E, name="clicbot(wireless)@main-dhcp-server (B8:2D:28:0A:39:0E)" queue=default/default target=192.168.90.222/32 total-queue=default
/queue simple add comment=dtq,B8:2D:28:0A:39:0E, name="clicbot(wireless)(blocked)@guest-dhcp-server (B8:2D:28:0A:39:0E)" queue=default/default target=192.168.98.222/32 total-queue=default
/queue tree add comment="FILE download control" name="Total Bandwidth" parent=global queue=default
/queue tree add name=RAR packet-mark=rar-mark parent="Total Bandwidth" queue=default
/queue tree add name=EXE packet-mark=exe-mark parent="Total Bandwidth" queue=default
/queue tree add name=7Z packet-mark=7z-mark parent="Total Bandwidth" queue=default
/queue tree add name=ZIP packet-mark=zip-mark parent="Total Bandwidth" queue=default
/routing bgp instance add as=64555 ignore-as-path-len=yes name=bgp-instance-1 router-id=46.39.51.221
/routing bgp template set default as=65001 disabled=yes
/routing id add comment="OSPF Common for specific routing table" disabled=no id=10.255.255.3 name=anna-10.255.255.3 select-dynamic-id=""
/routing id add comment="OSPF Common for main routing table" disabled=no id=10.255.0.3 name=anna-main-10.255.0.3 select-dynamic-id=""
/routing ospf instance add comment="OSPF Common - inject into \"specific\" table" disabled=no in-filter-chain=ospf-in name=routes-inject-into-vpn originate-default=never out-filter-chain=ospf-out-filter-reject-all redistribute="" router-id=anna-10.255.255.3 routing-table=main
/routing ospf instance add comment="OSPF Common - inject into \"main\" table" disabled=yes in-filter-chain=ospf-in name=routes-inject-into-main originate-default=never out-filter-chain=ospf-out-filter-reject-all router-id=anna-main-10.255.0.3 routing-table=main
/routing ospf area add disabled=no instance=routes-inject-into-vpn name=backbone-vpn
/routing ospf area add area-id=0.0.0.3 default-cost=10 disabled=no instance=routes-inject-into-vpn name=anna-space-vpn no-summaries type=stub
/routing ospf area add area-id=0.0.0.3 default-cost=10 disabled=no instance=routes-inject-into-main name=anna-space-main no-summaries type=stub
/routing ospf area add disabled=no instance=routes-inject-into-main name=backbone-main
/routing table add comment="tunnel swing" fib name=rmark-vpn-redirect
/routing table add comment="dpi swing" disabled=no fib name=rmark-docker-redirect
/routing bgp instance add as=65001 disabled=no ignore-as-path-len=no name=inject-into-vpn router-id=46.39.51.221 routing-table=rmark-vpn-redirect
/routing bgp template add afi=ip as=65000 disabled=yes hold-time=4m input.filter=bgp_in keepalive-time=1m multihop=yes name=antifilter-template output.filter-chain=bgp-out-filter-reject-all .network=alist-antifilter-bgp .no-client-to-client-reflection=yes routing-table=rmark-vpn-redirect
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action set 1 disk-file-name=journal
/system logging action set 3 add-topics-string=yes remote=victoria.home remote-log-format=syslog
/system logging action add name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=5 disk-file-name=ScriptsDiskLog disk-lines-per-file=300 name=ScriptsDiskLog target=disk
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
/system logging action add cef-event-delimiter="" name=VictoriaRemoteLog remote=victoria.home remote-log-format=cef target=remote
/system logging action add name=TransfersOnscreenLog target=memory
/system logging action add disk-file-count=1 disk-file-name=PKGInstallationLog disk-lines-per-file=100 name=PKGInstallationLog target=disk
/system logging action add disk-file-count=1 disk-file-name=REBOOTLog disk-lines-per-file=100 name=REBOOTDiskLog target=disk
/system logging action add name=DockerOnscreenLog target=memory
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
    \n\r\
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
    \n\
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
    \n:global globalOnPrimaryPartition;\
    \n:if ( ![\$globalOnPrimaryPartition] ) do {\
    \n    \
    \n    :set state \"WARNING: the system booted up from fallback partition!\"\
    \n    :log error \$state\
    \n    \$globalNoteMe value=\$state;\
    \n\
    \n    :set logcontenttemp \"\$state\"\
    \n    :set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" \\n\") \
    \n\
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
    \n\
    \n"
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
/system script add comment="This one checks some latencies (2 hosts, one is 8.8.8.8) and warns if its over \$ms value" dont-require-permissions=yes name=doCheckPingRate owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \"doCheckPingRate\";\
    \n\
    \n:global globalNoteMe;\
    \n:local state;\
    \n\
    \n#Mikrotik Ping more than 25ms to send mail\
    \n\
    \n:local host  [:resolve \"ya.ru\"];\
    \n:local ms 20;\
    \n\
    \n:set state (\"Checking ping rate \$host\");\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:local avgRttA value=0;\
    \n:local avgRttB value=0;\
    \n:local numPing value=6;\
    \n:local toPingIP1 value=8.8.8.8;\
    \n:local toPingIP2 value=\$host;\
    \n\
    \n:for tmpA from=1 to=\$numPing step=1 do={\
    \n /tool flood-ping count=1 size=38 address=\$toPingIP1 do={\
    \n  :set avgRttA (\$\"avg-rtt\" + \$avgRttA);\
    \n }\
    \n /tool flood-ping count=1 size=38 address=\$toPingIP2 do={\
    \n  :set avgRttB (\$\"avg-rtt\" + \$avgRttB);\
    \n }\
    \n /delay delay-time=1;\
    \n}\
    \n\
    \n:set state (\"Ping Average for 8.8.8.8: \".[:tostr (\$avgRttA / \$numPing )].\"ms\");\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:set state (\"Ping Average for \$host: \".[:tostr (\$avgRttB / \$numPing )].\"ms\");\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:local rate (\$avgRttB / \$numPing );\
    \n\
    \n:if (\$rate >= \$ms) do={\
    \n\
    \n    :set state \"Yandex latency is too high (\$rate ms, over \$ms ms)\";\
    \n    \$globalNoteMe value=\$state;\
    \n    :log warning \$state;\
    \n\
    \n    :global globalTgMessage;\
    \n    \$globalTgMessage value=\$state;\
    \n\
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
    \n\r\
    \n"
/system script add comment="Runs at morning to get flashes back (swith on all LEDs)" dont-require-permissions=yes name=doLEDon owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doLEDon\";\r\
    \n\r\
    \n/system leds settings set all-leds-off=never;\r\
    \n\r\
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
    \n\r\
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
    \n    :local port 2223;\
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
    \n\r\
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
/system script add comment="Punches IPSEC policies when they're not in 'established' state" dont-require-permissions=yes name=doIPSECPunch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# ============================================================\
    \n# IPSec/L2TP Connection Monitor & Auto-Recovery Script\
    \n# Version: 2.1\
    \n# ============================================================\
    \n\
    \n# === INITIALIZATION ===\
    \n:global globalScriptBeforeRun\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n\
    \n# Prevent concurrent execution\
    \n\$globalScriptBeforeRun \"doIPSECTest\"\
    \n\
    \n# === CONFIGURATION ===\
    \n:local Config {\
    \n    \"pingCount\"=10;\
    \n    \"pingSuccessRate\"=80;\
    \n    \"pingInterval\"=1000ms;\
    \n    \"pingRetryDelay\"=20s;\
    \n    \"maxRetryAttempts\"=3;\
    \n    \"flushHour\"=23;\
    \n    \"enableAutoRecovery\"=true\
    \n}\
    \n\
    \n:local PingTrigger ((\$Config->\"pingCount\") * (\$Config->\"pingSuccessRate\") / 100)\
    \n\
    \n\
    \n# Log with timestamp\
    \n:local Log do={\
    \n    :global globalNoteMe\
    \n    :local message [:tostr \$1]\
    \n    :local level [:tostr \$2]\
    \n    :if ([:len \$level] = 0) do={ :set level \"info\" }\
    \n    :local timestamp [/system clock get time]\
    \n    :local fullMessage (\"[\" . \$timestamp . \"][\" . \$level . \"] \" . \$message)\
    \n    \$globalNoteMe value=\$fullMessage\
    \n  \
    \n}\
    \n\
    \n# Calculate IP details from CIDR\
    \n:local IPCalc do={\
    \n    :local cidr [:tostr \$1]\
    \n    :local address [:toip [:pick \$cidr 0 [:find \$cidr \"/\"]]]\
    \n    :local bits [:tonum [:pick \$cidr ([:find \$cidr \"/\"] + 1) [:len \$cidr]]]\
    \n    :local mask ((255.255.255.255 << (32 - \$bits)) & 255.255.255.255)\
    \n    :return {\
    \n        \"network\"=(\$address & \$mask);\
    \n        \"hostmin\"=((\$address & \$mask) | 0.0.0.1);\
    \n        \"broadcast\"=(\$address | ~\$mask)\
    \n    }\
    \n}\
    \n\
    \n# Extract first IP from CIDR or return as-is\
    \n:local ExtractIP do={\
    \n    :local input [:tostr \$1]\
    \n    :if ([:find \$input \"/\"] >= 0) do={\
    \n        :return [:pick \$input 0 [:find \$input \"/\"]]\
    \n    }\
    \n    :return \$input\
    \n}\
    \n\
    \n# Find L2TP session info\
    \n:local FindL2TPSession do={\
    \n    :local dstIP [:tostr \$1]\
    \n    :local result {\"found\"=false; \"type\"=\"none\"}\
    \n\
    \n    # Incoming L2TP (server)\
    \n    :local incoming [/ppp/active find caller-id=\$dstIP]\
    \n    :if ([:len \$incoming] != 0) do={\
    \n        :set (\$result->\"running\") true\
    \n        :set (\$result->\"found\") true\
    \n        :set (\$result->\"type\") \"incoming\"\
    \n        :set (\$result->\"session\") \$incoming\
    \n        :set (\$result->\"peer\") [/ppp/active get \$incoming name]\
    \n        :set (\$result->\"remoteIP\") [/ppp/active get \$incoming address]\
    \n        :local network [/ip/address get [find network=(\$result->\"remoteIP\")] address]\
    \n        :set (\$result->\"localIP\") [:pick \$network 0 [:find \$network \"/\"]]\
    \n        :return \$result\
    \n    }\
    \n\
    \n    # Outgoing L2TP (client)\
    \n    :local outgoing [/interface/l2tp-client find where !disabled connect-to=\$dstIP]\
    \n    :if ([:len \$outgoing] != 0) do={\
    \n\
    \n        :local online [/interface/l2tp-client get \$outgoing running]\
    \n        :set (\$result->\"running\") \$online\
    \n        :set (\$result->\"found\") true\
    \n        :set (\$result->\"type\") \"outgoing\"\
    \n        :set (\$result->\"session\") \$outgoing\
    \n        :set (\$result->\"peer\") [/interface/l2tp-client get \$outgoing name]\
    \n\
    \n        :if ( \$online ) do={\
    \n            :local monitor [/interface l2tp-client monitor \$outgoing once as-value]\
    \n            :set (\$result->\"remoteIP\") (\$monitor->\"remote-address\")\
    \n            :local network [/ip/address get [find network=(\$result->\"remoteIP\")] address]\
    \n            :set (\$result->\"localIP\") [:pick \$network 0 [:find \$network \"/\"]]\
    \n\
    \n        }  else={\
    \n\
    \n            :set (\$result->\"remoteIP\") 0.0.0.1\
    \n            :set (\$result->\"localIP\") 0.0.0.1\
    \n            \
    \n        }\
    \n\
    \n        :return \$result\
    \n    }\
    \n\
    \n    :return \$result\
    \n}\
    \n\
    \n# Test connectivity with retry\
    \n:local TestConnectivity do={\
    \n    :local targetIP [:toip \$1]\
    \n    :local sourceIP [:toip \$2]\
    \n    :local count [:tonum \$3]\
    \n    :local threshold [:tonum \$4]\
    \n    :local retryDelay \$5\
    \n\
    \n    :local result1 [/ping address=\$targetIP src-address=\$sourceIP count=\$count interval=1000ms]\
    \n    :if (\$result1 >= \$threshold) do={\
    \n        :return {\"success\"=true; \"attempts\"=1; \"received\"=\$result1; \"required\"=\$threshold}\
    \n    }\
    \n\
    \n    :delay \$retryDelay\
    \n    :local result2 [/ping address=\$targetIP src-address=\$sourceIP count=\$count interval=1000ms]\
    \n    :if (\$result2 >= \$threshold) do={\
    \n        :return {\"success\"=true; \"attempts\"=2; \"received\"=\$result2; \"required\"=\$threshold}\
    \n    }\
    \n\
    \n    :return {\"success\"=false; \"attempts\"=2; \"received\"=\$result2; \"required\"=\$threshold}\
    \n}\
    \n\
    \n# Check route availability\
    \n:local CheckRoute do={\
    \n    :local dstIP [:toip \$1]\
    \n    :local srcIP [:toip \$2]\
    \n    :local check [/ip/route/check dst-ip=\$dstIP src-ip=\$srcIP once as-value]\
    \n    :local status (\$check->\"status\")\
    \n    :if (\$status = \"ok\") do={\
    \n        :return {\
    \n            \"reachable\"=true;\
    \n            \"interface\"=(\$check->\"interface\");\
    \n            \"gateway\"=(\$check->\"gateway\");\
    \n            \"nexthop\"=(\$check->\"nexthop\")\
    \n        }\
    \n    }\
    \n    :return {\"reachable\"=false; \"status\"=\$status}\
    \n}\
    \n\
    \n# Kill L2TP session\
    \n:local KillL2TPSession do={\
    \n    :local sessionInfo \$1\
    \n    :local Log \$2\
    \n    :if (!(\$sessionInfo->\"found\")) do={ :return false }\
    \n\
    \n    :do {\
    \n        :if ((\$sessionInfo->\"type\") = \"incoming\") do={\
    \n            /ppp/active remove (\$sessionInfo->\"session\")\
    \n            :local msg (\"Killed incoming L2TP session: \" . (\$sessionInfo->\"peer\"))\
    \n            \$Log \$msg\
    \n        } else={\
    \n            /interface/l2tp-client disable (\$sessionInfo->\"session\")\
    \n            :delay 4s\
    \n            /interface/l2tp-client enable (\$sessionInfo->\"session\")\
    \n            :local msg (\"Restarted outgoing L2TP client: \" . (\$sessionInfo->\"peer\"))\
    \n            \$Log \$msg\
    \n        }\
    \n        :return true\
    \n    } on-error={\
    \n        :local msg (\"FAILED to kill L2TP session for peer: \" . . (\$sessionInfo->\"peer\"))\
    \n        \$Log \$msg \"error\"\
    \n        :return false\
    \n    }\
    \n}\
    \n\
    \n# Kill IPSec active peers\
    \n:local KillIPSecPeers do={\
    \n    :local peerIP [:tostr \$1]\
    \n    :local Log \$2\
    \n    :local activePeers [/ip/ipsec/active-peers find remote-address=\$peerIP]\
    \n\
    \n    :if ([:len \$activePeers] = 0) do={\
    \n        :local msg (\"No active IPSec peers found for \" . \$peerIP)\
    \n        \$Log \$msg \"warning\"\
    \n        :return false\
    \n    }\
    \n\
    \n    :local killCount 0\
    \n    :foreach peer in=\$activePeers do={\
    \n        :do {\
    \n            /ip/ipsec/active-peers remove \$peer\
    \n            :set killCount (\$killCount + 1)\
    \n        } on-error={ \
    \n            :local err\
    \n            :local msg (\"FAILED to kill IPSec peer: \" . \$peerIP)\
    \n            \$Log \$msg \"error\"\
    \n        }\
    \n    }\
    \n\
    \n    :if (\$killCount > 0) do={\
    \n        :local msg (\"Killed \" . \$killCount . \" IPSec active peer(s) for \" . \$peerIP)\
    \n        \$Log \$msg\
    \n        :return true\
    \n    }\
    \n\
    \n    :return false\
    \n}\
    \n\
    \n# Perform recovery actions\
    \n:local RecoverPeer do={\
    \n\
    \n    :global globalPeerRetryCount\
    \n    :local peerIP [:tostr \$1]\
    \n    :local peerName [:tostr \$2]\
    \n    :local l2tpSession \$3\
    \n    :local Config \$4\
    \n    :local Log \$5\
    \n    :local KillL2TP \$6\
    \n    :local KillIPSec \$7\
    \n\
    \n    :local retryCount (\$globalPeerRetryCount->\$peerIP)\
    \n\
    \n    :if ([:typeof \$retryCount] != \"num\") do={ :set retryCount 0 }\
    \n   \
    \n    :set retryCount (\$retryCount + 1)\
    \n    :set (\$globalPeerRetryCount->\$peerIP) \$retryCount\
    \n\
    \n    :if (\$retryCount > (\$Config->\"maxRetryAttempts\")) do={\
    \n        :local msg (\"Peer \" . \$peerName . \" (\" . \$peerIP . \") exceeded max retry attempts (\" . \$retryCount . \") - MANUAL INTERVENTION REQUIRED\")\
    \n        \$Log \$msg \"error\"\
    \n        :return false\
    \n    }\
    \n\
    \n    :local startMsg (\"=== RECOVERY START: \" . \$peerName . \" (\" . \$peerIP . \") - Attempt \" . \$retryCount . \" ===\")\
    \n    \$Log \$startMsg\
    \n\
    \n    :if ((\$l2tpSession->\"found\")) do={\
    \n        :local killed [\$KillL2TP \$l2tpSession \$Log]\
    \n        :if (\$killed) do={ :delay 2s }\
    \n    }\
    \n\
    \n    :local ipsecKilled [\$KillIPSec \$peerIP \$Log]\
    \n    :if (\$ipsecKilled) do={ :delay 2s }\
    \n\
    \n    :local endMsg (\"=== RECOVERY COMPLETE: \" . \$peerName . \" (\" . \$peerIP . \") ===\")\
    \n    \$Log \$endMsg\
    \n    :return true\
    \n}\
    \n\
    \n# === MAIN EXECUTION ===\
    \n\
    \n\$Log \"=== IPSec/L2TP Connection Monitor Started ===\"\
    \n\
    \n:local PoliciesOnline [/ip/ipsec/policy find ( !template !disabled) ]\
    \n\
    \n:local msgPolicies (\"Found \" . [:len \$PoliciesOnline] . \" IPSec policies to investigate\")\
    \n\$Log \$msgPolicies\
    \n\
    \n# === STATISTICS ===\
    \n:local Stats {\
    \n    \"totalPolicies\"=[:len \$PoliciesOnline];\
    \n    \"testedPeers\"=0;\
    \n    \"passedPeers\"=0;\
    \n    \"failedPeers\"=0;\
    \n    \"recoveredPeers\"=0;\
    \n    \"skippedPeers\"=0\
    \n}\
    \n\
    \n# === MAIN POLICY CHECK LOOP ===\
    \n\
    \n:foreach policy in=\$PoliciesOnline do={\
    \n\
    \n        :local peerName \
    \n        :local srcAddr\
    \n        :local dstAddr\
    \n        :local l2tpInfo\
    \n\
    \n    :do {\
    \n        :set peerName [/ip/ipsec/policy get \$policy peer]\
    \n        :local isTunnel [/ip/ipsec/policy get \$policy tunnel]\
    \n\
    \n        :local isActive [/ip/ipsec/policy get \$policy active]\
    \n        :local polState [/ip/ipsec/policy get \$policy ph2-state]\
    \n\
    \n\
    \n        :set srcAddr\
    \n        :set dstAddr\
    \n\
    \n        :if (\$isTunnel) do={\
    \n            :local dstSubnet [/ip/ipsec/policy get \$policy dst-address]\
    \n            :local srcSubnet [/ip/ipsec/policy get \$policy src-address]\
    \n            :local dstCalc [\$IPCalc \$dstSubnet]\
    \n            :local srcCalc [\$IPCalc \$srcSubnet]\
    \n            :set dstAddr (\$dstCalc->\"hostmin\")\
    \n            :set srcAddr (\$srcCalc->\"hostmin\")\
    \n        } else={\
    \n            :set dstAddr [\$ExtractIP [/ip/ipsec/policy get \$policy dst-address]]\
    \n            :set srcAddr [\$ExtractIP [/ip/ipsec/policy get \$policy src-address]]\
    \n        }\
    \n\
    \n        :set (\$Stats->\"testedPeers\") ((\$Stats->\"testedPeers\") + 1)\
    \n\
    \n        :local testMsg (\"Examine Peer \" . \$peerName . \" (\" . \$dstAddr . \")\")\
    \n        \$Log \$testMsg\
    \n\
    \n        # 1) Looking for host L2TP session\
    \n        :set l2tpInfo [\$FindL2TPSession \$dstAddr]\
    \n\
    \n        :if (!\$isActive) do={\
    \n\
    \n            :local errL2tp (\"Non-active policy investigated for \" . \$peerName . \"\")\
    \n            \$Log \$errL2tp \"error\"\
    \n            :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n            :error \"skip-continue\"\
    \n\
    \n        }\
    \n\
    \n        :if ( \$polState!=\"established\" ) do={\
    \n\
    \n            :local errL2tp (\"Non-established policy investigated for \" . \$peerName . \"\")\
    \n            \$Log \$errL2tp \"error\"\
    \n            \
    \n            # some more diagnostic\
    \n           :if ((\$l2tpInfo->\"found\")) do={\
    \n   \
    \n                :if (!(\$l2tpInfo->\"running\")) do={\
    \n\
    \n                     :local errL2tp (\"Disconnected (Rx-Tx 0-0) \". (\$l2tpInfo->\"type\") . \" L2TP host-tunnel found for IPSEC: \" . (\$l2tpInfo->\"peer\"))             \
    \n                     \$Log \$errL2tp \"error\"\
    \n\
    \n                 }\
    \n\
    \n             }\
    \n\
    \n            :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n            :error \"skip-continue\"\
    \n\
    \n        }\
    \n\
    \n\
    \n        :local policyDstIP \$dstAddr\
    \n        :local policySrcIP \$srcAddr\
    \n\
    \n        :local mustUseL2TP false\
    \n        \
    \n        :local l2tpIf \"\"\
    \n        :local l2tpRouteIf \"\"\
    \n        :local policyRouteIf \"\"\
    \n\
    \n        :if ((\$l2tpInfo->\"found\")) do={\
    \n   \
    \n           :if (!(\$l2tpInfo->\"running\")) do={\
    \n\
    \n                :local errL2tp (\"Disconnected (Rx-Tx 0-0) \". (\$l2tpInfo->\"type\") . \" L2TP host-tunnel found for IPSEC: \" . (\$l2tpInfo->\"peer\"))                  \
    \n                \$Log \$errL2tp \"error\"\
    \n                :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                :error \"skip-continue\"\
    \n\
    \n            }\
    \n\
    \n           :local l2tpMsg (\"Active \". (\$l2tpInfo->\"type\") . \" L2TP host-tunnel found for IPSEC: \" . (\$l2tpInfo->\"peer\"))\
    \n            \$Log \$l2tpMsg\
    \n\
    \n            :local L2TPDstadd (\$l2tpInfo->\"remoteIP\")\
    \n            :local L2TPSrcadd (\$l2tpInfo->\"localIP\")\
    \n            :set mustUseL2TP true\
    \n            :set l2tpIf (\$l2tpInfo->\"peer\")\
    \n\
    \n            :set l2tpMsg \"Looking for specific (l2tp) routes to \$L2TPDstadd from \$L2TPSrcadd\"\
    \n            \$Log \$l2tpMsg\
    \n\
    \n            # we need specific route in the main table to that subnet\
    \n            :local l2tpRouteCheck [\$CheckRoute \$L2TPDstadd \$L2TPSrcadd]\
    \n            :if (!(\$l2tpRouteCheck->\"reachable\")) do={\
    \n\
    \n                :local errL2tp (\"Cannot find specific route (l2tp) to \" . \$L2TPDstadd . \" from \" . \$L2TPSrcadd . \" - status: \" . (\$l2tpRouteCheck->\"status\"))\
    \n                \$Log \$errL2tp \"error\"\
    \n                :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                :error \"skip-continue\"\
    \n\
    \n            } else={\
    \n\
    \n                :set l2tpRouteIf (\$l2tpRouteCheck->\"interface\")\
    \n                :local okL2tp (\"Found specific route (l2tp) to \" . \$L2TPDstadd .  \" from \" . \$L2TPSrcadd . \" via \" . (\$l2tpRouteCheck->\"nexthop\") . \" (\" . \$l2tpRouteIf . \")\")\
    \n                \$Log \$okL2tp\
    \n\
    \n            }\
    \n\
    \n            :set policyDstIP \$L2TPDstadd\
    \n            :set policySrcIP \$L2TPSrcadd\
    \n        \
    \n        } else={\
    \n\
    \n            :if (!\$isTunnel) do={\
    \n                # on transtort mode l2tp session have to exist (just a local convinience)\
    \n                :local errL2tp (\"No active L2TP host-tunnel found for IPSEC peer - \" . \$peerName . \" (on transport policy l2tp session have to exist)\")\
    \n                \$Log \$errL2tp \"error\"\
    \n                :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                :error \"skip-continue\"\
    \n\
    \n            } else={\
    \n                :local l2tpMsg (\"No active L2TP host-tunnel found for IPSEC peer - \" . \$peerName . \" (pure IPSEC, tunneled=\$isTunnel)\")\
    \n                \$Log \$l2tpMsg\
    \n            }\
    \n\
    \n        }\
    \n\
    \n\
    \n        :local polMsg \"Looking for specific (policy) routes to \$policyDstIP from \$policySrcIP\"\
    \n        \$Log \$polMsg\
    \n\
    \n        # 2) Policy route check\
    \n\
    \n        # we need specific route in the main table to that subnet\
    \n        :local policyRouteCheck [\$CheckRoute \$policyDstIP \$policySrcIP]\
    \n        :if (!(\$policyRouteCheck->\"reachable\")) do={\
    \n\
    \n            :local errPol (\"Cannot find specific route (policy) to \" . \$policyDstIP . \" from \" . \$policySrcIP . \" - status: \" . (\$policyRouteCheck->\"status\"))\
    \n            \$Log \$errPol \"error\"\
    \n            :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n            :error \"skip-continue\"\
    \n\
    \n        } else={\
    \n\
    \n            :set policyRouteIf (\$policyRouteCheck->\"interface\")\
    \n            :local okPol (\"Found specific route (policy) to \" . \$policyDstIP .  \" from \" . \$policySrcIP . \" via \" . (\$policyRouteCheck->\"nexthop\") . \" (\" . \$policyRouteIf . \")\")\
    \n            \$Log \$okPol\
    \n\
    \n                # 3) both routes have to be via the same catched L2TP interface\\gw\
    \n            :if (\$mustUseL2TP) do={\
    \n\
    \n                :local pingMsg \"Checking policy-l2tp routes' interfaces match\"\
    \n                \$Log \$pingMsg\
    \n\
    \n                # \D0\9E\D0\B1\D0\B0 \D0\BC\D0\B0\D1\80\D1\88\D1\80\D1\83\D1\82\D0\B0 (policy \D0\B8 test) \D0\B4\D0\BE\D0\BB\D0\B6\D0\BD\D1\8B \D0\B1\D1\8B\D1\82\D1\8C \D1\87\D0\B5\D1\80\D0\B5\D0\B7 L2TP\E2\80\91\D0\B8\D0\BD\D1\82\D0\B5\D1\80\D1\84\D0\B5\D0\B9\D1\81\
    \n                :if ((\$policyRouteIf != \$l2tpIf) or (\$l2tpRouteIf != \$l2tpIf)) do={\
    \n                    :local errIf (\"Found routes mismatch (policy via \" . \$policyRouteIf . \", l2tp via \" . \$l2tpRouteIf . \", expected \" . \$l2tpIf . \")\")\
    \n                    \$Log \$errIf \"error\"\
    \n                    :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                    :error \"skip-continue\"\
    \n\
    \n                } else={\
    \n\
    \n                    :local rL2tp (\"Found routes' interfaces are the same on L2TP \" . \$l2tpIf . \" and Policy \" . \$peerName )\
    \n                    \$Log \$rL2tp\
    \n\
    \n                    :set rL2tp (\"Pinging remote IP \" . \$policyDstIP )\
    \n                    \$Log \$rL2tp\
    \n\
    \n                    :local pingResult [\$TestConnectivity \$policyDstIP \$policySrcIP (\$Config->\"pingCount\") \$PingTrigger (\$Config->\"pingRetryDelay\")]\
    \n                    :if ((\$pingResult->\"success\")) do={\
    \n                        \
    \n                        :local pMsg (\"PASS: Ping test successful \" . (\$pingResult->\"received\") . \"/\" . (\$pingResult->\"required\") . \" (\" . (\$pingResult->\"attempts\") . \" attempt(s))\")\
    \n                        \$Log \$pMsg\
    \n\
    \n                        :set (\$Stats->\"passedPeers\") ((\$Stats->\"passedPeers\") + 1)\
    \n\
    \n                        # :set (\$globalPeerRetryCount->\$dstAddr) 0\
    \n                    } else={\
    \n\
    \n                        :local fMsg (\"FAIL: Ping test failed \" . (\$pingResult->\"received\") . \"/\" . (\$pingResult->\"required\") . \" after \" . (\$pingResult->\"attempts\") . \" attempts\")\
    \n\
    \n                        :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n\
    \n                        \$Log \$fMsg \"error\"\
    \n                       #going to recover\
    \n                       :error \"skip-continue\"\
    \n\
    \n                    }\
    \n                }\
    \n            \
    \n            } else={\
    \n\
    \n                :local pingMsg \"Skip policy-l2tp routes' interfaces match - no active L2TP host-tunnel available\"\
    \n                \$Log \$pingMsg\
    \n\
    \n                :local rL2tp (\"Pinging remote IP \" . \$policyDstIP )\
    \n                \$Log \$rL2tp\
    \n\
    \n                :local pingResult [\$TestConnectivity \$policyDstIP \$policySrcIP (\$Config->\"pingCount\") \$PingTrigger (\$Config->\"pingRetryDelay\")]\
    \n                :if ((\$pingResult->\"success\")) do={\
    \n                    \
    \n                    :local pMsg (\"PASS: Ping test successful \" . (\$pingResult->\"received\") . \"/\" . (\$pingResult->\"required\") . \" (\" . (\$pingResult->\"attempts\") . \" attempt(s))\")\
    \n                    \$Log \$pMsg\
    \n\
    \n                    :set (\$Stats->\"passedPeers\") ((\$Stats->\"passedPeers\") + 1)\
    \n\
    \n                    # :set (\$globalPeerRetryCount->\$dstAddr) 0\
    \n                } else={\
    \n\
    \n                    :local fMsg (\"FAIL: Ping test failed \" . (\$pingResult->\"received\") . \"/\" . (\$pingResult->\"required\") . \" after \" . (\$pingResult->\"attempts\") . \" attempts\")\
    \n \
    \n                    :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                  \
    \n                    \$Log \$fMsg \"error\"\
    \n                    # going to recover\
    \n                    :error \"skip-continue\"\
    \n\
    \n                }\
    \n\
    \n            }\
    \n\
    \n        } \
    \n\
    \n        \$Log \"Continue next\"\
    \n\
    \n    } on-error={ \
    \n\
    \n        # just go next policy\
    \n\
    \n                        :if ((\$Config->\"enableAutoRecovery\")) do={\
    \n                            :local recovered [\$RecoverPeer \$dstAddr \$peerName \$l2tpInfo \$Config \$Log \$KillL2TPSession \$KillIPSecPeers]\
    \n                            :if (\$recovered) do={\
    \n\
    \n                                :set (\$Stats->\"recoveredPeers\") ((\$Stats->\"recoveredPeers\") + 1)\
    \n\
    \n                            }\
    \n                        } else={\
    \n                            \$Log \"Auto-recovery disabled - manual intervention required\" \"warning\"\
    \n                        }\
    \n\
    \n\
    \n        \$Log \"Continue next (in case of skip or erros)\" \"warning\"\
    \n\
    \n    }\
    \n\
    \n\
    \n}\
    \n\
    \n# === POST-CHECK VALIDATION ===\
    \n\
    \n\$Log \"Waiting for system to come up after autorecovery\"\
    \n\
    \n:delay 5s\
    \n:local PoliciesOnlineAfter [/ip/ipsec/policy find active ph2-state=established]\
    \n:local PoliciesOfflineAfter [/ip/ipsec/policy find ( !template !disabled ph2-state!=established) ]\
    \n\
    \n# === FINAL SUMMARY ===\
    \n\
    \n\$Log \"=== TEST SUMMARY ===\"\
    \n\
    \n:local sumMsg1 (\"Total policies: \" . (\$Stats->\"totalPolicies\"))\
    \n\$Log \$sumMsg1\
    \n\
    \n:local sumMsg2 (\"Tested: \" . (\$Stats->\"testedPeers\") . \" | Passed: \" . (\$Stats->\"passedPeers\") . \" | Failed: \" . (\$Stats->\"failedPeers\"))\
    \n\$Log \$sumMsg2\
    \n\
    \n:local sumMsg3 (\"Recovered: \" . (\$Stats->\"recoveredPeers\") . \" | Skipped: \" . (\$Stats->\"skippedPeers\"))\
    \n\$Log \$sumMsg3\
    \n\
    \n:local sumMsg4 (\"Policies after check: Online=\" . [:len \$PoliciesOnlineAfter] . \" | Offline=\" . [:len \$PoliciesOfflineAfter])\
    \n\$Log \$sumMsg4\
    \n\
    \n# === RESULT ===\
    \n\
    \n:local testPassed true\
    \n:local errorMessage \"\"\
    \n\
    \n:if ((\$Stats->\"failedPeers\") > 0) do={\
    \n    :set testPassed false\
    \n    :set errorMessage ((\$Stats->\"failedPeers\") . \" peer(s) failed connectivity test\")\
    \n}\
    \n\
    \n:if ([:len \$PoliciesOfflineAfter] != 0) do={\
    \n    :set testPassed false\
    \n    :set errorMessage (\$errorMessage . \"; \" . [:len \$PoliciesOfflineAfter] . \" policies offline after recovery\")\
    \n}\
    \n\
    \n:if (\$testPassed) do={\
    \n    \$Log \"=== IPSec/L2TP Monitor: ALL CHECKS PASSED ===\" \"info\"\
    \n} else={\
    \n    \$Log \"=== IPSec/L2TP Monitor: FAILURES DETECTED ===\" \"error\"\
    \n    :local errLog (\"Error: \" . \$errorMessage)\
    \n    \$Log \$errLog \"error\"\
    \n\
    \n    :local tgMsg (\"IPSec Monitor ALERT: \" . \$errorMessage)\
    \n    \$globalTgMessage value=\$tgMsg\
    \n\
    \n    :error \$errorMessage\
    \n}\
    \n\r\
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
/system script add comment="Setups global functions, called by the other scripts (runs once on startup)" dont-require-permissions=yes name=doEnvironmentSetup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalNoteMe;\
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
    \n        :global simplercurrdatetimestr;\
    \n        :local stamp [\$simplercurrdatetimestr];\
    \n\
    \n        :local salt [:rndstr length=6 from=\"HtsP2n8qZ\"];        \
    \n        :local logName \"RAM/\$stamp-\$salt.log.txt\";\
    \n\
    \n        /file remove [find where name=\"\$logName\"]\
    \n        {\
    \n            :local jobid [:execute file=\$logName script=\$fetchCmd]\
    \n\
    \n            :set state \"Waiting the end of process for prototol \$logName to be ready, max 20 seconds...\";\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            :global Gltesec 0\
    \n            :while (([:len [/sys script job find where .id=\$jobid]] = 1) && (\$Gltesec < 20)) do={\
    \n                :set Gltesec (\$Gltesec + 1)\
    \n                :delay 1s\
    \n\
    \n                :set state \"waiting fetch result... \$Gltesec\";\
    \n                \$globalNoteMe value=\$state;\
    \n\
    \n            }\
    \n\
    \n            :set state \"Done. Elapsed Seconds: \$Gltesec\\r\\n\";\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            :if ([:len [/file find where name=\"\$logName\"]] = 1) do={\
    \n \
    \n                :local filecontent [/file get [/file find where name=\"\$logName\"] contents]\
    \n                :set state \"Result of Fetch:\\r\\n****************************\\r\\n\$filecontent\\r\\n****************************\";\
    \n                \$globalNoteMe value=\$state;\
    \n\
    \n                /file remove [find where name=\"\$logName\"];\
    \n\
    \n            } else={\
    \n\
    \n                :set state \"Result of Fetch:\\r\\n****************************\\r\\n 20Sec Timeout exceeded - still no log file \\r\\n****************************\";\
    \n                \$globalNoteMe value=\$state;\
    \n\
    \n            }\
    \n        }\
    \n    }\
    \n  }\
    \n}\
    \n\
    \n\
    \n\
    \n#Example call\
    \n#:put [\$globalOnPrimaryPartition]\
    \n#test if we are boot up from a primary partition(not fallback or recovery)\
    \n:global globalOnPrimaryPartition;\
    \n:if (!any \$globalOnPrimaryPartition) do={\
    \n    :global globalOnPrimaryPartition do={\
    \n        \
    \n        :global globalNoteMe;\
    \n        # \
    \n        :local partitionName \"primary\";\
    \n        :local OnPrimaryPartition false;\
    \n        \
    \n        :local partitionsActivated [system/device-mode/get partitions];\
    \n\
    \n        :if (!\$partitionsActivated) do={\
    \n\
    \n            :local state (\"Investigation result - partitions disabled\");\
    \n            \$globalNoteMe value=\$state;\
    \n            :local OnPrimaryPartition true;\
    \n            :return \$OnPrimaryPartition;\
    \n        }\
    \n\
    \n        :onerror errorName in={ \
    \n            \
    \n            # test if it exist in /partitions\
    \n            :local partition [/partitions find name=\$partitionName];\
    \n            :if ([:len \$partition] > 0) do={\
    \n                :local running [/partition get \$partition running];\
    \n                :if (\$running) do={\
    \n                    :set OnPrimaryPartition true;\
    \n                    :error \"primary active\";\
    \n                } else={\
    \n                    :set OnPrimaryPartition false;\
    \n                    :error \"primary inactive\";\
    \n                }\
    \n            } else={\
    \n                :set OnPrimaryPartition true;\
    \n                :error \"partitions not set\";\
    \n            }\
    \n\
    \n        } do={ \
    \n\
    \n            :local state (\"Investigation result - \$errorName\");\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            :return \$OnPrimaryPartition;\
    \n        }\
    \n       \
    \n        :put \$OnPrimaryPartition \
    \n        :return \$OnPrimaryPartition;\
    \n    }\
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
    \n:global globalOnPrimaryPartition;\
    \n:if ( ![\$globalOnPrimaryPartition] ) do {\
    \n    \
    \n    :set state \"WARNING: the system booted up from fallback partition - skipping backup!\"\
    \n    :log error \$state\
    \n    \$globalNoteMe value=\$state;\
    \n    :set itsOk false;\
    \n    :error \$state;\
    \n\
    \n}\
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
    \n    /file remove \$backupFile;\
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
    \n:local date [/system clock get date]; \
    \n:local monthNum [:tonum [:pick \$date 5 7]];\
    \n:local months {\"jan\";\"feb\";\"mar\";\"apr\";\"may\";\"jun\";\"jul\";\"aug\";\"sep\";\"oct\";\"nov\";\"dec\"};\
    \n:local pfx  ([:pick \$months (\$monthNum-1)]); \
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
    \n}\
    \n"
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
    \n:global globalOnPrimaryPartition;\
    \n:if ( ![\$globalOnPrimaryPartition] ) do {\
    \n    \
    \n    :set state \"WARNING: the system booted up from fallback partition - skipping dump!\"\
    \n    :log error \$state\
    \n    \$globalNoteMe value=\$state;\
    \n    :set itsOk false;\
    \n    :error \$state;\
    \n\
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
    \n:local UpdateList [:toarray \"doBackup,doEnvironmentSetup,doEnvironmentClearance,doRandomGen,doFreshTheScripts,doCertificatesIssuing,doNetwatchHost, doIPSECPunch,doStartupScript,doHeatFlag,doPeriodicLogDump,doPeriodicLogParse,doTelegramNotify,doLEDoff,doLEDon,doCPUHighLoadReboot,doUpdatePoliciesRemotely,doUpdateExternalDNS,doSuperviseCHRviaSSH,doCoolConsole,doFlushLogs,doCloudBackup\"];\
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
    \n  :foreach username,fi