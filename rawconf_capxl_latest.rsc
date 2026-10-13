# 2026-10-13 15:14:51 by RouterOS 7.24.2
# software id = 59DY-JI10
#
# model = RBcAPGi-5acD2nD
# serial number = HD208EFDKQY
/interface bridge add admin-mac=18:FD:74:94:FD:70 auto-mac=no igmp-snooping=yes name=main-infrastructure-br port-cost-mode=short
/interface ethernet set [ find default-name=ether1 ] arp=disabled name=lan-poe-in
/interface ethernet set [ find default-name=ether2 ] name=lan-poe-out
/interface wireless
# managed by CAPsMAN
# channel: 2412/20/gn(17dBm), SSID: WiFi 2Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan1 ] antenna-gain=0 country=no_country_set frequency-mode=manual-txpower name="wlan 2Ghz" ssid=MikroTik station-roaming=enabled
/interface wireless
# managed by CAPsMAN
# channel: 5220/20-Ce/ac/P(15dBm), SSID: WiFi 5Ghz PRIVATE, CAPsMAN forwarding
set [ find default-name=wlan2 ] antenna-gain=0 country=no_country_set frequency-mode=manual-txpower name="wlan 5Ghz" ssid=MikroTik station-roaming=enabled
/disk add comment=Ramdisk slot=RAM tmpfs-max-size=10000000 type=tmpfs
/disk add disabled=yes slot=sshfs sshfs-address=185.13.148.14 sshfs-password=RHWbJxAje sshfs-path=/REPO sshfs-port=2223 sshfs-user=automation type=sshfs
/interface lte apn set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-client option add code=60 name=classid value="'mikrotik-cap'"
/ip smb users set [ find default=yes ] disabled=yes
/ppp profile add bridge-learning=no change-tcp-mss=no local-address=0.0.0.0 name=null only-one=yes remote-address=0.0.0.0 session-timeout=1s use-compression=no use-encryption=no use-mpls=no use-upnp=no
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action set 0 memory-lines=3000
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
/system script add comment="StarWars march to  alarm on startup" dont-require-permissions=yes name=doImperialMarch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\r\
    \n:local scriptname \"doImperialMarch\"\r\
    \n:global globalScriptBeforeRun\r\
    \n\$globalScriptBeforeRun \$scriptname\r\
    \n\r\
    \n:global globalNoteMe\r\
    \n:global globalTgMessage\r\
    \n:local itsOk true\r\
    \n:local state \"\"\r\
    \n\r\
    \n:onerror errorDescr in={\r\
    \n    :set state \"Playing Imperial March\"\r\
    \n    \$globalNoteMe value=\$state\r\
    \n\r\
    \n    :delay 6\r\
    \n\r\
    \n    :beep frequency=500 length=500ms\r\
    \n    :delay 500ms\r\
    \n\r\
    \n    :beep frequency=500 length=500ms\r\
    \n    :delay 500ms\r\
    \n\r\
    \n    :beep frequency=500 length=500ms\r\
    \n    :delay 500ms\r\
    \n\r\
    \n    :beep frequency=400 length=500ms\r\
    \n    :delay 400ms\r\
    \n\r\
    \n    :beep frequency=600 length=200ms\r\
    \n    :delay 100ms\r\
    \n\r\
    \n    :beep frequency=500 length=500ms\r\
    \n    :delay 500ms\r\
    \n\r\
    \n    :beep frequency=400 length=500ms\r\
    \n    :delay 400ms\r\
    \n\r\
    \n    :beep frequency=600 length=200ms\r\
    \n    :delay 100ms\r\
    \n\r\
    \n    :beep frequency=500 length=500ms\r\
    \n    :delay 1000ms\r\
    \n\r\
    \n    :beep frequency=750 length=500ms\r\
    \n    :delay 500ms\r\
    \n\r\
    \n    :beep frequency=750 length=500ms\r\
    \n    :delay 500ms\r\
    \n\r\
    \n    :beep frequency=750 length=500ms\r\
    \n    :delay 500ms\r\
    \n\r\
    \n    :beep frequency=810 length=500ms\r\
    \n    :delay 400ms\r\
    \n\r\
    \n    :beep frequency=600 length=200ms\r\
    \n    :delay 100ms\r\
    \n\r\
    \n    :beep frequency=470 length=500ms\r\
    \n    :delay 500ms\r\
    \n\r\
    \n    :beep frequency=400 length=500ms\r\
    \n    :delay 400ms\r\
    \n\r\
    \n    :beep frequency=600 length=200ms\r\
    \n    :delay 100ms\r\
    \n\r\
    \n    :beep frequency=500 length=500ms\r\
    \n    :delay 1000ms\r\
    \n\r\
    \n    \$globalNoteMe value=\"Done\"\r\
    \n} do={\r\
    \n    :set state \"Error When \$state: \$errorDescr\"\r\
    \n    \$globalNoteMe value=\$state\r\
    \n    :set itsOk false\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: sequence played\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    \$globalTgMessage value=\$inf\r\
    \n    :error \$inf\r\
    \n}\r\
    \n"
/system script add comment="Updates address-list that contains my external IP" dont-require-permissions=yes name=doUpdateExternalDNS owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\
    \n:local scriptname \"doUpdateExternalDNS\"\
    \n:global globalScriptBeforeRun\
    \n\$globalScriptBeforeRun \$scriptname\
    \n\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n:local itsOk true\
    \n:local payLoad false\
    \n:local state \"\"\
    \n\
    \n# last seen external IP, survives between runs until doEnvironmentClearance\
    \n:global globalLastIpv4\
    \n\
    \n# set true to refresh address-list/DNS/CHR even when IP did not change\
    \n:local useForcedRefresh false\
    \n\
    \n:local ipv4 \"\"\
    \n\
    \n:onerror errorDescr in={\
    \n\
    \n    # parsing the current IPv4 result\
    \n    :set state \"Requesting cloud-DNS public address\"\
    \n    \$globalNoteMe value=\$state\
    \n    /ip cloud force-update\
    \n    :delay 7s\
    \n    :set ipv4 [/ip cloud get public-address]\
    \n\
    \n    :if ([:typeof [:toip \$ipv4]] != \"ip\") do={\
    \n        :error \"No cloud-DNS IP received\"\
    \n    }\
    \n    \$globalNoteMe value=\"Done\"\
    \n\
    \n    :if ((\$globalLastIpv4 != \$ipv4) or \$useForcedRefresh) do={\
    \n\
    \n        :set state \"External IP changed: current - (\$ipv4), last - (\$globalLastIpv4)\"\
    \n        \$globalNoteMe value=\$state\
    \n\
    \n        /ip firewall address-list remove [find list~\"alist-nat-external-ip\"]\
    \n        /ip firewall address-list add list=\"alist-nat-external-ip\" address=\$ipv4\
    \n\
    \n        /ip dns static remove [/ip dns static find name=ftpserver.org]\
    \n        /ip dns static add name=ftpserver.org address=\$ipv4\
    \n\
    \n        :set globalLastIpv4 \$ipv4\
    \n        :set payLoad true\
    \n\
    \n        :if ([:len [/system script find name=\"doSuperviseCHRviaSSH\"]] > 0) do={\
    \n            :set state \"Refreshing VPN server (CHR) IPSEC policies\"\
    \n            \$globalNoteMe value=\$state\
    \n            /system script run doSuperviseCHRviaSSH\
    \n        }\
    \n    }\
    \n\
    \n} do={\
    \n    :set state \"Error When \$state: \$errorDescr\"\
    \n    \$globalNoteMe value=\$state\
    \n    :set itsOk false\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk and \$payLoad) do={\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: external IP address change detected, refreshed\"\
    \n}\
    \n\
    \n:if (\$itsOk and !\$payLoad) do={\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: no external IP address update needed\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n    \$globalTgMessage value=\$inf\
    \n    :error \$inf\
    \n}\
    \n"
/system script add comment="Runs once on startup and makes console welcome message pretty" dont-require-permissions=yes name=doCoolConsole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\
    \n:local scriptname \"doCoolConsole\"\
    \n:global globalScriptBeforeRun\
    \n\$globalScriptBeforeRun \$scriptname\
    \n\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n:global globalOnPrimaryPartition\
    \n:local itsOk true\
    \n:local state \"\"\
    \n\
    \n:local logcontenttemp \"\"\
    \n:local logcontent \"\"\
    \n\
    \n# predicate-like helper: returns resolved address or \"ERROR\"\
    \n:local safeResolve do={\
    \n    :local host \"ERROR\"\
    \n    :if ([:len \$1] != 0) do={\
    \n        :onerror errorDescr in={\
    \n            :set host [:resolve \"\$1\"]\
    \n        } do={\
    \n            :log error \"FAIL resolving: \$1 (\$errorDescr)\"\
    \n            :put \"FAIL resolving: \$1\"\
    \n        }\
    \n    } else={\
    \n        :log error \"FAIL resolving: empty host name\"\
    \n        :put \"FAIL resolving: empty host name\"\
    \n    }\
    \n    :return \$host\
    \n}\
    \n\
    \n:onerror errorDescr in={\
    \n\
    \n    :local rosVer [:tonum [:pick [/system resource get version] 0 1]]\
    \n    :local sysver \"NA\"\
    \n    :if ([:len [/system package find where name=\"system\" and disabled=no]] > 0 and \$rosVer = 6) do={\
    \n        :set sysver [/system package get system version]\
    \n    }\
    \n    :if ([:len [/system package find where name=\"routeros\" and disabled=no]] > 0 and \$rosVer = 7) do={\
    \n        :set sysver [/system package get routeros version]\
    \n    }\
    \n\
    \n    :set state \"Picking default route\"\
    \n\
    \n    :local defaultRoute \"unreachable\"\
    \n    /ip route {\
    \n        :foreach i in=[find where dst-address=\"0.0.0.0/0\" and active and routing-table=main] do={\
    \n            :set defaultRoute [:tostr [/ip route get \$i gateway]]\
    \n        }\
    \n    }\
    \n\
    \n    :set state \"Picking ipsec\"\
    \n\
    \n    :local ipsecState \"okay\"\
    \n    /ip ipsec policy {\
    \n        :foreach vpnEndpoint in=[find (!disabled and !template)] do={\
    \n            :local ph2state [get value-name=ph2-state \$vpnEndpoint]\
    \n            :if (\$ph2state != \"established\") do={\
    \n                :set ipsecState \"issues found\"\
    \n            }\
    \n        }\
    \n    }\
    \n\
    \n    :if (![\$globalOnPrimaryPartition]) do={\
    \n        :set state \"WARNING: the system booted up from fallback partition!\"\
    \n        :log error \$state\
    \n        \$globalNoteMe value=\$state\
    \n\
    \n        :set logcontenttemp \"\$state\"\
    \n        :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \" \\n\")\
    \n    }\
    \n\
    \n    :set logcontenttemp \"Ipsec:         \$ipsecState\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \" \\n\")\
    \n    :set logcontenttemp \"Route:     \$defaultRoute\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \" \\n\")\
    \n    :set logcontenttemp \"Version:         \$sysver\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \" \\n\")\
    \n    :set logcontenttemp \"Uptime:        \$[/system resource get uptime]\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \"  \\n\")\
    \n\
    \n    :local avgRttA 0\
    \n    :local numPing 6\
    \n    :local latency \"NA\"\
    \n\
    \n    :set state \"Yandex connection test\"\
    \n\
    \n    :local latencySite \"Ya.ru\"\
    \n    :local yaResolve [\$safeResolve \$latencySite]\
    \n\
    \n    :set state \"Picking latency\"\
    \n\
    \n    :if (\$yaResolve != \"ERROR\") do={\
    \n        :for tmpA from=1 to=\$numPing step=1 do={\
    \n            /tool flood-ping count=1 size=38 address=\$yaResolve do={ :set avgRttA (\$\"avg-rtt\" + \$avgRttA) }\
    \n            :delay 1s\
    \n        }\
    \n        :set latency [:tostr (\$avgRttA / \$numPing)]\
    \n    } else={\
    \n        :set latency \"unreachable\"\
    \n    }\
    \n\
    \n    :set state \"Resolving CHR, MIK, ANNA\"\
    \n\
    \n    :local chrResolve [\$safeResolve \"accb195e0dffc6bb.sn.mynetname.net\"]\
    \n    :if (\$chrResolve = \"ERROR\") do={ :set chrResolve \"unreachable\" }\
    \n\
    \n    :local mikResolve [\$safeResolve \"673706ed7949.sn.mynetname.net\"]\
    \n    :if (\$mikResolve = \"ERROR\") do={ :set mikResolve \"unreachable\" }\
    \n\
    \n    :local annaResolve [\$safeResolve \"hcy086pz6xz.sn.mynetname.net\"]\
    \n    :if (\$annaResolve = \"ERROR\") do={ :set annaResolve \"unreachable\" }\
    \n\
    \n    :set logcontenttemp \"Time:        \$[/system clock get date] \$[/system clock get time]\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \"  \\n\")\
    \n    :set logcontenttemp \"Ping:    \$latency ms\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \"  \\n\")\
    \n\
    \n    :set logcontenttemp \"Chr:        \$chrResolve\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \"  \\n\")\
    \n    :set logcontenttemp \"Mik:        \$mikResolve\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \"  \\n\")\
    \n    :set logcontenttemp \"Anna:        \$annaResolve\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \"  \\n\")\
    \n\
    \n    :set logcontenttemp \"Clock:        \$[/system ntp client get status]\"\
    \n    :set logcontent (\"\$logcontent\" . \"\$logcontenttemp\" . \"  \\n\")\
    \n\
    \n    :set state \"Listing packages\"\
    \n\
    \n    /system/package {\
    \n        :foreach pkg in=[find (!disabled)] do={\
    \n            :local pkgName [get value-name=name \$pkg]\
    \n            :set logcontent (\"\$logcontent\" . \" * \$pkgName\" . \"  \\n\")\
    \n        }\
    \n    }\
    \n\
    \n    :set state \"Setting global note\"\
    \n    \$globalNoteMe value=\$state\
    \n\
    \n    /system note set note=\"\$logcontent\"\
    \n    \$globalNoteMe value=\"Done\"\
    \n\
    \n} do={\
    \n    :set state \"Error When \$state: \$errorDescr\"\
    \n    \$globalNoteMe value=\$state\
    \n    :set itsOk false\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: console note refreshed\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n    \$globalTgMessage value=\$inf\
    \n    :error \$inf\
    \n}\
    \n"
/system script add comment="Runs at midnight to have less flashes at living room (swith off all LEDs)" dont-require-permissions=yes name=doLEDoff owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\r\
    \n:local scriptname \"doLEDoff\"\r\
    \n:global globalScriptBeforeRun\r\
    \n\$globalScriptBeforeRun \$scriptname\r\
    \n\r\
    \n:global globalNoteMe\r\
    \n:global globalTgMessage\r\
    \n:local itsOk true\r\
    \n:local state \"\"\r\
    \n\r\
    \n:onerror errorDescr in={\r\
    \n    :set state \"Switching LEDs off\"\r\
    \n    \$globalNoteMe value=\$state\r\
    \n    /system leds settings set all-leds-off=immediate\r\
    \n    \$globalNoteMe value=\"Done\"\r\
    \n} do={\r\
    \n    :set state \"Error When \$state: \$errorDescr\"\r\
    \n    \$globalNoteMe value=\$state\r\
    \n    :set itsOk false\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: LEDs switched off\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    \$globalTgMessage value=\$inf\r\
    \n    :error \$inf\r\
    \n}\r\
    \n"
/system script add comment="Runs at morning to get flashes back (swith on all LEDs)" dont-require-permissions=yes name=doLEDon owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\r\
    \n:local scriptname \"doLEDon\"\r\
    \n:global globalScriptBeforeRun\r\
    \n\$globalScriptBeforeRun \$scriptname\r\
    \n\r\
    \n:global globalNoteMe\r\
    \n:global globalTgMessage\r\
    \n:local itsOk true\r\
    \n:local state \"\"\r\
    \n\r\
    \n:onerror errorDescr in={\r\
    \n    :set state \"Switching LEDs on\"\r\
    \n    \$globalNoteMe value=\$state\r\
    \n    /system leds settings set all-leds-off=never\r\
    \n    \$globalNoteMe value=\"Done\"\r\
    \n} do={\r\
    \n    :set state \"Error When \$state: \$errorDescr\"\r\
    \n    \$globalNoteMe value=\$state\r\
    \n    :set itsOk false\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: LEDs switched on\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    \$globalTgMessage value=\$inf\r\
    \n    :error \$inf\r\
    \n}\r\
    \n"
/system script add comment="Flushes all global variables on Startup" dont-require-permissions=yes name=doEnvironmentClearance owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# clear all global variables (called before doEnvironmentSetup, so no guard here)\r\
    \n/system script environment remove [find]\r\
    \n"
/system script add comment="Startup script" dont-require-permissions=yes name=doStartupScript owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\
    \n:local scriptname \"doStartupScript\"\
    \n\
    \n# reset current\
    \n/system note set note=\"Pending\"\
    \n\
    \n# Track sync time (avoid CHR initial clock bug), with this we are also checking if internet comes up\
    \n# globalNoteMe does not exist yet - direct :log/:put here\
    \n:onerror errorDescr in={\
    \n\
    \n    :local successSyncState \"synchronized\"\
    \n    :local syncOk false\
    \n    :local syncState \"\"\
    \n    :local timeSpent 0\
    \n    :local ticks 0\
    \n    :local maxTicks 40\
    \n    :local break false\
    \n    :do {\
    \n        :set syncState [/system ntp client get status]\
    \n        :set syncOk (\$syncState = \$successSyncState)\
    \n\
    \n        :log info \"Waiting 15s for clock sync using NTP.. (\$ticks/\$maxTicks, \$syncState)\"\
    \n        :put \"Waiting 15s for clock sync using NTP.. (\$ticks/\$maxTicks, \$syncState)\"\
    \n\
    \n        :if (!\$syncOk) do={\
    \n            :delay 15s\
    \n            :set timeSpent (\$timeSpent + 15)\
    \n            :set break (\$ticks >= \$maxTicks)\
    \n        } else={\
    \n            :set break true\
    \n        }\
    \n\
    \n        :set ticks (\$ticks + 1)\
    \n\
    \n    } while=(!\$break)\
    \n\
    \n    :if (\$syncOk) do={\
    \n        :log warning \"Successful clock sync using NTP in \$timeSpent seconds\"\
    \n        :put \"Successful clock sync using NTP in \$timeSpent seconds\"\
    \n    } else={\
    \n        :log error \"Error when clock sync using NTP in \$timeSpent seconds\"\
    \n        :put \"Error when clock sync using NTP in \$timeSpent seconds\"\
    \n    }\
    \n\
    \n} do={\
    \n    :log error \"Error when tracking clock sync using NTP: \$errorDescr\"\
    \n    :put \"Error when tracking clock sync using NTP: \$errorDescr\"\
    \n}\
    \n\
    \n# bootstrap environment directly - globalSafeScriptCall appears only after doEnvironmentSetup\
    \n:onerror errorDescr in={\
    \n    :log warning \"Starting script: doEnvironmentClearance (STARTUP context)\"\
    \n    /system script run doEnvironmentClearance\
    \n    :log warning \"Starting script: doEnvironmentSetup (STARTUP context)\"\
    \n    /system script run doEnvironmentSetup\
    \n} do={\
    \n    :log error \"FAIL Starting environment scripts (STARTUP context): \$errorDescr\"\
    \n    :put \"FAIL Starting environment scripts (STARTUP context): \$errorDescr\"\
    \n}\
    \n\
    \n:global globalSafeScriptCall\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n\
    \n:if (any \$globalSafeScriptCall) do={\
    \n    \$globalSafeScriptCall \"doImperialMarch\" \"STARTUP\"\
    \n    \$globalSafeScriptCall \"doCoolConsole\" \"STARTUP\"\
    \n} else={\
    \n    :log error \"Environment is not ready - skipping startup chain (STARTUP context)\"\
    \n}\
    \n\
    \n# wait some for all tunnels to come up after reboot and VPN to work\
    \n:local inf \"Wait some for all tunnels to come up after reboot and VPN to work..\"\
    \n:if (any \$globalNoteMe) do={ \$globalNoteMe value=\$inf }\
    \n\
    \n:delay 15s\
    \n\
    \n:set inf \"\$scriptname on \$sysname: system restart detected\"\
    \n:if (any \$globalNoteMe) do={ \$globalNoteMe value=\$inf }\
    \n:if (any \$globalTgMessage) do={ \$globalTgMessage value=\$inf }\
    \n"
/system script add comment="Setups global functions, called by the other scripts (runs once on startup)" dont-require-permissions=yes name=doEnvironmentSetup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# Example call\
    \n# \$globalNoteMe value=\"12345\"\
    \n# outputs \$value using both :put and :log info\
    \n:global globalNoteMe\
    \n:if (!any \$globalNoteMe) do={\
    \n    :global globalNoteMe do={\
    \n\
    \n        :local scriptname [:jobname]\
    \n        :local state \"\$scriptname: \$value\"\
    \n        :put \"\$state\"\
    \n        :log info \"\$state\"\
    \n\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# \$globalScriptBeforeRun \$scriptname\
    \n# \$globalScriptBeforeRun \$scriptname \"NETWATCH\"\
    \n# prevents second instance of the same script and logs the start; \$2 is an optional context postfix\
    \n:global globalScriptBeforeRun\
    \n:if (!any \$globalScriptBeforeRun) do={\
    \n    :global globalScriptBeforeRun do={\
    \n\
    \n        :global globalNoteMe\
    \n        :if ([:len \$1] > 0) do={\
    \n\
    \n            :local scriptname [:jobname]\
    \n            :local context \"\"\
    \n            :if ([:len \$2] > 0) do={ :set context \" (\$2 context)\" }\
    \n\
    \n            :local state \"\$scriptname instance already running - prevent new instance\$context\"\
    \n            :if ([/system script job print count-only as-value where script=\$scriptname] > 1) do={\
    \n                :log error \$state\
    \n                \$globalNoteMe value=\$state\
    \n                :error \$state\
    \n            }\
    \n\
    \n            :set state \"Starting script: \$scriptname\$context\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n        }\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# \$globalSafeScriptCall \"doImperialMarch\" \"STARTUP\"\
    \n# runs a script if it exists, never throws; \$2 is an optional context postfix\
    \n# uses :log directly - it may be called before globalNoteMe exists\
    \n:global globalSafeScriptCall\
    \n:if (!any \$globalSafeScriptCall) do={\
    \n    :global globalSafeScriptCall do={\
    \n\
    \n        :local targetScript [:tostr \$1]\
    \n        :local context \"\"\
    \n        :if ([:len \$2] > 0) do={ :set context \" (\$2 context)\" }\
    \n        :local itsOk false\
    \n\
    \n        :if ([:len \$targetScript] = 0) do={ :return \$itsOk }\
    \n\
    \n        :if ([:len [/system script find name=\$targetScript]] = 0) do={\
    \n            :log warning \"Script not found: \$targetScript\$context\"\
    \n            :put \"Script not found: \$targetScript\$context\"\
    \n            :return \$itsOk\
    \n        }\
    \n\
    \n        :onerror errorDescr in={\
    \n            :log warning \"Starting script: \$targetScript\$context\"\
    \n            :put \"Starting script: \$targetScript\$context\"\
    \n            /system script run \$targetScript\
    \n            :set itsOk true\
    \n        } do={\
    \n            :log error \"FAIL Starting script: \$targetScript\$context: \$errorDescr\"\
    \n            :put \"FAIL Starting script: \$targetScript\$context\"\
    \n        }\
    \n\
    \n        :return \$itsOk\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# \$globalSecret\
    \n# \$globalSecret get <name>\
    \n# \$globalSecret set <name> password=<password>\
    \n# \$globalSecret remove <name>\
    \n# \$globalSecret print\
    \n# stored entries are marked in /ppp secret with comment \"used by \$SECRET\" - this marker is data on devices, do not rename\
    \n:global globalSecret\
    \n:if (!any \$globalSecret) do={\
    \n    :global globalSecret do={\
    \n\
    \n        :global globalSecret\
    \n\
    \n        # helpers\
    \n        :local fixprofile do={\
    \n            :if ([/ppp profile find name=\"null\"]) do={ :put \"nothing\" } else={\
    \n                /ppp profile add bridge-learning=no change-tcp-mss=no local-address=0.0.0.0 name=\"null\" only-one=yes remote-address=0.0.0.0 session-timeout=1s use-compression=no use-encryption=no use-mpls=no use-upnp=no\
    \n            }\
    \n        }\
    \n\
    \n        :local lppp [:len [/ppp secret find where name=\$2]]\
    \n\
    \n        :local checkexist do={\
    \n            :if (\$lppp = 0) do={\
    \n                :error \"\\\$globalSecret: cannot find \$2 in secret store\"\
    \n            }\
    \n        }\
    \n\
    \n        # \$globalSecret\
    \n        :if ([:typeof \$1] != \"str\") do={\
    \n            :put \"\\\$globalSecret\"\
    \n            :put \"   uses /ppp/secrets to store stuff like REST apikeys, or other sensitive data\"\
    \n            :put \"\\t\\\$globalSecret print - prints stored secret passwords\"\
    \n            :put \"\\t\\\$globalSecret get <name> - gets a stored secret\"\
    \n            :put \"\\t\\\$globalSecret set <name> password=\\\"YOUR_SECRET\\\" - sets a secret password\"\
    \n            :put \"\\t\\\$globalSecret remove <name> - removes a secret\"\
    \n            :return\
    \n        }\
    \n\
    \n        # \$globalSecret print\
    \n        :if (\$1~\"^pr\") do={\
    \n            /ppp secret print where comment~\"\\\\\\\$SECRET\"\
    \n            :return\
    \n        }\
    \n\
    \n        # \$globalSecret get\
    \n        :if (\$1~\"get\") do={\
    \n            \$checkexist\
    \n            :local sid [/ppp secret find where name=\$2]\
    \n            :if ([:len \$sid] = 0) do={ :error \"\\\$globalSecret: cannot find \$2 in secret store\" }\
    \n            :return [/ppp secret get \$sid password]\
    \n        }\
    \n\
    \n        # \$globalSecret set\
    \n        :if (\$1~\"set|add\") do={\
    \n            :if ([:typeof \$password] = \"str\") do={} else={ :error \"\\\$globalSecret: password= required\" }\
    \n            :if (\$lppp = 0) do={\
    \n                /ppp secret add name=\$2 password=\$password\
    \n            } else={\
    \n                /ppp secret set [/ppp secret find where name=\$2] password=\$password\
    \n            }\
    \n            \$fixprofile\
    \n            /ppp secret set [/ppp secret find where name=\$2] comment=\"used by \\\$SECRET\"\
    \n            /ppp secret set [/ppp secret find where name=\$2] profile=\"null\"\
    \n            /ppp secret set [/ppp secret find where name=\$2] service=\"async\"\
    \n            :return [\$globalSecret get \$2]\
    \n        }\
    \n\
    \n        # \$globalSecret remove\
    \n        :if (\$1~\"rm|rem|del\") do={\
    \n            \$checkexist\
    \n            :return [/ppp secret remove [/ppp secret find where name=\$2]]\
    \n        }\
    \n\
    \n        :error \"\\\$globalSecret: bad command\"\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# \$globalTgMessage value=\"text\"\
    \n:global globalTgMessage\
    \n:if (!any \$globalTgMessage) do={\
    \n    :global globalTgMessage do={\
    \n\
    \n        :global globalNoteMe\
    \n        :global globalSecret\
    \n\
    \n        :local tToken \"\$[\$globalSecret get TELEGRAM_TOKEN]\"\
    \n        :local tGroupId \"\$[\$globalSecret get TELEGRAM_CHAT_ID]\"\
    \n        :local tUrl \"https://relay.usetheforce.io/bot\$tToken/sendMessage\\\?chat_id=\$tGroupId\"\
    \n\
    \n        :local sysname (\"#\" . [/system identity get name])\
    \n        :local scriptname [:jobname]\
    \n\
    \n        :local tgMessage (\"\$scriptname %C2%A9%EF%B8%8F \$sysname: \$value\")\
    \n\
    \n        :local state \"Sending telegram message... \$tgMessage\"\
    \n        \$globalNoteMe value=\$tgMessage\
    \n\
    \n        :onerror errorDescr in={\
    \n            /tool fetch http-method=post mode=https url=\"\$tUrl\" http-data=\"text=\$tgMessage\" keep-result=no\
    \n        } do={\
    \n            :set state \"Telegram notify error: \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n        }\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# \$globalIPSECPolicyUpdateViaSSH 1.2.3.4\
    \n:global globalIPSECPolicyUpdateViaSSH\
    \n:if (!any \$globalIPSECPolicyUpdateViaSSH) do={\
    \n    :global globalIPSECPolicyUpdateViaSSH do={\
    \n\
    \n        :global globalRemoteIp\
    \n        :global globalNoteMe\
    \n\
    \n        :if ([:len \$1] > 0) do={\
    \n            :global globalRemoteIp (\"\$1\" . \"/32\")\
    \n        }\
    \n\
    \n        :if (!any \$globalRemoteIp) do={\
    \n            :global globalRemoteIp \"0.0.0.0/32\"\
    \n        }\
    \n\
    \n        :local state \"RPC... \$value\"\
    \n        \$globalNoteMe value=\$state\
    \n        :local count [:len [/system script find name=\"doUpdatePoliciesRemotely\"]]\
    \n        :if (\$count > 0) do={\
    \n            :set state \"Starting policies process... \$globalRemoteIp\"\
    \n            \$globalNoteMe value=\$state\
    \n            /system script run doUpdatePoliciesRemotely\
    \n        }\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# \$globalNewNetworkMember ip=192.168.90.130 mac=50:DE:06:25:C2:FC gip=192.168.98.130 comm=iPadAlxPro ssid=\"WiFi 5\"\
    \n:global globalNewNetworkMember\
    \n:if (!any \$globalNewNetworkMember) do={\
    \n    :global globalNewNetworkMember do={\
    \n\
    \n        :global globalNoteMe\
    \n\
    \n        # to prevent connection\
    \n        :local guestDhcp \"guest-dhcp-server\"\
    \n\
    \n        # to allow connection\
    \n        :local mainDhcp \"main-dhcp-server\"\
    \n\
    \n        # when DHCP not using (add arp for leases)\
    \n        :local arpInterface \"main-infrastructure-br\"\
    \n        :local state \"Adding new network member... \"\
    \n        \$globalNoteMe value=\$state\
    \n\
    \n        # incoming named params\
    \n        :local newIp [:tostr \$ip]\
    \n        :local newBlockedIp [:tostr \$gip]\
    \n        :local newMac [:tostr \$mac]\
    \n        :local comment [:tostr \$comm]\
    \n        :local newSsid [:tostr \$ssid]\
    \n        :if ([:len \$newIp] > 0) do={\
    \n            :if ([:typeof [:toip \$newIp]] != \"ip\") do={\
    \n                :set state \"Error: bad IP parameter passed - (\$newIp)\"\
    \n                \$globalNoteMe value=\$state\
    \n                :return false\
    \n            }\
    \n        } else={\
    \n            :set state \"Error: bad IP parameter passed - (\$newIp)\"\
    \n            \$globalNoteMe value=\$state\
    \n            :return false\
    \n        }\
    \n\
    \n        :onerror errorDescr in={\
    \n\
    \n            :set state \"Removing existing DHCP configuration for (\$newIp/\$newMac) on \$mainDhcp\"\
    \n            \$globalNoteMe value=\$state\
    \n            /ip dhcp-server lease remove [find address=\$newIp]\
    \n            /ip dhcp-server lease remove [find mac-address=\$newMac]\
    \n\
    \n            :set state \"Adding DHCP configuration for (\$newIp/\$newMac) on \$mainDhcp\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            :if ([:len [/ip dhcp-server find where name=\"\$mainDhcp\"]] > 0) do={\
    \n                /ip dhcp-server lease add address=\$newIp mac-address=\$newMac server=\$mainDhcp comment=\$comment\
    \n                \$globalNoteMe value=\"Done\"\
    \n            } else={\
    \n                :set state \"Cant find DHCP server \$mainDhcp. SKIPPED.\"\
    \n                \$globalNoteMe value=\$state\
    \n            }\
    \n\
    \n        } do={\
    \n            :set state \"Error: something fail on DHCP configuration 'allow' step for (\$newIp/\$newMac) on \$mainDhcp: \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n            :return false\
    \n        }\
    \n\
    \n        :onerror errorDescr in={\
    \n\
    \n            /ip dhcp-server lease remove [find address=\$newBlockedIp]\
    \n            :set state \"Adding DHCP configuration for (\$newBlockedIp/\$newMac) on \$guestDhcp (preventing connections to guest network)\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            :if ([:len [/ip dhcp-server find where name=\"\$guestDhcp\"]] > 0) do={\
    \n                /ip dhcp-server lease add address=\$newBlockedIp block-access=yes mac-address=\$newMac server=\$guestDhcp comment=(\$comment . \"(blocked)\")\
    \n                \$globalNoteMe value=\"Done\"\
    \n            } else={\
    \n                :set state \"Cant find DHCP server \$guestDhcp. SKIPPED.\"\
    \n                \$globalNoteMe value=\$state\
    \n            }\
    \n\
    \n        } do={\
    \n            :set state \"Error: something fail on DHCP configuration 'block' step for (\$newBlockedIp/\$newMac) on \$guestDhcp: \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n            :return false\
    \n        }\
    \n\
    \n        :onerror errorDescr in={\
    \n\
    \n            :set state \"Adding ARP static entries for (\$newBlockedIp/\$newMac) on \$mainDhcp\"\
    \n            \$globalNoteMe value=\$state\
    \n            /ip arp remove [find address=\$newIp]\
    \n            /ip arp remove [find address=\$newBlockedIp]\
    \n            /ip arp remove [find mac-address=\$newMac]\
    \n\
    \n            :if ([:len [/interface find where name=\"\$arpInterface\"]] > 0) do={\
    \n                /ip arp add address=\$newIp interface=\$arpInterface mac-address=\$newMac comment=\$comment\
    \n                \$globalNoteMe value=\"Done\"\
    \n            } else={\
    \n                :set state \"Cant find interface \$arpInterface. SKIPPED.\"\
    \n                \$globalNoteMe value=\$state\
    \n            }\
    \n\
    \n        } do={\
    \n            :set state \"Error: something fail on ARP configuration step: \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n            :return false\
    \n        }\
    \n\
    \n        :onerror errorDescr in={\
    \n\
    \n            :set state \"Adding CAPs ACL static entries for (\$newBlockedIp/\$newMac) on \$newSsid\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            # avoid parse errors using Execute when no wireless package installed\
    \n            :if ([:len [/system package find where name=\"wireless\" and disabled=no]] > 0) do={\
    \n                :local cmd \"/caps-man access-list remove [find mac-address=\$newMac];\"\
    \n                :local jobid [:execute script=\$cmd]\
    \n\
    \n                :set cmd \"/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=\\\"\$comment\\\" disabled=no mac-address=\$newMac ssid-regexp=\\\"\$newSsid\\\" place-before=1;\"\
    \n                :set jobid [:execute script=\$cmd]\
    \n            }\
    \n\
    \n        } do={\
    \n            :set state \"Error: something fail on CAPS configuration step: \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n            :return false\
    \n        }\
    \n\
    \n        :return true\
    \n\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# \$globalNewClientCert argClients=\"anna.ipsec, mikrouter.ipsec\" argUsage=\"tls-client,digital-signature,key-encipherment\"\
    \n# \$globalNewClientCert argClients=\"anna.capsman, mikrouter.capsman\" argUsage=\"digital-signature,key-encipherment\"\
    \n# \$globalNewClientCert argClients=\"anna.proxy\" argUsage=\"tls-server,digital-signature,key-encipherment\" addSAN=\"*.anna.home\"\
    \n# \$globalNewClientCert argClients=\"185.13.148.14\" argUsage=\"tls-server\" argBindAsIP=\"any\"\
    \n:global globalNewClientCert\
    \n:if (!any \$globalNewClientCert) do={\
    \n    :global globalNewClientCert do={\
    \n\
    \n        # generates IPSEC certs CLIENT TEMPLATE, then requests SCEP to sign it\
    \n        # This script is a SCEP-client, it request the server to provide a new certificate\
    \n        # it ONLY form the request via API to remote SCEP server\
    \n\
    \n        # incoming named params\
    \n        :local clients [:tostr \$argClients]\
    \n        :local prefs [:tostr \$argUsage]\
    \n        :local asIp \$argBindAsIP\
    \n        :local san \$addSAN\
    \n\
    \n        # scope global functions\
    \n        :global globalNoteMe\
    \n        :global globalSecret\
    \n\
    \n        :local state \"\"\
    \n\
    \n        :if ([:len \$clients] > 0) do={\
    \n            :if ([:typeof [:tostr \$clients]] != \"str\") do={\
    \n                :set state \"Error: bad 'clients' parameter passed - (\$clients)\"\
    \n                \$globalNoteMe value=\$state\
    \n                :return false\
    \n            }\
    \n        } else={\
    \n            :set state \"Error: bad 'clients' parameter passed - (\$clients)\"\
    \n            \$globalNoteMe value=\$state\
    \n            :return false\
    \n        }\
    \n\
    \n        :onerror errorDescr in={\
    \n\
    \n            # clients\
    \n            :local ids [:toarray \"\$clients\"]\
    \n            :local fakeDomain \"myvpn.fake.org\"\
    \n            :local scepAlias \"CHR\"\
    \n            :set state \"Started requests generation\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            # this fields should be empty IPSEC/ike2/RSA to work, i can't get it functional with filled fields\
    \n            :local country \"RU\"\
    \n            :local certState \"MSC\"\
    \n            :local locality \"Moscow\"\
    \n            :local organization \"IKEv2 Home\"\
    \n            :local unit \"IKEv2 Mikrotik\"\
    \n\
    \n            :local keySize \"2048\"\
    \n\
    \n            :local scepUrl \"http://185.13.148.14/scep/grant\"\
    \n\
    \n            :local tname \"\"\
    \n            :foreach userName in=\$ids do={\
    \n\
    \n                :if ([:typeof \$san] != \"str\") do={\
    \n                    :set san \$userName\
    \n                }\
    \n\
    \n                # create a client certificate (that will be just a template while not signed)\
    \n                :if ([:len \$asIp] > 0) do={\
    \n\
    \n                    :set state \"CLIENT TEMPLATE certificates generation as IP...  \$userName\"\
    \n                    \$globalNoteMe value=\$state\
    \n\
    \n                    :set tname \"S.\$userName@\$scepAlias\"\
    \n\
    \n                    :if ([:len [/certificate find where name=\"\$tname\"]] > 0) do={\
    \n                        :set state \"Error: found certificate named (\$tname) -  cannot create the same one\"\
    \n                        \$globalNoteMe value=\$state\
    \n                        :return false\
    \n                    } else={\
    \n                        /certificate add name=\"\$tname\" common-name=\"\$userName@\$scepAlias\" subject-alt-name=\"IP:\$userName,DNS:\$fakeDomain\" key-usage=\$prefs country=\"\$country\" state=\"\$certState\" locality=\"\$locality\" organization=\"\$organization\" unit=\"\$unit\" key-size=\"\$keySize\" days-valid=365\
    \n                    }\
    \n\
    \n                } else={\
    \n\
    \n                    :set state \"CLIENT TEMPLATE certificates generation as EMAIL...  \$userName\"\
    \n                    \$globalNoteMe value=\$state\
    \n\
    \n                    :set tname \"C.\$userName@\$scepAlias\"\
    \n\
    \n                    :if ([:len [/certificate find where name=\"\$tname\"]] > 0) do={\
    \n                        :set state \"Error: found certificate named (\$tname) -  cannot create the same one\"\
    \n                        \$globalNoteMe value=\$state\
    \n                        :return false\
    \n                    } else={\
    \n                        /certificate add name=\"\$tname\" common-name=\"\$userName@\$scepAlias\" subject-alt-name=\"email:\$userName@\$fakeDomain,DNS:\$san\" key-usage=\$prefs country=\"\$country\" state=\"\$certState\" locality=\"\$locality\" organization=\"\$organization\" unit=\"\$unit\" key-size=\"\$keySize\" days-valid=365\
    \n                    }\
    \n\
    \n                }\
    \n\
    \n                :set state \"Pushing sign request...\"\
    \n                \$globalNoteMe value=\$state\
    \n                /certificate add-scep template=\"\$tname\" scep-url=\"\$scepUrl\"\
    \n\
    \n                :delay 6s\
    \n\
    \n                # we now have to wait while on remote [mikrotik] this request will be granted and pushed back ready-to-use certificate\
    \n                :set state \"We now have to wait while on remote [mikrotik] this request will be granted and pushed back ready-to-use certificate... \"\
    \n                \$globalNoteMe value=\$state\
    \n\
    \n                :set state \"Proceed to remote SCEP please, find this request and approve it. I'll wait 30 seconds\"\
    \n                \$globalNoteMe value=\$state\
    \n\
    \n                :delay 30s\
    \n\
    \n                :local baseLength 5\
    \n                :for j from=1 to=\$baseLength do={\
    \n                    :if ([:len [/certificate find where status=\"idle\" name=\"\$tname\"]] > 0) do={\
    \n\
    \n                        :set state \"Got it at last. Exporting to file\"\
    \n                        \$globalNoteMe value=\$state\
    \n\
    \n                        /certificate set trusted=yes [find where name=\"\$tname\" and status=\"idle\"]\
    \n\
    \n                        # export the CA, client certificate, and private key\
    \n                        # Configure CERTIFICATE_EXPORT_PASSPHRASE in \$globalSecret before requesting export.\
    \n                        /certificate export-certificate [find where name=\"\$tname\" and status=\"idle\"] export-passphrase=\"\$[\$globalSecret get CERTIFICATE_EXPORT_PASSPHRASE]\" type=pkcs12\
    \n\
    \n                        :return true\
    \n\
    \n                    } else={\
    \n\
    \n                        :set state \"Waiting for mikrotik to download the certificate...\"\
    \n                        \$globalNoteMe value=\$state\
    \n                        :delay 8s\
    \n\
    \n                    }\
    \n                }\
    \n            }\
    \n\
    \n            :return false\
    \n\
    \n        } do={\
    \n            :set state \"Error: something fail on SCEP certificates issuing step: \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n            :return false\
    \n        }\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# :put [\$globalTimestamp]\
    \n# returns \"yyyyMMdd-HHmmss\" for both old and new RouterOS date formats\
    \n:global globalTimestamp\
    \n:if (!any \$globalTimestamp) do={\
    \n    :global globalTimestamp do={\
    \n        /system clock\
    \n        :local vdate [get date]\
    \n        :local vtime [get time]\
    \n        :local vdoff [:toarray \"0,4,5,7,8,10\"]\
    \n        :local mon2 [:pick \$vdate (\$vdoff->2) (\$vdoff->3)]\
    \n        :local mon [:tonum \$mon2]\
    \n        :if (\$vdate ~ \".../../....\") do={\
    \n            :set vdoff [:toarray \"7,11,1,3,4,6\"]\
    \n            :set mon ([:find \"xxanebarprayunulugepctovecANEBARPRAYUNULUGEPCTOVEC\" [:pick \$vdate (\$vdoff->2) (\$vdoff->3)] -1] / 2)\
    \n            :if (\$mon > 12) do={ :set mon (\$mon - 12) }\
    \n            :set mon2 [:pick (100 + \$mon) 1 3]\
    \n        }\
    \n        :local yyyy [:pick \$vdate (\$vdoff->0) (\$vdoff->1)]\
    \n        :local dd [:pick \$vdate (\$vdoff->4) (\$vdoff->5)]\
    \n        :local hh [:pick \$vtime 0 2]\
    \n        :local mm [:pick \$vtime 3 5]\
    \n        :local ss [:pick \$vtime 6 8]\
    \n\
    \n        :return \"\$yyyy\$mon2\$dd-\$hh\$mm\$ss\"\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# \$globalCallFetch \"/tool fetch url=sftp://host:port/dst src-path=file user=u password=p upload=yes\"\
    \n# calls Fetch as a background job and reports its output\
    \n:global globalCallFetch\
    \n:if (!any \$globalCallFetch) do={\
    \n    :global globalCallFetch do={\
    \n\
    \n        :global globalNoteMe\
    \n        :global globalTimestamp\
    \n        :global globalFetchWaitTicks\
    \n\
    \n        :if ([:len \$1] > 0) do={\
    \n\
    \n            :local fetchCmd \"\$1\"\
    \n\
    \n            :local state \"I'm now putting: \$fetchCmd\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            :local stamp [\$globalTimestamp]\
    \n\
    \n            :local salt [:rndstr length=6 from=\"HtsP2n8qZ\"]\
    \n            :local logName \"RAM/\$stamp-\$salt.log.txt\"\
    \n\
    \n            /file remove [find where name=\"\$logName\"]\
    \n\
    \n            :local jobid [:execute file=\$logName script=\$fetchCmd]\
    \n\
    \n            :set state \"Waiting the end of process for protocol \$logName to be ready, max 30 seconds...\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            :set globalFetchWaitTicks 0\
    \n            :while (([:len [/system script job find where .id=\$jobid]] = 1) && (\$globalFetchWaitTicks < 30)) do={\
    \n                :set globalFetchWaitTicks (\$globalFetchWaitTicks + 1)\
    \n                :delay 1s\
    \n\
    \n                :set state \"waiting fetch result... \$globalFetchWaitTicks\"\
    \n                \$globalNoteMe value=\$state\
    \n            }\
    \n\
    \n            :set state \"Done. Elapsed Seconds: \$globalFetchWaitTicks\\r\\n\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            :if ([:len [/file find where name=\"\$logName\"]] = 1) do={\
    \n\
    \n                :local filecontent [/file get [/file find where name=\"\$logName\"] contents]\
    \n                :set state \"Result of Fetch:\\r\\n****************************\\r\\n\$filecontent\\r\\n****************************\"\
    \n                \$globalNoteMe value=\$state\
    \n\
    \n                /file remove [find where name=\"\$logName\"]\
    \n\
    \n            } else={\
    \n\
    \n                :set state \"Result of Fetch:\\r\\n****************************\\r\\n 30Sec Timeout exceeded - still no log file \\r\\n****************************\"\
    \n                \$globalNoteMe value=\$state\
    \n\
    \n            }\
    \n        }\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# :put [\$globalOnPrimaryPartition]\
    \n# test if we are boot up from a primary partition (not fallback or recovery); predicate - returns true/false\
    \n:global globalOnPrimaryPartition\
    \n:if (!any \$globalOnPrimaryPartition) do={\
    \n    :global globalOnPrimaryPartition do={\
    \n\
    \n        :global globalNoteMe\
    \n\
    \n        :local partitionName \"primary\"\
    \n        :local onPrimaryPartition false\
    \n        :local state \"\"\
    \n\
    \n        :local partitionsActivated [system/device-mode/get partitions]\
    \n\
    \n        :if (!\$partitionsActivated) do={\
    \n            :set state \"Investigation result - partitions disabled\"\
    \n            \$globalNoteMe value=\$state\
    \n            :set onPrimaryPartition true\
    \n            :return \$onPrimaryPartition\
    \n        }\
    \n\
    \n        :local partition\
    \n        :onerror errorDescr in={\
    \n\
    \n            # device may have no /partitions command if it is 16Mb\
    \n            :set partition [/partitions find name=\$partitionName]\
    \n\
    \n        } do={\
    \n\
    \n            :set state \"Investigation result - device has no /partitions submenu\"\
    \n            \$globalNoteMe value=\$state\
    \n            :set onPrimaryPartition true\
    \n            :return \$onPrimaryPartition\
    \n        }\
    \n\
    \n        :onerror errorDescr in={\
    \n\
    \n            # test if it exist in /partitions\
    \n            :if ([:len \$partition] > 0) do={\
    \n                :local running [/partition get \$partition running]\
    \n                :if (\$running) do={\
    \n                    :set onPrimaryPartition true\
    \n                    :error \"primary active\"\
    \n                } else={\
    \n                    :set onPrimaryPartition false\
    \n                    :error \"primary inactive\"\
    \n                }\
    \n            } else={\
    \n                :set onPrimaryPartition true\
    \n                :error \"partitions not set\"\
    \n            }\
    \n\
    \n        } do={\
    \n\
    \n            :set state \"Investigation result - \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            :return \$onPrimaryPartition\
    \n        }\
    \n\
    \n        :return \$onPrimaryPartition\
    \n    }\
    \n}\
    \n\
    \n# Example call\
    \n# :local errorDef [\$globalCallSSH \":global globalRemoteIp 1.2.3.4/32\"]\
    \n# operation - returns \"\" on success, error text otherwise; SSH target is taken from \$globalSecret SSH_*\
    \n:global globalCallSSH\
    \n:if (!any \$globalCallSSH) do={\
    \n    :global globalCallSSH do={\
    \n\
    \n        :global globalNoteMe\
    \n        :global globalSecret\
    \n\
    \n        :local cmd \$1\
    \n\
    \n        :if ([:len \$cmd] = 0) do={\
    \n            :return \"RPC: ssh empty command\"\
    \n        }\
    \n\
    \n        :local sshServer \"\$[\$globalSecret get SSH_SERVER]\"\
    \n        :local sshPort \"\$[\$globalSecret get SSH_PORT]\"\
    \n        :local sshUser \"\$[\$globalSecret get SSH_USER]\"\
    \n        :local sshPass \"\$[\$globalSecret get SSH_PASSWORD]\"\
    \n\
    \n        :local state \"\"\
    \n\
    \n        :onerror errorDescr in={\
    \n\
    \n            :set state \"Call: /system ssh-exec address=\$sshServer user=\$sshUser port=\$sshPort command=\\\"\$cmd\\\" as-value\"\
    \n            \$globalNoteMe value=\$state\
    \n\
    \n            :local result [/system ssh-exec address=\$sshServer user=\$sshUser password=\$sshPass port=\$sshPort command=\$cmd as-value]\
    \n            :local exitCode ([\$result]->\"exit-code\")\
    \n\
    \n            :if (\$exitCode != 0) do={\
    \n                :set state \"RPC: ssh command returned exit code (\$exitCode)\"\
    \n            } else={\
    \n                # no errors - success operation\
    \n                :set state \"\"\
    \n            }\
    \n\
    \n        } do={\
    \n            :set state \"RPC: ssh error when \$state: \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n        }\
    \n\
    \n        :return \$state\
    \n    }\
    \n}\
    \n"
/system script add comment="Common backup script to ftp/email using both raw/plain formats. Can also be used to collect Git config history" dont-require-permissions=yes name=doBackup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\
    \n:local scriptname \"doBackup\"\
    \n:global globalScriptBeforeRun\
    \n\$globalScriptBeforeRun \$scriptname\
    \n\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n:global globalSecret\
    \n:global globalTimestamp\
    \n:global globalCallFetch\
    \n:global globalCallSSH\
    \n:global globalOnPrimaryPartition\
    \n:local itsOk true\
    \n:local state \"\"\
    \n\
    \n:local rosVer [:tonum [:pick [/system resource get version] 0 1]]\
    \n:local sysver \"NA\"\
    \n:if ([:len [/system package find where name=\"system\" and disabled=no]] > 0 and \$rosVer = 6) do={\
    \n    :set sysver [/system package get system version]\
    \n}\
    \n:if ([:len [/system package find where name=\"routeros\" and disabled=no]] > 0 and \$rosVer = 7) do={\
    \n    :set sysver [/system package get routeros version]\
    \n}\
    \n\
    \n:local useSysBackup true\
    \n:local useEncryption false\
    \n:local useRawExport true\
    \n:local useVerboseRawExport false\
    \n\
    \n# directories have to exist!\
    \n:local useFtp true\
    \n:local ftpServer \"\$[\$globalSecret get SSH_SERVER]\"\
    \n:local ftpPort \"\$[\$globalSecret get SSH_PORT]\"\
    \n:local ftpUser \"\$[\$globalSecret get SSH_USER]\"\
    \n:local ftpPass \"\$[\$globalSecret get SSH_PASSWORD]\"\
    \n:local ftpRoot \"REPO/backups/\"\
    \n:local useFtpGit true\
    \n:local ftpRawGitName (\"REPO/raw/rawconf_\" . \$sysname . \"_latest.rsc\")\
    \n\
    \n:local sysnote [/system note get note]\
    \n\
    \n:local stamp [\$globalTimestamp]\
    \n\
    \n:local useSmtp true\
    \n:local smtpAddress \"defm.kopcap@gmail.com\"\
    \n:local smtpSubject \"\$sysname Full Backup (\$stamp)\"\
    \n:local smtpBody \"\$sysname full Backup file see in attachment.\\n \$sysnote\"\
    \n\
    \n# preflight\
    \n:if (![\$globalOnPrimaryPartition]) do={\
    \n    :set state \"WARNING: the system booted up from fallback partition - skipping backup!\"\
    \n    :log error \$state\
    \n    \$globalNoteMe value=\$state\
    \n    :error \$state\
    \n}\
    \n\
    \n:onerror errorDescr in={\
    \n    :local smtpserv [:resolve \"\$ftpServer\"]\
    \n} do={\
    \n    :set state \"WARNING: FTP server '\$ftpServer' unreachable - skipping backup!\"\
    \n    :log error \$state\
    \n    \$globalNoteMe value=\$state\
    \n    :error \$state\
    \n}\
    \n\
    \n:local fname \"BACKUP-\$sysname-\$stamp\"\
    \n\
    \n:onerror errorDescr in={\
    \n\
    \n    :if (\$useSysBackup) do={\
    \n        :set state \"Saving system backup \$fname.backup\"\
    \n        \$globalNoteMe value=\$state\
    \n        :if (\$useEncryption) do={ /system backup save name=(\$fname . \".backup\") }\
    \n        :if (!\$useEncryption) do={ /system backup save dont-encrypt=yes name=(\$fname . \".backup\") }\
    \n        :delay 2s\
    \n        \$globalNoteMe value=\"System Backup Finished\"\
    \n    }\
    \n\
    \n    :if (\$useRawExport and \$useFtpGit) do={\
    \n        :set state \"Exporting raw configuration \$fname.safe.rsc\"\
    \n        \$globalNoteMe value=\$state\
    \n        # show sensitive data\
    \n        :if (\$useVerboseRawExport) do={ /export show-sensitive terse verbose file=(\$fname . \".safe.rsc\") }\
    \n        :if (!\$useVerboseRawExport) do={ /export show-sensitive terse file=(\$fname . \".safe.rsc\") }\
    \n        :delay 2s\
    \n        \$globalNoteMe value=\"Raw configuration script export Finished\"\
    \n    }\
    \n\
    \n    :delay 5s\
    \n\
    \n    # make some backdoor\
    \n    :local wanIp [/ip cloud get public-address]\
    \n    :local remoteCommand \"{ /ip/firewall/address-list remove [find list=alist-fw-knockknock address=\$wanIp]; /ip/firewall/address-list/add address=\$wanIp list=alist-fw-knockknock comment=doBackup timeout=5m dynamic=yes }\"\
    \n\
    \n    :set state \"Making SFTP backdoor for \$wanIp via SSH\"\
    \n    \$globalNoteMe value=\$state\
    \n\
    \n    :local errorDef [\$globalCallSSH \$remoteCommand]\
    \n    :if ([:len \$errorDef] > 0) do={ :error \$errorDef }\
    \n\
    \n    :set state \"Success RPC call: \$state\"\
    \n    \$globalNoteMe value=\$state\
    \n\
    \n    # we have to wait while backdoor alist-fw-ssh-stage1 flushes our first-call Ip, otherwise we get banned\
    \n    :set state \"Waiting backdoor for \$wanIp for some seconds..\"\
    \n    \$globalNoteMe value=\$state\
    \n    :delay 15s\
    \n\
    \n} do={\
    \n    :set state \"Error When \$state: \$errorDescr\"\
    \n    \$globalNoteMe value=\$state\
    \n    :set itsOk false\
    \n}\
    \n\
    \n:if (\$itsOk) do={\
    \n\
    \n    :foreach backupFile in=[/file find] do={\
    \n\
    \n        :local buFile [/file get \$backupFile name]\
    \n\
    \n        :if ([:typeof [:find \$buFile \$fname]] != \"nil\") do={\
    \n\
    \n            :local itsSrc (\$buFile ~ \".safe.rsc\")\
    \n\
    \n            :if (\$useFtp) do={\
    \n\
    \n                :onerror errorDescr in={\
    \n                    :set state \"Uploading \$buFile to FTP (\$ftpRoot\$buFile)\"\
    \n                    \$globalNoteMe value=\$state\
    \n\
    \n                    :local dst \"\$ftpRoot\$buFile\"\
    \n                    :local fetchCmd \"/tool fetch url=sftp://\$ftpServer:\$ftpPort/\$dst src-path=\$buFile user=\$ftpUser password=\$ftpPass upload=yes\"\
    \n                    \$globalCallFetch \$fetchCmd\
    \n\
    \n                    \$globalNoteMe value=\"Done\"\
    \n                } do={\
    \n                    :set state \"Error When \$state: \$errorDescr\"\
    \n                    \$globalNoteMe value=\$state\
    \n                    :set itsOk false\
    \n                }\
    \n\
    \n                # special ftp upload for git purposes\
    \n                :if (\$itsSrc and \$useFtpGit) do={\
    \n                    :onerror errorDescr in={\
    \n                        :set state \"Uploading \$buFile to GIT-FTP (RAW, \$ftpRawGitName)\"\
    \n                        \$globalNoteMe value=\$state\
    \n\
    \n                        :local dst \"\$ftpRawGitName\"\
    \n                        :local fetchCmd \"/tool fetch url=sftp://\$ftpServer:\$ftpPort/\$dst src-path=\$buFile user=\$ftpUser password=\$ftpPass upload=yes\"\
    \n                        \$globalCallFetch \$fetchCmd\
    \n\
    \n                        \$globalNoteMe value=\"Done\"\
    \n                    } do={\
    \n                        :set state \"Error When \$state: \$errorDescr\"\
    \n                        \$globalNoteMe value=\$state\
    \n                        :set itsOk false\
    \n                    }\
    \n                }\
    \n            }\
    \n\
    \n            :if (\$useSmtp and !\$itsSrc) do={\
    \n                :onerror errorDescr in={\
    \n                    :set state \"Uploading \$buFile to SMTP\"\
    \n                    \$globalNoteMe value=\$state\
    \n\
    \n                    # email works in background, delay needed\
    \n                    /tool e-mail send to=\$smtpAddress body=\$smtpBody subject=\$smtpSubject file=\$buFile tls=starttls\
    \n\
    \n                    # waiting for email to be delivered\
    \n                    :delay 15s\
    \n\
    \n                    :if ([/tool e-mail get last-status] != \"succeeded\") do={\
    \n                        :error \"e-mail last-status is not succeeded\"\
    \n                    }\
    \n\
    \n                    \$globalNoteMe value=\"Done\"\
    \n                } do={\
    \n                    :set state \"Error When \$state: \$errorDescr\"\
    \n                    \$globalNoteMe value=\$state\
    \n                    :set itsOk false\
    \n                }\
    \n            }\
    \n\
    \n            :delay 2s\
    \n            /file remove \$backupFile\
    \n        }\
    \n    }\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: automatic backup completed\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n    \$globalTgMessage value=\$inf\
    \n    :error \$inf\
    \n}\
    \n"
/system script add comment="Periodically renews password for some user accounts and sends a email" dont-require-permissions=yes name=doRandomGen owner=owner policy=ftp,reboot,read,write,policy,test,password,sensitive source=":local sysname [/system identity get name]\
    \n:local scriptname \"doRandomGen\"\
    \n:global globalScriptBeforeRun\
    \n\$globalScriptBeforeRun \$scriptname\
    \n\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n:global globalTimestamp\
    \n:local itsOk true\
    \n:local state \"\"\
    \n\
    \n:local stamp [\$globalTimestamp]\
    \n\
    \n:local rosVer [:tonum [:pick [/system resource get version] 0 1]]\
    \n:local sysver \"NA\"\
    \n:if ([:len [/system package find where name=\"system\" and disabled=no]] > 0 and \$rosVer = 6) do={\
    \n    :set sysver [/system package get system version]\
    \n}\
    \n:if ([:len [/system package find where name=\"routeros\" and disabled=no]] > 0 and \$rosVer = 7) do={\
    \n    :set sysver [/system package get routeros version]\
    \n}\
    \n\
    \n:local smtpAddress \"defm.kopcap@gmail.com\"\
    \n:local smtpSubject \"\$sysname pwd restoration (\$stamp)\"\
    \n:local smtpBody \"\"\
    \n\
    \n:set state \"Starting reserve password generator Script...\"\
    \n\$globalNoteMe value=\$state\
    \n\
    \n# special password appendix - current month 3chars\
    \n:local date [/system clock get date]\
    \n:local monthNum [:tonum [:pick \$date 5 7]]\
    \n:local months {\"jan\";\"feb\";\"mar\";\"apr\";\"may\";\"jun\";\"jul\";\"aug\";\"sep\";\"oct\";\"nov\";\"dec\"}\
    \n:local pfx [:pick \$months (\$monthNum - 1)]\
    \n\
    \n:local newPassword [:rndstr length=6 from=\"0123456789dglpqwBHNTQV\"]\
    \n\
    \n:set state \"Randomized: '\$newPassword'\"\
    \n\$globalNoteMe value=\$state\
    \n\
    \n# doing simple salt\
    \n:set newPassword (\$pfx . \$newPassword)\
    \n\
    \n/user set [find name=reserved] password=\$newPassword\
    \n\
    \n# crop appendix\
    \n:local halfPass [:pick \$newPassword 3 11]\
    \n\
    \n:onerror errorDescr in={\
    \n    :set state \"Sending backup password\"\
    \n    \$globalNoteMe value=\$state\
    \n\
    \n    :set smtpBody \"Device additional password: '***\$halfPass'\"\
    \n\
    \n    # email works in background, delay needed\
    \n    /tool e-mail send to=\$smtpAddress body=\$smtpBody subject=\$smtpSubject tls=starttls\
    \n\
    \n    # waiting for email to be delivered\
    \n    :delay 15s\
    \n\
    \n    :if ([/tool e-mail get last-status] != \"succeeded\") do={\
    \n        :error \"e-mail last-status is not succeeded\"\
    \n    }\
    \n\
    \n    \$globalNoteMe value=\"Done\"\
    \n\
    \n} do={\
    \n    :set state \"Error When \$state: \$errorDescr\"\
    \n    \$globalNoteMe value=\$state\
    \n    :set itsOk false\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: pwd restoration completed\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n    \$globalTgMessage value=\$inf\
    \n    :error \$inf\
    \n}\
    \n"
/system script add comment="Updates chosen scripts from Git/master (sheduler entry with the same name have to exist)" dont-require-permissions=yes name=doFreshTheScripts owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\
    \n:local scriptname \"doFreshTheScripts\"\
    \n:global globalScriptBeforeRun\
    \n\$globalScriptBeforeRun \$scriptname\
    \n\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n:local itsOk true\
    \n:local state \"\"\
    \n\
    \n:local gitHubUserName \"Defm\"\
    \n:local gitHubRepoName \"mikroconf\"\
    \n\
    \n# should be used for private repos\
    \n:local gitHubAccessToken \"\"\
    \n\
    \n:local requestUrl \"https://\$gitHubAccessToken@relay.usetheforce.io/\$gitHubUserName/\$gitHubRepoName/master/src/scripts/\"\
    \n\
    \n# whitelist: scripts absent on the device are skipped with a message\
    \n:local useUpdateList true\
    \n:local updateList [:toarray \"doBackup,doEnvironmentSetup,doEnvironmentClearance,doRandomGen,doFreshTheScripts,doCertificatesIssuing,doSCEPClientCertificatesIssuing,doNetwatchHost,doNetwatchDNS,doDHCPLeaseTrack,doIPSECPunch,doStartupScript,doHeatFlag,doPeriodicLogDump,doPeriodicLogParse,doTelegramNotify,doLEDoff,doLEDon,doCPUHighLoadReboot,doUpdatePoliciesRemotely,doUpdateExternalDNS,doSuperviseCHRviaSSH,doCoolConsole,doFlushLogs,doCloudBackup,doDumpTheScripts,doKeepScriptsOwner,doFreshDNSAddressLists,doPushStatsToInfluxDB,doCreateTrafficAccountingQueues,doCheckPingRate,doStaleTSLConnectionsTrack,doCollectSpeedStats,doWestminister,doBumerSound,doSomeAlarm,doImperialMarch,flush_dns\"]\
    \n\
    \n:foreach scriptName in=\$updateList do={\
    \n    :if ([:len [/system script find name=\$scriptName]] = 0) do={\
    \n        :set state \"Script '\$scriptName' skipped due to absence\"\
    \n        \$globalNoteMe value=\$state\
    \n    }\
    \n}\
    \n\
    \n:foreach scriptId in=[/system script find] do={\
    \n\
    \n    :local theScript [/system script get \$scriptId name]\
    \n\
    \n    :onerror errorDescr in={\
    \n\
    \n        :if (\$useUpdateList and [:len [find key=\$theScript in=\$updateList]] = 0) do={\
    \n            :set state \"Script '\$theScript' skipped due to setup\"\
    \n            \$globalNoteMe value=\$state\
    \n            :error \"skip-continue\"\
    \n        }\
    \n\
    \n        :set state \"/tool fetch url=\$requestUrl\$\$theScript.rsc.txt output=user as-value\"\
    \n        \$globalNoteMe value=\$state\
    \n\
    \n        # Please keep care about consistency if size over 4096 bytes\
    \n        :local answer [/tool fetch url=\"\$requestUrl\$\$theScript.rsc.txt\" output=user as-value]\
    \n        :local code (\$answer->\"data\")\
    \n        \$globalNoteMe value=\"Done\"\
    \n\
    \n        :set state \"Setting Up Script source for '\$theScript'\"\
    \n        \$globalNoteMe value=\$state\
    \n        /system script set \$theScript source=\"\$code\"\
    \n        \$globalNoteMe value=\"Done\"\
    \n\
    \n        :delay 1s\
    \n\
    \n    } do={\
    \n        :if (\$errorDescr != \"skip-continue\") do={\
    \n            :set state \"Error When \$state: \$errorDescr\"\
    \n            \$globalNoteMe value=\$state\
    \n            :set itsOk false\
    \n        }\
    \n    }\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: scripts refreshed\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n    \$globalTgMessage value=\$inf\
    \n    :error \$inf\
    \n}\
    \n"
/system script add comment="This will check for free CPU/RAM resources over \$ticks times to be more than \$CpuWarnLimit%/\$RamWarnLimit% each time. Will reboot the router when overload" dont-require-permissions=yes name=doCPUHighLoadReboot owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\r\
    \n:local scriptname \"doCPUHighLoadReboot\"\r\
    \n:global globalScriptBeforeRun\r\
    \n\$globalScriptBeforeRun \$scriptname\r\
    \n\r\
    \n:global globalNoteMe\r\
    \n:global globalTgMessage\r\
    \n:local itsOk true\r\
    \n:local state \"\"\r\
    \n\r\
    \n# available (free) resource (percent), set it to 90 for testing\r\
    \n:local ramWarnLimit 15\r\
    \n:local cpuWarnLimit 15\r\
    \n\r\
    \n:local ticks 7\r\
    \n:local delayTime 7\r\
    \n:local useProgressiveDelay true\r\
    \n\r\
    \n:local usedCpu [/system resource get cpu-load]\r\
    \n:local freeCpu (100 - \$usedCpu)\r\
    \n:local freeRam ((100 * [/system resource get free-memory]) / [/system resource get total-memory])\r\
    \n\r\
    \n:set state \"Checking for free CPU/RAM resources over \$ticks times to be more than \$cpuWarnLimit%/\$ramWarnLimit% each time\"\r\
    \n\$globalNoteMe value=\$state\r\
    \n\r\
    \n:set state \"Step 0: free CPU/RAM \$freeCpu%/\$freeRam%, going deeper..\"\r\
    \n\$globalNoteMe value=\$state\r\
    \n\r\
    \n:if (\$freeRam < \$ramWarnLimit or \$freeCpu < \$cpuWarnLimit) do={\r\
    \n    # this tick is high-HighLoad\r\
    \n    :set itsOk false\r\
    \n    :delay \$delayTime\r\
    \n}\r\
    \n\r\
    \n:for i from=1 to=\$ticks do={\r\
    \n\r\
    \n    :if (!\$itsOk) do={\r\
    \n        :set usedCpu [/system resource get cpu-load]\r\
    \n        :set freeCpu (100 - \$usedCpu)\r\
    \n        :set freeRam ((100 * [/system resource get free-memory]) / [/system resource get total-memory])\r\
    \n\r\
    \n        :set state \"Recalc stats\"\r\
    \n        \$globalNoteMe value=\$state\r\
    \n    }\r\
    \n\r\
    \n    :if (!\$itsOk and (\$freeRam < \$ramWarnLimit or \$freeCpu < \$cpuWarnLimit)) do={\r\
    \n\r\
    \n        # keep \$itsOk = false\r\
    \n        :local delaySec \$delayTime\r\
    \n        :if (\$useProgressiveDelay) do={\r\
    \n            :set delaySec (\$delayTime + \$i)\r\
    \n        }\r\
    \n\r\
    \n        :set state \"Step \$i: free CPU/RAM \$freeCpu%/\$freeRam%, its too low, sleep \$delaySec and recheck..\"\r\
    \n        \$globalNoteMe value=\$state\r\
    \n\r\
    \n        :delay \$delaySec\r\
    \n\r\
    \n    } else={\r\
    \n        # if one step is non-HighLoad, then the whole result is non-HighLoad\r\
    \n        :set itsOk true\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: cpu load ok\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: CPU load too high, I'm going reboot\"\r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    \$globalTgMessage value=\$inf\r\
    \n    /system reboot\r\
    \n}\r\
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
/system script add comment="periodically Wipes memory-configered logging buffers" dont-require-permissions=yes name=doFlushLogs owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\r\
    \n:local scriptname \"doFlushLogs\"\r\
    \n:global globalScriptBeforeRun\r\
    \n\$globalScriptBeforeRun \$scriptname\r\
    \n\r\
    \n:global globalNoteMe\r\
    \n:global globalTgMessage\r\
    \n:local itsOk true\r\
    \n:local state \"\"\r\
    \n\r\
    \n:onerror errorDescr in={\r\
    \n\r\
    \n    :set state \"FLUSHING logs..\"\r\
    \n    \$globalNoteMe value=\$state\r\
    \n\r\
    \n    /system/logging/action {\r\
    \n        :foreach memAction in=[find target=memory] do={\r\
    \n            :local actName [get value-name=name \$memAction]\r\
    \n            clear action=\$actName\r\
    \n        }\r\
    \n    }\r\
    \n\r\
    \n    \$globalNoteMe value=\"Done\"\r\
    \n\r\
    \n} do={\r\
    \n    :set state \"Error When \$state: \$errorDescr\"\r\
    \n    \$globalNoteMe value=\$state\r\
    \n    :set itsOk false\r\
    \n}\r\
    \n\r\
    \n:local inf \"\"\r\
    \n:if (\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: logs flushed\"\r\
    \n}\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\r\
    \n}\r\
    \n\r\
    \n\$globalNoteMe value=\$inf\r\
    \n\r\
    \n:if (!\$itsOk) do={\r\
    \n    \$globalTgMessage value=\$inf\r\
    \n    :error \$inf\r\
    \n}\r\
    \n"
/system script add comment="Fast cloud backup" dont-require-permissions=yes name=doCloudBackup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local sysname [/system identity get name]\
    \n:local scriptname \"doCloudBackup\"\
    \n:global globalScriptBeforeRun\
    \n\$globalScriptBeforeRun \$scriptname\
    \n\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n:global globalSecret\
    \n:global globalOnPrimaryPartition\
    \n:local itsOk true\
    \n:local state \"\"\
    \n\
    \n# Configure at runtime: \$globalSecret set BACKUP_PASSWORD password=\"YOUR_SECRET\"\
    \n:local backupPassword \"\$[\$globalSecret get BACKUP_PASSWORD]\"\
    \n\
    \n# preflight\
    \n:if (![\$globalOnPrimaryPartition]) do={\
    \n    :set state \"WARNING: the system booted up from fallback partition - skipping backup!\"\
    \n    :log error \$state\
    \n    \$globalNoteMe value=\$state\
    \n    :error \$state\
    \n}\
    \n\
    \n:onerror errorDescr in={\
    \n\
    \n    # we are not interested in output, but print without count-only is\
    \n    # required to fetch information from cloud\
    \n    /system backup cloud print as-value\
    \n\
    \n    :set state \"Creating and uploading cloud backup\"\
    \n    \$globalNoteMe value=\$state\
    \n\
    \n    :local backup ([/system/backup/cloud/find]->0)\
    \n    :if ([:typeof \$backup] = \"id\") do={\
    \n        /system/backup/cloud/upload-file action=create-and-upload password=\$backupPassword replace=\$backup\
    \n    } else={\
    \n        /system/backup/cloud/upload-file action=create-and-upload password=\$backupPassword\
    \n    }\
    \n\
    \n    :set backup ([/system/backup/cloud/find]->0)\
    \n    :local backupName [/system/backup/cloud/get \$backup name]\
    \n    :set state \"Cloud backup file uploaded: \$backupName\"\
    \n    \$globalNoteMe value=\$state\
    \n    \$globalNoteMe value=\"Done\"\
    \n\
    \n} do={\
    \n    :set state \"Error When \$state: \$errorDescr\"\
    \n    \$globalNoteMe value=\$state\
    \n    :set itsOk false\
    \n}\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n    :set inf \"\E2\9C\93 SUCCESS \$scriptname on \$sysname: cloud backup uploaded\"\
    \n}\
    \n\
    \n:if (!\$itsOk) do={\
    \n    :set inf \"\E2\9C\97 FAILED \$scriptname on \$sysname: \$state\"\
    \n}\
    \n\
    \n\$globalNoteMe value=\$inf\
    \n\
    \n:if (!\$itsOk) do={\
    \n    \$globalTgMessage value=\$inf\
    \n    :error \$inf\
    \n}\
    \n"
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!write,!policy,!sensitive
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!policy,!sensitive
/user group add name=mikrodash policy=read,test,api,!local,!telnet,!ssh,!ftp,!reboot,!write,!policy,!winbox,!password,!web,!sniff,!sensitive,!romon,!rest-api
/ip smb set domain=HNW interfaces=main-infrastructure-br
/interface bridge port add bridge=main-infrastructure-br ingress-filtering=no interface=lan-poe-in internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge port add bridge=main-infrastructure-br ingress-filtering=no interface=lan-poe-out internal-path-cost=10 path-cost=10 trusted=yes
/interface bridge settings set use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes udp-timeout=10s
/ip neighbor discovery-settings set discover-interface-list=!dynamic
/ip settings set accept-source-route=yes max-neighbor-entries=8192
/ipv6 settings set disable-ipv6=yes max-neighbor-entries=8192
/interface ovpn-server server add auth=sha1,md5 mac-address=FE:AA:B6:DE:38:D8 name=ovpn-server1
/interface wireless cap
# 
set caps-man-addresses=192.168.90.1 discovery-interfaces=main-infrastructure-br enabled=yes interfaces="wlan 2Ghz,wlan 5Ghz"
/ip cloud set ddns-enabled=yes ddns-update-interval=10m
/ip dhcp-client add dhcp-options=hostname,clientid,classid interface=main-infrastructure-br name="main infrastructure"
/ip dns set cache-max-ttl=1d cache-size=1024KiB query-server-timeout=3s
/ip dns static add address=46.39.51.197 name=ftpserver.org type=A
/ip firewall address-list add address=109.252.162.10 list=external-ip
/ip firewall address-list add address=46.39.51.197 list=alist-nat-external-ip
/ip firewall filter add action=accept chain=input dst-port=123 in-interface=main-infrastructure-br protocol=udp
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip firewall service-port set udplite disabled=yes
/ip firewall service-port set dccp disabled=yes
/ip firewall service-port set sctp disabled=yes
/ip ipsec profile set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip service set ftp disabled=yes
/ip service set telnet disabled=yes
/ip service set api-ssl disabled=yes
/ip smb shares set [ find default=yes ] directory=/pub
/ip ssh set ciphers=aes-gcm,aes-ctr,aes-cbc,3des-cbc,null forwarding-enabled=remote
/ip tftp add real-filename=NAS/ req-filename=.*
/ip upnp set show-dummy-rule=no
/ip upnp interfaces add interface=main-infrastructure-br type=internal
/ipv6 nd
# automatic dns option advertising is not started, re-apply dns config
set [ find default=yes ] advertise-dns=yes
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_TOKEN password=8954042546:AAHg_MJ7sK4sUFKSvcQ1YsGAnep_UYnuBO0 profile=null service=async
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_CHAT_ID password=-1001798127067 profile=null service=async
/ppp secret add comment="used by \$SECRET" name=BACKUP_PASSWORD password=RHWbJxAje profile=null service=async
/ppp secret add comment="used by \$SECRET" name=SSH_PASSWORD password=RHWbJxAje profile=null service=async
/ppp secret add comment="used by \$SECRET" name=SSH_PORT password=2223 profile=null service=async
/ppp secret add comment="used by \$SECRET" name=SSH_USER password=automation profile=null service=async
/ppp secret add comment="used by \$SECRET" name=SSH_SERVER password=usetheforce.io profile=null service=async
/routing bfd configuration add disabled=yes
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces=main-infrastructure-br trap-version=2
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
/system logging add action=DHCPOnScreenLog topics=dhcp
/system logging add action=DNSOnScreenLog topics=dns,!packet
/system logging add action=OSPFOnscreenLog topics=ospf,!raw
/system logging add action=L2TPOnScreenLog topics=l2tp
/system logging add action=AuthDiskLog topics=account
/system logging add action=CertificatesOnScreenLog topics=certificate
/system logging add action=AuthDiskLog topics=manager
/system logging add action=ParseMemoryLog topics=warning
/system logging add action=CAPSOnScreenLog topics=caps
/system logging add action=FirewallOnScreenLog topics=firewall
/system logging add action=CAPSOnScreenLog topics=wireless
/system logging add action=ParseMemoryLog topics=system
/system logging add action=SSHOnScreenLog topics=ssh,!packet,!debug
/system logging add action=PoEOnscreenLog topics=poe-out
/system logging add action=EmailOnScreenLog topics=e-mail
/system logging add action=ParseMemoryLog topics=error
/system logging add action=ParseMemoryLog topics=account
/system logging add action=ParseMemoryLog topics=critical
/system logging add action=TransfersOnscreenLog topics=fetch,!raw
/system logging add action=PKGInstallationLog regex="^.*install.*\$"
/system logging add action=VictoriaRemoteLog prefix=WARN regex="^.*reboot.*\$" topics=!dhcp
/system logging add action=PKGInstallationLog regex="^.*package.*\$"
/system logging add action=DockerOnscreenLog topics=container
/system logging add action=VictoriaRemoteLog topics=!packet,!debug,!raw,!dns,!firewall,!ssh,!l2tp
/system logging add action=OnScreenLog topics=!debug,!packet,!raw,!dns,!ssh,!firewall
/system logging add action=AuthDiskLog regex="^.*login.*\$"
/system logging add action=VictoriaRemoteLog topics=error
/system logging add action=VictoriaRemoteLog prefix=AUTH regex="^.*login.*\$"
/system logging add topics=netwatch
/system logging add action=VictoriaRemoteLog topics=l2tp,!packet,!debug,!raw,!info
/system logging add action=REBOOTDiskLog regex="^.*supout.*\$"
/system note set note="Ipsec:         okay \
    \nRoute:     192.168.90.1 \
    \nVersion:         7.24.2 \
    \nUptime:        3w3d01:05:29  \
    \nTime:        2026-10-13 15:13:04  \
    \nPing:    0 ms  \
    \nChr:        185.13.148.14  \
    \nMik:        178.65.91.156  \
    \nAnna:        46.39.51.197  \
    \nClock:        synchronized  \
    \n * wireless  \
    \n * routeros  \
    \n" show-at-cli-login=yes
/system ntp client set enabled=yes mode=multicast
/system routerboard settings set auto-upgrade=yes
/system scheduler add !days interval=10m name=doCoolConsole on-event="/system script run doCoolConsole" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-04-15 start-time=17:52:52
/system scheduler add !days interval=6h name=doFlushLogs on-event="/system script run doFlushLogs" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-05-02 start-time=22:00:00
/system scheduler add !days interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-03-01 start-time=15:55:00
/system scheduler add !days interval=5d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-06-26 start-time=21:13:00
/system scheduler add !days interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=23:30:00
/system scheduler add !days interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=07:00:00
/system scheduler add !days interval=15m name=doCPUHighLoadReboot on-event="/system script run doCPUHighLoadReboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2019-02-07 start-time=06:05:00
/system scheduler add !days interval=1h name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2017-01-30 start-time=18:57:09
/system scheduler add !days interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-03-01 start-time=08:00:00
/system scheduler add !days name=doStartupScript on-event="/system script run doStartupScript;" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add !days interval=30m name=doCloudBackup on-event="/system script run doCloudBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2026-06-04 start-time=21:13:00
/tool bandwidth-server set authenticate=no
/tool e-mail set certificate-verification=no from=defm.kopcap@gmail.com password=lpnaabjwbvbondrg port=587 server=smtp.gmail.com tls=yes user=defm.kopcap@gmail.com
/tool graphing resource add
