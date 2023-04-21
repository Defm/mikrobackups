# apr/21/2023 21:00:02 by RouterOS 7.7
# software id = 59DY-JI10
#
# model = RBcAPGi-5acD2nD
# serial number = HD208EFDKQY
/interface bridge add admin-mac=18:FD:74:13:6E:33 auto-mac=no igmp-snooping=yes name="main infrastructure"
/interface ethernet set [ find default-name=ether1 ] arp=disabled name="lan A"
/interface ethernet set [ find default-name=ether2 ] name="lan B"
/interface wireless
# managed by CAPsMAN
# channel: 2412/20/gn(17dBm), SSID: WiFi 2Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan1 ] antenna-gain=0 country=no_country_set frequency-mode=manual-txpower name="wlan 2Ghz" ssid=MikroTik station-roaming=enabled
/interface wireless
# managed by CAPsMAN
# channel: 5220/20-Ce/ac/P(15dBm), SSID: WiFi 5Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan2 ] antenna-gain=0 country=no_country_set frequency-mode=manual-txpower name="wlan 5Ghz" ssid=MikroTik station-roaming=enabled
/interface lte apn set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-client option add code=60 name=classid value="'mikrotik-cap'"
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
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
/system logging action add memory-lines=1 name=ParseMemoryLog target=memory
/system logging action add name=CAPSOnScreenLog target=memory
/system logging action add name=FirewallOnScreenLog target=memory
/system logging action add name=FTPMemoryLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!write,!policy,!sensitive
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!policy,!sensitive
/interface bridge port add bridge="main infrastructure" ingress-filtering=no interface="lan A" trusted=yes
/interface bridge port add bridge="main infrastructure" ingress-filtering=no interface="lan B" trusted=yes
/interface bridge settings set use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes
/ip neighbor discovery-settings set discover-interface-list=!dynamic
/ip settings set accept-source-route=yes max-neighbor-entries=8192
/ipv6 settings set disable-ipv6=yes max-neighbor-entries=8192
/interface detect-internet set detect-interface-list=all
/interface ovpn-server server set auth=sha1,md5
/interface wireless cap
# 
set caps-man-addresses=192.168.90.1 caps-man-certificate-common-names=anna.capsman@CHR certificate=C.capxl.capsman@CHR discovery-interfaces="main infrastructure" enabled=yes interfaces="wlan 2Ghz,wlan 5Ghz"
/ip dhcp-client add dhcp-options=hostname,clientid,classid interface="main infrastructure"
/ip dns set cache-max-ttl=1d cache-size=1024KiB query-server-timeout=3s
/ip dns static add address=46.39.51.172 name=ftpserver.org
/ip firewall address-list add address=109.252.162.10 list=external-ip
/ip firewall address-list add address=46.39.51.172 list=alist-nat-external-ip
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip firewall service-port set udplite disabled=yes
/ip firewall service-port set dccp disabled=yes
/ip firewall service-port set sctp disabled=yes
/ip service set telnet disabled=yes
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip smb set allow-guests=no domain=HNW interfaces="main infrastructure"
/ip smb shares set [ find default=yes ] directory=/pub disabled=yes
/ip ssh set allow-none-crypto=yes forwarding-enabled=remote
/ip tftp add real-filename=NAS/ req-filename=.*
/ip upnp set enabled=yes
/ip upnp interfaces add interface="main infrastructure" type=internal
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces="main infrastructure" trap-version=2
/system clock set time-zone-name=Europe/Moscow
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
/system note set note="Idenity: capxl | Uptime:  4w3d07:26:24 | Public IP:  46.39.51.172 | "
/system ntp client set enabled=yes
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sensitive start-date=mar/01/2018 start-time=15:55:00
/system scheduler add interval=5d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jun/26/2018 start-time=21:00:00
/system scheduler add interval=30m name=doHeatFlag on-event="/system script run doHeatFlag" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/10/2018 start-time=15:10:00
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=07:00:00
/system scheduler add interval=1m name=doPeriodicLogDump on-event="/system script run doPeriodicLogDump" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=11:31:24
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=15m name=doCPUHighLoadReboot on-event="/system script run doCPUHighLoadReboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=06:05:00
/system scheduler add interval=1h name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=read,write,policy,password start-date=jan/30/2017 start-time=18:57:09
/system scheduler add interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=08:00:00
/system scheduler add interval=10m name=doCoolConsole on-event="/system script run doCoolConsole" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=apr/15/2023 start-time=17:52:52
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
    \n\r\
    \n"
/system script add comment="Runs once on startup and makes console welcome message pretty" dont-require-permissions=yes name=doCoolConsole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n};\r\
    \n"
/system script add comment="Runs at midnight to have less flashes at living room (swith off all LEDs)" dont-require-permissions=yes name=doLEDoff owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doLEDoff\";\r\
    \n\r\
    \n/system leds settings set all-leds-off=immediate\r\
    \n\r\
    \n\r\
    \n"
/system script add comment="Runs at morning to get flashes back (swith on all LEDs)" dont-require-permissions=yes name=doLEDon owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doLEDon\";\r\
    \n\r\
    \n/system leds settings set all-leds-off=never;\r\
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
    \n"
/system script add comment="Flushes all global variables on Startup" dont-require-permissions=yes name=doEnvironmentClearance owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
    \n#clear all global variables\r\
    \n/system script environment remove [find];\r\
    \n"
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
    \n\r\
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
    \n}\r\
    \n"
/system script add comment="Setups global functions, called by the other scripts (runs once on startup)" dont-require-permissions=yes name=doEnvironmentSetup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
/system script add comment="Common backup script to ftp/email using both raw/plain formats. Can also be used to collect Git config history" dont-require-permissions=yes name=doBackup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\r\r\
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
/tool bandwidth-server set authenticate=no
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com port=587 tls=yes user=defm.kopcap@gmail.com
