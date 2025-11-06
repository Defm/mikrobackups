# 2025-11-06 21:13:02 by RouterOS 7.20.1
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
    \n\r\
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
    \n\r\
    \n"
/system script add comment="Periodically renews password for some user accounts and sends a email" dont-require-permissions=yes name=doRandomGen owner=owner policy=ftp,reboot,read,write,policy,test,password,sensitive source="\
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
    \n}\r\
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
    \n\r\
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
    \n\r\
    \n"
/tool bandwidth-server set authenticate=no
/tool e-mail set from=defm.kopcap@gmail.com password=lpnaabjwbvbondrg port=587 server=smtp.gmail.com tls=yes user=defm.kopcap@gmail.com
