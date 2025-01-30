# 2025-01-30 21:00:02 by RouterOS 7.18beta2
# software id = IA5H-12KT
#
# model = RB5009UPr+S+
# serial number = HCY086PZ6XZ
/caps-man channel add band=2ghz-b/g/n comment=CH1 control-channel-width=20mhz extension-channel=disabled frequency=2412 name=common-chnls-2Ghz reselect-interval=10h skip-dfs-channels=yes tx-power=17
/caps-man channel add band=5ghz-a/n/ac comment="20Mhz + Ce = 40Mhz, reselect interval from 5180, 5220, 5745, 5785 once per 10h" control-channel-width=20mhz extension-channel=Ce frequency=5180,5220,5745,5785 name=common-chnls-5Ghz reselect-interval=10h tx-power=15
/caps-man configuration add mode=ap name=empty
/interface bridge add dhcp-snooping=yes igmp-snooping=yes name=guest-infrastructure-br port-cost-mode=short
/interface bridge add arp=proxy-arp fast-forward=no name=ip-mapping-br port-cost-mode=short
/interface bridge add admin-mac=48:8F:5A:D4:5F:69 arp=reply-only auto-mac=no dhcp-snooping=yes igmp-snooping=yes name=main-infrastructure-br port-cost-mode=short
/interface ethernet set [ find default-name=ether2 ] arp=disabled comment="to WB (wire)" loop-protect=on name="lan A" poe-out=forced-on
/interface ethernet set [ find default-name=ether3 ] arp=disabled comment="to miniAlx (wire)" loop-protect=on name="lan B"
/interface ethernet set [ find default-name=ether4 ] arp=disabled comment="to MbpAlxm (wire)" loop-protect=on name="lan C"
/interface ethernet set [ find default-name=ether5 ] arp=disabled name="lan D"
/interface ethernet set [ find default-name=ether6 ] arp=disabled comment="to capxl(wire)" loop-protect=on name="lan E"
/interface ethernet set [ find default-name=ether7 ] arp=disabled comment="to PC(wire)" loop-protect=on name="lan F"
/interface ethernet set [ find default-name=ether8 ] comment="to ATV(wire)" loop-protect=on name="lan G"
/interface ethernet set [ find default-name=sfp-sfpplus1 ] disabled=yes name=optic
/interface ethernet set [ find default-name=ether1 ] arp=proxy-arp mac-address=20:CF:30:DE:7B:2A name="wan A" poe-out=off
/caps-man datapath add arp=proxy-arp bridge=guest-infrastructure-br client-to-client-forwarding=no name=2CapsMan-guest
/caps-man datapath add arp=reply-only bridge=main-infrastructure-br client-to-client-forwarding=yes name=2CapsMan-private
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps name="5GHz Rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps vht-basic-mcs=mcs0-9 vht-supported-mcs=mcs0-9
/caps-man rates add basic=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps ht-basic-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 ht-supported-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23 name="2GHz rates" supported=1Mbps,2Mbps,5.5Mbps,11Mbps,6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps
/caps-man security add authentication-types=wpa2-psk comment="2GHz/5GHz Security" encryption=aes-ccm group-encryption=aes-ccm group-key-update=1h name=private passphrase=mikrotik
/caps-man security add authentication-types="" comment="2GHz/5GHz FREE" encryption="" group-key-update=5m name=guest
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
/caps-man configuration add channel=common-chnls-2Ghz country=russia datapath=2CapsMan-private datapath.interface-list=list-2ghz-caps-private distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-2Ghz-private rx-chains=0,1,2,3 security=private ssid="WiFi 2Ghz PRIVATE" tx-chains=0,1,2,3
/caps-man configuration add channel=common-chnls-5Ghz country=russia datapath=2CapsMan-private datapath.interface-list=list-5ghz-caps-private disconnect-timeout=9s distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-5Ghz-private rx-chains=0,1,2,3 security=private ssid="WiFi 5Ghz PRIVATE" tx-chains=0,1,2,3
/caps-man configuration add channel=common-chnls-2Ghz country=russia datapath=2CapsMan-guest datapath.interface-list=list-2ghz-caps-guest distance=indoors guard-interval=long hw-protection-mode=rts-cts hw-retries=7 installation=indoor keepalive-frames=enabled max-sta-count=10 mode=ap multicast-helper=full name=zone-2Ghz-guest rx-chains=0,1,2,3 security=guest ssid="WiFi 2Ghz FREE" tx-chains=0,1,2,3
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=anna
/interface wireless security-profiles add authentication-types=wpa2-psk eap-methods="" group-key-update=1h management-protection=allowed mode=dynamic-keys name=private supplicant-identity="" wpa-pre-shared-key=mikrotik wpa2-pre-shared-key=mikrotik
/interface wireless security-profiles add authentication-types=wpa-psk,wpa2-psk eap-methods="" management-protection=allowed name=public supplicant-identity=""
/ip dhcp-server add authoritative=after-2sec-delay interface=main-infrastructure-br lease-time=1d name=main-dhcp-server
/ip dhcp-server option add code=15 force=yes name=DomainName_Windows value="s'home'"
/ip dhcp-server option add code=119 force=yes name=DomainName_LinuxMac value="s'home'"
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
/ppp profile add address-list=alist-l2tp-active-clients interface-list=list-l2tp-tunnels local-address=10.0.0.3 name=l2tp-no-encrypt-site2site only-one=no remote-address=10.0.0.1
/interface l2tp-client add allow=mschap2 connect-to=185.13.148.14 disabled=no ipsec-secret=123 max-mru=1360 max-mtu=1360 name=tunnel profile=l2tp-no-encrypt-site2site user=vpn-remote-anna
/queue simple add comment=dtq,50:DE:06:25:C2:FC,iPadProAlx name="iPadAlxPro@main-dhcp-server (50:DE:06:25:C2:FC)" queue=default/default target=192.168.90.130/32 total-queue=default
/queue simple add comment=dtq,B0:34:95:50:A1:6A, name="AudioATV(blocked)@guest-dhcp-server (B0:34:95:50:A1:6A)" queue=default/default target=192.168.98.231/32 total-queue=default
/queue simple add comment=dtq,90:DD:5D:C8:46:AB,AlxATV name="AlxATV (wireless)@main-dhcp-server (90:DD:5D:C8:46:AB)" queue=default/default target=192.168.90.200/32 total-queue=default
/queue simple add comment=dtq,B0:34:95:50:A1:6A, name="AudioATV (wireless)@main-dhcp-server (B0:34:95:50:A1:6A)" queue=default/default target=192.168.90.210/32 total-queue=default
/queue simple add comment=dtq,10:DD:B1:9E:19:5E,miniAlx name="miniAlx (wire)@main-dhcp-server (10:DD:B1:9E:19:5E)" queue=default/default target=192.168.90.70/32 total-queue=default
/queue simple add comment=dtq,00:11:32:2C:A7:85,nas name="NAS@main-dhcp-server (00:11:32:2C:A7:85)" queue=default/default target=192.168.90.40/32 total-queue=default
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
/queue simple add comment=dtq,04:F1:69:8E:12:B6,HONOR_9X-e57500d48bf17173 name="Hare's Honor9x(wireless)@main-dhcp-server (04:F1:69:8E:12:B6)" queue=default/default target=192.168.90.140/32 total-queue=default
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
/queue simple add comment=dtq,DC:10:57:2D:39:7B, name="iPhoneAlxr(wireless)(blocked)@guest-dhcp-server (DC:10:57:2D:39:7B)" queue=default/default target=192.168.98.150/32 total-queue=default
/queue simple add comment=dtq,00:1C:42:FE:E3:AB,W11 name="W11Parallels@main-dhcp-server (00:1C:42:FE:E3:AB)" queue=default/default target=192.168.90.35/32 total-queue=default
/queue simple add comment=dtq,00:1C:42:FE:E3:AB, name="W11Parallels(blocked)@guest-dhcp-server (00:1C:42:FE:E3:AB)" queue=default/default target=192.168.98.35/32 total-queue=default
/queue simple add comment=dtq,00:85:01:01:50:0E,wb name="WB (wire)@main-dhcp-server (00:85:01:01:50:0E)" queue=default/default target=192.168.90.2/32 total-queue=default
/queue simple add comment=dtq,00:85:01:01:50:0E, name="WB (wire)(blocked)@guest-dhcp-server (00:85:01:01:50:0E)" queue=default/default target=192.168.98.2/32 total-queue=default
/queue simple add comment=dtq,CA:FE:0F:0B:19:3A,wb name="WB (wireless)@main-dhcp-server (CA:FE:0F:0B:19:3A)" queue=default/default target=192.168.90.3/32 total-queue=default
/queue simple add comment=dtq,CA:FE:0F:0B:19:3A, name="WB (wireless)(blocked)@guest-dhcp-server (CA:FE:0F:0B:19:3A)" queue=default/default target=192.168.98.3/32 total-queue=default
/queue simple add comment=dtq,18:FD:74:94:FD:70,capxl name="capxl(wire)@main-dhcp-server (18:FD:74:94:FD:70)" queue=default/default target=192.168.90.10/32 total-queue=default
/queue simple add comment=dtq,88:53:95:30:68:9F,miniAlx name="miniAlx(wireless)@main-dhcp-server (88:53:95:30:68:9F)" queue=default/default target=192.168.90.80/32 total-queue=default
/queue simple add comment=dtq,88:53:95:30:68:9F, name="miniAlx(wireless)(blocked)@guest-dhcp-server (88:53:95:30:68:9F)" queue=default/default target=192.168.98.80/32 total-queue=default
/queue simple add comment=dtq,BC:74:4B:E8:9B:61, name="nSwitch(wereless)@main-dhcp-server (BC:74:4B:E8:9B:61)" queue=default/default target=192.168.90.199/32 total-queue=default
/queue simple add comment=dtq,BC:74:4B:E8:9B:61, name="nSwitch(wereless)(blocked)@guest-dhcp-server (BC:74:4B:E8:9B:61)" queue=default/default target=192.168.98.199/32 total-queue=default
/queue tree add comment="FILE download control" name="Total Bandwidth" parent=global queue=default
/queue tree add name=RAR packet-mark=rar-mark parent="Total Bandwidth" queue=default
/queue tree add name=EXE packet-mark=exe-mark parent="Total Bandwidth" queue=default
/queue tree add name=7Z packet-mark=7z-mark parent="Total Bandwidth" queue=default
/queue tree add name=ZIP packet-mark=zip-mark parent="Total Bandwidth" queue=default
/routing id add comment="OSPF Common" disabled=no id=10.255.255.3 name=anna-10.255.255.3 select-dynamic-id=only-loopback
/routing ospf instance add comment="OSPF Common - inject into \"main\" table" disabled=no in-filter-chain=ospf-in name=routes-inject-into-main originate-default=always redistribute="" router-id=anna-10.255.255.3 routing-table=rmark-vpn-redirect
/routing ospf area add disabled=no instance=routes-inject-into-main name=backbone
/routing ospf area add area-id=0.0.0.3 default-cost=10 disabled=no instance=routes-inject-into-main name=anna-space-main no-summaries type=stub
/routing table add comment="tunnel swing" fib name=rmark-vpn-redirect
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action set 0 memory-lines=300
/system logging action set 1 disk-file-name=journal
/system logging action add memory-lines=300 name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=1 disk-file-name=ScriptsDiskLog disk-lines-per-file=300 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=20 disk-file-name=ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add memory-lines=300 name=OnScreenLog target=memory
/system logging action add memory-lines=300 name=DHCPOnScreenLog target=memory
/system logging action add memory-lines=300 name=DNSOnScreenLog target=memory
/system logging action add memory-lines=300 name=RouterControlLog target=memory
/system logging action add memory-lines=300 name=OSPFOnscreenLog target=memory
/system logging action add memory-lines=300 name=L2TPOnScreenLog target=memory
/system logging action add disk-file-count=20 disk-file-name=AuthDiskLog disk-lines-per-file=300 name=AuthDiskLog target=disk
/system logging action add memory-lines=300 name=CertificatesOnScreenLog target=memory
/system logging action add memory-lines=300 name=ParseMemoryLog target=memory
/system logging action add memory-lines=300 name=CAPSOnScreenLog target=memory
/system logging action add memory-lines=300 name=FirewallOnScreenLog target=memory
/system logging action add memory-lines=300 name=SSHOnScreenLog target=memory
/system logging action add memory-lines=300 name=PoEOnscreenLog target=memory
/system logging action add memory-lines=300 name=EmailOnScreenLog target=memory
/system logging action add name=macos remote=192.168.90.70 remote-log-format=cef remote-port=1514 syslog-facility=local0 syslog-time-format=iso8601 target=remote
/system logging action add memory-lines=300 name=TransfersOnscreenLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!write,!policy,!sensitive
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!policy,!sensitive
/caps-man access-list add action=reject allow-signal-out-of-range=10s comment="Drop any when poor signal rate, https://support.apple.com/en-us/HT203068" disabled=no signal-range=-120..-80 ssid-regexp=WiFi
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
/ip smb set domain=HNW interfaces=main-infrastructure-br
/interface bridge port add bridge=main-infrastructure-br interface="lan D" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan A" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan B" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan C" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan E" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan F" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface="lan G" internal-path-cost=10 path-cost=10 trusted=yes
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
/interface list member add comment="neighbors lookup" interface=tunnel list=list-neighbors-lookup
/interface list member add comment="FW: drop invalid" interface="wan A" list=list-drop-invalid-connections
/interface list member add comment=OSPF interface=tunnel list=list-ospf-bearing
/interface list member add interface=main-infrastructure-br list=list-ospf-master
/interface list member add comment=OSPF interface=ospf-lo list=list-ospf-bearing
/interface ovpn-server server add mac-address=FE:0A:96:A8:C8:9C name=ovpn-server1
/interface wireless snooper set receive-errors=yes
/ip address add address=192.168.90.1/24 comment="local ip" interface=main-infrastructure-br network=192.168.90.0
/ip address add address=192.168.98.1/24 comment="local guest wifi" interface=guest-infrastructure-br network=192.168.98.0
/ip address add address=10.255.255.3 comment="ospf router-id binding" interface=ospf-lo network=10.255.255.3
/ip address add address=172.16.0.16/30 comment="GRAFANA IP redirect" interface=ip-mapping-br network=172.16.0.16
/ip address add address=172.16.0.17/30 comment="INFLUXDB IP redirect" interface=ip-mapping-br network=172.16.0.16
/ip address add address=10.20.225.166/24 comment="wan via ACADO edge router" interface="wan A" network=10.20.225.0
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
/ip dhcp-server lease add address=192.168.98.150 block-access=yes comment="iPhoneAlxr(wireless)(blocked)" mac-address=DC:10:57:2D:39:7B server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.35 comment=W11Parallels mac-address=00:1C:42:FE:E3:AB server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.35 block-access=yes comment="W11Parallels(blocked)" mac-address=00:1C:42:FE:E3:AB server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.80 comment="miniAlx(wireless)" mac-address=88:53:95:30:68:9F server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.80 block-access=yes comment="miniAlx(wireless)(blocked)" mac-address=88:53:95:30:68:9F server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.130 comment=iPadAlxPro mac-address=50:DE:06:25:C2:FC server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.130 block-access=yes comment="iPadAlxPro(blocked)" mac-address=50:DE:06:25:C2:FC server=guest-dhcp-server
/ip dhcp-server lease add address=192.168.90.199 comment="nSwitch(wereless)" mac-address=BC:74:4B:E8:9B:61 server=main-dhcp-server
/ip dhcp-server lease add address=192.168.98.199 block-access=yes comment="nSwitch(wereless)(blocked)" mac-address=BC:74:4B:E8:9B:61 server=guest-dhcp-server
/ip dhcp-server matcher add address-pool=pool-vendor code=60 matching-type=exact name=vendor-mikrotik-caps server=main-dhcp-server value=mikrotik-cap
/ip dhcp-server network add address=192.168.90.0/27 caps-manager=192.168.90.1 comment="Network devices, CCTV" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.32/27 caps-manager=192.168.90.1 comment="Virtual machines" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.64/26 caps-manager=192.168.90.1 comment="Mac, Pc" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.128/27 caps-manager=192.168.90.1 comment="Phones, tablets" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.160/27 caps-manager=192.168.90.1 comment="IoT, intercom" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.192/27 caps-manager=192.168.90.1 comment="TV, projector, boxes" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.90.224/27 caps-manager=192.168.90.1 comment="Reserved, special" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=192.168.90.1 gateway=192.168.90.1 netmask=24 ntp-server=192.168.90.1
/ip dhcp-server network add address=192.168.98.0/24 comment="Guest DHCP leasing (Yandex protected DNS)" dns-server=77.88.8.7 gateway=192.168.98.1 ntp-server=192.168.98.1
/ip dns set address-list-extra-time=1d allow-remote-requests=yes cache-max-ttl=1d cache-size=4096KiB max-concurrent-queries=200 max-concurrent-tcp-sessions=30 query-server-timeout=3s servers=217.10.36.5,217.10.32.4 use-doh-server=https://1.1.1.1/dns-query
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
/ip dns static add address=192.168.90.100 comment=<AUTO:DHCP:main-dhcp-server> name=DESKTOP-QMUE5PH.home ttl=5m type=A
/ip dns static add comment="OpenNIC - dns relay (DoH should not be configured)" forward-to=185.121.177.177,51.15.98.97,2a01:4f8:1c0c:80c9::1 regexp=".*(\\.bbs|\\.chan|\\.cyb|\\.dyn|\\.geek|\\.gopher|\\.indy|\\.libre|\\.neo|\\.null|\\.o)\$" type=FWD
/ip dns static add comment="OpenNIC - dns relay (DoH should not be configured)" forward-to=185.121.177.177,51.15.98.97,2a01:4f8:1c0c:80c9::1 regexp=".*(\\.oss|\\.oz|\\.parody|\\.pirate|\\.opennic.glue|\\.dns\\.opennic\\.glue)\$" type=FWD
/ip dns static add comment="OpenNIC - dns relay (DoH should not be configured)" forward-to=185.121.177.177,51.15.98.97,2a01:4f8:1c0c:80c9::1 regexp=".*(\\.bazar|\\.coin|\\.emc|\\.lib|\\.fur1|\\.bit|\\.ku|\\.te|\\.ti|\\.uu)\$" type=FWD
/ip dns static add address=192.168.90.140 comment=<AUTO:DHCP:main-dhcp-server> name=HONOR9X-e57500d48bf17173.home ttl=5m type=A
/ip dns static add address=192.168.90.205 comment=<AUTO:DHCP:main-dhcp-server> name=localhost.home ttl=5m type=A
/ip dns static add address=192.168.90.150 comment=<AUTO:DHCP:main-dhcp-server> name=iPhoneAlxr.home ttl=5m type=A
/ip dns static add address=192.168.90.77 comment=<AUTO:DHCP:main-dhcp-server> name=DESKTOP-G3RE47G.home ttl=5m type=A
/ip dns static add address=192.168.90.130 comment=<AUTO:DHCP:main-dhcp-server> name=iPadProAlx.home ttl=5m type=A
/ip dns static add address=1.1.1.1 name=cloudflare-dns.com type=A
/ip dns static add address=192.168.90.35 comment=<AUTO:DHCP:main-dhcp-server> name=W11.home ttl=5m type=A
/ip dns static add address=8.8.8.8 name=dns.google type=A
/ip dns static add address=8.8.4.4 name=dns.google type=A
/ip dns static add cname=miniAlx.home name=miniAlx type=CNAME
/ip dns static add address=192.168.90.220 comment=<AUTO:DHCP:main-dhcp-server> name=yandex-mini2-ZGNK.home ttl=5m type=A
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=googlevideo.com type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=youtube.com type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=ytimg.com type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=youtu.be type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=yt.be type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=ggpht.com type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=gvt1.com type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=youtube-nocookie.com type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=googleapis.com type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=google.com type=FWD
/ip dns static add address-list=alist-mangle-YouTube comment="YT Hack" disabled=yes forward-to=0.0.0.0 match-subdomain=yes name=google.ru type=FWD
/ip dns static add address=46.39.51.86 name=ftpserver.org type=A
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
/ip firewall address-list add address=nnmclub.me list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=10.0.0.0/24 list=alist-fw-local-subnets
/ip firewall address-list add address=10.0.0.0/24 list=alist-nat-local-subnets
/ip firewall address-list add address=myexternalip.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=172.16.0.16/30 list=alist-fw-local-subnets
/ip firewall address-list add address=172.16.0.16/30 list=alist-nat-local-subnets
/ip firewall address-list add address=192.168.98.0/24 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=telegram.org list=alist-fw-telegram-servers
/ip firewall address-list add address=grafana.home list=alist-nat-grafana-server
/ip firewall address-list add address=grafanasvc.home list=alist-nat-grafana-service
/ip firewall address-list add address=influxdb.home list=alist-nat-influxdb-server
/ip firewall address-list add address=influxdbsvc.home list=alist-nat-influxdb-service
/ip firewall address-list add address=speedtest.tele2.net list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.90.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=lostfilm.tv list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=nnmclub.to list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=rutor.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=rutor.info list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=10.0.0.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=185.13.148.14 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=192.168.90.0/24 comment="Port scan entire LAN allow" list=alist-fw-port-scanner-allow
/ip firewall address-list add address=www.parallels.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=instagram.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=l.instagram.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.100.7 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=217.10.36.5 comment="AKADO official DNS server" list=alist-fw-dns-allow
/ip firewall address-list add address=217.10.34.2 comment="AKADO official DNS server" list=alist-fw-dns-allow
/ip firewall address-list add address=2ip.ru list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=www.canva.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.99.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=192.168.90.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=radarr.video list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=tmdb.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=themoviedb.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=image.tmdb.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=radarr.servarr.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=swagger.io list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=gog.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=pornhub.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=www.tinkercad.com comment=www.tinkercad.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=autodesk.com comment=autodesk.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=accounts.autodesk.com comment=accounts.autodesk.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=ntc.party list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=binaryronin.io list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=nmac.to list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=x.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=tkjpedia.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=twitter.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=youtube.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=youtu.be comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=yt.be comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=googlevideo.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=ytimg.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=ggpht.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=gvt1.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=youtube-nocookie.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=youtube-ui.l.google.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=youtubeembeddedplayer.googleapis.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=youtube.googleapis.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=youtubei.googleapis.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=yt-video-upload.l.google.com comment="YT Hack" disabled=yes list=alist-mangle-YouTube
/ip firewall address-list add address=wide-youtube.l.google.com comment="YT Hack" list=alist-mangle-You