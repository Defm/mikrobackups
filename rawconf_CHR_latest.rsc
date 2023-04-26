# apr/26/2023 21:00:02 by RouterOS 7.8
# software id = 
#
/interface bridge add arp=proxy-arp fast-forward=no name="main infrastructure"
/interface bridge add arp=proxy-arp fast-forward=no name=ospf-loopback
/interface ethernet set [ find default-name=ether1 ] advertise=10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=proxy-arp name=wan
/interface l2tp-server add disabled=yes name=rw-alx user=vpn-user-alx
/interface l2tp-server add name=tunnel-anna user=vpn-remote-anna
/interface l2tp-server add name=tunnel-mikrotik user=vpn-remote-mic
/disk set disk1 slot=disk1
/disk set slot1 slot=slot1
/interface list add comment="trusted interfaces" name=trusted
/interface list add comment="neighbors allowed interfaces" name=neighbors
/interface list add comment="includes l2tp client interfaces when UP" name=l2tp-dynamic-tun
/interface lte apn set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/ip ipsec policy group add name=inside-ipsec-encryption
/ip ipsec policy group add name=roadwarrior-ipsec
/ip ipsec policy group add name=outside-ipsec-encryption
/ip ipsec profile set [ find default=yes ] dh-group=modp1024
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=ROUTEROS
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=IOS/OSX
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=WINDOWS
/ip ipsec peer add address=85.174.204.244/32 comment="IPSEC IKEv2 VPN PHASE1 (MIC, outer-tunnel encryption, RSA, port-override, remotely updated via SSH)" disabled=yes exchange-mode=ike2 local-address=185.13.148.14 name=MIC-OUTER-STATIC-IP-RANGE passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add address=85.174.195.133/32 comment="IPSEC IKEv2 VPN PHASE1 (MIC, outer-tunnel encryption, RSA, port-override, MGTS ip range)" exchange-mode=ike2 local-address=185.13.148.14 name=MIC-OUTER-IP-REMOTE-CONTROLLABLE passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add address=46.39.51.172/32 comment="IPSEC IKEv2 VPN PHASE1 (ANNA, outer-tunnel encryption, RSA, port-override, MGTS ip range)" exchange-mode=ike2 local-address=185.13.148.14 name=ANNA-OUTER-IP-REMOTE-CONTROLLABLE passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add address=10.0.0.3/32 comment="IPSEC IKEv2 VPN PHASE1 (ANNA, traffic-only encryption)" local-address=10.0.0.1 name=ANNA-INNER passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add address=10.0.0.2/32 comment="IPSEC IKEv2 VPN PHASE1 (MIC, traffic-only encryption)" local-address=10.0.0.1 name=MIC-INNER passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add address=91.79.0.0/16 comment="IPSEC IKEv2 VPN PHASE1 (ANNA, outer-tunnel encryption, RSA, port-override, remotely updated via SSH)" disabled=yes exchange-mode=ike2 local-address=185.13.148.14 name=ANNA-OUTER-STATIC-IP-RANGE passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add comment="IPSEC IKEv2 VPN PHASE1 (IOS/OSX)" disabled=yes exchange-mode=ike2 local-address=185.13.148.14 name=RW passive=yes profile=IOS/OSX send-initial-contact=no
/ip ipsec peer add comment="IPSEC IKEv2 VPN PHASE1 (WINDOWS)" disabled=yes name=WIN passive=yes profile=WINDOWS send-initial-contact=no
/ip ipsec proposal set [ find default=yes ] disabled=yes enc-algorithms=aes-256-cbc,aes-192-cbc,aes-128-cbc,3des lifetime=1h
/ip ipsec proposal add enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 WINDOWS" pfs-group=none
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc lifetime=8h name="IPSEC IKEv2 VPN PHASE2 IOS/OSX" pfs-group=none
/ip pool add name=vpn-clients ranges=10.0.0.0/29
/ip pool add name=int-clients ranges=192.168.97.0/29
/ip pool add name=rw-clients ranges=10.10.10.8/29
/ip dhcp-server add add-arp=yes address-pool=int-clients bootp-support=none interface=wan name=internal
/ip ipsec mode-config add address-pool=vpn-clients address-prefix-length=30 name=common-setup static-dns=8.8.8.8 system-dns=no
/ip ipsec mode-config add address-pool=rw-clients address-prefix-length=32 name=roadwarrior-setup
/port set 0 name=serial0
/port set 1 name=serial1
/ppp profile add address-list=l2tp-active-clients dns-server=8.8.8.8,8.8.4.4 interface-list=l2tp-dynamic-tun local-address=10.0.0.1 name=l2tp-no-encrypt-site2site only-one=no remote-address=vpn-clients
/ppp profile add address-list=l2tp-active-clients dns-server=8.8.8.8,8.8.4.4 interface-list=l2tp-dynamic-tun local-address=10.0.0.1 name=l2tp-no-encrypt-ios-rw only-one=no remote-address=rw-clients
/routing bgp template set default disabled=no output.network=bgp-networks
/routing id add comment="OSPF Common" id=10.255.255.1 name=chr-10.255.255.1
/routing ospf instance add comment="OSPF Common - inject into \"main\" table" disabled=no in-filter-chain=ospf-in name=routes-inject-into-main originate-default=never redistribute="" router-id=chr-10.255.255.1
/routing ospf area add disabled=no instance=routes-inject-into-main name=backbone
/routing ospf area add area-id=0.0.0.1 default-cost=1 disabled=no instance=routes-inject-into-main name=chr-space-main no-summaries type=stub
/routing table add fib name=mark-site-over-vpn
/routing table add comment="tunnel swing" fib name=rmark-vpn-redirect
/routing table add comment="tunnel swing" fib name=rmark-telegram-redirect
/snmp community set [ find default=yes ] addresses=0.0.0.0/0 disabled=yes
/snmp community add addresses=::/0 name=globus
/system logging action set 1 disk-file-name=journal
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
/system logging action add name=EmailOnScreenLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!write,!policy,!sensitive
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!policy,!sensitive
/user group add name=remote policy=ssh,read,write,winbox,!local,!telnet,!ftp,!reboot,!policy,!test,!password,!web,!sniff,!sensitive,!api,!romon,!rest-api
/certificate scep-server add ca-cert=ca@CHR days-valid=365 next-ca-cert=ca@CHR path=/scep/grant request-lifetime=5m
/certificate settings set crl-download=yes crl-use=yes
#error exporting /interface/bridge/calea
/interface bridge settings set allow-fast-path=no use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes
/ip neighbor discovery-settings set discover-interface-list=neighbors
/ip settings set accept-source-route=yes allow-fast-path=no max-neighbor-entries=8192 rp-filter=loose
/ipv6 settings set disable-ipv6=yes max-neighbor-entries=8192
/interface detect-internet set detect-interface-list=all
/interface l2tp-server server set authentication=mschap2 default-profile=l2tp-no-encrypt-site2site enabled=yes max-mru=1418 max-mtu=1418
/interface list member add comment="neighbors lookup" interface=tunnel-mikrotik list=neighbors
/interface list member add comment="neighbors lookup" interface="main infrastructure" list=neighbors
/interface ovpn-server server set auth=sha1,md5
/ip address add address=192.168.97.1/29 comment="local IP" interface="main infrastructure" network=192.168.97.0
/ip address add address=10.255.255.1 comment="ospf router-id binding" interface=ospf-loopback network=10.255.255.1
/ip cloud set ddns-enabled=yes update-time=yes
/ip dhcp-client add add-default-route=no dhcp-options=clientid,hostname interface=wan use-peer-ntp=no
/ip dhcp-server network add address=10.0.0.0/29 dns-server=8.8.8.8,8.8.4.4 gateway=10.0.0.1
/ip dhcp-server network add address=192.168.97.0/29 gateway=192.168.97.1
/ip dns set cache-max-ttl=1d
/ip dns static add address=192.168.90.70 name=minialx.home
/ip dns static add cname=minialx.home name=minialx type=CNAME
/ip dns static add address=192.168.90.40 name=nas.home
/ip dns static add cname=nas.home name=nas type=CNAME
/ip dns static add address=192.168.99.1 name=mikrouter.home
/ip dns static add cname=mikrouter.home name=mikrouter type=CNAME
/ip dns static add address=192.168.90.1 name=anna.home
/ip dns static add cname=anna.home name=anna type=CNAME
/ip dns static add address=192.168.90.2 name=wb.home
/ip dns static add cname=wb.home name=wb type=CNAME
/ip dns static add address=192.168.97.1 name=chr.home
/ip dns static add cname=chr.home name=chr type=CNAME
/ip dns static add address=192.168.90.10 name=capxl.home
/ip dns static add cname=capxl.home name=capxl type=CNAME
/ip dns static add address=185.13.148.14 name=ftpserver.org
/ip firewall address-list add address=8.8.8.8 list=dns-accept
/ip firewall address-list add address=192.168.97.0/29 list=mis-network
/ip firewall address-list add address=rutracker.org list=vpn-sites
/ip firewall address-list add address=185.13.148.14 list=external-ip
/ip firewall address-list add address=192.168.99.0/24 list=mic-network
/ip firewall address-list add address=8.8.4.4 list=dns-accept
/ip firewall address-list add address=10.0.0.0/29 list=tun-network
/ip firewall address-list add address=192.168.99.0/24 list=mis-remote-control
/ip firewall address-list add address=192.168.97.0/29 list=mis-remote-control
/ip firewall address-list add address=0.0.0.0/0 list=mis-remote-control
/ip firewall address-list add address=2ip.ru list=vpn-sites
/ip firewall address-list add address=10.0.0.0/29 list=mic-network
/ip firewall address-list add address=10.0.0.1 list=mis-network
/ip firewall address-list add address=10.0.0.0/29 list=alist-fw-vpn-subnets
/ip firewall address-list add address=192.168.90.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=192.168.99.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=192.168.97.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=185.13.148.14 list=alist-nat-external-ip
#error exporting /ip/firewall/calea
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
/ip firewall filter add action=add-src-to-address-list address-list=bh-ssh address-list-timeout=none-dynamic chain="SSH Staged control" comment="Transfer repeated attempts from SSH Stage 3 to Black-List" connection-state=new dst-port=22,2222 protocol=tcp src-address-list=ssh-staged-3
/ip firewall filter add action=add-src-to-address-list address-list=ssh-staged-3 address-list-timeout=1m chain="SSH Staged control" comment="Add succesive attempts to SSH Stage 3" connection-state=new dst-port=22,2222 protocol=tcp src-address-list=ssh-staged-2
/ip firewall filter add action=add-src-to-address-list address-list=ssh-staged-2 address-list-timeout=1m chain="SSH Staged control" comment="Add succesive attempts to SSH Stage 2" connection-state=new dst-port=22,2222 protocol=tcp src-address-list=ssh-staged-1
/ip firewall filter add action=add-src-to-address-list address-list=ssh-staged-1 address-list-timeout=1m chain="SSH Staged control" comment="Add intial attempt to SSH Stage 1 List" connection-state=new dst-port=22,2222 protocol=tcp
/ip firewall filter add action=return chain="SSH Staged control" comment="Return From SSH Staged control"
/ip firewall filter add action=jump chain=input comment="Jump to Winbox staged control" jump-target="Winbox staged control"
/ip firewall filter add action=add-src-to-address-list address-list=bh-winbox address-list-timeout=none-dynamic chain="Winbox staged control" comment="Transfer repeated attempts from Winbox Stage 3 to Black-List" connection-state=new dst-port=8291 protocol=tcp src-address-list=winbox-staged-3
/ip firewall filter add action=add-src-to-address-list address-list=winbox-staged-3 address-list-timeout=1m chain="Winbox staged control" comment="Add succesive attempts to Winbox Stage 3" connection-state=new dst-port=8291 protocol=tcp src-address-list=winbox-staged-2
/ip firewall filter add action=add-src-to-address-list address-list=winbox-staged-2 address-list-timeout=1m chain="Winbox staged control" comment="Add succesive attempts to Winbox Stage 2" connection-state=new dst-port=8291 protocol=tcp src-address-list=winbox-staged-1
/ip firewall filter add action=add-src-to-address-list address-list=winbox-staged-1 address-list-timeout=1m chain="Winbox staged control" comment="Add Intial attempt to Winbox Stage 1" connection-state=new dst-port=8291 protocol=tcp src-address-list=!alist-fw-vpn-subnets
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
/ip firewall nat add action=dst-nat chain=dstnat comment="FTP pass through" dst-port=2121 protocol=tcp to-addresses=192.168.90.40 to-ports=21
/ip firewall nat add action=dst-nat chain=dstnat comment="WINBOX ANNA pass through" dst-port=9999 protocol=tcp to-addresses=192.168.90.1 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="WINBOX CAPXL pass through" dst-port=9998 protocol=tcp to-addresses=192.168.90.10 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="WINBOX MIKROUTER pass through" dst-port=9997 protocol=tcp to-addresses=10.0.0.2 to-ports=8291
/ip firewall nat add action=accept chain=srcnat comment="accept tunnel traffic" dst-address-list=mic-network log-prefix=#VPN src-address-list=mis-network
/ip firewall nat add action=accept chain=dstnat comment="accept tunnel traffic" dst-address-list=mis-network log-prefix=#VPN src-address-list=mic-network
/ip firewall nat add action=masquerade chain=srcnat comment="VPN masq (pure L2TP, w/o IPSEC)" out-interface=tunnel-anna
/ip firewall nat add action=masquerade chain=srcnat comment="all cable allowed"
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip firewall service-port set udplite disabled=yes
/ip firewall service-port set dccp disabled=yes
/ip firewall service-port set sctp disabled=yes
/ip ipsec identity add comment=to-MIKROTIK-traffic-only-encryption-PSK generate-policy=port-strict mode-config=common-setup peer=MIC-INNER policy-template-group=inside-ipsec-encryption
/ip ipsec identity add auth-method=digital-signature certificate=S.185.13.148.14@CHR disabled=yes generate-policy=port-override mode-config=roadwarrior-setup peer=RW policy-template-group=roadwarrior-ipsec
/ip ipsec identity add disabled=yes generate-policy=port-strict mode-config=common-setup peer=WIN policy-template-group=inside-ipsec-encryption
/ip ipsec identity add auth-method=digital-signature certificate=S.185.13.148.14@CHR comment=to-MIKROTIK-outer-tunnel-encryption-RSA generate-policy=port-override mode-config=common-setup peer=MIC-OUTER-IP-REMOTE-CONTROLLABLE policy-template-group=outside-ipsec-encryption
/ip ipsec identity add auth-method=digital-signature certificate=S.185.13.148.14@CHR disabled=yes generate-policy=port-override mode-config=common-setup peer=MIC-OUTER-STATIC-IP-RANGE policy-template-group=outside-ipsec-encryption
/ip ipsec identity add comment=to-ANNA-traffic-only-encryption-PSK generate-policy=port-strict mode-config=common-setup peer=ANNA-INNER policy-template-group=inside-ipsec-encryption
/ip ipsec identity add auth-method=digital-signature certificate=S.185.13.148.14@CHR comment=to-ANNA-outer-tunnel-encryption-RSA generate-policy=port-override mode-config=common-setup peer=ANNA-OUTER-IP-REMOTE-CONTROLLABLE policy-template-group=outside-ipsec-encryption
/ip ipsec identity add auth-method=digital-signature certificate=S.185.13.148.14@CHR disabled=yes generate-policy=port-override mode-config=common-setup peer=ANNA-OUTER-STATIC-IP-RANGE policy-template-group=outside-ipsec-encryption
/ip ipsec policy set 0 disabled=yes
/ip ipsec policy add comment="Roadwarrior IPSEC TRANSPORT TEMPLATE (outer-tunnel encryption)" disabled=yes dst-address=10.10.10.8/29 group=roadwarrior-ipsec proposal="IPSEC IKEv2 VPN PHASE2 IOS/OSX" src-address=0.0.0.0/0 template=yes
/ip ipsec policy add comment="Common IPSEC TUNNEL TEMPLATE (traffic-only encryption) MIKROUTER" dst-address=192.168.99.0/24 group=inside-ipsec-encryption proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" src-address=192.168.97.0/29 template=yes
/ip ipsec policy add comment=MIC-OUTER-IP-REMOTE-CONTROLLABLE dst-address=85.174.195.133/32 group=outside-ipsec-encryption proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=185.13.148.14/32 template=yes
/ip ipsec policy add comment=ANNA-OUTER-IP-REMOTE-CONTROLLABLE dst-address=46.39.51.172/32 group=outside-ipsec-encryption proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=185.13.148.14/32 template=yes
/ip ipsec policy add comment="Common IPSEC TRANSPORT TEMPLATE (outer-tunnel encryption, MGTS dst-IP range 2)" disabled=yes dst-address=91.79.0.0/16 group=outside-ipsec-encryption proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=185.13.148.14/32 template=yes
/ip ipsec policy add comment="Common IPSEC TUNNEL TEMPLATE (traffic-only encryption) ANNA" dst-address=192.168.90.0/24 group=inside-ipsec-encryption proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" src-address=192.168.97.0/29 template=yes
/ip route add check-gateway=ping comment=GLOBAL disabled=no distance=10 dst-address=0.0.0.0/0 gateway=185.13.148.1
/ip service set telnet disabled=yes
/ip service set ssh port=2222
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip smb set allow-guests=no
/ip ssh set allow-none-crypto=yes always-allow-password-login=yes forwarding-enabled=remote
/ip upnp set show-dummy-rule=no
/ppp secret add local-address=10.0.0.1 name=vpn-remote-mic profile=l2tp-no-encrypt-site2site remote-address=10.0.0.2 service=l2tp
/ppp secret add local-address=10.0.0.1 name=vpn-remote-anna profile=l2tp-no-encrypt-site2site remote-address=10.0.0.3 service=l2tp
/routing filter rule add chain=ospf-in comment="discard intra area routes" disabled=no rule="if ( protocol ospf && ospf-type intra) { set comment DISCARDED-INTRA-AREA ; reject; }"
/routing filter rule add chain=ospf-in comment="accept DEFAULT ROUTE" disabled=no rule="if ( protocol ospf && dst-len==0) { set pref-src 10.0.0.1 ; set comment GLOBAL-VPN ; accept; }"
/routing filter rule add chain=ospf-in comment="accept inter area routes" disabled=no rule="if ( protocol ospf && ospf-type inter) { set comment LOCAL-AREA ; set pref-src 10.0.0.1 ; accept; }"
/routing filter rule add chain=ospf-in comment="DROP OTHERS" disabled=no rule="reject;"
/routing ospf interface-template add area=chr-space-main auth-id=1 auth-key="" cost=10 disabled=no interfaces="main infrastructure" networks=192.168.97.0/29 passive priority=1
/routing ospf interface-template add area=backbone comment="ANNA routes" disabled=no interfaces=tunnel-anna networks=10.0.0.0/29 type=ptp
/routing ospf interface-template add area=backbone comment="MIKROTIK routes" disabled=yes interfaces=tunnel-mikrotik networks=10.0.0.0/29 type=ptp
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-community=globus trap-generators=interfaces trap-interfaces="main infrastructure" trap-version=2
/system clock set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity set name=CHR
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
/system logging add action=EmailOnScreenLog topics=e-mail
/system note set note="Idenity: CHR | Uptime:  03:04:09 | Public IP:  185.13.148.14 | "
/system ntp client set enabled=yes
/system ntp client servers add address=85.21.78.91
/system ntp client servers add address=46.254.216.9
/system scheduler add interval=5d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=aug/04/2020 start-time=21:00:00
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=15:55:00
/system scheduler add interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=08:00:00
/system scheduler add interval=10m name=doIPSECPunch on-event="/system script run doIPSECPunch" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/07/2019 start-time=09:00:00
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=7m name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jan/26/2022 start-time=14:34:19
/system scheduler add interval=10m name=doCoolConsole on-event="/system script run doCoolConsole" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=apr/08/2023 start-time=16:06:04
/system script add dont-require-permissions=yes name=doBackup owner=owner policy=ftp,read,write,policy,test,password,sensitive source=":global globalScriptBeforeRun;\r\r\
    \n\$globalScriptBeforeRun \"doBackup\";\r\r\
    \n\r\r\
    \n:local sysname [/system identity get name]\r\r\
    \n:local rosVer [:tonum [:pick [/system resource get version] 0 1]]\r\r\
    \n\r\r\
    \n:local sysver \"NA\"\r\r\
    \n:if ( [ :len [ /system package find where name=\"system\" and disabled=no ] ] = 0 and \$rosVer = 6 ) do={\r\r\
    \n  :local sysver [/system package get system version]\r\r\
    \n}\r\r\
    \n:if ( [ :len [ /system package find where name=\"routeros\" and disabled=no ] ] = 0 and \$rosVer = 7 ) do={\r\r\
    \n  :local sysver [/system package get routeros version]\r\r\
    \n}\r\r\
    \n\r\r\
    \n:local scriptname \"doBackup\"\r\r\
    \n:local saveSysBackup true\r\r\
    \n:local encryptSysBackup false\r\r\
    \n:local saveRawExport true\r\r\
    \n:local verboseRawExport false\r\r\
    \n:local state \"\"\r\r\
    \n\r\r\
    \n:local ts [/system clock get time]\r\r\
    \n:set ts ([:pick \$ts 0 2].[:pick \$ts 3 5].[:pick \$ts 6 8])\r\r\
    \n:local ds [/system clock get date]\r\r\
    \n:set ds ([:pick \$ds 7 11].[:pick \$ds 0 3].[:pick \$ds 4 6])\r\r\
    \n\r\r\
    \n#directories have to exist!\r\r\
    \n:local FTPEnable true\r\r\
    \n:local FTPServer \"nas.home\"\r\r\
    \n:local FTPPort 21\r\r\
    \n:local FTPUser \"git\"\r\r\
    \n:local FTPPass \"git\"\r\r\
    \n:local FTPRoot \"/REPO/backups/\"\r\r\
    \n:local FTPGitEnable true\r\r\
    \n:local FTPRawGitName \"/REPO/mikrobackups/rawconf_\$sysname_latest.rsc\"\r\r\
    \n\r\r\
    \n:local SMTPEnable true\r\r\
    \n:local SMTPAddress \"defm.kopcap@gmail.com\"\r\r\
    \n:local SMTPSubject (\"\$sysname Full Backup (\$ds-\$ts)\")\r\r\
    \n:local SMTPBody (\"\$sysname full Backup file see in attachment.\\nRouterOS version: \$sysver\\nTime and Date stamp: (\$ds-\$ts) \")\r\r\
    \n\r\r\
    \n:global globalNoteMe;\r\r\
    \n\r\r\
    \n:local itsOk true;\r\r\
    \n\r\r\
    \n:do {\r\r\
    \n  :local smtpserv [:resolve \"\$FTPServer\"];\r\r\
    \n} on-error={ \r\r\
    \n  :set state \"FTP server looks like to be unreachable\"\r\r\
    \n  \$globalNoteMe value=\$state;\r\r\
    \n  :set itsOk false;\r\r\
    \n}\r\r\
    \n\r\r\
    \n:local fname (\"BACKUP-\$sysname-\$ds-\$ts\")\r\r\
    \n\r\r\
    \n:if (\$saveSysBackup and \$itsOk) do={\r\r\
    \n  :if (\$encryptSysBackup = true) do={ /system backup save name=(\$fname.\".backup\") }\r\r\
    \n  :if (\$encryptSysBackup = false) do={ /system backup save dont-encrypt=yes name=(\$fname.\".backup\") }\r\r\
    \n  :delay 2s;\r\r\
    \n  \$globalNoteMe value=\"System Backup Finished\"\r\r\
    \n}\r\r\
    \n\r\r\
    \n:if (\$saveRawExport and \$itsOk) do={\r\r\
    \n  :if (\$FTPGitEnable ) do={\r\r\
    \n     #do not apply hide-sensitive flag\r\r\
    \n     :if (\$verboseRawExport = true) do={ /export terse verbose file=(\$fname.\".safe.rsc\") }\r\r\
    \n     :if (\$verboseRawExport = false) do={ /export terse file=(\$fname.\".safe.rsc\") }\r\r\
    \n     :delay 2s;\r\r\
    \n  }\r\r\
    \n  \$globalNoteMe value=\"Raw configuration script export Finished\"\r\r\
    \n}\r\r\
    \n\r\r\
    \n:delay 5s\r\r\
    \n\r\r\
    \n:local buFile \"\"\r\r\
    \n\r\r\
    \n:foreach backupFile in=[/file find] do={\r\r\
    \n  :set buFile ([/file get \$backupFile name])\r\r\
    \n  :if ([:typeof [:find \$buFile \$fname]] != \"nil\" and \$itsOk) do={\r\r\
    \n    :local itsSRC ( \$buFile ~\".safe.rsc\")\r\r\
    \n    if (\$FTPEnable and \$itsOk) do={\r\r\
    \n        :do {\r\r\
    \n        :set state \"Uploading \$buFile to FTP (\$FTPRoot\$buFile)\"\r\r\
    \n        \$globalNoteMe value=\$state\r\r\
    \n        /tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\"\$FTPRoot\$buFile\" mode=ftp upload=yes\r\r\
    \n        \$globalNoteMe value=\"Done\"\r\r\
    \n        } on-error={ \r\r\
    \n          :set state \"Error When \$state\"\r\r\
    \n          \$globalNoteMe value=\$state;\r\r\
    \n          :set itsOk false;\r\r\
    \n       }\r\r\
    \n\r\r\
    \n        #special ftp upload for git purposes\r\r\
    \n        if (\$itsSRC and \$FTPGitEnable and \$itsOk) do={\r\r\
    \n            :do {\r\r\
    \n            :set state \"Uploading \$buFile to GIT-FTP (RAW, \$FTPRawGitName)\"\r\r\
    \n            \$globalNoteMe value=\$state\r\r\
    \n            /tool fetch address=\$FTPServer port=\$FTPPort src-path=\$buFile user=\$FTPUser password=\$FTPPass dst-path=\"\$FTPRawGitName\" mode=ftp upload=yes\r\r\
    \n            \$globalNoteMe value=\"Done\"\r\r\
    \n            } on-error={ \r\r\
    \n              :set state \"Error When \$state\"\r\r\
    \n              \$globalNoteMe value=\$state;\r\r\
    \n              :set itsOk false;\r\r\
    \n           }\r\r\
    \n        }\r\r\
    \n\r\r\
    \n    }\r\r\
    \n    if (\$SMTPEnable and !\$itsSRC and \$itsOk) do={\r\r\
    \n        :do {\r\r\
    \n        :set state \"Uploading \$buFile to SMTP\"\r\r\
    \n        \$globalNoteMe value=\$state\r\r\
    \n\r\r\
    \n        #email works in background, delay needed\r\r\
    \n        /tool e-mail send to=\$SMTPAddress body=\$SMTPBody subject=\$SMTPSubject file=\$buFile tls=starttls\r\r\
    \n\r\r\
    \n        #waiting for email to be delivered\r\r\
    \n        :delay 15s;\r\r\
    \n\r\r\
    \n        :local emlResult ([/tool e-mail get last-status] = \"succeeded\")\r\r\
    \n\r\r\
    \n        if (!\$emlResult) do={\r\r\
    \n\r\r\
    \n          :set state \"Error When \$state\"\r\r\
    \n          \$globalNoteMe value=\$state;\r\r\
    \n          :set itsOk false;\r\r\
    \n\r\r\
    \n        } else={\r\r\
    \n\r\r\
    \n          \$globalNoteMe value=\"Done\"\r\r\
    \n       \r\r\
    \n        }\r\r\
    \n\r\r\
    \n        } on-error={ \r\r\
    \n          :set state \"Error When \$state\"\r\r\
    \n          \$globalNoteMe value=\$state;\r\r\
    \n          :set itsOk false;\r\r\
    \n       }\r\r\
    \n    }\r\r\
    \n\r\r\
    \n    :delay 2s;\r\r\
    \n    /file remove \$backupFile;\r\r\
    \n\r\r\
    \n  }\r\r\
    \n}\r\r\
    \n\r\r\
    \n:local inf \"\"\r\r\
    \n:if (\$itsOk) do={\r\r\
    \n  :set inf \"\$scriptname on \$sysname: Automatic Backup Completed Successfully\"\r\r\
    \n}\r\r\
    \n\r\r\
    \n:if (!\$itsOk) do={\r\r\
    \n  :set inf \"Error When \$scriptname on \$sysname: \$state\"  \r\r\
    \n}\r\r\
    \n\r\r\
    \n\$globalNoteMe value=\$inf\r\r\
    \n\r\r\
    \n:if (!\$itsOk) do={\r\r\
    \n\r\r\
    \n  :global globalTgMessage;\r\r\
    \n  \$globalTgMessage value=\$inf;\r\r\
    \n  \r\r\
    \n}\r\r\
    \n\r\
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
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=doCertificatesIssuing owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n:local UpdateList [:toarray \"doBackup,doEnvironmentSetup,doEnvironmentClearance,doRandomGen,doFreshTheScripts,doCertificatesIssuing,doNetwatchHost, doIPSECPunch,doStartupScript,doHeatFlag,doPeriodicLogDump,doPeriodicLogParse,doTelegramNotify,doLEDoff,doLEDon,doCPUHighLoadReboot,doUpdatePoliciesRemotely,doUpdateExternalDNS,doSuperviseCHRviaSSH,doCoolConsole\"];\r\
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
    \n    :local arpInterface \"main-infrastructure-br\";\r\
    \n    :local state (\"Adding new network member... \");\r\
    \n\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    # incoming named params\r\
    \n    :local newIp [ :tostr \$ip ];\r\
    \n    :local newBlockedIp [ :tostr \$gip ];\r\
    \n    :local newMac [ :tostr \$mac ];\r\
    \n    :local comment [ :tostr \$comm ];\r\
    \n    :local newSsid [ :tostr \$ssid ];\r\
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
    \n        \$globalNoteMe value=\$state;       \r\
    \n        /ip dhcp-server lease remove [find address=\$newIp];\r\
    \n        /ip dhcp-server lease remove [find mac-address=\$newMac];\r\
    \n\r\
    \n        :local state (\"Adding DHCP configuration for (\$newIp/\$newMac) on \$mainDHCP\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        \r\
    \n       :if ([ :len [ /ip dhcp-server find where name=\"\$mainDHCP\" ] ] > 0) do={\r\
    \n            /ip dhcp-server lease add address=\$newIp mac-address=\$newMac server=\$mainDHCP comment=\$comment;\r\
    \n            :local state (\"Done.\");\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n       } else={\r\
    \n        :local state (\"Cant find DHCP server \$mainDHCP. SKIPPED.\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n       }\r\
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
    \n\r\
    \n       :if ([ :len [ /ip dhcp-server find where name=\"\$guestDHCP\" ] ] > 0) do={\r\
    \n          /ip dhcp-server lease add address=\$newBlockedIp block-access=yes mac-address=\$newMac server=\$guestDHCP comment=(\$comment . \"(blocked)\");\r\
    \n          :local state (\"Done.\");\r\
    \n          \$globalNoteMe value=\$state;\r\
    \n       } else={\r\
    \n        :local state (\"Cant find DHCP server \$guestDHCP. SKIPPED.\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n       }\r\
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
    \n\r\
    \n     :if ([ :len [ /interface find where name=\"\$arpInterface\" ] ] > 0) do={\r\
    \n        /ip arp add address=\$newIp interface=\$arpInterface mac-address=\$newMac comment=\$comment\r\
    \n        :local state (\"Done.\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n       } else={\r\
    \n        :local state (\"Cant find interface \$arpInterface. SKIPPED.\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n       }\r\
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
    \n        :local state (\"Adding CAPs ACL static entries for (\$newBlockedIp/\$newMac) on \$newSsid\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        /caps-man access-list remove [find mac-address=\$newMac];\r\
    \n        /caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=\$comment disabled=no mac-address=\$newMac ssid-regexp=\"\$newSsid\" place-before=1\r\
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
    \n                :set tname \"\$USERNAME@\$scepAlias\";\r\
    \n\r\
    \n                /certificate add name=\"\$tname\" common-name=\"\$USERNAME@\$scepAlias\" subject-alt-name=\"IP:\$USERNAME,DNS:\$fakeDomain\" key-usage=\$prefs country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365;\r\
    \n\r\
    \n            } else={\r\
    \n\r\
    \n                :local state \"CLIENT TEMPLATE certificates generation as EMAIL...  \$USERNAME\";\r\
    \n                \$globalNoteMe value=\$state;\r\
    \n\r\
    \n                :set tname \"\$USERNAME@\$scepAlias\";\r\
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
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doUpdateExternalDNS owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doCoolConsole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doCoolConsole\";\r\
    \n\r\
    \n:local content \"\"\r\
    \n:local logcontenttemp \"\"\r\
    \n:local logcontent \"\"\r\
    \n \r\
    \n:set logcontenttemp \"Idenity: \$[/system identity get name]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" | \")\r\
    \n:set logcontenttemp \"Uptime:  \$[/system resource get uptime]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" | \")\r\
    \n:set logcontenttemp \"Public IP:  \$[/ip cloud get public-address]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" | \")\r\
    \n\r\
    \n/system note set note=\"\$logcontent\"  \r\
    \n"
/tool bandwidth-server set authenticate=no
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com port=587 tls=starttls user=defm.kopcap@gmail.com
/tool netwatch add disabled=no down-script=":global NetwatchHostName \"mikrouter.home\";\r\
    \n/system script run doNetwatchHost;" host=192.168.99.1 interval=1m timeout=1s type=simple up-script=":global NetwatchHostName \"mikrouter.home\";\r\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-port=https streaming-server=192.168.99.170
