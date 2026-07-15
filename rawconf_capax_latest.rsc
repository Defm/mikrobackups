# 2026-07-03 21:14:14 by RouterOS 7.23.1
# software id = DLYF-EX6C
#
# model = cAPGi-5HaxD2HaxD
# serial number = HK40AMR9K9K
/disk add comment=Ramdisk slot=RAM tmpfs-max-size=100000000 type=tmpfs
/disk add disabled=yes slot=sshfs sshfs-address=185.13.148.14 sshfs-password=RHWbJxAje sshfs-path=/REPO sshfs-port=2223 sshfs-user=automation type=sshfs
/interface bridge add admin-mac=04:F4:1C:7E:F1:1F auto-mac=no igmp-snooping=yes name=main-infrastructure-br port-cost-mode=short
/interface ethernet set [ find default-name=ether1 ] loop-protect=on name=lan-poe-in
/interface ethernet set [ find default-name=ether2 ] arp=disabled comment="Trivial WAN" loop-protect=on name=lan-poe-out poe-out=forced-on
/interface veth add address=192.168.255.2/30 container-mac-address=72:E1:C0:B8:03:54 dhcp=no gateway=192.168.255.1 gateway6="" mac-address=72:E1:C0:B8:03:53 name=MihomoProxyRoS
/container add comment=MihomoProxyRoS envlists=MihomoProxyRoS file=mihomo-ros-arm64-v1.19.27.tar.gz interface=MihomoProxyRoS layer-dir="" logging=yes mountlists=MihomoProxyRoS name=MihomoProxyRoS root-dir=/RAM/Containers/MihomoProxyRoS start-on-boot=yes
/interface list add comment="common LAN" name=list-lan
/interface list add comment="common WAN" name=list-wan
/interface list add comment="neighbors allowed interfaces" name=list-neighbors-lookup
/interface list add comment="winbox allowed interfaces" name=list-winbox-allowed
/interface list add comment=MihomoProxyRoS name=list-containers
/interface list add comment=MihomoProxyRoS include=list-wan name=list-mihomo-WAN
/interface list add comment=MihomoProxyRoS include=list-lan name=list-mihomo-LAN
/interface list add comment=MihomoProxyRoS include=list-mihomo-WAN name=list-mihomo-accept
/interface wifi channel add band=2ghz-n disabled=no frequency=2412,2437,2462 name=2CH-N-1-6-11 reselect-interval=2h..4h width=20mhz
/interface wifi channel add band=5ghz-ac comment="UNII-1 (skip DFS)" disabled=no frequency=5180,5220 name=5CH-AC-36-44 reselect-interval=2h..4h reselect-time=10:00:00..10:30:00 skip-dfs-channels=all width=20/40mhz
/interface wifi channel add band=5ghz-ax comment="UNII-2 Extended (+DFS)" disabled=no frequency=5700 name=5CH-AX-140 reselect-interval=2h..4h reselect-time=10:00:00..10:30:00 skip-dfs-channels=10min-cac width=20/40mhz
/interface wifi channel add band=5ghz-ax comment="UNII-3 (skip DFS)" disabled=no frequency=5745 name=5CH-AX-149 reselect-interval=2h..4h reselect-time=10:00:00..10:30:00 skip-dfs-channels=all width=20/40/80mhz
/interface wifi security add authentication-types=wpa3-psk dh-groups=19,20 disable-pmkid=yes disabled=no encryption=ccmp,gcmp,ccmp-256,gcmp-256 ft=yes ft-reassociation-deadline=1m management-protection=required name=wpa3-security passphrase=mikrotik wps=disable
/interface wifi security add authentication-types=wpa2-psk dh-groups=19,20 disable-pmkid=yes disabled=no encryption=ccmp,gcmp,ccmp-256,gcmp-256 ft=yes ft-reassociation-deadline=1m management-protection=allowed name=wpa2-security passphrase=mikrotik wps=disable
/interface wifi steering add disabled=no name=same-ssid rrm=yes wnm=yes
/interface wifi configuration add channel=5CH-AX-140 country=Russia disabled=no hw-protection-mode=rts-cts installation=indoor max-clients=20 mode=ap multicast-enhance=enabled name=RU-AP-5 qos-classifier=priority security=wpa3-security ssid=LocalWiFi5 steering=same-ssid steering.neighbor-group=dynamic-LocalWiFi-e5e02ae3 tx-power=20
/interface wifi configuration add channel=2CH-N-1-6-11 country=Russia disabled=no hw-protection-mode=rts-cts installation=indoor max-clients=20 mode=ap multicast-enhance=enabled name=RU-AP-24 qos-classifier=priority security=wpa2-security ssid=LocalWiFi2 steering=same-ssid steering.neighbor-group=dynamic-LocalWiFi-e5e02ae3 tx-power=17
/interface wifi set [ find default-name=wifi2 ] configuration=RU-AP-24 configuration.mode=ap disable-running-check=yes disabled=no name=wlan-2Ghz security=wpa2-security security.authentication-types=wpa2-psk .encryption=ccmp,gcmp,ccmp-256,gcmp-256 .ft=yes .ft-over-ds=yes .passphrase=mikrotik
/interface wifi set [ find default-name=wifi1 ] configuration=RU-AP-5 configuration.mode=ap disable-running-check=yes disabled=no name=wlan-5Ghz security=wpa3-security security.authentication-types=wpa3-psk .encryption=ccmp,gcmp,ccmp-256,gcmp-256 .management-encryption=cmac .sae-anti-clogging-threshold=0
/ip dhcp-server option add code=15 force=yes name=DomainName_Windows value="s'home'"
/ip dhcp-server option add code=119 force=yes name=DomainName_LinuxMac value="s'home'"
/ip dhcp-server option add code=6 name=DNSServer_Static_DHCP value="'172.30.30.1'"
/ip dhcp-server option sets add name=ReconfigureOpts options=DNSServer_Static_DHCP
/ip dns forwarders add doh-servers=https://dns.google/dns-query name=DOH-Google
/ip dns forwarders add doh-servers=https://cloudflare-dns.com/dns-query name=DOH-CloudFlare
/ip dns forwarders add doh-servers=https://dns.quad9.net/dns-query name=DOH-Quad9
/ip dns forwarders add dns-servers=8.8.8.8 name=DNS-Google8 verify-doh-cert=no
/ip dns forwarders add doh-servers=https://router.comss.one/dns-query name=DOH-Comss
/ip dns forwarders add dns-servers=172.16.16.16 name=DNS-Blackhole verify-doh-cert=no
/ip dns forwarders add dns-servers=77.88.8.8,77.88.8.1 name=DNS-Yandex verify-doh-cert=no
/ip dns forwarders add comment=MihomoProxyRoS dns-servers=192.168.255.2 name=DNS-Mihomo verify-doh-cert=no
/ip kid-control add fri=0s-1d mon=0s-1d name=totals sat=0s-1d sun=0s-1d thu=0s-1d tue=0s-1d wed=0s-1d
/ip kid-control add fri=0s-1d mon=0s-1d name=Alx sat=0s-1d sun=0s-1d thu=0s-1d tue=0s-1d wed=0s-1d
/ip pool add name=dhcp-pool-androids ranges=172.30.30.131-172.30.30.140
/ip pool add name=dhcp-pool-iphones ranges=172.30.30.141-172.30.30.150
/ip pool add name=dhcp-pool-default ranges=172.30.30.32-172.30.30.130,172.30.30.151-172.30.30.254
/ip dhcp-server add add-arp=yes address-pool=dhcp-pool-default authoritative=after-2sec-delay interface=main-infrastructure-br lease-time=1d name=main-dhcp-server use-reconfigure=yes
/ip smb users add name=qqqq password=qqqq
/ppp profile add bridge-learning=no change-tcp-mss=no comment="used by \$SECRET" local-address=0.0.0.0 name=null only-one=yes remote-address=0.0.0.0 session-timeout=1s use-compression=no use-encryption=no use-mpls=no use-upnp=no
/queue type add kind=fq-codel name=fq-codel-ethernet-default
/queue interface set lan-poe-in queue=fq-codel-ethernet-default
/routing id add comment="Main RID" disabled=no name=capax-main-10.255.255.5 select-dynamic-id=only-loopback
/routing table add comment=MihomoProxyRoS disabled=no fib name=via-mihomo
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action set 0 memory-lines=3000
/system logging action set 1 disk-file-name=journal
/system logging action set 3 add-topics-string=yes remote=victoria.home remote-log-format=syslog
/system logging action add name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=5 disk-file-name=ScriptsDiskLog disk-lines-per-file=300 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=5 disk-file-name=ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add memory-lines=3000 name=OnScreenLog target=memory
/system logging action add name=DHCPOnScreenLog target=memory
/system logging action add name=DNSOnScreenLog target=memory
/system logging action add name=RouterControlLog target=memory
/system logging action add name=OSPFOnscreenLog target=memory
/system logging action add name=L2TPOnScreenLog target=memory
/system logging action add disk-file-count=5 disk-file-name=AuthDiskLog disk-lines-per-file=300 name=AuthDiskLog target=disk
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
    \n\r\
    \n"
/system script add comment="Flushes all global variables on Startup" dont-require-permissions=yes name=doEnvironmentClearance owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n#clear all global variables\
    \n/system script environment remove [find];\
    \n\r\
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
    \n\r\
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
    \n    :local tURL \"https://relay.usetheforce.io/bot\$tToken/sendMessage\\\?chat_id=\$tGroupID\";\
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
    \n         # avoid parse errors using Execute when no wireless package installed\
    \n       :if ( [ :len [ /system package find where name=\"wireless\" and disabled=no ] ] > 0  ) do={\
    \n          :local Cmd \"/caps-man access-list remove [find mac-address=\$newMac];\";\
    \n          :local jobid [:execute script=\$Cmd];\
    \n\
    \n          :local Cmd \"/caps-man access-list add action=accept allow-signal-out-of-range=10s client-to-client-forwarding=yes comment=\\\"\$comment\\\" disabled=no mac-address=\$newMac ssid-regexp=\\\"\$newSsid\\\" place-before=1;\";\
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
    \n#\$globalNewClientCert argClients=\"anna.proxy\" argUsage=\"tls-server,digital-signature,key-encipherment\" addSAN=\"*.anna.home\"\
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
    \n    :local asIp  \$argBindAsIP;\
    \n    :local san  \$addSAN ;\
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
    \n        :if ([:typeof \$san ] != \"str\" ) do={\
    \n           :set san \$USERNAME;\
    \n        }\
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
    \n                  /certificate add name=\"\$tname\" common-name=\"\$USERNAME@\$scepAlias\" subject-alt-name=\"email:\$USERNAME@\$fakeDomain,DNS:\$san\" key-usage=\$prefs  country=\"\$COUNTRY\" state=\"\$STATE\" locality=\"\$LOC\" organization=\"\$ORG\" unit=\"\$OU\"  key-size=\"\$KEYSIZE\" days-valid=365\
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
    \n            :set state \"Waiting the end of process for prototol \$logName to be ready, max 30 seconds...\";\
    \n            \$globalNoteMe value=\$state;\
    \n\
    \n            :global Gltesec 0\
    \n            :while (([:len [/sys script job find where .id=\$jobid]] = 1) && (\$Gltesec < 30)) do={\
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
    \n                :set state \"Result of Fetch:\\r\\n****************************\\r\\n 30Sec Timeout exceeded - still no log file \\r\\n****************************\";\
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
    \n       \
    \n       \
    \n      :local partition;\
    \n      :onerror errorName in={ \
    \n            \
    \n            # device may have no /partitions command if it is 16Mb\
    \n            :set partition [/partitions find name=\$partitionName];\
    \n\
    \n        } do={ \
    \n\
    \n            :local state (\"Investigation result - device has no /partitions submenu\");\
    \n            \$globalNoteMe value=\$state;\
    \n            :local OnPrimaryPartition true;\
    \n            :return \$OnPrimaryPartition;\
    \n        }\
    \n\
    \n        :onerror errorName in={ \
    \n            \
    \n            # test if it exist in /partitions\
    \n            \
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
    \n:global SECRET;\
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
    \n:local FTPServer \"usetheforce.io\";\
    \n:local FTPPort 2223;\
    \n:local FTPUser \"automation\";\
    \n:local FTPPass \"\$[\$SECRET get BACKUP_PASSWORD]\";\
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
    \n             \$globalCallFetch \$fetchCmd;\
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
    \n\r\
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
    \n:local RequestUrl \"https://\$GitHubAccessToken@relay.usetheforce.io/\$GitHubUserName/\$GitHubRepoName/master/scripts/\";\
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
    \n\r\
    \n"
/system script add comment="Periodically Wipes memory-configured logging buffers" dont-require-permissions=yes name=doFlushLogs owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
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
    \n\r\
    \n"
/system script add comment="Fast cloud backup" dont-require-permissions=yes name=doCloudBackup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \"doCloudBackup\";\
    \n\
    \n:global globalNoteMe;\
    \n:local state\
    \n:local itsOk true;\
    \n\
    \n:local BackupPassword \"1234567890\" ;\
    \n\
    \n# we are not interested in output, but print without count-only is\
    \n# required to fetch information from cloud\
    \n\
    \n:global globalOnPrimaryPartition;\
    \n:if ( ![\$globalOnPrimaryPartition] ) do {\
    \n    \
    \n    :set state \"WARNING: the system booted up from fallback partition - skipping backup!\"\
    \n    :log error \$state\
    \n    \$globalNoteMe value=\$state;\
    \n    :error \$state;\
    \n\
    \n}\
    \n\
    \n/system backup cloud print as-value\
    \n\
    \n:local Backup ([ /system/backup/cloud/find ]->0);\
    \n:if ([ :typeof \$Backup ] = \"id\") do={\
    \n    /system/backup/cloud/upload-file action=create-and-upload password=\$BackupPassword replace=\$Backup;\
    \n} else={\
    \n    /system/backup/cloud/upload-file action=create-and-upload password=\$BackupPassword;\
    \n}\
    \n\
    \n:local Backup ([ /system/backup/cloud/find ]->0);\
    \n:local BackupName [/system/backup/cloud/get \$Backup name];\
    \n:set state \"Creating and uploading backup file... \$BackupName\"\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n\
    \n\
    \n\r\
    \n"
/system script add comment="Netwatch handler OnDown" dont-require-permissions=yes name=doNetwatchHost owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local SafeScriptCall do={\
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
    \n# init globals as far as we are inside *sys user account\
    \n\$SafeScriptCall \"doEnvironmentSetup\";\
    \n\
    \n# NetWatch notifier OnDown\
    \n\
    \n:local scriptname \"doNetwatchHost\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n# fill it inside netwatch script\
    \n:global NetwatchHostName;\
    \n\
    \n:global globalTgMessage;\
    \n:global globalNoteMe;\
    \n\
    \n:local state;\
    \n\
    \n:if (!any \$NetwatchHostName) do={\
    \n\
    \n  :set state \"No NetwatchHostName provided..\";\
    \n  \$globalNoteMe value=\$state;\
    \n  :error \$inf; \
    \n}\
    \n\
    \n:set state \"Netwatch for \$NetwatchHostName started...\";\
    \n\$globalNoteMe value=\$state;\
    \n\
    \n:set state \"\$NetwatchHostName is DOWN\";\
    \n:log error \"\$state\";\
    \n\
    \n\$globalTgMessage value=\$state;\
    \n\
    \n\
    \n\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=MPR owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:if ([:len [/system/script/find name=\"IP_MihomoProxyRoS\"]] = 0) do={\
    \n/system script\
    \nadd name=IP_MihomoProxyRoS source=\"# Define global variables\\r\\\
    \n\\n:global AddressList \\\"MihomoProxyRoS\\\"\\r\\\
    \n\\n\\r\\\
    \n\\n:global LoadRscResources do={\\r\\\
    \n\\n:foreach resource in=\\\$resources do={\\r\\\
    \n\\n:local url (\\\$baseUrl . \\\"/\\\" . \\\$resource . \\\".rsc\\\")\\r\\\
    \n\\n:do {\\r\\\
    \n\\n:local r [/tool fetch url=\\\$url mode=https output=user as-value]\\r\\\
    \n\\n:if ((\\\$r->\\\"status\\\") = \\\"finished\\\") do={\\r\\\
    \n\\n:local content (\\\$r->\\\"data\\\")\\r\\\
    \n\\n:local s [:parse \\\$content]\\r\\\
    \n\\n\\\$s\\r\\\
    \n\\n:log warning (\\\$resource . \\\".rsc loading completed\\\")\\r\\\
    \n\\n:put (\\\$resource . \\\".rsc loading completed\\\")\\r\\\
    \n\\n}\\r\\\
    \n\\n} on-error={}\\r\\\
    \n\\n:local part 1\\r\\\
    \n\\n:local continue true\\r\\\
    \n\\n:while (\\\$continue) do={\\r\\\
    \n\\n:local partUrl (\\\$baseUrl . \\\"/\\\" . \\\$resource . \\\"_part\\\" . \\\$part . \\\".rsc\\\")\\r\\\
    \n\\n:do {\\r\\\
    \n\\n:local r [/tool fetch url=\\\$partUrl mode=https output=user as-value]\\r\\\
    \n\\n:if ((\\\$r->\\\"status\\\") = \\\"finished\\\") do={\\r\\\
    \n\\n:local content (\\\$r->\\\"data\\\")\\r\\\
    \n\\n:local s [:parse \\\$content]\\r\\\
    \n\\n\\\$s\\r\\\
    \n\\n:log warning (\\\$resource . \\\".rsc part\\\" . \\\$part . \\\" loading completed\\\")\\r\\\
    \n\\n:put (\\\$resource . \\\".rsc part\\\" . \\\$part . \\\" loading completed\\\")\\r\\\
    \n\\n:set part (\\\$part + 1)\\r\\\
    \n\\n} else={\\r\\\
    \n\\n:set continue false\\r\\\
    \n\\n}\\r\\\
    \n\\n} on-error={\\r\\\
    \n\\n:set continue false\\r\\\
    \n\\n}\\r\\\
    \n\\n}\\r\\\
    \n\\n}\\r\\\
    \n\\n}\\r\\\
    \n\\n\\r\\\
    \n\\n# First resources\\r\\\
    \n\\n:local baseUrl \\\"https://raw.githubusercontent.com/Medium1992/MikroTik_IPlist/refs/heads/main/for_scripts\\\"\\r\\\
    \n\\n:local resources {\\r\\\
    \n\\n# Telegram\\r\\\
    \n\\n\\\"geoipv4/telegram\\\";\\r\\\
    \n\\n\\\"asnv4/AS62041\\\";\\r\\\
    \n\\n\\\"asnv4/AS59930\\\";\\r\\\
    \n\\n\\\"asnv4/AS62014\\\";\\r\\\
    \n\\n\\\"asnv4/AS211157\\\";\\r\\\
    \n\\n\\\"asnv4/AS44907\\\";\\r\\\
    \n\\n# Twitter\\r\\\
    \n\\n\\\"geoipv4/twitter\\\";\\r\\\
    \n\\n\\\"asnv4/AS13414\\\";\\r\\\
    \n\\n\\\"asnv4/AS63179\\\";\\r\\\
    \n\\n\\\"asnv4/AS35995\\\";\\r\\\
    \n\\n# Meta\\r\\\
    \n\\n\\\"geoipv4/facebook\\\";\\r\\\
    \n\\n\\\"asnv4/AS32934\\\";\\r\\\
    \n\\n\\\"asnv4/AS54115\\\";\\r\\\
    \n\\n\\\"asnv4/AS63293\\\";\\r\\\
    \n\\n\\\"asnv4/AS45796\\\";\\r\\\
    \n\\n# NetFlix\\r\\\
    \n\\n\\\"geoipv4/netflix\\\";\\r\\\
    \n\\n\\\"asnv4/AS2906\\\";\\r\\\
    \n\\n# Anthropic\\r\\\
    \n\\n\\\"asnv4/AS399358\\\";\\r\\\
    \n\\n\\\"asnv4/AS60808\\\";\\r\\\
    \n\\n}\\r\\\
    \n\\n\\r\\\
    \n\\n\\\$LoadRscResources resources=\\\$resources baseUrl=\\\$baseUrl\\r\\\
    \n\\n\\r\\\
    \n\\n\\r\\\
    \n\\n# Second resources\\r\\\
    \n\\n:local baseUrl \\\"https://raw.githubusercontent.com/Medium1992/mihomo-proxy-ros/refs/heads/main/custom_list\\\"\\r\\\
    \n\\n:local resources {\\r\\\
    \n\\n\\\"ipcidr_address_list_custom\\\";\\r\\\
    \n\\n}\\r\\\
    \n\\n\\r\\\
    \n\\n\\\$LoadRscResources resources=\\\$resources baseUrl=\\\$baseUrl\\r\\\
    \n\\n\"\
    \n:put \"Add script IP_AddressList for pull IPs to ip firewall address-list\"}\
    \n\
    \n:if ([:len [/system/script/find name=\"FWD_update\"]] = 0) do={\
    \n/system script\
    \nadd name=FWD_update source=\"# Define global variables\\r\\\
    \n\\n:global AddressList \\\"\\\"\\r\\\
    \n\\n:global ForwardTo \\\"MihomoProxyRoS\\\"\\r\\\
    \n\\n\\r\\\
    \n\\n:global LoadRscResources do={\\r\\\
    \n\\n:foreach resource in=\\\$resources do={\\r\\\
    \n\\n:local url (\\\$baseUrl . \\\"/\\\" . \\\$resource . \\\".rsc\\\")\\r\\\
    \n\\n:do {\\r\\\
    \n\\n:local r [/tool fetch url=\\\$url mode=https output=user as-value]\\r\\\
    \n\\n:if ((\\\$r->\\\"status\\\") = \\\"finished\\\") do={\\r\\\
    \n\\n:local content (\\\$r->\\\"data\\\")\\r\\\
    \n\\n:local s [:parse \\\$content]\\r\\\
    \n\\n\\\$s\\r\\\
    \n\\n:log warning (\\\$resource . \\\".rsc loading completed\\\")\\r\\\
    \n\\n:put (\\\$resource . \\\".rsc loading completed\\\")\\r\\\
    \n\\n}\\r\\\
    \n\\n} on-error={}\\r\\\
    \n\\n:local part 1\\r\\\
    \n\\n:local continue true\\r\\\
    \n\\n:while (\\\$continue) do={\\r\\\
    \n\\n:local partUrl (\\\$baseUrl . \\\"/\\\" . \\\$resource . \\\"_part\\\" . \\\$part . \\\".rsc\\\")\\r\\\
    \n\\n:do {\\r\\\
    \n\\n:local r [/tool fetch url=\\\$partUrl mode=https output=user as-value]\\r\\\
    \n\\n:if ((\\\$r->\\\"status\\\") = \\\"finished\\\") do={\\r\\\
    \n\\n:local content (\\\$r->\\\"data\\\")\\r\\\
    \n\\n:local s [:parse \\\$content]\\r\\\
    \n\\n\\\$s\\r\\\
    \n\\n:log warning (\\\$resource . \\\".rsc part\\\" . \\\$part . \\\" loading completed\\\")\\r\\\
    \n\\n:put (\\\$resource . \\\".rsc part\\\" . \\\$part . \\\" loading completed\\\")\\r\\\
    \n\\n:set part (\\\$part + 1)\\r\\\
    \n\\n} else={\\r\\\
    \n\\n:set continue false\\r\\\
    \n\\n}\\r\\\
    \n\\n} on-error={\\r\\\
    \n\\n:set continue false\\r\\\
    \n\\n}\\r\\\
    \n\\n}\\r\\\
    \n\\n}\\r\\\
    \n\\n}\\r\\\
    \n\\n\\r\\\
    \n\\n# First resources set\\r\\\
    \n\\n:local baseUrl \\\"https://raw.githubusercontent.com/Medium1992/MikroTik_DNS_FWD/refs/heads/main/for_scripts\\\"\\r\\\
    \n\\n\\r\\\
    \n\\n:local resources {\\r\\\
    \n\\n\\\"youtube\\\";\\r\\\
    \n\\n\\\"meta\\\";\\r\\\
    \n\\n\\\"netflix\\\";\\r\\\
    \n\\n\\\"discord\\\";\\r\\\
    \n\\n\\\"rutracker\\\";\\r\\\
    \n\\n\\\"torrent\\\";\\r\\\
    \n\\n\\\"adguard\\\";\\r\\\
    \n\\n\\\"anime\\\";\\r\\\
    \n\\n\\\"deepl\\\";\\r\\\
    \n\\n\\\"category-ai-!cn\\\";\\r\\\
    \n\\n\\\"openai\\\";\\r\\\
    \n\\n\\\"google-gemini\\\";\\r\\\
    \n\\n\\\"canva\\\";\\r\\\
    \n\\n\\\"art\\\";\\r\\\
    \n\\n\\\"tidal\\\";\\r\\\
    \n\\n\\\"tiktok\\\";\\r\\\
    \n\\n\\\"music\\\";\\r\\\
    \n\\n\\\"tmdb\\\";\\r\\\
    \n\\n\\\"x\\\";\\r\\\
    \n\\n\\\"kinopub\\\";\\r\\\
    \n\\n\\\"xhamster\\\";\\r\\\
    \n\\n\\\"porn\\\";\\r\\\
    \n\\n\\\"video\\\";\\r\\\
    \n\\n\\\"anthropic\\\";\\r\\\
    \n\\n\\\"xai\\\";\\r\\\
    \n\\n\\\"notion\\\";\\r\\\
    \n\\n\\\"twitch\\\";\\r\\\
    \n\\n\\\"supercell\\\";\\r\\\
    \n\\n\\\"xbox\\\";\\r\\\
    \n\\n\\\"pornhub\\\";\\r\\\
    \n\\n}\\r\\\
    \n\\n\\r\\\
    \n\\n\\\$LoadRscResources resources=\\\$resources baseUrl=\\\$baseUrl\\r\\\
    \n\\n\\r\\\
    \n\\n# Second resources\\r\\\
    \n\\n:local baseUrl \\\"https://raw.githubusercontent.com/Medium1992/mihomo-proxy-ros/refs/heads/main/custom_list\\\"\\r\\\
    \n\\n\\r\\\
    \n\\n:local resources {\\r\\\
    \n\\n\\\"domain_custom\\\";\\r\\\
    \n\\n}\\r\\\
    \n\\n\\r\\\
    \n\\n\\\$LoadRscResources resources=\\\$resources baseUrl=\\\$baseUrl\\r\\\
    \n\\n\"\
    \n:put \"Add script FWD_update for pull resources to DNS static FWD\"}\
    \n\
    \n:if ([:len [/system/script/find name=\"FWD_update_RU\"]] = 0) do={\
    \n/system script\
    \nadd name=FWD_update_RU source=\"# Define global variables\\r\\\
    \n\\n:global AddressList \\\"\\\"\\r\\\
    \n\\n:global ForwardTo \\\"Yandex\\\"\\r\\\
    \n\\n\\r\\\
    \n\\n# List of resources corresponding to RSC files\\r\\\
    \n\\n:global resources {\\r\\\
    \n\\n\\\"category-gov-ru\\\";\\r\\\
    \n\\n\\\"category-bank-ru\\\";\\r\\\
    \n\\n\\\"category-retail-ru\\\";\\r\\\
    \n\\n\\\"category-travel-ru\\\";\\r\\\
    \n\\n\\\"category-ecommerce-ru\\\";\\r\\\
    \n\\n\\\"category-entertainment-ru\\\";\\r\\\
    \n\\n\\\"mailru-group\\\";\\r\\\
    \n\\n\\\"vk\\\";\\r\\\
    \n\\n\\\"ok\\\";\\r\\\
    \n\\n\\\"yandex\\\";\\r\\\
    \n\\n\\\"ozon\\\";\\r\\\
    \n\\n\\\"wildberries\\\";\\r\\\
    \n\\n\\\"x5\\\";\\r\\\
    \n\\n\\\"okko\\\";\\r\\\
    \n\\n\\\"kinopoisk\\\";\\r\\\
    \n\\n}\\r\\\
    \n\\n\\r\\\
    \n\\n# Base URL for RSC files\\r\\\
    \n\\n:local baseUrl \\\"https://raw.githubusercontent.com/Medium1992/MikroTik_DNS_FWD/refs/heads/main/for_scripts\\\"\\r\\\
    \n\\n\\r\\\
    \n\\n:foreach resource in=\\\$resources do={\\r\\\
    \n\\n:local url \\\"\\\$baseUrl/\\\$resource.rsc\\\"\\r\\\
    \n\\n:do {\\r\\\
    \n\\n:local r [/tool fetch url=\\\$url mode=https output=user as-value]\\r\\\
    \n\\n:if ((\\\$r->\\\"status\\\")=\\\"finished\\\") do={\\r\\\
    \n\\n:local content (\\\$r->\\\"data\\\")\\r\\\
    \n\\n:local s [:parse \\\$content]\\r\\\
    \n\\n\\\$s\\r\\\
    \n\\n:log warning \\\"\\\$resource.rsc loading completed\\\"\\r\\\
    \n\\n:put \\\"\\\$resource.rsc loading completed\\\"\\r\\\
    \n\\n}\\r\\\
    \n\\n} on-error {}\\r\\\
    \n\\n:local part 1\\r\\\
    \n\\n:local continue true\\r\\\
    \n\\n:while (\\\$continue) do={\\r\\\
    \n\\n:local url \\\"\\\$baseUrl/\\\$resource_part\\\$part.rsc\\\"\\r\\\
    \n\\n:do {\\r\\\
    \n\\n:local r [/tool fetch url=\\\$url mode=https output=user as-value]\\r\\\
    \n\\n:if ((\\\$r->\\\"status\\\")=\\\"finished\\\") do={\\r\\\
    \n\\n:local content (\\\$r->\\\"data\\\")\\r\\\
    \n\\n:local s [:parse \\\$content]\\r\\\
    \n\\n\\\$s\\r\\\
    \n\\n:log warning \\\"\\\$resource.rsc part\\\$part loading completed\\\"\\r\\\
    \n\\n:put \\\"\\\$resource.rsc part\\\$part loading completed\\\"\\r\\\
    \n\\n}\\r\\\
    \n\\n:set part (\\\$part + 1)\\r\\\
    \n\\n} on-error {\\r\\\
    \n\\n:set continue false\\r\\\
    \n\\n}\\r\\\
    \n\\n}\\r\\\
    \n\\n}\"\
    \n:put \"Add script FWD_update_RU for pull resources to DNS static FWD\"}\
    \n\
    \n:if ([:len [/system/script/find name=\"route_UP\"]] = 0) do={\
    \n/system script\
    \nadd name=route_UP source=\\\
    \n    \":global comments {\\\
    \n    \\n\\\"MihomoProxyRoS0\\\";\\\
    \n    \\n\\\"MihomoProxyRoS1\\\";\\\
    \n    \\n}\\\
    \n    \\n:foreach i in=\\\$comments do={\\\
    \n    \\n/ip/route/set [find where comment=\\\$i disabled=yes] disabled=no\\\
    \n    \\n}\"\
    \n:put \"Add script route_UP\"}\
    \n\
    \n:if ([:len [/system/scheduler/find comment=\"MihomoProxyRoS\"]] = 0) do={\
    \n:do {\
    \n:put \"Run script FWD_update_RU, pls wait for DNS static entries pulled\"\
    \n/system/script/run FWD_update_RU\
    \n:put \"Run script FWD_update, pls wait for DNS static entries pulled\"\
    \n/system/script/run FWD_update\
    \n:put \"Run script IP_MihomoProxyRoS, pls wait for IPs static entries pulled\"\
    \n/system/script/run IP_MihomoProxyRoS\
    \n} on-error {}\
    \n}\
    \n:do {\
    \n/system scheduler\
    \nadd interval=1d name=update_FWD start-time=06:30:00 comment=\"MihomoProxyRoS\" on-event=\"/system/script/run FWD_update_RU\\r\\\
    \n\\n/system/script/run FWD_update\\r\\\
    \n\\n/system/script/run IP_MihomoProxyRoS\"\
    \n:put \"Add schedule update resources on 06:30 AM every day\"\
    \n/system scheduler\
    \nadd interval=10s name=route_UP comment=\"route_UP\" on-event=\"/system/script/run route_UP\"\
    \n} on-error {} \
    \n\
    \n:local flagContainer false\
    \n:while (\$flagContainer = false) do={\
    \n:if (\$totalspace>=120000000) do={\
    \n:if ([:len [/container/mounts/find comment=\"MihomoProxyRoS\"]] = 0) do={\
    \n:do { /file/add name=mihomo type=directory} on-error {}\
    \n/container/mounts/add src=/mihomo/ dst=/root/.config/mihomo/ list=MihomoProxyRoS comment=\"MihomoProxyRoS\"\
    \n}\
    \n} else={\
    \n:if ([:len [/container/mounts/find comment=\"MihomoProxyRoSAWG\"]] = 0) do={\
    \n:do { /file/add name=awg_conf type=directory} on-error {}\
    \n/container/mounts/add src=/awg_conf/ dst=/root/.config/mihomo/awg/ list=MihomoProxyRoS comment=\"MihomoProxyRoSAWG\"\
    \n}\
    \n:if ([:len [/container/mounts/find comment=\"MihomoProxyRoSProxies\"]] = 0) do={\
    \n:do { /file/add name=proxies_yaml type=directory} on-error {}\
    \n/container/mounts/add src=/proxies_yaml/ dst=/root/.config/mihomo/proxies_mount/ list=MihomoProxyRoS comment=\"MihomoProxyRoSProxies\"\
    \n}\
    \n:if ([:len [/container/mounts/find comment=\"MihomoProxyRoSRuleSet\"]] = 0) do={\
    \n:do { /file/add name=ruleset_txt type=directory} on-error {}\
    \n/container/mounts/add src=/ruleset_txt/ dst=/root/.config/mihomo/rule_set_list list=MihomoProxyRoS comment=\"MihomoProxyRoSRuleSet\"\
    \n}\
    \n}\
    \n:if ([:len [/container/find comment=\"MihomoProxyRoS\"]] = 0) do={\
    \n/container/add remote-image=\"ghcr.io/medium1992/mihomo-proxy-ros\" envlists=MihomoProxyRoS mountlists=MihomoProxyRoS interface=MihomoProxyRoS root-dir=(\$pathPull . \"Containers/MihomoProxyRoS\") start-on-boot=yes comment=\"MihomoProxyRoS\"\
    \n:put \"Start pull MihomoProxyRoS container, pls wait when container starting, pls wait\"\
    \n:delay 1\
    \n}\
    \n:if ([:len [/container/find comment=\"MihomoProxyRoS\" and (stopped or running)]] > 0) do={\
    \n/container/start [find where comment=\"MihomoProxyRoS\" and stopped]\
    \n:delay 3\
    \n:if ([:len [/container/find comment=\"MihomoProxyRoS\" and running]] > 0) do={\
    \n:put \"Container MihomoProxyRoS started\"\
    \n:set flagContainer true\
    \n}\
    \n}\
    \n:delay 1\
    \n}\
    \n\
    \n/system/script/environment/remove [find where ]\
    \n:put \"Script complete, enjoy!\"\
    \n:put \"For use WG,AWG pls push conf files on Mikrotik to path /awg_conf/\"\
    \n:put \"Webpanel UI http://192.168.255.2:9090/ui/\"\
    \n:put \"For donate:\"\
    \n:put \"- USDT(TRC20):TWDDYD1nk5JnG6FxvEu2fyFqMCY9PcdEsJ\"\
    \n:put \"- https://boosty.to/petersolomon/donate\"\
    \n:put \"Invite link Telegram-group https://t.me/+96HVPF3Ww6o3YTNi\"\
    \n:log warning \"script complete, enjoy!\"\
    \n:log warning \"For use WG,AWG pls push conf files on Mikrotik to path /awg_conf/\"\
    \n:log warning \"Webpanel UI http://192.168.255.2:9090/ui/\"\
    \n:log warning \"For donate:\"\
    \n:log warning \"- USDT(TRC20):TWDDYD1nk5JnG6FxvEu2fyFqMCY9PcdEsJ\"\
    \n:log warning \"- https://boosty.to/petersolomon/donate\"\
    \n:log warning \"Invite link Telegram-group https://t.me/+96HVPF3Ww6o3YTNi\"\
    \n}\
    \n"
/system script add dont-require-permissions=no name=MihomoProxyRoS_repull owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local containerName \"MihomoProxyRoS\"\
    \n:local c [/container/find where comment=\$containerName]\
    \n\
    \n:if ([:len \$c] > 0) do={\
    \n    :do {\
    \n        /container/stop \$c\
    \n    } on-error={}\
    \n\
    \n    :while ([:len [/container/find where comment=\$containerName and stopped]] = 0) do={\
    \n        :delay 1\
    \n    }\
    \n\
    \n    /container/remove \$c\
    \n}\
    \n\
    \n:local imagePath \"mihomo-ros-arm64-v1.19.27.tar.gz\";\
    \n/container/add \\\
    \n    file=\$imagePath \\\
    \n    envlists=\$containerName \\\
    \n    mountlists=\$containerName \\\
    \n    interface=\$containerName \\\
    \n    root-dir=(\"RAM/Containers/\" . \$containerName) \\\
    \n    start-on-boot=yes \\\
    \n    logging=yes \\\
    \n    name=\$containerName \\\
    \n    comment=\$containerName\
    \n\
    \n:while ([:len [/container/find where comment=\$containerName and running]] = 0) do={\
    \n    /container/start [find where comment=\$containerName and stopped]\
    \n    :delay 3\
    \n}"
/system script add dont-require-permissions=no name=IP_MihomoProxyRoS owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# Define global variables\r\
    \n:global AddressList \"MihomoProxyRoS\"\r\
    \n\r\
    \n:global LoadRscResources do={\r\
    \n:foreach resource in=\$resources do={\r\
    \n:local url (\$baseUrl . \"/\" . \$resource . \".rsc\")\r\
    \n:do {\r\
    \n:local r [/tool fetch url=\$url mode=https output=user as-value]\r\
    \n:if ((\$r->\"status\") = \"finished\") do={\r\
    \n:local content (\$r->\"data\")\r\
    \n:local s [:parse \$content]\r\
    \n\$s\r\
    \n:log warning (\$resource . \".rsc loading completed\")\r\
    \n:put (\$resource . \".rsc loading completed\")\r\
    \n}\r\
    \n} on-error={}\r\
    \n:local part 1\r\
    \n:local continue true\r\
    \n:while (\$continue) do={\r\
    \n:local partUrl (\$baseUrl . \"/\" . \$resource . \"_part\" . \$part . \".rsc\")\r\
    \n:do {\r\
    \n:local r [/tool fetch url=\$partUrl mode=https output=user as-value]\r\
    \n:if ((\$r->\"status\") = \"finished\") do={\r\
    \n:local content (\$r->\"data\")\r\
    \n:local s [:parse \$content]\r\
    \n\$s\r\
    \n:log warning (\$resource . \".rsc part\" . \$part . \" loading completed\")\r\
    \n:put (\$resource . \".rsc part\" . \$part . \" loading completed\")\r\
    \n:set part (\$part + 1)\r\
    \n} else={\r\
    \n:set continue false\r\
    \n}\r\
    \n} on-error={\r\
    \n:set continue false\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n\r\
    \n# First resources\r\
    \n:local baseUrl \"https://raw.githubusercontent.com/Medium1992/MikroTik_IPlist/refs/heads/main/for_scripts\"\r\
    \n:local resources {\r\
    \n# Telegram\r\
    \n\"geoipv4/telegram\";\r\
    \n\"asnv4/AS62041\";\r\
    \n\"asnv4/AS59930\";\r\
    \n\"asnv4/AS62014\";\r\
    \n\"asnv4/AS211157\";\r\
    \n\"asnv4/AS44907\";\r\
    \n# Twitter\r\
    \n\"geoipv4/twitter\";\r\
    \n\"asnv4/AS13414\";\r\
    \n\"asnv4/AS63179\";\r\
    \n\"asnv4/AS35995\";\r\
    \n# Meta\r\
    \n\"geoipv4/facebook\";\r\
    \n\"asnv4/AS32934\";\r\
    \n\"asnv4/AS54115\";\r\
    \n\"asnv4/AS63293\";\r\
    \n\"asnv4/AS45796\";\r\
    \n# NetFlix\r\
    \n\"geoipv4/netflix\";\r\
    \n\"asnv4/AS2906\";\r\
    \n# Anthropic\r\
    \n\"asnv4/AS399358\";\r\
    \n\"asnv4/AS60808\";\r\
    \n}\r\
    \n\r\
    \n\$LoadRscResources resources=\$resources baseUrl=\$baseUrl\r\
    \n\r\
    \n\r\
    \n# Second resources\r\
    \n:local baseUrl \"https://raw.githubusercontent.com/Medium1992/mihomo-proxy-ros/refs/heads/main/custom_list\"\r\
    \n:local resources {\r\
    \n\"ipcidr_address_list_custom\";\r\
    \n}\r\
    \n\r\
    \n\$LoadRscResources resources=\$resources baseUrl=\$baseUrl\r\
    \n"
/system script add dont-require-permissions=no name=FWD_update owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# Define global variables\r\
    \n:global AddressList \"\"\r\
    \n:global ForwardTo \"MihomoProxyRoS\"\r\
    \n\r\
    \n:global LoadRscResources do={\r\
    \n:foreach resource in=\$resources do={\r\
    \n:local url (\$baseUrl . \"/\" . \$resource . \".rsc\")\r\
    \n:do {\r\
    \n:local r [/tool fetch url=\$url mode=https output=user as-value]\r\
    \n:if ((\$r->\"status\") = \"finished\") do={\r\
    \n:local content (\$r->\"data\")\r\
    \n:local s [:parse \$content]\r\
    \n\$s\r\
    \n:log warning (\$resource . \".rsc loading completed\")\r\
    \n:put (\$resource . \".rsc loading completed\")\r\
    \n}\r\
    \n} on-error={}\r\
    \n:local part 1\r\
    \n:local continue true\r\
    \n:while (\$continue) do={\r\
    \n:local partUrl (\$baseUrl . \"/\" . \$resource . \"_part\" . \$part . \".rsc\")\r\
    \n:do {\r\
    \n:local r [/tool fetch url=\$partUrl mode=https output=user as-value]\r\
    \n:if ((\$r->\"status\") = \"finished\") do={\r\
    \n:local content (\$r->\"data\")\r\
    \n:local s [:parse \$content]\r\
    \n\$s\r\
    \n:log warning (\$resource . \".rsc part\" . \$part . \" loading completed\")\r\
    \n:put (\$resource . \".rsc part\" . \$part . \" loading completed\")\r\
    \n:set part (\$part + 1)\r\
    \n} else={\r\
    \n:set continue false\r\
    \n}\r\
    \n} on-error={\r\
    \n:set continue false\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n\r\
    \n# First resources set\r\
    \n:local baseUrl \"https://raw.githubusercontent.com/Medium1992/MikroTik_DNS_FWD/refs/heads/main/for_scripts\"\r\
    \n\r\
    \n:local resources {\r\
    \n\"youtube\";\r\
    \n\"meta\";\r\
    \n\"netflix\";\r\
    \n\"discord\";\r\
    \n\"rutracker\";\r\
    \n\"torrent\";\r\
    \n\"adguard\";\r\
    \n\"anime\";\r\
    \n\"deepl\";\r\
    \n\"category-ai-!cn\";\r\
    \n\"openai\";\r\
    \n\"google-gemini\";\r\
    \n\"canva\";\r\
    \n\"art\";\r\
    \n\"tidal\";\r\
    \n\"tiktok\";\r\
    \n\"music\";\r\
    \n\"tmdb\";\r\
    \n\"x\";\r\
    \n\"kinopub\";\r\
    \n\"xhamster\";\r\
    \n\"porn\";\r\
    \n\"video\";\r\
    \n\"anthropic\";\r\
    \n\"xai\";\r\
    \n\"notion\";\r\
    \n\"twitch\";\r\
    \n\"supercell\";\r\
    \n\"xbox\";\r\
    \n\"pornhub\";\r\
    \n}\r\
    \n\r\
    \n\$LoadRscResources resources=\$resources baseUrl=\$baseUrl\r\
    \n\r\
    \n# Second resources\r\
    \n:local baseUrl \"https://raw.githubusercontent.com/Medium1992/mihomo-proxy-ros/refs/heads/main/custom_list\"\r\
    \n\r\
    \n:local resources {\r\
    \n\"domain_custom\";\r\
    \n}\r\
    \n\r\
    \n\$LoadRscResources resources=\$resources baseUrl=\$baseUrl\r\
    \n"
/system script add dont-require-permissions=no name=FWD_update_RU owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# Define global variables\r\
    \n:global AddressList \"\"\r\
    \n:global ForwardTo \"Yandex\"\r\
    \n\r\
    \n# List of resources corresponding to RSC files\r\
    \n:global resources {\r\
    \n\"category-gov-ru\";\r\
    \n\"category-bank-ru\";\r\
    \n\"category-retail-ru\";\r\
    \n\"category-travel-ru\";\r\
    \n\"category-ecommerce-ru\";\r\
    \n\"category-entertainment-ru\";\r\
    \n\"mailru-group\";\r\
    \n\"vk\";\r\
    \n\"ok\";\r\
    \n\"yandex\";\r\
    \n\"ozon\";\r\
    \n\"wildberries\";\r\
    \n\"x5\";\r\
    \n\"okko\";\r\
    \n\"kinopoisk\";\r\
    \n}\r\
    \n\r\
    \n# Base URL for RSC files\r\
    \n:local baseUrl \"https://raw.githubusercontent.com/Medium1992/MikroTik_DNS_FWD/refs/heads/main/for_scripts\"\r\
    \n\r\
    \n:foreach resource in=\$resources do={\r\
    \n:local url \"\$baseUrl/\$resource.rsc\"\r\
    \n:do {\r\
    \n:local r [/tool fetch url=\$url mode=https output=user as-value]\r\
    \n:if ((\$r->\"status\")=\"finished\") do={\r\
    \n:local content (\$r->\"data\")\r\
    \n:local s [:parse \$content]\r\
    \n\$s\r\
    \n:log warning \"\$resource.rsc loading completed\"\r\
    \n:put \"\$resource.rsc loading completed\"\r\
    \n}\r\
    \n} on-error {}\r\
    \n:local part 1\r\
    \n:local continue true\r\
    \n:while (\$continue) do={\r\
    \n:local url \"\$baseUrl/\$resource_part\$part.rsc\"\r\
    \n:do {\r\
    \n:local r [/tool fetch url=\$url mode=https output=user as-value]\r\
    \n:if ((\$r->\"status\")=\"finished\") do={\r\
    \n:local content (\$r->\"data\")\r\
    \n:local s [:parse \$content]\r\
    \n\$s\r\
    \n:log warning \"\$resource.rsc part\$part loading completed\"\r\
    \n:put \"\$resource.rsc part\$part loading completed\"\r\
    \n}\r\
    \n:set part (\$part + 1)\r\
    \n} on-error {\r\
    \n:set continue false\r\
    \n}\r\
    \n}\r\
    \n}"
/system script add dont-require-permissions=no name=route_UP owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global comments {\
    \n\"MihomoProxyRoS0\";\
    \n\"MihomoProxyRoS1\";\
    \n}\
    \n:foreach i in=\$comments do={\
    \n/ip/route/set [find where comment=\$i disabled=yes] disabled=no\
    \n}"
/app set cinny firewall-redirects=8094:80:tcp:web
/app set goaway container-command-lines=goaway:none:docker.io/pommee/goaway:latest
/app set home-assistant container-command-lines=home-assistant:none:lscr.io/linuxserver/homeassistant
/app set lorawan-stack secrets=lorawan-stack__admin_password:iFLtXNhCPtkIBWHwnKCrNeRxPampiPGo
/app set n8n firewall-redirects=5678:5678:tcp:web
/app set nextcloud container-command-lines="db:none:docker.io/postgres:17,redis:none:docker.io/valkey/valkey:/bin/sh -c 'valkey-server --port 6379 --appendonly yes --requirepass \$VALKEY_PASSWORD',server:none:docker.io/nextcloud:apache"
/app set pihole environment="pihole:FTLCONF_dns_listeningMode=all,pihole:FTLCONF_webserver_api_password=password"
/app set redlib firewall-redirects=8087:8080:tcp:web
/app set solr container-command-lines=solr:none:docker.io/solr:latest
/app set uptime-kuma container-command-lines=uptime-kuma:none:docker.io/louislam/uptime-kuma:1
/app set zulip secrets=zulip__postgres_password:wSPNPnFdiKQIRtDYqrOpMaXMhwrkLYpo,zulip__memcached_password:UDPwqfBRZXBIzacmceWeNlGrcOvGNeoG,zulip__rabbitmq_password:JSAzOIKGJHWFSavKwDMtxwnTJPjhvFXR,zulip__redis_password:DCKlIaEdgkBUIBChEHNfbBQBKIdPvmWn,zulip__secret_key:QVGkHEjkpwVhdzrUWGkKJWFthxdBKLFv,zulip__email_password:YyyoYjDuhLEPaMhAJyArcBbqiDHvmhuN
/app settings set lan-bridge=main-infrastructure-br
/certificate settings set builtin-trust-store=all
/container config set registry-url=https://dh-mirror.gitverse.ru tmpdir=/RAM
/container envs add key=AI_AS list=MihomoProxyRoS value=AS399358,AS60808
/container envs add key=AI_GEOSITE list=MihomoProxyRoS value=category-ai-!cn,openai,google-gemini,anthropic
/container envs add key=AI_IPCIDR list=MihomoProxyRoS value=216.73.216.0/22
/container envs add key=BASIC_AUTH_HASH list=MihomoProxyRoS value="\$1\$aa4w45bg\$IaUws.TSv8uVXViLZ9dsx1"
/container envs add key=BASIC_AUTH_USER list=MihomoProxyRoS value=owner
/container envs add key=BYEDPI_CMD list=MihomoProxyRoS value="-Ku -a1 -An -d1 -s1+s -d3+s -s6+s -d9+s -s12+s -d15+s -s20+s -d25+s -s30+s -d35+s -At,r,s -s1 -q1 -At,r,s -s5 -o2 -At,r,s -o1 -d1 -r1+s -s1+s -d3+s -At,r,s -f-1 -r1+s -At,r,s -s1 -o1+s -s-1"
/container envs add key=DISCORD_GEOIP list=MihomoProxyRoS value=discord
/container envs add key=DISCORD_GEOSITE list=MihomoProxyRoS value=discord
/container envs add key=FAKE_IP_FILTER1 list=MihomoProxyRoS value=DOMAIN,www.youtube.com,real-ip
/container envs add key=FAKE_IP_RANGE list=MihomoProxyRoS value=198.18.0.0/15
/container envs add key=FAKE_IP_TTL list=MihomoProxyRoS value=10
/container envs add key=GROUP list=MihomoProxyRoS value=YouTube,Telegram,Discord,META,SuperCell,AI,Twitch
/container envs add key=LINK1 list=MihomoProxyRoS value=""
/container envs add key=LOG_LEVEL list=MihomoProxyRoS value=error
/container envs add key=META_AS list=MihomoProxyRoS value=AS32934,AS54115,AS63293
/container envs add key=META_GEOIP list=MihomoProxyRoS value=facebook
/container envs add key=META_GEOSITE list=MihomoProxyRoS value=meta
/container envs add key=META_IPCIDR list=MihomoProxyRoS value=41.189.185.0/24,202.59.209.0/24,223.27.200.0/24,223.27.237.0/24
/container envs add key=NAMESERVER_POLICY list=MihomoProxyRoS value=tmdb-image-prod.b-cdn.net#https://dns.quad9.net/dns-query,+.themoviedb.org#https://dns.quad9.net/dns-query,+.tmdb.org#https://dns.quad9.net/dns-query,rule-set:META_geosite_meta#https://dns.quad9.net/dns-query
/container envs add key=RULES1 list=MihomoProxyRoS value="AND,((NETWORK,udp),(DST-PORT,443)),REJECT"
/container envs add key=SUB_LINK1 list=MihomoProxyRoS value=""
/container envs add key=SUPERCELL_GEOSITE list=MihomoProxyRoS value=supercell
/container envs add key=TELEGRAM_AS list=MihomoProxyRoS value=AS62041,AS59930,AS62014,AS211157,AS44907
/container envs add key=TELEGRAM_GEOIP list=MihomoProxyRoS value=telegram
/container envs add key=TELEGRAM_GEOSITE list=MihomoProxyRoS value=telegram
/container envs add key=TELEGRAM_IPCIDR list=MihomoProxyRoS value=109.239.140.0/24,5.28.192.0/18,194.221.61.2/32,172.121.110.0/24,142.252.197.0/24
/container envs add key=TWITCH_GEOSITE list=MihomoProxyRoS value=twitch
/container envs add key=YOUTUBE_GEOSITE list=MihomoProxyRoS value=youtube
/container envs add key=ZAPRET2_CMD list=MihomoProxyRoS value=""
/container envs add key=ZAPRET_CMD list=MihomoProxyRoS value=""
/disk settings set auto-media-interface=main-infrastructure-br
/ip smb set domain=HNW enabled=yes interfaces=main-infrastructure-br
/interface bridge port add bridge=main-infrastructure-br interface=lan-poe-in trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface=lan-poe-out trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface=wlan-5Ghz trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface=wlan-2Ghz trusted=yes
/interface bridge settings set use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes tcp-established-timeout=15m udp-timeout=10s
/ip neighbor discovery-settings set discover-interface-list=list-neighbors-lookup
/ip settings set accept-source-route=yes rp-filter=loose tcp-syncookies=yes
/ipv6 settings set disable-ipv6=yes
/interface detect-internet set lan-interface-list=list-lan wan-interface-list=list-wan
/interface list member add interface=main-infrastructure-br list=list-neighbors-lookup
/interface list member add interface=main-infrastructure-br list=list-winbox-allowed
/interface list member add interface=main-infrastructure-br list=list-lan
/interface list member add interface=MihomoProxyRoS list=list-mihomo-accept
/interface list member add interface=MihomoProxyRoS list=list-containers
/interface wifi access-list add action=accept comment=MbpAlxm disabled=no mac-address=BC:D0:74:0A:B2:6A
/interface wifi access-list add action=accept comment=iPhoneAlxr disabled=no mac-address=DC:10:57:2D:39:7B
/interface wifi access-list add action=accept comment=HuaweiNbk disabled=no mac-address=4C:5F:70:97:DD:99
/interface wifi capsman set interfaces=wlan-2Ghz
/ip address add address=172.30.30.1/24 comment="local ip" interface=main-infrastructure-br network=172.30.30.0
/ip address add address=10.255.255.5 comment="router id" interface=ospf-lo network=10.255.255.5
/ip address add address=192.168.255.1/30 comment=MihomoProxyRoS interface=MihomoProxyRoS network=192.168.255.0
/ip arp add address=172.30.30.30 interface=main-infrastructure-br mac-address=48:A9:8A:98:92:5C
/ip cloud set ddns-enabled=yes ddns-update-interval=10m
/ip dhcp-server lease add address=172.30.30.70 client-id=1:6c:1f:f7:60:69:71 comment="MbpAlxm(wired)" mac-address=6C:1F:F7:60:69:71 server=main-dhcp-server
/ip dhcp-server lease add address=172.30.30.65 client-id=MbpAlxm comment="MbpAlxm(wireless)" mac-address=BC:D0:74:0A:B2:6A server=main-dhcp-server
/ip dhcp-server lease add address=172.30.30.30 client-id=1:48:a9:8a:98:92:5c comment=ATL mac-address=48:A9:8A:98:92:5C server=main-dhcp-server
/ip dhcp-server matcher add address-pool=dhcp-pool-androids code=60 matching-type=substring name=detect-android server=main-dhcp-server value=android-dhcp
/ip dhcp-server matcher add address-pool=dhcp-pool-iphones code=12 matching-type=substring name=detect-iphone-host-name server=main-dhcp-server value=iPhone
/ip dhcp-server matcher add address-pool=dhcp-pool-iphones code=60 matching-type=substring name=detect-iphone-vendor-class server=main-dhcp-server value=AAPL
/ip dhcp-server network add address=172.30.30.0/27 caps-manager=172.30.30.1 comment="Network devices, CCTV" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=172.30.30.1 gateway=172.30.30.1 netmask=24 ntp-server=172.30.30.1
/ip dhcp-server network add address=172.30.30.32/27 caps-manager=172.30.30.1 comment="Virtual machines" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=172.30.30.1 gateway=172.30.30.1 netmask=24 ntp-server=172.30.30.1
/ip dhcp-server network add address=172.30.30.64/26 caps-manager=172.30.30.1 comment="Mac, Pc" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=172.30.30.1 gateway=172.30.30.1 netmask=24 ntp-server=172.30.30.1
/ip dhcp-server network add address=172.30.30.128/27 caps-manager=172.30.30.1 comment="Phones, tablets" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=172.30.30.1 gateway=172.30.30.1 netmask=24 ntp-server=172.30.30.1
/ip dhcp-server network add address=172.30.30.160/27 caps-manager=172.30.30.1 comment="IoT, intercom" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=172.30.30.1 gateway=172.30.30.1 netmask=24 ntp-server=172.30.30.1
/ip dhcp-server network add address=172.30.30.192/27 caps-manager=172.30.30.1 comment="TV, projector, boxes" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=172.30.30.1 gateway=172.30.30.1 netmask=24 ntp-server=172.30.30.1
/ip dhcp-server network add address=172.30.30.224/27 caps-manager=172.30.30.1 comment="Reserved, special" dhcp-option=DomainName_Windows,DomainName_LinuxMac dns-server=172.30.30.1 gateway=172.30.30.1 netmask=24 ntp-server=172.30.30.1
/ip dns set address-list-extra-time=30s allow-remote-requests=yes cache-max-ttl=1d cache-size=15000KiB doh-max-concurrent-queries=500 doh-max-server-connections=10 max-concurrent-queries=200 max-concurrent-tcp-sessions=30 mdns-repeat-ifaces=main-infrastructure-br query-server-timeout=3s servers=10.153.3.212,77.88.8.1 verify-doh-cert=yes
/ip dns adlist add url=https://schakal.hopto.org/alive_hosts.txt
/ip dns static add address=1.0.0.1 comment="Forwarder bind - DNS CloudFlare" name=cloudflare-dns.com type=A
/ip dns static add address=9.9.9.9 comment="Forwarder bind - DNS Quad9" name=dns.quad9.net type=A
/ip dns static add address=149.112.112.112 comment="Forwarder bind - DNS Quad9" name=dns.quad9.net type=A
/ip dns static add address=195.133.25.16 comment="Forwarder bind - DNS Comss" name=router.comss.one type=A
/ip dns static add address=1.1.1.1 comment="Forwarder bind - DNS CloudFlare" name=cloudflare-dns.com type=A
/ip dns static add address=8.8.8.8 comment="Forwarder bind - DNS Google" name=dns.google type=A
/ip dns static add address=8.8.4.4 comment="Forwarder bind - DNS Google" name=dns.google type=A
/ip dns static add address=172.30.30.1 match-subdomain=yes name=capax.home type=A
/ip dns static add cname=capax.home name=capax type=CNAME
/ip dns static add cname=capax.home name=mihomo.capax.home type=CNAME
/ip dns static add address=192.168.90.70 name=minialx.home type=A
/ip dns static add cname=minialx.home name=minialx type=CNAME
/ip dns static add address=192.168.90.40 name=nas.home type=A
/ip dns static add cname=nas.home name=nas type=CNAME
/ip dns static add address=192.168.99.1 name=mikrouter.home type=A
/ip dns static add cname=mikrouter.home name=mikrouter type=CNAME
/ip dns static add address=192.168.90.1 name=anna.home type=A
/ip dns static add cname=anna.home name=anna type=CNAME
/ip dns static add address=192.168.90.2 name=wb.home type=A
/ip dns static add cname=wb.home name=wb type=CNAME
/ip dns static add address=192.168.97.1 name=chr.home type=A
/ip dns static add cname=chr.home name=chr type=CNAME
/ip dns static add address=192.168.90.10 name=capxl.home type=A
/ip dns static add cname=capxl.home name=capxl type=CNAME
/ip dns static add address=192.168.90.85 name=MbpAlxm.home type=A
/ip dns static add cname=MbpAlxm.home name=MbpAlxm type=CNAME
/ip dns static add cname=victoria.home name=victoria type=CNAME
/ip dns static add address=192.168.90.1 name=victoria.home type=A
/ip dns static add forward-to=DNS-Mihomo match-subdomain=yes name=pool.ntp.org type=FWD
/ip dns static add comment="Non-Existent Domain" disabled=yes name=mask.icloud.com type=NXDOMAIN
/ip dns static add comment="Non-Existent Domain" disabled=yes name=mask-h2.icloud.com type=NXDOMAIN
/ip dns static add comment="Non-Existent Domain" disabled=yes name=doh.dns.apple.com type=NXDOMAIN
/ip dns static add comment="Non-Existent Domain" disabled=yes name=dns.apple.com type=NXDOMAIN
/ip dns static add cname=box.ntc.party comment=NTCParty name=ntc.party type=CNAME
/ip dns static add comment=https://common.dot.dns.yandex.net/dns-query name="ya DOH" text="" type=TXT
/ip dns static add address=172.30.30.30 name=atl.home type=A
/ip dns static add cname=atl.home name=atl type=CNAME
/ip firewall address-list add address=www.youtube.com comment=YT_MSS list=alist-mangle-YT
/ip firewall address-list add address=www.youtube.com comment=YT list=alist-mangle-mihomo
/ip firewall address-list add address=17.248.214.0/24 list=alist-apple
/ip firewall filter add action=accept chain=input
/ip firewall mangle add action=change-mss chain=forward comment="Fix YT mss for TVs" connection-state=new disabled=yes dst-address-list=alist-mangle-YT in-interface=MihomoProxyRoS new-mss=88 protocol=tcp tcp-flags=syn
/ip firewall mangle add action=accept chain=prerouting comment="Accept w\\o connection mark" connection-mark=no-mark connection-state=established disabled=yes
/ip firewall mangle add action=accept chain=prerouting comment="Allow WAN and Containers" disabled=yes in-interface-list=list-mihomo-accept
/ip firewall mangle add action=mark-routing chain=prerouting comment=RoutingToMihomo2 connection-mark=cmark-mihomo disabled=yes in-interface-list=list-mihomo-LAN new-routing-mark=via-mihomo passthrough=no
/ip firewall mangle add action=mark-connection chain=prerouting comment=MarkConnAddressList connection-mark=no-mark connection-state=new disabled=yes dst-address-list=alist-mangle-mihomo in-interface-list=list-mihomo-LAN new-connection-mark=cmark-mihomo
/ip firewall mangle add action=jump chain=prerouting comment=chain-conn-marking connection-mark=no-mark connection-state=new in-interface-list=list-lan jump-target=chain-conn-marking
/ip firewall mangle add action=mark-connection chain=chain-conn-marking comment=chain-conn-marking-apple dst-address-list=alist-apple new-connection-mark=cmark-apple
/ip firewall mangle add action=return chain=chain-conn-marking comment=chain-conn-marking
/ip firewall mangle add action=mark-routing chain=prerouting comment=RoutingToMihomo1 connection-mark=cmark-mihomo disabled=yes in-interface-list=list-mihomo-LAN new-routing-mark=via-mihomo passthrough=no
/ip firewall nat add action=redirect chain=dstnat comment="NTP mikrotik time server" dst-address-type=!local dst-port=123 in-interface-list=list-lan log-prefix="NTP redirect" protocol=udp
/ip firewall service-port set ftp disabled=yes
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip hotspot service-port set ftp disabled=yes
/ip kid-control device add mac-address=BC:D0:74:0A:B2:6A name="MbpAlxm(wireless)" user=Alx
/ip kid-control device add mac-address=6C:1F:F7:60:69:71 name="MbpAlx(wired)" user=Alx
/ip kid-control device add mac-address=48:A9:8A:98:92:5C name=ATL user=Alx
/ip reverse-proxy add certificate=WiFi-CAPsMAN-04F41C7EF11F comment=https://mihomo.capax.home ip-address=192.168.255.2 port=80 sni=mihomo.capax.home
/ip route add check-gateway=ping comment="via ATL" disabled=no distance=1 dst-address=0.0.0.0/0 gateway=172.30.30.30 pref-src=172.30.30.1 routing-table=main scope=30 target-scope=10
/ip route add blackhole comment="BlackHole - MAIN" disabled=no distance=254 dst-address=10.0.0.0/8 gateway="" routing-table=main
/ip route add blackhole comment="BlackHole - MAIN" disabled=no distance=254 dst-address=172.16.0.0/12 gateway="" routing-table=main
/ip route add blackhole comment="BlackHole - MAIN" disabled=no distance=254 dst-address=192.168.0.0/16 gateway="" routing-table=main
/ip route add comment="via MIHO (0)" disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.255.2 routing-table=via-mihomo scope=30 target-scope=10
/ip route add blackhole comment="BlackHole - MIHO" disabled=no distance=254 dst-address=10.0.0.0/8 gateway="" routing-table=via-mihomo
/ip route add blackhole comment="BlackHole - MIHO" disabled=no distance=254 dst-address=172.16.0.0/12 gateway="" routing-table=via-mihomo
/ip route add blackhole comment="BlackHole - MIHO" disabled=no distance=254 dst-address=192.168.0.0/16 gateway="" routing-table=via-mihomo
/ip route add comment="via MIHO (1)" disabled=no distance=1 dst-address=198.18.0.0/15 gateway=192.168.255.2 routing-table=main scope=30 target-scope=10
/ip service set ftp disabled=yes
/ip service set telnet disabled=yes
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip smb shares set [ find default=yes ] disabled=no
/ip ssh set ciphers=aes-gcm,aes-ctr,aes-cbc,3des-cbc,null forwarding-enabled=remote
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_TOKEN password=8954042546:AAHg_MJ7sK4sUFKSvcQ1YsGAnep_UYnuBO0 profile=null service=async
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_CHAT_ID password=-1001798127067 profile=null service=async
/ppp secret add comment="used by \$SECRET" name=BACKUP_PASSWORD password=RHWbJxAje profile=null service=async
/snmp set contact=defm.kopcap@gmail.com location=RU
/system clock set time-zone-name=Europe/Moscow
/system identity set name=capax
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
/system logging add action=SSHOnScreenLog topics=ssh,!packet
/system logging add action=PoEOnscreenLog topics=poe-out
/system logging add action=EmailOnScreenLog topics=e-mail
/system logging add action=ParseMemoryLog topics=error
/system logging add action=ParseMemoryLog topics=account
/system logging add action=ParseMemoryLog topics=critical
/system logging add action=TransfersOnscreenLog topics=fetch,!raw
/system logging add action=PKGInstallationLog regex="^.*install.*\$"
/system logging add action=REBOOTDiskLog regex="^.*reboot.*\$" topics=!dhcp
/system logging add action=PKGInstallationLog regex="^.*package.*\$"
/system logging add action=DockerOnscreenLog topics=container
/system logging add action=VictoriaRemoteLog topics=!packet,!debug,!raw,!dns,!firewall,!ssh
/system logging add action=REBOOTDiskLog regex="^.*supout.*\$"
/system logging add action=OnScreenLog topics=!debug,!packet,!raw,!dns,!ssh,!firewall
/system logging add action=AuthDiskLog regex="^.*login.*\$"
/system logging add topics=netwatch
/system note set note="Ipsec:         okay \
    \nRoute:     172.30.30.30 \
    \nVersion:         7.23.1 \
    \nUptime:        2d10:21:14  \
    \nTime:        2026-07-03 21:13:04  \
    \nPing:    0 ms  \
    \nChr:        185.13.148.14  \
    \nMik:        178.65.91.156  \
    \nAnna:        46.39.51.213  \
    \nClock:        synchronized  \
    \n * zerotier  \
    \n * wifi-qcom  \
    \n * container  \
    \n * routeros  \
    \n" show-at-cli-login=yes
/system ntp client set enabled=yes
/system ntp server set enabled=yes manycast=yes
/system ntp client servers add address=85.21.78.91
/system ntp client servers add address=ru.pool.ntp.org
/system ntp client servers add address=ntp.msk-ix.ru
/system ntp client servers add address=ntp1.vniiftri.ru
/system ntp client servers add address=ntp2.vniiftri.ru
/system ntp client servers add address=ntp3.vniiftri.ru
/system ntp client servers add address=ntp4.vniiftri.ru
/system routerboard mode-button set enabled=yes
/system routerboard settings set auto-upgrade=yes
/system scheduler add interval=10m name=doCoolConsole on-event="/system script run doCoolConsole" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-04-15 start-time=17:52:52
/system scheduler add interval=6h name=doFlushLogs on-event="/system script run doFlushLogs" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-05-02 start-time=22:00:00
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-03-01 start-time=15:55:00
/system scheduler add interval=5d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-06-26 start-time=21:13:00
/system scheduler add interval=1d name=doLEDoff on-event="/system script run doLEDoff" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=23:30:00
/system scheduler add interval=1d name=doLEDon on-event="/system script run doLEDon" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-09-09 start-time=07:00:00
/system scheduler add interval=15m name=doCPUHighLoadReboot on-event="/system script run doCPUHighLoadReboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2019-02-07 start-time=06:05:00
/system scheduler add interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-03-01 start-time=08:00:00
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript;" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=30m name=doCloudBackup on-event="/system script run doCloudBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2026-05-11 start-time=21:13:00
/system scheduler add name=MihomoProxyRoS_repull on-event="/system/script/run MihomoProxyRoS_repull" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/tool bandwidth-server set enabled=no
/tool e-mail set certificate-verification=no from=defm.kopcap@gmail.com password=lpnaabjwbvbondrg port=587 server=smtp.gmail.com tls=yes user=defm.kopcap@gmail.com
/tool graphing interface add
/tool graphing resource add
/tool mac-server set allowed-interface-list=none
