# may/04/2023 16:57:32 by RouterOS 7.9
# software id = 
#
/interface bridge add arp=proxy-arp fast-forward=no name=main-infrastructure-br
/interface bridge add arp=proxy-arp fast-forward=no name=ospf-loopback-br
/interface ethernet set [ find default-name=ether1 ] arp=proxy-arp disable-running-check=no name=wan
/interface l2tp-server add disabled=yes name=rw-alx user=vpn-user-alx
/interface l2tp-server add name=tunnel-anna user=vpn-remote-anna
/interface l2tp-server add disabled=yes name=tunnel-mikrotik user=vpn-remote-mic
/disk set slot1 disabled=yes type=hardware
/disk set slot2 disabled=yes slot=slot2 type=hardware
/disk set slot3 disabled=yes slot=slot3 type=hardware
/disk set slot4 disabled=yes slot=slot4 type=hardware
/interface list add comment="trusted interfaces" name=list-trusted
/interface list add comment="Semi-Trusted networks" name=list-semi-trusted
/interface list add comment="Untrusted networks" name=list-untrusted
/interface list add comment="FW: winbox allowed interfaces" name=list-winbox-allowed
/interface list add comment="includes l2tp client interfaces when UP" name=list-l2tp-tunnels
/interface list add comment="FW: drop invalid conn" name=list-drop-invalid-connections
/interface list add comment="LAN intefaces" name=list-autodetect-LAN
/interface list add comment="WAN interfaces" name=list-autodetect-WAN
/interface list add comment="Internet interfaces" name=list-autodetect-INTERNET
/interface list add comment="neighbors allowed interfaces" name=list-neighbors-lookup
/interface list add comment="infrastructure OSPF interfaces" name=list-ospf-master
/interface list add comment="support OSPF interfaces" name=list-ospf-bearing
/interface list add comment="FW: allow router cerfices from LAN" name=list-FW-allow-router-services-LAN
/interface list add comment="FW: allow router cerfices from WAN" name=list-FW-allow-router-services-WAN
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=CHR
/ip dhcp-server option add code=15 name=DomainName value="s'home'"
/ip ipsec policy group add name=roadwarrior-s
/ip ipsec policy group add name=roaming-s
/ip ipsec policy group add name=moscow-s
/ip ipsec policy group add name=spring-s
/ip ipsec profile set [ find default=yes ] dh-group=modp1024
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=ROUTEROS
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=IOS/OSX
/ip ipsec profile add dh-group=modp1024 enc-algorithm=aes-256 hash-algorithm=sha256 name=WINDOWS
/ip ipsec peer add address=10.0.0.3/32 comment="IPSEC IKEv2 VPN PHASE1 (ANNA, traffic-only encryption)" local-address=10.0.0.1 name=ANNA-INNER passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add address=10.0.0.2/32 comment="IPSEC IKEv2 VPN PHASE1 (MIC, traffic-only encryption)" disabled=yes local-address=10.0.0.1 name=ANY-INNER passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add comment="IPSEC IKEv2 VPN PHASE1 (IOS/OSX)" disabled=yes exchange-mode=ike2 local-address=185.13.148.14 name=RW passive=yes profile=IOS/OSX send-initial-contact=no
/ip ipsec peer add comment="IPSEC IKEv2 VPN PHASE1 (ANY, outer-tunnel encryption, RSA, port-override, remotely updated via SSH)" exchange-mode=ike2 local-address=185.13.148.14 name=ANY-OUTER-IP-REMOTE-CONTROLLABLE passive=yes profile=ROUTEROS send-initial-contact=no
/ip ipsec peer add comment="IPSEC IKEv2 VPN PHASE1 (WINDOWS)" disabled=yes name=WIN passive=yes profile=WINDOWS send-initial-contact=no
/ip ipsec proposal set [ find default=yes ] disabled=yes enc-algorithms=aes-256-cbc,aes-192-cbc,aes-128-cbc,3des lifetime=1h
/ip ipsec proposal add enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 WINDOWS" pfs-group=none
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc name="IPSEC IKEv2 VPN PHASE2 MIKROTIK"
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc lifetime=8h name="IPSEC IKEv2 VPN PHASE2 IOS/OSX" pfs-group=none
/ip kid-control add fri=0s-1d mon=0s-1d name=totals sat=0s-1d sun=0s-1d thu=0s-1d tue=0s-1d wed=0s-1d
/ip pool add name=pool-vpn ranges=10.0.0.0/29
/ip pool add name=pool-dhcp ranges=192.168.97.0/29
/ip pool add name=pool-rw ranges=10.10.10.8/29
/ip dhcp-server add add-arp=yes address-pool=pool-dhcp authoritative=after-2sec-delay interface=main-infrastructure-br lease-time=1d name=main-dhcp-server
/ip ipsec mode-config add address-pool=pool-vpn address-prefix-length=30 name=common-setup static-dns=8.8.8.8 system-dns=no
/ip ipsec mode-config add address-pool=pool-rw address-prefix-length=32 name=roadwarrior-setup
/port set 0 name=serial0
/port set 1 name=serial1
/ppp profile add address-list=l2tp-active-clients dns-server=8.8.8.8,8.8.4.4 interface-list=list-l2tp-tunnels local-address=10.0.0.1 name=l2tp-no-encrypt-site2site only-one=no remote-address=pool-vpn use-ipv6=no
/ppp profile add address-list=l2tp-active-clients dns-server=8.8.8.8,8.8.4.4 interface-list=list-l2tp-tunnels local-address=10.0.0.1 name=l2tp-no-encrypt-ios-rw only-one=no remote-address=pool-rw
/routing bgp template set default disabled=no output.network=bgp-networks
/routing id add comment="OSPF Common" id=10.255.255.1 name=chr-10.255.255.1
/routing ospf instance add comment="OSPF Common - inject into \"main\" table" disabled=no in-filter-chain=ospf-in name=routes-inject-into-main originate-default=never redistribute="" router-id=chr-10.255.255.1
/routing ospf area add disabled=no instance=routes-inject-into-main name=backbone
/routing ospf area add area-id=0.0.0.1 default-cost=10 disabled=no instance=routes-inject-into-main name=chr-space-main no-summaries type=stub
/routing table add fib name=mark-site-over-vpn
/routing table add comment="tunnel swing" fib name=rmark-vpn-redirect
/routing table add comment="tunnel swing" fib name=rmark-telegram-redirect
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action set 0 memory-lines=300
/system logging action set 1 disk-file-name=journal disk-lines-per-file=500
/system logging action add memory-lines=300 name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=1 disk-file-name=ScriptsDiskLog disk-lines-per-file=500 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=20 disk-file-name=ErrorDiskLog disk-lines-per-file=500 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add memory-lines=300 name=OnScreenLog target=memory
/system logging action add memory-lines=300 name=DHCPOnScreenLog target=memory
/system logging action add memory-lines=300 name=DNSOnScreenLog target=memory
/system logging action add memory-lines=300 name=RouterControlLog target=memory
/system logging action add memory-lines=300 name=OSPFOnscreenLog target=memory
/system logging action add memory-lines=300 name=L2TPOnScreenLog target=memory
/system logging action add disk-file-count=20 disk-file-name=AuthDiskLog disk-lines-per-file=500 name=AuthDiskLog target=disk
/system logging action add memory-lines=300 name=CertificatesOnScreenLog target=memory
/system logging action add memory-lines=300 name=ParseMemoryLog target=memory
/system logging action add memory-lines=300 name=CAPSOnScreenLog target=memory
/system logging action add memory-lines=300 name=FirewallOnScreenLog target=memory
/system logging action add memory-lines=300 name=SSHOnScreenLog target=memory
/system logging action add memory-lines=300 name=PoEOnscreenLog target=memory
/system logging action add memory-lines=300 name=EmailOnScreenLog target=memory
/system logging action add memory-lines=300 name=NTPOnscreenLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!write,!policy,!sensitive
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!policy,!sensitive
/certificate scep-server add ca-cert=ca@CHR days-valid=365 next-ca-cert=ca@CHR path=/scep/grant request-lifetime=5m
/certificate settings set crl-download=yes crl-use=yes
#error exporting /interface/bridge/calea
/interface bridge settings set use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes
/ip neighbor discovery-settings set discover-interface-list=list-neighbors-lookup
/ip settings set accept-source-route=yes allow-fast-path=no max-neighbor-entries=8192 rp-filter=loose tcp-syncookies=yes
/ipv6 settings set disable-ipv6=yes max-neighbor-entries=8192
/interface detect-internet set detect-interface-list=all internet-interface-list=list-autodetect-INTERNET lan-interface-list=list-autodetect-LAN wan-interface-list=list-autodetect-WAN
/interface l2tp-server server set authentication=mschap2 default-profile=l2tp-no-encrypt-site2site enabled=yes keepalive-timeout=60 max-mru=1360 max-mtu=1360
/interface list member add comment=GERMANY interface=wan list=list-untrusted
/interface list member add comment=LAN interface=main-infrastructure-br list=list-trusted
/interface list member add comment="DISCOVERY: allow neighbors lookup" interface=tunnel-mikrotik list=list-neighbors-lookup
/interface list member add comment="DISCOVERY: allow neighbors lookup" interface=main-infrastructure-br list=list-neighbors-lookup
/interface list member add comment="DISCOVERY: allow neighbors lookup" interface=tunnel-anna list=list-neighbors-lookup
/interface list member add comment=OSPF interface=tunnel-mikrotik list=list-ospf-bearing
/interface list member add comment=OSPF interface=tunnel-anna list=list-ospf-bearing
/interface list member add comment=OSPF interface=ospf-loopback-br list=list-ospf-bearing
/interface list member add comment="FW: winbox allowed" interface=main-infrastructure-br list=list-winbox-allowed
/interface list member add comment="FW: winbox allowed" interface=wan list=list-winbox-allowed
/interface list member add comment="FW: drop invalid" interface=wan list=list-drop-invalid-connections
/interface list member add comment="FW: allow router cerfices from LAN" interface=main-infrastructure-br list=list-FW-allow-router-services-LAN
/interface list member add comment="FW: allow router cerfices from WAN" interface=wan list=list-FW-allow-router-services-WAN
/interface list member add comment=OSPF interface=main-infrastructure-br list=list-ospf-master
/ip address add address=192.168.97.1/29 comment="local IP" interface=main-infrastructure-br network=192.168.97.0
/ip address add address=10.255.255.1 comment="ospf router-id binding" interface=ospf-loopback-br network=10.255.255.1
/ip cloud set ddns-enabled=yes ddns-update-interval=10m
/ip dhcp-client add add-default-route=no dhcp-options=clientid,hostname interface=wan
/ip dhcp-server network add address=10.0.0.0/29 dns-server=8.8.8.8,8.8.4.4 gateway=10.0.0.1
/ip dhcp-server network add address=192.168.97.0/29 gateway=192.168.97.1
/ip dns set cache-max-ttl=1d max-concurrent-queries=200 max-concurrent-tcp-sessions=30 query-server-timeout=3s
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
/ip firewall address-list add address=192.168.97.0/24 list=alist-fw-local-subnets
/ip firewall address-list add address=192.168.97.0/24 list=alist-nat-local-subnets
/ip firewall address-list add address=0.0.0.0/8 comment="RFC 1122 \"This host on this network\"" list=alist-fw-rfc-special
/ip firewall address-list add address=10.0.0.0/8 comment="RFC 1918 (Private Use IP Space)" list=alist-fw-rfc-special
/ip firewall address-list add address=100.64.0.0/10 comment="RFC 6598 (Shared Address Space)" list=alist-fw-rfc-special
/ip firewall address-list add address=127.0.0.0/8 comment="RFC 1122 (Loopback)" list=alist-fw-rfc-special
/ip firewall address-list add address=169.254.0.0/16 comment="RFC 3927 (Dynamic Configuration of IPv4 Link-Local Addresses)" list=alist-fw-rfc-special
/ip firewall address-list add address=172.16.0.0/12 comment="RFC 1918 (Private Use IP Space)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.0.0.0/24 comment="RFC 6890 (IETF Protocol Assingments)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.0.2.0/24 comment="RFC 5737 (Test-Net-1)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.168.0.0/16 comment="RFC 1918 (Private Use IP Space)" list=alist-fw-rfc-special
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
/ip firewall address-list add address=4.2.2.2 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=185.6.175.49 comment="Manual Black List" list=alist-fw-manual-block
/ip firewall address-list add address=192.168.97.0/24 list=alist-fw-rdp-allow
/ip firewall address-list add address=192.168.97.0/24 list=alist-fw-smb-allow
/ip firewall address-list add address=185.13.148.14 list=alist-fw-vpn-server-addr
/ip firewall address-list add address=rutracker.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.97.0/24 list=alist-fw-vpn-subnets
/ip firewall address-list add address=10.0.0.0/29 list=alist-fw-vpn-server-addr
/ip firewall address-list add address=10.0.0.0/29 list=alist-fw-vpn-subnets
/ip firewall address-list add address=nnmclub.me list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=10.0.0.0/29 list=alist-fw-local-subnets
/ip firewall address-list add address=10.0.0.0/29 list=alist-nat-local-subnets
/ip firewall address-list add address=myexternalip.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=serverfault.com list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=telegram.org list=alist-fw-telegram-servers
/ip firewall address-list add address=grafana.home list=alist-nat-grafana-server
/ip firewall address-list add address=grafanasvc.home list=alist-nat-grafana-service
/ip firewall address-list add address=influxdb.home list=alist-nat-influxdb-server
/ip firewall address-list add address=influxdbsvc.home list=alist-nat-influxdb-service
/ip firewall address-list add address=192.168.97.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=10.0.0.1 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=185.13.148.14 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=185.13.148.14 list=alist-nat-external-ip
#error exporting /ip/firewall/calea
/ip firewall filter add action=log chain=input disabled=yes protocol=ipsec-ah
/ip firewall filter add action=accept chain=input disabled=yes port=8291 protocol=tcp
/ip firewall filter add action=drop chain=input comment="Drop Invalid Connections (HIGH PRIORIRY RULE)" connection-state=invalid disabled=yes in-interface-list=list-drop-invalid-connections
/ip firewall filter add action=drop chain=forward comment="Drop Invalid Connections (HIGH PRIORIRY RULE)" connection-state=invalid disabled=yes dst-address-list=!alist-fw-vpn-subnets
/ip firewall filter add action=accept chain=forward comment="Accept Related or Established Connections (HIGH PRIORIRY RULE)" connection-state=established,related disabled=yes log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=accept chain=input comment="OSFP neighbour-ing allow" disabled=yes log-prefix=~~~OSFP protocol=ospf
/ip firewall filter add action=accept chain=input comment="Allow mikrotik self-discovery" disabled=yes dst-address-type=broadcast dst-port=5678 protocol=udp
/ip firewall filter add action=accept chain=forward comment="Allow mikrotik neighbor-discovery" disabled=yes dst-address-type=broadcast dst-port=5678 protocol=udp
/ip firewall filter add action=jump chain=input comment="VPN Access" disabled=yes jump-target=chain-vpn-rules
/ip firewall filter add action=accept chain=chain-vpn-rules comment="L2TP tunnel" disabled=yes dst-port=1701 log=yes log-prefix=~~~L2TP protocol=udp
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IPSec-ah\"" disabled=yes log=yes log-prefix=~~~VPN protocol=ipsec-ah src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IPSec-esp\"" disabled=yes log=yes log-prefix=~~~VPN_FRW protocol=ipsec-esp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IKE\" - IPSEC connection establishing" disabled=yes dst-port=500 log=yes log-prefix=~~~VPN_FRW protocol=udp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow UDP\" - IPSEC data trasfer" disabled=yes dst-port=4500 log=yes log-prefix=~~~VPN_FRW protocol=udp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=return chain=chain-vpn-rules comment="VPN Access" disabled=yes
/ip firewall filter add action=accept chain=forward comment=VPN disabled=yes dst-address-list=alist-fw-vpn-subnets log-prefix=~~~VPN_FRW src-address-list=alist-fw-local-subnets
/ip firewall filter add action=accept chain=forward comment=VPN disabled=yes dst-address-list=alist-fw-local-subnets log-prefix=~~~VPN_FRW src-address-list=alist-fw-vpn-subnets
/ip firewall filter add action=jump chain=forward comment="Jump to chain-rdp-staged-control" disabled=yes jump-target=chain-rdp-staged-control
/ip firewall filter add action=drop chain=chain-rdp-staged-control comment="drop rdp brute forcers" disabled=yes dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-block
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-block address-list-timeout=10h chain=chain-rdp-staged-control connection-state=new disabled=yes dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage3 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new disabled=yes dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage2 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new disabled=yes dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage1 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new disabled=yes dst-port=3389 protocol=tcp src-address-list=!alist-fw-rdp-allow
/ip firewall filter add action=return chain=chain-rdp-staged-control comment="Return From chain-rdp-staged-control" disabled=yes
/ip firewall filter add action=jump chain=forward comment="jump to chain-smb-staged-control" disabled=yes jump-target=chain-smb-staged-control src-address-list=!alist-fw-smb-allow
/ip firewall filter add action=add-src-to-address-list address-list=alist-smb-shares-track address-list-timeout=10h chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" disabled=yes dst-port=137-139,445 log-prefix=~~~SMB protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list=alist-smb-shares-track address-list-timeout=10h chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" disabled=yes dst-port=137-139,445 log-prefix=~~~SMB protocol=tcp
/ip firewall filter add action=drop chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" disabled=yes dst-port=137-139,445 log-prefix=~~~SMB protocol=tcp src-address-list=alist-smb-shares-track
/ip firewall filter add action=drop chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" disabled=yes dst-port=137-139,445 log-prefix=~~~SMB protocol=udp src-address-list=alist-smb-shares-track
/ip firewall filter add action=return chain=chain-smb-staged-control comment="Return from chain-smb-staged-control" disabled=yes
/ip firewall filter add action=drop chain=input comment="drop ftp brute forcers" disabled=yes dst-port=21 protocol=tcp src-address-list=alist-fw-ftp-block
/ip firewall filter add action=accept chain=output comment="drop ftp brute forcers" content="530 Login incorrect" disabled=yes dst-limit=1/1m,9,dst-address/1m protocol=tcp
/ip firewall filter add action=add-dst-to-address-list address-list=alist-fw-ftp-block address-list-timeout=3h chain=output comment="drop ftp brute forcers" content="530 Login incorrect" disabled=yes protocol=tcp
/ip firewall filter add action=jump chain=input comment="Jump to DNS Amplification" disabled=yes jump-target=chain-dns-amp-attack
/ip firewall filter add action=accept chain=chain-dns-amp-attack comment="Make exceptions for DNS" disabled=yes log-prefix=~~~DNS port=53 protocol=udp src-address-list=alist-fw-dns-allow
/ip firewall filter add action=accept chain=chain-dns-amp-attack comment="Make exceptions for DNS" disabled=yes dst-address-list=alist-fw-dns-allow log-prefix=~~~DNS port=53 protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-dns-amp-block address-list-timeout=10h chain=chain-dns-amp-attack comment="Add DNS Amplification to Blacklist" disabled=yes log=yes log-prefix=~~~~DNS port=53 protocol=udp src-address-list=!alist-fw-dns-allow
/ip firewall filter add action=drop chain=chain-dns-amp-attack comment="Drop DNS Amplification" disabled=yes src-address-list=alist-fw-dns-amp-block
/ip firewall filter add action=return chain=chain-dns-amp-attack comment="Return from DNS Amplification" disabled=yes
/ip firewall filter add action=accept chain=input comment="Self fetch requests" disabled=yes log-prefix=WEB port=80 protocol=tcp
/ip firewall filter add action=jump chain=input comment="Allow router services on the lan" disabled=yes in-interface-list=list-FW-allow-router-services-LAN jump-target=chain-router-services-lan
/ip firewall filter add action=accept chain=chain-router-services-lan comment="Winbox (8291/TCP)" disabled=yes dst-port=8291 protocol=tcp
/ip firewall filter add action=accept chain=chain-router-services-lan comment=SNMP disabled=yes port=161 protocol=udp
/ip firewall filter add action=accept chain=chain-router-services-lan comment=WEB disabled=yes port=80 protocol=tcp
/ip firewall filter add action=return chain=chain-router-services-lan comment="Return from chain-router-services-lan Chain" disabled=yes
/ip firewall filter add action=jump chain=input comment="Allow router services on the wan" disabled=yes in-interface-list=list-FW-allow-router-services-WAN jump-target=chain-router-services-wan
/ip firewall filter add action=drop chain=chain-router-services-wan comment="SSH (2223/TCP)" disabled=yes dst-port=2223 protocol=tcp
/ip firewall filter add action=drop chain=chain-router-services-wan comment="Winbox (8291/TCP)" disabled=yes dst-port=8291 protocol=tcp
/ip firewall filter add action=return chain=chain-router-services-wan comment="Return from chain-router-services-wan Chain" disabled=yes
/ip firewall filter add action=jump chain=input comment="Check for ping flooding" disabled=yes jump-target=chain-detect-ping-flood protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="0:0 and limit for 5 pac/s Allow Ping" disabled=yes icmp-options=0:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="3:3 and limit for 5 pac/s Allow Traceroute" disabled=yes icmp-options=3:3 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="3:4 and limit for 5 pac/s Allow Path MTU Discovery" disabled=yes icmp-options=3:4 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="8:0 and limit for 5 pac/s Allow Ping" disabled=yes icmp-options=8:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="11:0 and limit for 5 pac/s Allow Traceroute" disabled=yes icmp-options=11:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="0:0 and limit for 50 pac/s Allow Ping tool speed-test" disabled=yes icmp-options=0:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="8:0 and limit for 50 pac/s Allow Ping tool speed-test" disabled=yes icmp-options=8:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=drop chain=chain-detect-ping-flood comment="drop everything else" disabled=yes log-prefix="#ICMP DROP" protocol=icmp
/ip firewall filter add action=return chain=chain-detect-ping-flood comment="Return from chain-detect-ping-flood Chain" disabled=yes
/ip firewall filter add action=passthrough chain=forward comment=DUMMY1 disabled=yes log-prefix=~~~DUMMY1 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Manually Added)" disabled=yes src-address-list=alist-fw-manual-block
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Manually Added)" disabled=yes src-address-list=alist-fw-manual-block
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (SSH)" disabled=yes src-address-list=alist-fw-ssh-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (SSH)" disabled=yes src-address-list=alist-fw-ssh-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Telnet)" disabled=yes src-address-list=alist-fw-telnet-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Telnet)" disabled=yes src-address-list=alist-fw-telnet-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Winbox)" disabled=yes src-address-list=alist-fw-winbox-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Winbox)" disabled=yes src-address-list=alist-fw-winbox-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the WAN Port Scanner List" disabled=yes src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the WAN Port Scanner List" disabled=yes src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=passthrough chain=input comment="Drop anyone in the LAN Port Scanner List" disabled=yes src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=passthrough chain=forward comment="Drop anyone in the LAN Port Scanner List" disabled=yes src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=drop chain=input comment="Drop all Bogons" disabled=yes src-address-list=alist-fw-rfc-special
/ip firewall filter add action=drop chain=forward comment="Drop all Bogons" disabled=yes src-address-list=alist-fw-rfc-special
/ip firewall filter add action=passthrough chain=forward comment=DUMMY2 disabled=yes log-prefix=~~~DUMMY2 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC SSH Chain" disabled=yes jump-target=chain-ssh-staged-control
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-ban address-list-timeout=1w3d chain=chain-ssh-staged-control comment="Transfer repeated attempts from SSH Stage 3 to Black-List" connection-state=new disabled=yes dst-port=22 protocol=tcp src-address-list=alist-fw-ssh-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage3 address-list-timeout=1m chain=chain-ssh-staged-control comment="Add succesive attempts to SSH Stage 3" connection-state=new disabled=yes dst-port=22 protocol=tcp src-address-list=alist-fw-ssh-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage2 address-list-timeout=1m chain=chain-ssh-staged-control comment="Add succesive attempts to SSH Stage 2" connection-state=new disabled=yes dst-port=22 protocol=tcp src-address-list=alist-fw-ssh-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage1 address-list-timeout=1m chain=chain-ssh-staged-control comment="Add intial attempt to SSH Stage 1 List" connection-state=new disabled=yes dst-port=22 protocol=tcp
/ip firewall filter add action=return chain=chain-ssh-staged-control comment="Return From RFC SSH Chain" disabled=yes
/ip firewall filter add action=passthrough chain=forward comment=DUMMY3 disabled=yes log-prefix=~~~DUMMY3 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Telnet Chain" disabled=yes jump-target=chain-telnet-staged-control
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-ban address-list-timeout=1w3d chain=chain-telnet-staged-control comment="Transfer repeated attempts from Telnet Stage 3 to Black-List" connection-state=new disabled=yes dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage3 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add succesive attempts to Telnet Stage 3" connection-state=new disabled=yes dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage2 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add succesive attempts to Telnet Stage 2" connection-state=new disabled=yes dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage1 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add Intial attempt to Telnet Stage 1" connection-state=new disabled=yes dst-port=23 protocol=tcp
/ip firewall filter add action=return chain=chain-telnet-staged-control comment="Return From RFC Telnet Chain" disabled=yes
/ip firewall filter add action=passthrough chain=forward comment=DUMMY4 disabled=yes log-prefix=~~~DUMMY4 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Winbox Chain" disabled=yes jump-target=chain-winbox-staged-control
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-ban address-list-timeout=1w3d chain=chain-winbox-staged-control comment="Transfer repeated attempts from Winbox Stage 3 to Black-List" connection-state=new disabled=yes dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage3 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add succesive attempts to Winbox Stage 3" connection-state=new disabled=yes dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage2 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add succesive attempts to Winbox Stage 2" connection-state=new disabled=yes dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage1 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add Intial attempt to Winbox Stage 1" connection-state=new disabled=yes dst-port=8291 protocol=tcp src-address-list=!alist-fw-vpn-subnets
/ip firewall filter add action=return chain=chain-winbox-staged-control comment="Return From RFC Winbox Chain" disabled=yes
/ip firewall filter add action=passthrough chain=forward comment=DUMMY5 disabled=yes log-prefix=~~~DUMMY5 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-port-scanner-ban address-list-timeout=10h chain=input comment="Add TCP Port Scanners to Address List" disabled=yes protocol=tcp psd=40,3s,2,1 src-address-list=!alist-fw-port-scanner-allow
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-port-scanner-ban address-list-timeout=10h chain=forward comment="Add TCP Port Scanners to Address List" disabled=yes protocol=tcp psd=40,3s,2,1 src-address-list=!alist-fw-port-scanner-allow
/ip firewall filter add action=passthrough chain=forward comment=DUMMY6 disabled=yes log-prefix=~~~DUMMY6 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-highload address-list-timeout=1h chain=input comment=alist-fw-highload connection-limit=100,32 disabled=yes protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-highload address-list-timeout=10h chain=forward comment=alist-fw-highload connection-limit=100,32 disabled=yes protocol=tcp
/ip firewall filter add action=jump chain=input comment="Jump to Virus Chain" disabled=yes jump-target=chain-worms-detector
/ip firewall filter add action=drop chain=chain-worms-detector comment=Conficker disabled=yes dst-port=593 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm disabled=yes dst-port=1024-1030 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="ndm requester" disabled=yes dst-port=1363 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="ndm server" disabled=yes dst-port=1364 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="screen cast" disabled=yes dst-port=1368 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=hromgrafx disabled=yes dst-port=1373 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom" disabled=yes dst-port=1080 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=cichlid disabled=yes dst-port=1377 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm disabled=yes dst-port=1433-1434 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dumaru.Y" disabled=yes dst-port=2283 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle" disabled=yes dst-port=2535 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle.C-K" disabled=yes dst-port=2745 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom" disabled=yes dst-port=3127-3128 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Backdoor OptixPro" disabled=yes dst-port=3410 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Sasser" disabled=yes dst-port=5554 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm disabled=yes dst-port=4444 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm disabled=yes dst-port=4444 protocol=udp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle.B" disabled=yes dst-port=8866 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dabber.A-B" disabled=yes dst-port=9898 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dumaru.Y" disabled=yes dst-port=10000 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom.B" disabled=yes dst-port=10080 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop NetBus" disabled=yes dst-port=12345 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Kuang2" disabled=yes dst-port=17300 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop SubSeven" disabled=yes dst-port=27374 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop PhatBot, Agobot, Gaobot" disabled=yes dst-port=65506 protocol=tcp
/ip firewall filter add action=return chain=chain-worms-detector comment="Return From Virus Chain" disabled=yes
/ip firewall filter add action=passthrough chain=forward comment=DUMMY7 disabled=yes log-prefix=~~~DUMMY7 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to \"Manage Common Ports\" Chain" disabled=yes jump-target=chain-self-common-ports
/ip firewall filter add action=accept chain=chain-self-common-ports comment="\"All hosts on this subnet\" Broadcast" disabled=yes src-address=224.0.0.1
/ip firewall filter add action=accept chain=chain-self-common-ports comment="\"All routers on this subnet\" Broadcast" disabled=yes src-address=224.0.0.2
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DVMRP (Distance Vector Multicast Routing Protocol)" disabled=yes src-address=224.0.0.4
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OSPF - All OSPF Routers Broadcast" disabled=yes src-address=224.0.0.5
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OSPF - OSPF DR Routers Broadcast" disabled=yes src-address=224.0.0.6
/ip firewall filter add action=accept chain=chain-self-common-ports comment="RIP Broadcast" disabled=yes src-address=224.0.0.9
/ip firewall filter add action=accept chain=chain-self-common-ports comment="EIGRP Broadcast" disabled=yes src-address=224.0.0.10
/ip firewall filter add action=accept chain=chain-self-common-ports comment="PIM Broadcast" disabled=yes src-address=224.0.0.13
/ip firewall filter add action=accept chain=chain-self-common-ports comment="VRRP Broadcast" disabled=yes src-address=224.0.0.18
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" disabled=yes src-address=224.0.0.19
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" disabled=yes src-address=224.0.0.20
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" disabled=yes src-address=224.0.0.21
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IGMP Broadcast" disabled=yes src-address=224.0.0.22
/ip firewall filter add action=accept chain=chain-self-common-ports comment="GRE Protocol (Local Management)" disabled=yes protocol=gre
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPdata transfer" disabled=yes log-prefix=~~~FTP port=20 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPcontrol (command)" disabled=yes log-prefix=~~~FTP port=21 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPdata transfer  " disabled=yes log-prefix=~~~FTP port=20 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Secure Shell(SSH)" disabled=yes port=22 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Secure Shell(SSH)   " disabled=yes port=22 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment=Telnet disabled=yes port=23 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment=Telnet disabled=yes port=23 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Priv-mail: any privatemailsystem." disabled=yes port=24 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Priv-mail: any privatemailsystem.  " disabled=yes port=24 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Mail Transfer Protocol(SMTP)" disabled=yes port=25 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Mail Transfer Protocol(SMTP)  " disabled=yes port=25 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TIME protocol" disabled=yes port=37 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TIME protocol  " disabled=yes port=37 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="ARPA Host Name Server Protocol & WINS" disabled=yes port=42 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="ARPA Host Name Server Protocol  & WINS  " disabled=yes port=42 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WHOIS protocol" disabled=yes port=43 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WHOIS protocol" disabled=yes port=43 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Domain Name System (DNS)" disabled=yes port=53 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Domain Name System (DNS)" disabled=yes port=53 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Mail Transfer Protocol(RFC 780)" disabled=yes port=57 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="(BOOTP) Server & (DHCP)  " disabled=yes port=67 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="(BOOTP) Client & (DHCP)  " disabled=yes port=68 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Trivial File Transfer Protocol (TFTP)  " disabled=yes port=69 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Gopher protocol" disabled=yes port=70 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Finger protocol" disabled=yes port=79 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Hypertext Transfer Protocol (HTTP)" disabled=yes port=80 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="RemoteTELNETService protocol" disabled=yes port=107 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocolv2 (POP2)" disabled=yes port=109 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocolv3 (POP3)" disabled=yes port=110 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IdentAuthentication Service/Identification Protocol" disabled=yes port=113 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Authentication Service (auth)  " disabled=yes port=113 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple File Transfer Protocol (SFTP)" disabled=yes port=115 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Network Time Protocol(NTP)" disabled=yes port=123 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Name Service" disabled=yes port=137 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Name Service  " disabled=yes port=137 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Datagram Service" disabled=yes port=138 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Datagram Service  " disabled=yes port=138 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Session Service" disabled=yes port=139 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Session Service  " disabled=yes port=139 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP)" disabled=yes port=143 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Background File Transfer Program (BFTP)" disabled=yes port=152 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Background File Transfer Program (BFTP)  " disabled=yes port=152 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SGMP,Simple Gateway Monitoring Protocol" disabled=yes port=153 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SGMP,Simple Gateway Monitoring Protocol  " disabled=yes port=153 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DMSP, Distributed Mail Service Protocol" disabled=yes port=158 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DMSP, Distributed Mail Service Protocol  " disabled=yes port=158 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management Protocol(SNMP)  " disabled=yes port=161 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management ProtocolTrap (SNMPTRAP)" disabled=yes port=162 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management ProtocolTrap (SNMPTRAP)  " disabled=yes port=162 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGP (Border Gateway Protocol)" disabled=yes port=179 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP), version 3" disabled=yes port=220 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP), version 3" disabled=yes port=220 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGMP, Border Gateway Multicast Protocol" disabled=yes port=264 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGMP, Border Gateway Multicast Protocol  " disabled=yes port=264 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Lightweight Directory Access Protocol (LDAP)" disabled=yes port=389 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Lightweight Directory Access Protocol (LDAP)" disabled=yes port=389 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SSTP TCP Port 443 (Local Management) & HTTPS" disabled=yes port=443 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Microsoft-DSActive Directory, Windows shares" disabled=yes port=445 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP/ IPSEC UDP Port 500 (Local Management)" disabled=yes port=500 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Modbus, Protocol" disabled=yes port=502 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Modbus, Protocol  " disabled=yes port=502 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Shell (Remote Shell, rsh, remsh)" disabled=yes port=514 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Syslog - used for system logging  " disabled=yes port=514 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Routing Information Protocol (RIP)  " disabled=yes port=520 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="e-mail message submission (SMTP)" disabled=yes port=587 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="LDP,Label Distribution Protocol" disabled=yes port=646 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="LDP,Label Distribution Protocol" disabled=yes port=646 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (data):FTP over TLS/SSL" disabled=yes port=989 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (data):FTP over TLS/SSL" disabled=yes port=989 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (control):FTP over TLS/SSL" disabled=yes port=990 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (control):FTP over TLS/SSL" disabled=yes port=990 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TELNET protocol overTLS/SSL" disabled=yes port=992 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TELNET protocol overTLS/SSL" disabled=yes port=992 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol over TLS/SSL (IMAPS)" disabled=yes port=993 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocol3 over TLS/SSL (POP3S)" disabled=yes port=995 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OVPN TCP Port 1194 (Local Management)" disabled=yes port=1194 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="PPTP Port 1723 (Local Management)" disabled=yes port=1723 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP UDP Port 1701 (Local Management)" disabled=yes port=1701 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP UDP Port 4500 (Local Management)" disabled=yes port=4500 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WINBOX TCP Port 8291 (Local Management)" disabled=yes port=8291 protocol=tcp
/ip firewall filter add action=accept chain=input comment="TCP/UDP ports necessary for SMB" disabled=yes dst-port=137-138 log-prefix=~~~SMB protocol=udp src-address-list=alist-fw-smb-allow
/ip firewall filter add action=accept chain=input comment="TCP/UDP ports necessary for SMB" disabled=yes dst-port=137,139 log-prefix=~~~SMB protocol=tcp src-address-list=alist-fw-smb-allow
/ip firewall filter add action=accept chain=input comment="Accept Related or Established Connections" connection-state=established,related disabled=yes log-prefix="#ACCEPTED UNKNOWN (INPUT)"
/ip firewall filter add action=accept chain=forward comment="Accept New Connections" connection-state=new disabled=yes log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY8 disabled=yes log-prefix=~~~DUMMY8 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=drop chain=forward comment="WAN static-routes intruders not DSTNATed drop" connection-nat-state=dstnat connection-state=new disabled=yes in-interface=wan log-prefix="#DROP UNKNOWN (FWD/no DSTN)"
/ip firewall filter add action=drop chain=forward comment="Drop all other LAN Traffic" disabled=yes log-prefix="#DROP UNKNOWN (FWD)"
/ip firewall filter add action=drop chain=input comment="Drop all other WAN Traffic" disabled=yes log-prefix="#DROP UNKNOWN (INPUT)"
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" disabled=yes in-interface=all-ppp new-mss=1390 passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1391-65535
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" disabled=yes new-mss=1390 out-interface=all-ppp passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1391-65535
/ip firewall mangle add action=change-mss chain=output comment="fix MSS for l2tp/ipsec (self)" disabled=yes new-mss=1390 passthrough=yes protocol=tcp src-address-list=alist-fw-vpn-subnets tcp-flags=syn tcp-mss=1391-65535
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites" disabled=yes dst-address-list=alist-mangle-vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self)" disabled=yes dst-address-list=alist-mangle-vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=mark-site-over-vpn passthrough=no
/ip firewall mangle add action=mark-packet chain=input comment="VPN Traffic" disabled=yes log-prefix="#VPN PCKT MARK" new-packet-mark="IPSEC PCKT" passthrough=yes protocol=ipsec-esp
/ip firewall mangle add action=mark-connection chain=output comment="Mark IPsec" disabled=yes ipsec-policy=out,ipsec new-connection-mark=ipsec passthrough=yes
/ip firewall mangle add action=mark-connection chain=input comment="Mark IPsec" disabled=yes ipsec-policy=in,ipsec new-connection-mark=ipsec passthrough=yes
/ip firewall mangle add action=mark-connection chain=forward comment="Mark IPsec" disabled=yes ipsec-policy=out,ipsec new-connection-mark=ipsec passthrough=yes
/ip firewall mangle add action=mark-connection chain=forward comment="Mark IPsec" disabled=yes ipsec-policy=in,ipsec new-connection-mark=ipsec passthrough=yes
/ip firewall nat add action=masquerade chain=srcnat comment="fix the ntp client by changing its source port 123 with something higher (mikrotik forum 794718)" disabled=yes protocol=udp src-port=123 to-ports=12400-12440
/ip firewall nat add action=dst-nat chain=dstnat disabled=yes dst-port=8888 protocol=tcp to-addresses=192.168.99.1 to-ports=80
/ip firewall nat add action=dst-nat chain=dstnat comment="FTP pass through" disabled=yes dst-port=2121 protocol=tcp to-addresses=192.168.90.40 to-ports=21
/ip firewall nat add action=dst-nat chain=dstnat comment="WINBOX ANNA pass through" disabled=yes dst-port=9999 protocol=tcp to-addresses=192.168.90.1 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="WINBOX CAPXL pass through" disabled=yes dst-port=9998 protocol=tcp to-addresses=192.168.90.10 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="WINBOX MIKROUTER pass through" disabled=yes dst-port=9997 log=yes log-prefix=~~WINB-MIK protocol=tcp to-addresses=192.168.99.1 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="ICMP MIKROUTER pass through" disabled=yes log=yes log-prefix=~~ICMP-MIK protocol=icmp to-addresses=192.168.99.1
/ip firewall nat add action=accept chain=srcnat comment="accept tunnel traffic" disabled=yes dst-address-list=alist-fw-vpn-subnets log-prefix=#VPN src-address-list=alist-nat-local-subnets
/ip firewall nat add action=accept chain=dstnat comment="accept tunnel traffic" disabled=yes dst-address-list=alist-nat-local-subnets log-prefix=#VPN src-address-list=alist-fw-vpn-subnets
/ip firewall nat add action=masquerade chain=srcnat comment="ANNA - VPN masq (pure L2TP, w/o IPSEC)" out-interface=tunnel-anna
/ip firewall nat add action=masquerade chain=srcnat comment="MIK - VPN masq (pure L2TP, w/o IPSEC)" disabled=yes out-interface=tunnel-mikrotik
/ip firewall nat add action=masquerade chain=srcnat comment="all cable allowed"
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip ipsec identity add comment=to-ANNA-traffic-only-encryption-PSK generate-policy=port-strict mode-config=common-setup peer=ANNA-INNER policy-template-group=roadwarrior-s
/ip ipsec identity add comment=to-MIKROTIK-traffic-only-encryption-PSK generate-policy=port-override mode-config=common-setup peer=ANY-INNER policy-template-group=roaming-s
/ip ipsec identity add auth-method=digital-signature certificate=ca@CHR disabled=yes generate-policy=port-override mode-config=roadwarrior-setup peer=RW policy-template-group=roadwarrior-s
/ip ipsec identity add auth-method=digital-signature certificate=182.13.148.14@CHR comment=to-ANNA-outer-tunnel-encryption-RSA generate-policy=port-override match-by=certificate mode-config=common-setup peer=ANY-OUTER-IP-REMOTE-CONTROLLABLE policy-template-group=moscow-s remote-certificate=anna.ipsec@CHR
/ip ipsec identity add auth-method=digital-signature certificate=182.13.148.14@CHR comment=to-MIKROTIK-outer-tunnel-encryption-RSA generate-policy=port-override mode-config=common-setup peer=ANY-OUTER-IP-REMOTE-CONTROLLABLE policy-template-group=spring-s
/ip ipsec identity add disabled=yes generate-policy=port-strict mode-config=common-setup peer=WIN policy-template-group=roadwarrior-s
/ip ipsec policy set 0 disabled=yes
/ip ipsec policy add comment="Roadwarrior IPSEC TRANSPORT TEMPLATE (outer-tunnel encryption)" disabled=yes dst-address=10.10.10.8/29 group=roadwarrior-s proposal="IPSEC IKEv2 VPN PHASE2 IOS/OSX" src-address=0.0.0.0/0 template=yes
/ip ipsec policy add comment="Common IPSEC TUNNEL TEMPLATE (traffic-only encryption) MIKROUTER" dst-address=0.0.0.0/0 group=roaming-s proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" src-address=192.168.97.0/29 template=yes
/ip ipsec policy add comment=MOSCOW-OUTER-IP-REMOTE-CONTROLLABLE dst-address=0.0.0.0/0 group=moscow-s proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=185.13.148.14/32 template=yes
/ip ipsec policy add comment=SPRING-OUTER-IP-REMOTE-CONTROLLABLE disabled=yes dst-address=0.0.0.0/0 group=spring-s proposal="IPSEC IKEv2 VPN PHASE2 MIKROTIK" protocol=udp src-address=185.13.148.14/32 template=yes
/ip route add check-gateway=ping comment=GLOBAL disabled=no distance=10 dst-address=0.0.0.0/0 gateway=185.13.148.1
/ip service set telnet disabled=yes
/ip service set ssh port=2223
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip smb set allow-guests=no domain=HNW interfaces=main-infrastructure-br
/ip smb shares set [ find default=yes ] disabled=yes
/ip ssh set allow-none-crypto=yes always-allow-password-login=yes forwarding-enabled=remote
/ip tftp add real-filename=NAS/ req-filename=.*
/ip traffic-flow set cache-entries=64k interfaces=wan
/ip upnp set show-dummy-rule=no
/ip upnp interfaces add interface=wan type=external
/ip upnp interfaces add interface=main-infrastructure-br type=internal
/ppp secret add local-address=10.0.0.1 name=vpn-remote-mic profile=l2tp-no-encrypt-site2site remote-address=10.0.0.2 service=l2tp
/ppp secret add local-address=10.0.0.1 name=vpn-remote-anna profile=l2tp-no-encrypt-site2site remote-address=10.0.0.3 service=l2tp
/ppp secret add local-address=10.0.0.1 name=vpn-user-alx profile=l2tp-no-encrypt-site2site remote-address=10.0.0.4 service=l2tp
/routing filter rule add chain=ospf-in comment="discard intra area routes" disabled=no rule="if ( protocol ospf && ospf-type intra) { set comment DISCARDED-INTRA-AREA ; reject; }"
/routing filter rule add chain=ospf-in comment="accept DEFAULT ROUTE" disabled=no rule="if ( protocol ospf && dst-len==0) { set pref-src 10.0.0.1 ; set comment GLOBAL-VPN ; accept; }"
/routing filter rule add chain=ospf-in comment="accept inter area routes" disabled=no rule="if ( protocol ospf && ospf-type inter) { set comment LOCAL-AREA ; set pref-src 10.0.0.1 ; accept; }"
/routing filter rule add chain=ospf-in comment="DROP OTHERS" disabled=no rule="reject;"
/routing ospf interface-template add area=chr-space-main auth-id=1 auth-key="" disabled=no interfaces=main-infrastructure-br networks=192.168.97.0/29 passive
/routing ospf interface-template add area=backbone comment="ANNA routes" disabled=no interfaces=tunnel-anna networks=10.0.0.0/29 type=ptp
/routing ospf interface-template add area=backbone comment="MIKROTIK routes" disabled=no interfaces=tunnel-mikrotik networks=10.0.0.0/29 type=ptp
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces=main-infrastructure-br trap-version=2
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
/system logging add action=NTPOnscreenLog topics=ntp
/system note set note="CHR: \t\t7.9 \
    \nUptime:\t\t03:46:21  \
    \nTime:\t\tmay/04/2023 16:50:12  \
    \nya.ru latency:\t52 ms  \
    \nCHR:\t\t185.13.148.14  \
    \nMIK:\t\t85.174.193.108  \
    \nANNA:\t\t46.39.51.172  \
    \nClock:\t\tsynchronized  \
    \n"
/system ntp client set enabled=yes
/system ntp client servers add address=ru.pool.ntp.org
/system ntp client servers add address=85.21.78.91
/system ntp client servers add address=46.254.216.9
/system scheduler add interval=5d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=aug/04/2020 start-time=21:00:00
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=15:55:00
/system scheduler add interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=08:00:00
/system scheduler add interval=10m name=doIPSECPunch on-event="/system script run doIPSECPunch" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/07/2019 start-time=09:00:00
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=7m name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jan/26/2022 start-time=14:34:19
/system scheduler add interval=10m name=doCoolConsole on-event="/system script run doCoolConsole" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=apr/08/2023 start-time=07:00:00
/system scheduler add interval=6h name=doFlushLogs on-event="/system script run doFlushLogs" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=aug/04/2020 start-time=21:00:00
/system script add dont-require-permissions=yes name=doBackup owner=owner policy=ftp,read,write,policy,test,password,sensitive source=":global globalScriptBeforeRun;\r\r\
    \n\$globalScriptBeforeRun \"doBackup\";\r\r\
    \n\r\r\
    \n:local sysname [/system identity get name]\r\r\
    \n:local rosVer [:tonum [:pick [/system resource get version] 0 1]]\r\r\
    \n\r\r\
    \n:local sysver \"NA\"\r\r\
    \n:if ( [ :len [ /system package find where name=\"system\" and disabled=no ] ] > 0 and \$rosVer = 6 ) do={\r\r\
    \n  :set sysver [/system package get system version]\r\r\
    \n}\r\r\
    \n:if ( [ :len [ /system package find where name=\"routeros\" and disabled=no ] ] > 0 and \$rosVer = 7 ) do={\r\r\
    \n  :set sysver [/system package get routeros version]\r\r\
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
    \n:local UpdateList [:toarray \"doBackup,doEnvironmentSetup,doEnvironmentClearance,doRandomGen,doFreshTheScripts,doCertificatesIssuing,doNetwatchHost, doIPSECPunch,doStartupScript,doHeatFlag,doPeriodicLogDump,doPeriodicLogParse,doTelegramNotify,doLEDoff,doLEDon,doCPUHighLoadReboot,doUpdatePoliciesRemotely,doUpdateExternalDNS,doSuperviseCHRviaSSH,doCoolConsole,doFlushLogs\"];\r\
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
/system script add dont-require-permissions=yes name=doFlushLogs owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doFlushLogs\";\r\
    \n\r\
    \n:local state \"\"\r\
    \n\r\
    \n:set state \"FLUSHING logs..\"\r\
    \n\$globalNoteMe value=\$state;\r\
    \n\r\
    \n/system/logging/action/set memory-lines=1 [find target=memory]\r\
    \n/system/logging/action/set memory-lines=300 [find target=memory]\r\
    \n\r\
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
    \n\r\
    \n:local rosVer [:tonum [:pick [/system resource get version] 0 1]]\r\
    \n\r\
    \n:local sysver \"NA\"\r\
    \n:if ( [ :len [ /system package find where name=\"system\" and disabled=no ] ] > 0 and \$rosVer = 6 ) do={\r\
    \n  :set sysver [/system package get system version]\r\
    \n}\r\
    \n:if ( [ :len [ /system package find where name=\"routeros\" and disabled=no ] ] > 0 and \$rosVer = 7 ) do={\r\
    \n  :set sysver [/system package get routeros version]\r\
    \n}\r\
    \n \r\
    \n:set logcontenttemp \"\$[/system identity get name]: \t\t\$sysver\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\" \\n\")\r\
    \n:set logcontenttemp \"Uptime:\t\t\$[/system resource get uptime]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\r\
    \n\r\
    \n\r\
    \n:local hostname \"ya.ru\";\r\
    \n:local host  [:resolve \$hostname ];\r\
    \n:local ms 20;\r\
    \n\r\
    \n:local avgRttA value=0;\r\
    \n:local numPing value=6;\r\
    \n:local toPingIP value=\$host;\r\
    \n\r\
    \n:for tmpA from=1 to=\$numPing step=1 do={\r\
    \n\r\
    \n /tool flood-ping count=1 size=38 address=\$toPingIP do={\r\
    \n  :set avgRttA (\$\"avg-rtt\" + \$avgRttA);\r\
    \n }\r\
    \n\r\
    \n /delay delay-time=1;\r\
    \n\r\
    \n}\r\
    \n\r\
    \n \r\
    \n:set logcontenttemp \"Time:\t\t\$[/system clock get date] \$[/system clock get time]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\r\
    \n:set logcontenttemp \"\$hostname latency:\t\$[:tostr (\$avgRttA / \$numPing )] ms\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\r\
    \n\r\
    \n:set logcontenttemp \"CHR:\t\t\$[:resolve accb195e0dffc6bb.sn.mynetname.net]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\r\
    \n:set logcontenttemp \"MIK:\t\t\$[:resolve 673706ed7949.sn.mynetname.net]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\r\
    \n:set logcontenttemp \"ANNA:\t\t\$[:resolve hcy086pz6xz.sn.mynetname.net]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\r\
    \n\r\
    \n:set logcontenttemp \"Clock:\t\t\$[/system ntp client get status]\"\r\
    \n:set logcontent (\"\$logcontent\" .\"\$logcontenttemp\" .\"  \\n\")\r\
    \n\r\
    \n\r\
    \n/system note set note=\"\$logcontent\"  \r\
    \n"
/tool bandwidth-server set authenticate=no enabled=no
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com port=587 tls=starttls user=defm.kopcap@gmail.com
/tool netwatch add disabled=no down-script=":global NetwatchHostName \"mikrouter.home\";\r\
    \n/system script run doNetwatchHost;" host=192.168.99.1 interval=1m timeout=1s type=simple up-script=":global NetwatchHostName \"mikrouter.home\";\r\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-port=https streaming-server=192.168.99.170
