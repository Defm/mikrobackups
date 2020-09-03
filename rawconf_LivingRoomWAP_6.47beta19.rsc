# sep/03/2020 21:00:02 by RouterOS 6.47beta19
# software id = FXCL-E3SF
#
# model = RouterBOARD wAP G-5HacT2HnD
# serial number = 7DF108C899B2
/interface bridge add name="main infrastructure"
/interface wireless
# managed by CAPsMAN
# channel: 2412/20/gn(17dBm), SSID: WiFi 2Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan1 ] antenna-gain=0 country=no_country_set frequency-mode=manual-txpower name="wlan 2Ghz" ssid=MikroTik
/interface wireless
# managed by CAPsMAN
# channel: 5220/20-Ce/ac/P(15dBm), SSID: WiFi 5Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan2 ] antenna-gain=0 country=no_country_set frequency-mode=manual-txpower name="wlan 5Ghz" ssid=MikroTik
/interface ethernet set [ find default-name=ether1 ] name="lan A"
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/snmp community set [ find default=yes ] addresses=192.168.99.180/32,192.168.99.170/32 authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 name=public
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
/system logging action add memory-lines=6000 name=ParseMemoryLog target=memory
/system logging action add name=CAPSOnScreenLog target=memory
/system logging action add name=FirewallOnScreenLog target=memory
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!write,!policy,!sensitive,!dude
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,tikapp,!ftp,!reboot,!policy,!sensitive,!dude
/certificate settings set crl-download=no crl-use=no
/interface bridge port add bridge="main infrastructure" interface="lan A"
/ip firewall connection tracking set enabled=yes
/ip settings set accept-source-route=yes
/interface detect-internet set detect-interface-list=all
/interface wireless cap
# 
set caps-man-addresses=192.168.99.1 certificate=request discovery-interfaces="main infrastructure" enabled=yes interfaces="wlan 2Ghz,wlan 5Ghz" lock-to-caps-man=yes
/ip accounting set account-local-traffic=yes enabled=yes threshold=200
/ip cloud set ddns-enabled=yes
/ip dhcp-client add disabled=no interface="main infrastructure"
/ip dns set cache-max-ttl=1d query-server-timeout=3s
/ip dns static add address=37.190.116.144 name=ftpserver.org
/ip firewall address-list add address=37.190.116.144 list=external-ip
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set irc disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip firewall service-port set udplite disabled=yes
/ip firewall service-port set dccp disabled=yes
/ip firewall service-port set sctp disabled=yes
/ip service set ftp disabled=yes
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip smb set allow-guests=no domain=HNW interfaces="main infrastructure"
/ip smb shares set [ find default=yes ] directory=/pub disabled=yes
/ip ssh set allow-none-crypto=yes forwarding-enabled=remote
/ip tftp add real-filename=NAS/ req-filename=.*
/ip upnp set enabled=yes
/ip upnp interfaces add interface="main infrastructure" type=internal
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces="main infrastructure" trap-version=2
/system clock set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity set name=LivingRoomWAP
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
/system ntp client set enabled=yes primary-ntp=195.151.98.66 secondary-ntp=46.254.216.9
/system package update set channel=testing
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sensitive start-date=mar/01/2018 start-time=15:55:00
/system scheduler add interval=1w3d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jun/26/2018 start-time=21:00:00
/system scheduler add interval=30m name=doHeatFlag on-event="/system script run doHeatFlag" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/10/2018 start-time=15:10:00
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/09/2018 start-time=07:00:00
/system scheduler add interval=1m name=doPeriodicLogDump on-event="/system script run doPeriodicLogDump" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=11:31:24
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=15m name=doCPUHighLoadReboot on-event="/system script run doCPUHighLoadReboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/07/2019 start-time=06:05:00
/system scheduler add interval=1h name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=read,write,policy,password start-date=jan/30/2017 start-time=18:57:09
/system scheduler add interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=mar/01/2018 start-time=08:00:00
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
    \n:local content\
    \n:local IPv4\
    \n:global LastIPv4\
    \n\
    \n# Getting my current IPv4 address\
    \n\
    \n# via web\
    \n\
    \n\r\
    \n:global globalScriptBeforeRun;\r\
    \n\$globalScriptBeforeRun \"doUpdateExternalDNS\";\r\
    \n\r\
    \n# parsing the current IPv4 result\
    \n:set IPv4 [/ip cloud get public-address];\
    \n\
    \n:put \"EXTERNAL IP: Current IPv4 = \$IPv4\";\
    \n:log info \"EXTERNAL IP: Current IPv4 = \$IPv4\";\
    \n\
    \n:if ((\$LastIPv4 != \$IPv4) || (\$force = true)) do={\
    \n   :put \"EXTERNAL IP: update needed!\";\
    \n   :log info \"EXTERNAL IP: update needed!\";\
    \n\
    \n    :log info \"Address list updated: external-ip\";\
    \n   /ip firewall address-list remove [find list~\"external-ip\"];\
    \n   /ip firewall address-list add list=\"external-ip\" address=\$IPv4;\
    \n   \
    \n   /ip dns static remove [/ip dns static find name=ftpserver.org];\
    \n   \r\
    \n   :log info \"Address list updated: Static DNS of ftpserver.org\";\
    \n   /ip dns static add name=ftpserver.org address=\$IPv4;\
    \n \
    \n   :set LastIPv4 \$IPv4;\
    \n    \
    \n} else={\
    \n   :put \"EXTERNAL IP: no update needed!\"\
    \n   :log info \"EXTERNAL IP: no update needed!\"\
    \n}\
    \n\
    \n"
/system script add comment="Runs once on startup and makes console welcome message pretty" dont-require-permissions=no name=doCoolConcole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\r\
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
    \n:set maxTemp 60;\r\
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
    \n    :local state (\"RPC... \$value\");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
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
    \n#Example call\r\
    \n#\$globalNewNetworkMember ip=192.168.99.130 mac=50:DE:06:25:C2:FC gip=192.168.98.229 comm=iPadAlxPro ssid=\"WiFi 5\"  \r\
    \n:global globalNewNetworkMember;\r\
    \n\r\
    \n:if (!any \$globalNewNetworkMember) do={ \r\
    \n  :global globalNewNetworkMember do={\r\
    \n    \r\
    \n    :global globalNoteMe;\r\
    \n\r\
    \n    #to prevent connection\r\
    \n    :local guestDHCP \"guest dhcp\";\r\
    \n    #to allow connection\r\
    \n    :local mainDHCP \"main dhcp\";\r\
    \n\r\
    \n    #when DHCP not using (add arp for leases)\r\
    \n    :local arpInterface \"main infrastructure\";\r\
    \n\r\
    \n    :local state (\"Adding new network member... \");\r\
    \n    \$globalNoteMe value=\$state;\r\
    \n\r\
    \n    # incoming named params \r\
    \n    :local newIp [ :tostr \$ip ];\r\
    \n    :local newBlockedIp [ :tostr \$gip ];\r\
    \n    :local newMac [ :tostr \$mac ];\r\
    \n    :local comment [ :tostr \$comm ];\r\
    \n    :local ssid [ :tostr \$ssid ];    \r\
    \n\r\
    \n    :if ([:len \$newIp] > 0) do={\r\
    \n\r\
    \n        :if ([ :typeof [ :toip \$newIp ] ] != \"ip\" ) do={\r\
    \n\r\
    \n            :local state (\"Error: bad IP parameter passed - (\$newIp)\");\r\
    \n            \$globalNoteMe value=\$state;\r\
    \n            :return false;\r\
    \n        }\r\
    \n\r\
    \n    } else={\r\
    \n\r\
    \n        :local state (\"Error: bad IP parameter passed - (\$newIp)\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n\r\
    \n        /ip dhcp-server lease remove [find address=\$newIp];\r\
    \n        /ip dhcp-server lease remove [find mac-address=\$newMac];\r\
    \n\r\
    \n        :local state (\"Adding DHCP configuration for (\$newIp/\$newMac) on \$mainDHCP\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n\r\
    \n        /ip dhcp-server lease add address=\$newIp mac-address=\$newMac server=\$mainDHCP comment=\$comment;\r\
    \n\r\
    \n    } on-error={\r\
    \n        :local state (\"Error: something fail on DHCP configuration 'allow' step for (\$newIp/\$newMac) on \$mainDHCP\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n\r\
    \n        /ip dhcp-server lease remove [find address=\$newBlockedIp];\r\
    \n\r\
    \n        :local state (\"Adding DHCP configuration for (\$newBlockedIp/\$newMac) on \$guestDHCP (preventing connections to guest network)\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n\r\
    \n        /ip dhcp-server lease add address=\$newBlockedIp block-access=yes mac-address=\$newMac server=\$guestDHCP comment=(\$comment . \"(blocked)\");\r\
    \n\r\
    \n    } on-error={\r\
    \n        :local state (\"Error: something fail on DHCP configuration 'block' step for (\$newBlockedIp/\$newMac) on \$guestDHCP\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n       \r\
    \n        /ip arp remove [find address=\$newIp];\r\
    \n        /ip arp remove [find address=\$newBlockedIp];\r\
    \n        /ip arp remove [find mac-address=\$newMac];\r\
    \n\r\
    \n        /ip arp add address=\$newIp interface=\$arpInterface mac-address=\$newMac comment=\$comment\r\
    \n    } on-error={\r\
    \n        :local state (\"Error: something fail on ARP configuration step\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n    }\r\
    \n\r\
    \n    :do {\r\
    \n       \r\
    \n        /caps-man access-list remove [find mac-address=\$newMac];\r\
    \n\r\
    \n        /caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=\$comment disabled=no mac-address=\$newMac ssid-regexp=\$ssid place-before=1\r\
    \n    \r\
    \n    } on-error={\r\
    \n        :local state (\"Error: something fail on CAPS configuration step\");\r\
    \n        \$globalNoteMe value=\$state;\r\
    \n        :return false;\r\
    \n    }\r\
    \n\r\
    \n    :return true;\r\
    \n    }\r\
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
    \n}\r\
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
/tool e-mail set address=smtp.gmail.com from=defm.kopcap@gmail.com password=zgejdmvndvorrmsn port=587 start-tls=yes user=defm.kopcap@gmail.com
