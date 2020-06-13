# jun/13/2020 21:00:02 by RouterOS 6.46beta59
# software id = 
#
#
#
/interface bridge add arp=proxy-arp fast-forward=no name="main infrastructure"
/interface bridge add arp=proxy-arp fast-forward=no name=ospf-loopback
/interface ethernet set [ find default-name=ether1 ] advertise=10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=proxy-arp name=wan
/interface l2tp-server add disabled=yes name=rw-alx user=vpn-user-alx
/interface l2tp-server add name=tunnel user=vpn-remote-mic
/interface list add comment="trusted interfaces" name=trusted
/interface list add comment="neighbors allowed interfaces" name=neighbors
/interface list add comment="includes l2tp client interfaces when UP" name=l2tp-dynamic-tun
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/ip ipsec policy group add name=inside-ipsec-encryption
/ip ipsec policy group add name=roadwarrior-ipsec
/ip ipsec policy group add name=outside-ipsec-encryption
/ip ipsec profile set [ find default=yes ] dh-group=modp1024
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=ROUTEROS
/ip ipsec profile add dh-group=modp2048 enc-algorithm=aes-256 hash-algorithm=sha256 name=IOS/OSX
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=WINDOWS
/ip ipsec peer add address=91.79.193.47/32 comment="IPSEC IKEv2 VPN PHASE1 (MIC, outer-tunnel encryption, RSA, port-override, MGTS ip range)" exchange-mode=ike2 local-address=185.13.148.14 name=MIC-OUTER-IP-REMOTE-CONTROLLABLE passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add address=10.0.0.2/32 comment="IPSEC IKEv2 VPN PHASE1 (MIC, traffic-only encryption)" local-address=10.0.0.1 name=MIC-INNER passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add address=91.79.0.0/16 comment="IPSEC IKEv2 VPN PHASE1 (MIC, outer-tunnel encryption, RSA, port-override, remotely updated via SSH)" exchange-mode=ike2 local-address=185.13.148.14 name=MIC-OUTER-STATIC-IP-RANGE passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add comment="IPSEC IKEv2 VPN PHASE1 (IOS/OSX)" exchange-mode=ike2 local-address=185.13.148.14 name=RW passive=yes profile=IOS/OSX send-initial-contact=no
/ip ipsec peer add comment="IPSEC IKEv2 VPN PHASE1 (WINDOWS)" name=WIN passive=yes profile=WINDOWS send-initial-contact=no
/ip ipsec proposal set [ find default=yes ] enc-algorithms=aes-256-cbc,aes-192-cbc,aes-128-cbc,3des lifetime=1h
/ip ipsec proposal add enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 WINDOWS" pfs-group=none
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc lifetime=8h name="IPSEC IKEv2 VPN PHASE2 IOS/OSX" pfs-group=none
/ip pool add name=vpn-clients ranges=10.0.0.2
/ip pool add name=int-clients ranges=192.168.97.0/30
/ip pool add name=rw-clients ranges=10.10.10.8/29
/ip dhcp-server add add-arp=yes address-pool=int-clients bootp-support=none disabled=no interface=wan name=internal
/ip ipsec mode-config add address-pool=vpn-clients address-prefix-length=30 name=common-setup static-dns=8.8.8.8 system-dns=no
/ip ipsec mode-config add address-pool=rw-clients address-prefix-length=32 name=roadwarrior-setup
/ppp profile add address-list=l2tp-active-clients dns-server=8.8.8.8,8.8.4.4 interface-list=l2tp-dynamic-tun local-address=10.0.0.1 name=l2tp-no-encrypt-site2site only-one=no remote-address=vpn-clients
/ppp profile add address-list=l2tp-active-clients dns-server=8.8.8.8,8.8.4.4 interface-list=l2tp-dynamic-tun local-address=10.0.0.1 name=l2tp-no-encrypt-ios-rw only-one=no remote-address=rw-clients
/routing ospf area add area-id=0.0.0.1 default-cost=1 inject-summary-lsas=no name=local type=stub
/routing ospf instance set [ find default=yes ] distribute-default=always-as-type-2 name=routes-provider-mis router-id=10.255.255.1
/snmp community set [ find default=yes ] addresses=0.0.0.0/0
/snmp community add addresses=192.168.99.180/32,192.168.99.170/32 name=globus
/system logging action add memory-lines=600 name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=1 disk-file-name=ScriptsDiskLog disk-lines-per-file=300 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=1 disk-file-name=ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add memory-lines=500 name=OnScreenLog target=memory
/system logging action add name=DHCPOnScreenLog target=memory
/system logging action add name=DNSOnScreenLog target=memory
/system logging action add name=RouterControlDiskLog target=memory
/system logging action add name=OSFTOnScreenLog target=memory
/system logging action add name=L2TPOnScreenLog target=memory
/system logging action add disk-file-count=20 disk-file-name=AuthDiskLog disk-lines-per-file=300 name=AuthDiskLog target=disk
/system logging action add name=CertificatesOnScreenLog target=memory
/system logging action add name=SSHOnscreenLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!write,!policy,!sensitive,!dude
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!policy,!sensitive,!dude
/user group add name=remote policy=ssh,read,write,winbox,!local,!telnet,!ftp,!reboot,!policy,!test,!password,!web,!sniff,!sensitive,!api,!romon,!dude,!tikapp
/certificate scep-server add ca-cert=ca@CHR days-valid=365 next-ca-cert=ca@CHR path=/scep/grant request-lifetime=5m
/interface bridge settings set allow-fast-path=no use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes
/ip neighbor discovery-settings set discover-interface-list=neighbors
/ip settings set accept-source-route=yes allow-fast-path=no rp-filter=loose
/interface l2tp-server server set authentication=mschap2 default-profile=l2tp-no-encrypt-site2site enabled=yes ipsec-secret=123 max-mru=1418 max-mtu=1418
/interface list member add comment="neighbors lookup" interface=tunnel list=neighbors
/interface list member add comment="neighbors lookup" interface="main infrastructure" list=neighbors
/ip accounting set enabled=yes
/ip address add address=192.168.97.1/30 comment="local IP" interface="main infrastructure" network=192.168.97.0
/ip address add address=10.255.255.1 comment="ospf router-id binding" interface=ospf-loopback network=10.255.255.1
/ip cloud set ddns-enabled=yes
/ip dhcp-client add add-default-route=no dhcp-options=clientid,hostname disabled=no interface=wan use-peer-ntp=no
/ip dhcp-server network add address=10.0.0.0/30 dns-server=8.8.8.8,8.8.4.4 gateway=10.0.0.1
/ip dhcp-server network add address=192.168.97.0/30 gateway=192.168.97.1
/ip dns set cache-max-ttl=1d
/ip dns static add address=10.0.0.1 name=CHR
/ip dns static add address=192.168.99.180 name=minialx.home
/ip dns static add address=192.168.99.30 name=nas.home
/ip dns static add address=192.168.99.1 name=mikrouter.home
/ip firewall address-list add address=8.8.8.8 list=dns-accept
/ip firewall address-list add address=192.168.97.0/30 list=mis-network
/ip firewall address-list add address=rutracker.org list=vpn-sites
/ip firewall address-list add address=185.13.148.14 list=external-ip
/ip firewall address-list add address=192.168.99.0/24 list=mic-network
/ip firewall address-list add address=8.8.4.4 list=dns-accept
/ip firewall address-list add address=10.0.0.0/30 list=tun-network
/ip firewall address-list add address=192.168.99.0/24 list=mis-remote-control
/ip firewall address-list add address=192.168.97.0/30 list=mis-remote-control
/ip firewall address-list add address=0.0.0.0/0 list=mis-remote-control
/ip firewall address-list add address=2ip.ru list=vpn-sites
/ip firewall address-list add address=10.0.0.2 list=mic-network
/ip firewall address-list add address=10.0.0.1 list=mis-network
/ip firewall filter add action=accept chain=input comment="OSFP neighbour-ing allow" log-prefix=#OSFP protocol=ospf
/ip firewall filter add action=accept chain=input comment="Bandwidth test allow" port=2000 protocol=tcp
/ip firewall filter add action=accept chain=forward comment="Accept Related or Established Connections" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=jump chain=input comment="VPN Access" jump-target="VPN Access"
/ip firewall filter add action=accept chain="VPN Access" comment="L2TP tunnel" dst-port=1701 log-prefix=#L2TP protocol=udp
/ip firewall filter add action=accept chain="VPN Access" comment="VPN Allow IPSec-ah" log-prefix=#VPN protocol=ipsec-ah
/ip firewall filter add action=accept chain="VPN Access" comment="VPN Allow IPSec-esp" log-prefix=#VPN protocol=ipsec-esp
/ip firewall filter add action=accept chain="VPN Access" comment="VPN \"Allow IKE\" - IPSEC connection establishing" dst-port=500 log-prefix=#VPN protocol=udp
/ip firewall filter add action=accept chain="VPN Access" comment="VPN \"Allow UDP\" - IPSEC data trasfer" dst-port=4500 log-prefix=#VPN protocol=udp
/ip firewall filter add action=return chain="VPN Access" comment="Return from VPN Access"
/ip firewall filter add action=jump chain=forward comment="VPN Passthrough" jump-target="VPN Access"
/ip firewall filter add action=accept chain="VPN Passthrough" comment=VPN dst-address-list=mis-network log-prefix=#VPN
/ip firewall filter add action=accept chain="VPN Passthrough" comment=VPN dst-address-list=mis-network log-prefix=#VPN
/ip firewall filter add action=return chain="VPN Passthrough" comment="Return from VPN Passthrough"
/ip firewall filter add action=jump chain=input comment="Invalid DROP" jump-target="Invalid input DROP"
/ip firewall filter add action=drop chain="Invalid input DROP" comment="Drop Invalid Connections" connection-state=invalid
/ip firewall filter add action=return chain="Invalid input DROP" comment="Invalid DROP"
/ip firewall filter add action=jump chain=forward comment="Invalid DROP" jump-target="Invalid forward DROP"
/ip firewall filter add action=drop chain="Invalid forward DROP" comment="Drop Invalid Connections" connection-state=invalid
/ip firewall filter add action=return chain="Invalid forward DROP" comment="Invalid DROP"
/ip firewall filter add action=jump chain=input comment="Input BL" jump-target="Input Blacklist"
/ip firewall filter add action=drop chain="Input Blacklist" comment="Drop anyone in the Black List (Manually Added)" src-address-list=bh-manual
/ip firewall filter add action=drop chain="Input Blacklist" comment="Drop anyone in the Black List (SSH)" src-address-list=bh-ssh
/ip firewall filter add action=drop chain="Input Blacklist" comment="Drop anyone in the Black List (Winbox)" src-address-list=bh-winbox
/ip firewall filter add action=drop chain="Input Blacklist" comment="Drop anyone in the WAN Port Scanner List" src-address-list=bh-wan-port-scan
/ip firewall filter add action=drop chain="Input Blacklist" comment="Drop anyone in the LAN Port Scanner List" src-address-list=bh-lan-port-scan
/ip firewall filter add action=return chain="Input Blacklist" comment="Input Blacklist"
/ip firewall filter add action=jump chain=forward comment="Forward BL" jump-target="Forward Blacklist"
/ip firewall filter add action=drop chain="Forward Blacklist" comment="Drop anyone in the Black List (Manually Added)" src-address-list=bh-manual
/ip firewall filter add action=drop chain="Forward Blacklist" comment="Drop anyone in the Black List (SSH)" src-address-list=bh-ssh
/ip firewall filter add action=drop chain="Forward Blacklist" comment="Drop anyone in the Black List (Winbox)" src-address-list=bh-winbox
/ip firewall filter add action=drop chain="Forward Blacklist" comment="Drop anyone in the WAN Port Scanner List" src-address-list=bh-wan-port-scan
/ip firewall filter add action=drop chain="Forward Blacklist" comment="Drop anyone in the LAN Port Scanner List" src-address-list=bh-lan-port-scan
/ip firewall filter add action=return chain="Forward Blacklist" comment="Forward Blacklist"
/ip firewall filter add action=jump chain=input comment="Jump to SSH Staged control" jump-target="SSH Staged control"
/ip firewall filter add action=add-src-to-address-list address-list=bh-ssh address-list-timeout=none-dynamic chain="SSH Staged control" comment="Transfer repeated attempts from SSH Stage 3 to Black-List" connection-state=new dst-port=22 protocol=tcp src-address-list=ssh-staged-3
/ip firewall filter add action=add-src-to-address-list address-list=ssh-staged-3 address-list-timeout=1m chain="SSH Staged control" comment="Add succesive attempts to SSH Stage 3" connection-state=new dst-port=22 protocol=tcp src-address-list=ssh-staged-2
/ip firewall filter add action=add-src-to-address-list address-list=ssh-staged-2 address-list-timeout=1m chain="SSH Staged control" comment="Add succesive attempts to SSH Stage 2" connection-state=new dst-port=22 protocol=tcp src-address-list=ssh-staged-1
/ip firewall filter add action=add-src-to-address-list address-list=ssh-staged-1 address-list-timeout=1m chain="SSH Staged control" comment="Add intial attempt to SSH Stage 1 List" connection-state=new dst-port=22 protocol=tcp
/ip firewall filter add action=return chain="SSH Staged control" comment="Return From SSH Staged control"
/ip firewall filter add action=jump chain=input comment="Jump to Winbox staged control" jump-target="Winbox staged control"
/ip firewall filter add action=add-src-to-address-list address-list=bh-winbox address-list-timeout=none-dynamic chain="Winbox staged control" comment="Transfer repeated attempts from Winbox Stage 3 to Black-List" connection-state=new dst-port=8291 protocol=tcp src-address-list=winbox-staged-3
/ip firewall filter add action=add-src-to-address-list address-list=winbox-staged-3 address-list-timeout=1m chain="Winbox staged control" comment="Add succesive attempts to Winbox Stage 3" connection-state=new dst-port=8291 protocol=tcp src-address-list=winbox-staged-2
/ip firewall filter add action=add-src-to-address-list address-list=winbox-staged-2 address-list-timeout=1m chain="Winbox staged control" comment="Add succesive attempts to Winbox Stage 2" connection-state=new dst-port=8291 protocol=tcp src-address-list=winbox-staged-1
/ip firewall filter add action=add-src-to-address-list address-list=winbox-staged-1 address-list-timeout=1m chain="Winbox staged control" comment="Add Intial attempt to Winbox Stage 1" connection-state=new dst-port=8291 protocol=tcp
/ip firewall filter add action=return chain="Winbox staged control" comment="Return From Winbox staged control"
/ip firewall filter add action=add-src-to-address-list address-list=bh-wan-port-scan address-list-timeout=none-dynamic chain=input comment="Add TCP Port Scanners to Address List" protocol=tcp psd=40,3s,2,1
/ip firewall filter add action=add-src-to-address-list address-list=bh-lan-port-scan address-list-timeout=none-dynamic chain=forward comment="Add TCP Port Scanners to Address List" protocol=tcp psd=40,3s,2,1
/ip firewall filter add action=jump chain=input comment="Jump to DNS Amplification" jump-target="DNS Amplification" protocol=udp
/ip firewall filter add action=accept chain="DNS Amplification" comment="Make exceptions for DNS" log-prefix=#DNS port=53 protocol=udp src-address-list=dns-accept
/ip firewall filter add action=accept chain="DNS Amplification" comment="Make exceptions for DNS" dst-address-list=dns-accept log-prefix=#DNS port=53 protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list=dns-reject address-list-timeout=10h chain="DNS Amplification" comment="Add DNS Amplification to Blacklist" port=53 protocol=udp src-address-list=!dns-accept
/ip firewall filter add action=drop chain="DNS Amplification" comment="Drop DNS Amplification" src-address-list=dns-reject
/ip firewall filter add action=return chain="DNS Amplification" comment="Return from DNS Amplification"
/ip firewall filter add action=jump chain=input comment="Check for ping flooding" jump-target=detect-ping-flood protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="0:0 and limit for 5 pac/s" icmp-options=0:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="3:3 and limit for 5 pac/s" icmp-options=3:3 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="3:4 and limit for 5 pac/s" icmp-options=3:4 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="8:0 and limit for 5 pac/s" icmp-options=8:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="11:0 and limit for 5 pac/s" icmp-options=11:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="8:0 and limit for 50 pac/s Allow Ping tool speed-test" icmp-options=8:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=accept chain=detect-ping-flood comment="0:0 and limit for 50 pac/s Allow Ping tool speed-test" icmp-options=0:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=drop chain=detect-ping-flood comment="drop everything else" log=yes log-prefix="#ICMP DROP" protocol=icmp
/ip firewall filter add action=return chain=detect-ping-flood comment="Return from detect-ping-flood Chain"
/ip firewall filter add action=jump chain=input comment="Router remote control" jump-target="Router remote control" src-address-list=mis-remote-control
/ip firewall filter add action=accept chain="Router remote control" comment="SSH (2222/TCP)" dst-port=2222 protocol=tcp
/ip firewall filter add action=accept chain="Router remote control" comment="Winbox (8291/TCP)" dst-port=8291 protocol=tcp
/ip firewall filter add action=accept chain="Router remote control" comment=WEB port=80 protocol=tcp
/ip firewall filter add action=accept chain="Router remote control" comment=FTP port=20,21 protocol=tcp
/ip firewall filter add action=return chain="Router remote control" comment="Return from Router remote control"
/ip firewall filter add action=accept chain=input comment="Simple Network Management Protocol(SNMP)  " port=161 protocol=udp
/ip firewall filter add action=accept chain=input comment="Simple Network Management ProtocolTrap (SNMPTRAP)" port=162 protocol=tcp
/ip firewall filter add action=accept chain=input comment="Simple Network Management ProtocolTrap (SNMPTRAP)  " port=162 protocol=udp
/ip firewall filter add action=accept chain=input comment="Accept Related or Established Connections" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (INPUT)"
/ip firewall filter add action=accept chain=forward comment="Accept New Connections" connection-state=new log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=drop chain=input comment="Drop all other WAN Traffic" log=yes log-prefix="#DROP UNKNOWN (INPUT)"
/ip firewall filter add action=drop chain=forward comment="Drop all other LAN Traffic" log-prefix="#DROP UNKNOWN (FWD)"
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" in-interface=all-ppp new-mss=1360 passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" new-mss=1360 out-interface=all-ppp passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=change-mss chain=output comment="fix MSS for l2tp/ipsec (self)" dst-address-list=tun-network new-mss=1360 passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1361-65535
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites" dst-address-list=vpn-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self)" dst-address-list=vpn-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-packet chain=input comment="VPN Traffic" log-prefix="#VPN PCKT MARK" new-packet-mark="IPSEC PCKT" passthrough=yes protocol=ipsec-esp
/ip firewall mangle add action=mark-connection chain=output comment="Mark IPsec" ipsec-policy=out,ipsec new-connection-mark=ipsec passthrough=yes
/ip firewall mangle add action=mark-connection chain=input comment="Mark IPsec" ipsec-policy=in,ipsec new-connection-mark=ipsec passthrough=yes
/ip firewall mangle add action=mark-connection chain=forward comment="Mark IPsec" ipsec-policy=out,ipsec new-connection-mark=ipsec passthrough=yes
/ip firewall mangle add action=mark-connection chain=forward comment="Mark IPsec" ipsec-policy=in,ipsec new-connection-mark=ipsec passthrough=yes
/ip firewall nat add action=dst-nat chain=dstnat dst-port=8888 protocol=tcp to-addresses=192.168.99.1 to-ports=80
/ip firewall nat add action=accept chain=srcnat comment="accept tunnel traffic" dst-address-list=mic-network log-prefix=#VPN src-address-list=mis-network
/ip firewall nat add action=accept chain=dstnat comment="accept tunnel traffic" dst-address-list=mis-network log-prefix=#VPN src-address-list=mic-network
/ip firewall nat add action=masquerade chain=srcnat comment="VPN masq (pure L2TP, w/o IPSEC)" out-interface=tunnel
/ip firewall nat add action=masquerade chain=srcnat comment="all cable allowed"
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set irc disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip firewall service-port set udplite disabled=yes
/ip firewall service-port set dccp disabled=yes
/ip firewall service-port set sctp disabled=yes
/ip ipsec identity add generate-policy=port-strict mode-config=common-setup peer=MIC-INNER policy-template-group=inside-ipsec-encryption secret=123
/ip ipsec identity add auth-method=digital-signature certificate=server@CHR generate-policy=port-override match-by=certificate mode-config=roadwarrior-setup peer=RW policy-template-group=roadwarrior-ipsec remote-certificate=alx.iphone.rw.2019@CHR
/ip ipsec identity add auth-method=digital-signature certificate=server@CHR generate-policy=port-override match-by=certificate mode-config=roadwarrior-setup peer=RW policy-template-group=roadwarrior-ipsec remote-certificate=glo.iphone.rw.2019@CHR remote-id=fqdn:glo.iphone.rw.2019@CHR
/ip ipsec identity add generate-policy=port-strict mode-config=common-setup peer=WIN policy-template-group=inside-ipsec-encryption secret=123
/ip ipsec identity add auth-method=digital-signature certificate=server@CHR generate-policy=port-override match-by=certificate mode-config=common-setup peer=MIC-OUTER-IP-REMOTE-CONTROLLABLE policy-template-group=outside-ipsec-encryption remote-certificate=mikrouter@CHR
/ip ipsec identity add auth-method=digital-signature certificate=server@CHR generate-policy=port-override match-by=certificate mode-config=common-setup peer=MIC-OUTER-STATIC-IP-RANGE policy-template-group=outside-ipsec-encryption remote-certificate=mikrouter@CHR
/ip ipsec policy set 0 disabled=yes
/ip ipsec policy add comment="Roadwarrior IPSEC TRANSPORT TEMPLATE (outer-tunnel encryption)" dst-address=10.10.10.8/29 group=roadwarrior-ipsec proposal="IPSEC IKEv2 VPN PHASE2 IOS/OSX" src-address=0.0.0.0/0 template=yes
/ip ipsec policy add comment="Common IPSEC TUNNEL TEMPLATE (traffic-only encryption)" dst-address=192.168.99.0/24 group=inside-ipsec-encryption proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" src-address=192.168.97.0/30 template=yes
/ip ipsec policy add comment=MIC-OUTER-IP-REMOTE-CONTROLLABLE dst-address=91.79.193.47/32 group=outside-ipsec-encryption proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=185.13.148.14/32 template=yes
/ip ipsec policy add comment="Common IPSEC TRANSPORT TEMPLATE (outer-tunnel encryption, MGTS dst-IP range 2)" dst-address=91.79.0.0/16 group=outside-ipsec-encryption proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=185.13.148.14/32 template=yes
/ip route add check-gateway=ping comment=GLOBAL distance=10 gateway=185.13.148.1
/ip service set telnet disabled=yes
/ip service set ssh port=2222
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip smb set allow-guests=no
/ip ssh set allow-none-crypto=yes forwarding-enabled=remote
/ip upnp set show-dummy-rule=no
/ppp secret add local-address=10.0.0.1 name=vpn-remote-mic profile=l2tp-no-encrypt-site2site remote-address=10.0.0.2 service=l2tp
/ppp secret add disabled=yes local-address=10.0.0.1 name=vpn-remote-alx profile=l2tp-no-encrypt-ios-rw remote-address=10.0.0.3 service=l2tp
/ppp secret add disabled=yes local-address=10.0.0.1 name=vpn-remote-glo profile=l2tp-no-encrypt-ios-rw remote-address=10.0.0.4 service=l2tp
/routing filter add action=discard chain=ospf-in comment="discard intra area routes" ospf-type=intra-area
/routing filter add action=accept chain=ospf-in comment="set pref source" set-pref-src=10.0.0.1
/routing filter add action=accept chain=ospf-in comment="set default remote route mark" prefix-length=0 set-pref-src=10.0.0.1 set-route-comment=GLOBAL set-routing-mark=mark-site-over-vpn
/routing ospf nbma-neighbor add address=10.255.255.2
/routing ospf network add area=backbone network=10.0.0.0/30
/routing ospf network add area=local network=192.168.97.0/30
/routing ospf network add area=backbone network=10.255.255.1/32
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-community=globus trap-generators=interfaces trap-interfaces="main infrastructure" trap-version=2
/system clock set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity set name=CHR
/system logging set 0 action=OnScreenLog topics=info,!ipsec,!script
/system logging set 1 action=OnScreenLog
/system logging set 2 action=OnScreenLog
/system logging set 3 action=TerminalConsoleLog
/system logging add action=ErrorDiskLog topics=critical
/system logging add action=ErrorDiskLog topics=error
/system logging add action=ScriptsDiskLog topics=script
/system logging add action=OnScreenLog topics=firewall
/system logging add action=OnScreenLog topics=smb
/system logging add action=OnScreenLog topics=critical
/system logging add action=DHCPOnScreenLog topics=dhcp
/system logging add action=DNSOnScreenLog topics=dns
/system logging add action=OSFTOnScreenLog topics=ospf,!raw
/system logging add action=L2TPOnScreenLog topics=l2tp
/system logging add action=AuthDiskLog topics=account
/system logging add action=CertificatesOnScreenLog topics=certificate
/system logging add action=AuthDiskLog topics=manager
/system logging add action=IpsecOnScreenLog topics=ipsec,!debug,!packet
/system logging add action=SSHOnscreenLog topics=ssh
/system note set note="You are logged into: CHR\
    \n############### system health ###############\
    \nUptime:  2w6d00:00:10 d:h:m:s | CPU: 0%\
    \nRAM: 65092/1015808M | Voltage: NIL | Temp: NIL\
    \n############# user auth details #############\
    \nHotspot online: 0 | PPP online: 1\
    \n"
/system ntp client set enabled=yes primary-ntp=195.151.98.66 secondary-ntp=46.254.216.9
/system package update set channel=testing
/system scheduler add interval=1w3d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=nov/26/2017 start-time=21:00:00
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=15:55:00
/system scheduler add interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=08:00:00
/system scheduler add interval=10m name=doIPSECPunch on-event="/system script run doIPSECPunch" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/07/2019 start-time=09:00:00
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system script add dont-require-permissions=yes name=doBackup owner=owner policy=ftp,read,write,policy,test,password,sensitive source=":global globalScriptBeforeRun;\r\
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
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=doRandomGen owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive source="\r\
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
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=doCertificatesIssuing owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n\r\
    \n#should be used for private repos\r\
    \n:local GitHubAccessToken \"\";\r\
    \n\r\
    \n:local RequestUrl \"https://\$GitHubAccessToken@raw.githubusercontent.com/\$GitHubUserName/\$GitHubRepoName/master/scripts/\";\r\
    \n\r\
    \n:local UseUpdateList true;\r\
    \n:local UpdateList [:toarray \"doBackup,doEnvironmentSetup,doEnvironmentClearance,doRandomGen,doFreshTheScripts,doCertificatesIssuing,doNetwatchHost, doIPSECPunch,doStartupScript,doHeatFlag,doPeriodicLogDump,doPeriodicLogParse,doTelegramNotify,doLEDoff,doLEDon,doCPUHighLoadReboot,doUpdatePoliciesRemotely\"];\r\
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
    \n}\r\
    \n"
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
    \n:global globalIPSECPolicyUpdateViaSSH;\r\r\
    \n\r\r\
    \n:if (!any \$globalIPSECPolicyUpdateViaSSH) do={ \r\r\
    \n  :global globalIPSECPolicyUpdateViaSSH do={\r\r\
    \n\r\r\
    \n    :global globalRemoteIp;\r\r\
    \n    :global globalNoteMe;\r\
    \n\r\r\
    \n    :if ([:len \$1] > 0) do={\r\r\
    \n      :global globalRemoteIp (\"\$1\" . \"/32\"); \r\r\
    \n    }\r\r\
    \n\r\r\
    \n    :if (!any \$globalRemoteIp) do={ \r\r\
    \n      :global globalRemoteIp \"0.0.0.0/32\" \r\r\
    \n    } else={\r\r\
    \n    \r\r\
    \n    }\r\r\
    \n    \r\r\
    \n    :local count [:len [/system script find name=\"doUpdatePoliciesRemotely\"]];\r\r\
    \n\r\r\
    \n    :if (\$count > 0) do={\r\r\
    \n  \r\
    \n       :local state (\"Starting policies process... \$globalRemoteIp \");\r\
    \n       \$globalNoteMe value=\$state;  \r\
    \n       \r\
    \n       /system script run doUpdatePoliciesRemotely;\r\r\
    \n    \r\
    \n     }\r\r\
    \n  }\r\r\
    \n}\r\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doNetwatchHost owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n"
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
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doEnvironmentClearance owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n#clear all global variables\r\
    \n/system script environment remove [find];\r\
    \n"
/system script add dont-require-permissions=yes name=doCoolConcole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n/system note set note=\"\$logcontent\"\r\
    \n"
/system script add dont-require-permissions=yes name=doImperialMarch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#test\r\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doIPSECPunch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\r\
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
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doUpdatePoliciesRemotely owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:local sysname [/system identity get name];\r\
    \n:local scriptname \"doUpdatePoliciesRemotely\";\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \$scriptname;\r\
    \n\r\
    \n:global globalNoteMe;\r\
    \n:local itsOk true;\r\
    \n:local state \"\";\r\
    \n\r\
    \n:global globalRemoteIp;\r\
    \n\r\
    \n:do {\r\
    \n    :if ([:len \$globalRemoteIp] > 0) do={\r\
    \n\r\
    \n    :local peerID \"MIC-OUTER-IP-REMOTE-CONTROLLABLE\";\r\
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
    \n\r\
    \n"
/tool bandwidth-server set authenticate=no
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com password=zgejdmvndvorrmsn port=587 start-tls=yes user=defm.kopcap@gmail.com
/tool netwatch add down-script=":global NetwatchHostName \"mikrouter.home\";\r\
    \n/system script run doNetwatchHost;" host=192.168.99.1 up-script=":global NetwatchHostName \"mikrouter.home\";\r\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-port=https streaming-server=192.168.99.170
