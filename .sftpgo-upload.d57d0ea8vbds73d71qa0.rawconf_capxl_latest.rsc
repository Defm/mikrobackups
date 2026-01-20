# 2025-12-26 21:13:02 by RouterOS 7.20.1
# software id = 59DY-JI10
#
# model = RBcAPGi-5acD2nD
# serial number = HD208EFDKQY
/interface bridge add admin-mac=18:FD:74:94:FD:70 auto-mac=no igmp-snooping=yes name="main infrastructure" port-cost-mode=short
/interface wireless
# managed by CAPsMAN
# channel: 2412/20/gn(17dBm), SSID: WiFi 2Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan1 ] antenna-gain=0 country=no_country_set frequency-mode=manual-txpower name="wlan 2Ghz" ssid=MikroTik station-roaming=enabled
/interface wireless
# managed by CAPsMAN
# channel: 5220/20-Ce/ac/P(15dBm), SSID: WiFi 5Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan2 ] antenna-gain=0 country=no_country_set frequency-mode=manual-txpower name="wlan 5Ghz" ssid=MikroTik station-roaming=enabled
/interface ethernet set [ find default-name=ether1 ] arp=disabled name="lan A"
/interface ethernet set [ find default-name=ether2 ] name="lan B"
/interface lte apn set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-client option add code=60 name=classid value="'mikrotik-cap'"
/ip smb users set [ find default=yes ] disabled=yes
/ppp profile add bridge-learning=no change-tcp-mss=no local-address=0.0.0.0 name=null only-one=yes remote-address=0.0.0.0 session-timeout=1s use-compression=no use-encryption=no use-mpls=no use-upnp=no
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action add name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=1 disk-file-name=flash/ScriptsDiskLog disk-lines-per-file=10000 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=1 disk-file-name=flash/ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add name=OnScreenLog target=memory
/system logging action add name=DHCPOnScreenLog target=memory
/system logging action add name=DNSOnScreenLog target=memory
/system logging action add name=RouterControlLog target=memory
/system logging action add name=OSPFOnscreenLog target=memory
/system logging action add name=L2TPOnScreenLog target=memory
/system logging action add disk-file-name=flash/AuthDiskLog name=AuthDiskLog target=disk
/system logging action add name=CertificatesOnScreenLog target=memory
/system logging action add name=ParseMemoryLog target=memory
/system logging action add name=CAPSOnScreenLog target=memory
/system logging action add name=FirewallOnScreenLog target=memory
/system logging action add name=FTPMemoryLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!write,!policy,!sensitive
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!policy,!sensitive
/user group add name=mktxp policy=read,api,!local,!telnet,!ssh,!ftp,!reboot,!write,!policy,!test,!winbox,!password,!web,!sniff,!sensitive,!romon,!rest-api
/ip smb set domain=HNW interfaces="main infrastructure"
/interface bridge port add bridge="main infrastructure" ingress-filtering=no interface="lan A" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge="main infrastructure" ingress-filtering=no interface="lan B" internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge settings set use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes udp-timeout=10s
/ip neighbor discovery-settings set discover-interface-list=!dynamic
/ip settings set accept-source-route=yes max-neighbor-entries=8192
/ipv6 settings set disable-ipv6=yes max-neighbor-entries=8192
/interface detect-internet set detect-interface-list=all
/interface ovpn-server server add auth=sha1,md5 mac-address=FE:AA:B6:DE:38:D8 name=ovpn-server1
/interface wireless cap
# 
set caps-man-addresses=192.168.90.1 certificate=C.capxl.capsman@CHR discovery-interfaces="main infrastructure" enabled=yes interfaces="wlan 2Ghz,wlan 5Ghz"
/ip cloud set ddns-enabled=yes ddns-update-interval=10m
/ip dhcp-client add dhcp-options=hostname,clientid,classid interface="main infrastructure"
/ip dns set cache-max-ttl=1d cache-size=1024KiB query-server-timeout=3s
/ip dns static add address=46.39.51.206 name=ftpserver.org type=A
/ip firewall address-list add address=109.252.162.10 list=external-ip
/ip firewall address-list add address=46.39.51.206 list=alist-nat-external-ip
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip firewall service-port set udplite disabled=yes
/ip firewall service-port set dccp disabled=yes
/ip firewall service-port set sctp disabled=yes
/ip ipsec profile set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip service set telnet disabled=yes
/ip service set api-ssl disabled=yes
/ip smb shares set [ find default=yes ] directory=/pub
/ip ssh set ciphers=aes-gcm,aes-ctr,aes-cbc,3des-cbc,null forwarding-enabled=remote
/ip tftp add real-filename=NAS/ req-filename=.*
/ip upnp set enabled=yes
/ip upnp interfaces add interface="main infrastructure" type=internal
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_TOKEN password=798290125:AAE3gfeLKdtai3RPtnHRLbE8quNgAh7iC8M profile=null service=async
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_CHAT_ID password=-1001798127067 profile=null service=async
/routing bfd configuration add disabled=no
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces="main infrastructure" trap-version=2
/system clock set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity set name=capxl
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
/system logging add action=ParseMemoryLog topics=info,system,!script
/system logging add action=FTPMemoryLog topics=tftp
/system note set note=Pending show-at-cli-login=yes
/system ntp client set enabled=yes
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sensitive start-date=2018-03-01 start-time=15:55:00
/system scheduler add interval=5d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-06-26 start-time=21:13:00
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=07:00:00
/system scheduler add interval=1m name=doPeriodicLogDump on-event="/system script run doPeriodicLogDump" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2019-02-07 start-time=11:31:24
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=15m name=doCPUHighLoadReboot on-event="/system script run doCPUHighLoadReboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2019-02-07 start-time=06:05:00
/system scheduler add interval=1h name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=read,write,policy,password start-date=2017-01-30 start-time=18:57:09
/system scheduler add interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-03-01 start-time=08:00:00
/system scheduler add interval=10m name=doCoolConsole on-event="/system script run doCoolConsole" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-04-15 start-time=17:52:52
/system scheduler add interval=6h name=doFlushLogs on-event="/system script run doFlushLogs" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-05-02 start-time=22:00:00
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
    \n\r\
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
/system script add comment="Simple telegram notify script" dont-require-permissions=yes name=doTelegramNotify owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n};\r\
    \n\r\
    \n\r\
    \n"
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
/system script add comment="Mikrotik system log dump, collects new entries once per minute. You should have 'ParseMemoryLog' buffer at your 'system-logging'. Calls 'doPeriodicLogParse' when new logs available" dont-require-permissions=yes name=doPeriodicLogDump owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\
    \n:local scriptname \"doPeriodicLogDump\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\r\
    \n\r\
    \n"
/system script add comment="Mikrotik system log analyzer, called manually by 'doPeriodicLogDump' script, checks 'interesting' conditions and does the routine" dont-require-permissions=yes name=doPeriodicLogParse owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name];\
    \n:local scriptname \"doPeriodicLogParse\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\r\
    \n\r\
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
    \n    :local tgmessage