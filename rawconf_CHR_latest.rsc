# 2026-06-24 21:13:02 by RouterOS 7.23.1
# system id = pEDSXaHXN3J
#
# custom default configuration script installed
# see /system/default-configuration/custom-script/print
#
/disk add comment=Ramdisk slot=RAM tmpfs-max-size=100000000 type=tmpfs
/disk set ssd slot=ssd
/interface bridge add name=docker-infrastructure-br port-cost-mode=short protocol-mode=none
/interface bridge add arp=proxy-arp fast-forward=no name=main-infrastructure-br port-cost-mode=short
/interface ethernet set [ find default-name=ether1 ] arp=proxy-arp comment="Trivial WAN" disable-running-check=no name=wan
/interface l2tp-server add disabled=yes name=rw-alx user=vpn-user-alx
/interface l2tp-server add name=tunnel-anna user=vpn-remote-anna
/interface l2tp-server add disabled=yes name=tunnel-mikrotik user=vpn-remote-mic
/interface veth add address=172.17.0.4/29 container-mac-address=22:35:59:47:36:AD dhcp=no gateway=172.17.0.1 gateway6="" mac-address=22:35:59:47:36:AC name=veth-caddy
/interface veth add address=172.17.0.5/29 container-mac-address=12:A7:68:6A:F3:73 dhcp=no gateway=172.17.0.1 gateway6="" mac-address=12:A7:68:6A:F3:72 name=veth-gitwatch
/interface veth add address=192.168.97.4/29 container-mac-address=2E:DD:B8:89:61:B9 dhcp=no gateway=192.168.97.1 gateway6="" mac-address=2E:DD:B8:89:61:B8 name=veth-haproxy
/interface veth add address=172.17.0.2/29 container-mac-address=26:8A:0C:A0:3E:3B dhcp=no gateway=172.17.0.1 gateway6="" mac-address=26:8A:0C:A0:3E:3A name=veth-telemt
/interface veth add address=172.17.0.3/29 container-mac-address=30:A6:92:7E:80:32 dhcp=no gateway=172.17.0.1 gateway6="" mac-address=30:A6:92:7E:80:31 name=veth-telemt-webui
/interface wireguard add listen-port=65114 mtu=1420 name=wg-to-capax private-key="03n33pIsv9MIDWss0bDxyZ0/0xsXo2OvEBjCWOy/Hlw="
/container add check-certificate=no comment="MTProto telegram proxy" dns=192.168.97.1 envlists=TELEMT_ENVS hostname=telemt interface=veth-telemt layer-dir=/docker/layers logging=yes memory-high=256.0MiB mountlists=TELEMT_VOLUMES name=telemt remote-image=raylabpro/telemt:latest root-dir=/docker/runs/telemt start-on-boot=yes user=0:0 workdir=/tmp
/container add check-certificate=no comment="MTProto telegram proxy web panel" dns=192.168.97.1 hostname=telemt-webui interface=veth-telemt-webui layer-dir=/docker/layers logging=yes memory-high=256.0MiB mountlists=TELEMT_WEBUI_VOLUMES name=telemt-webui remote-image=aleksey123/telemt-web-panel:latest root-dir=/docker/runs/telemt-webui start-on-boot=yes
/container add check-certificate=no comment="Caddy web server and reverse proxy" dns=192.168.97.1 envlists=CADDY_ENVS hostname=caddy interface=veth-caddy layer-dir=/docker/layers logging=yes memory-high=200.0MiB mountlists=CADDY_VOLUMES name=caddy remote-image=caddy:latest root-dir=/docker/runs/caddy start-on-boot=yes user=0:0 workdir=/srv
/container add check-certificate=no comment=HAproxy dns=192.168.97.1 hostname=haproxy interface=veth-haproxy layer-dir=/docker/layers logging=yes memory-high=200.0MiB mountlists=HAPROXY_VOLUMES name=haproxy remote-image=haproxy:latest root-dir=/docker/runs/haproxy start-on-boot=yes user=0:0 workdir=/var/lib/haproxy
/container add check-certificate=no comment="gitwatch autocommit utility" dns=192.168.97.1 envlists=GITWATCH_ENVS hostname=gitwatch interface=veth-gitwatch layer-dir=/docker/layers logging=yes memory-high=200.0MiB mountlists=GITWATCH_VOLUMES name=gitwatch remote-image=ghcr.io/gitwatch/gitwatch:latest root-dir=/gitwatch start-on-boot=yes user=0:0
/disk add file-path=/ssd/swap file-size=1023.6MiB media-interface=main-infrastructure-br slot=file-ssd-swap swap=yes type=file
/disk add disabled=yes media-interface=main-infrastructure-br slot=sshfs sshfs-address=185.13.148.14 sshfs-password=RHWbJxAje sshfs-path=/REPO sshfs-port=2223 sshfs-user=automation type=sshfs
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
/interface list add comment="FW:prevent DNS req from WAN" name=list-FW-prevent-dns-requests-WAN
/interface list add comment="FW: allow port redirect from WAN" name=list-FW-allow-port-redirect-WAN
/interface list add comment="FW: hairpin\\loopback from LAN" name=list-mangle-loopback-LAN
/interface list add comment="FW: listen to Portknocking" name=list-FW-portknocking
/ip dhcp-server option add code=15 name=DomainName value="s'home'"
/ip ipsec proposal set [ find default=yes ] auth-algorithms=sha256 enc-algorithms=aes-256-cbc,aes-192-cbc,aes-128-cbc,3des lifetime=1h
/ip pool add name=pool-vpn ranges=10.0.0.0/29
/ip pool add name=pool-dhcp ranges=192.168.97.0/29
/ip pool add name=pool-rw ranges=10.10.10.8/29
/ip smb users set [ find default=yes ] disabled=yes
/ppp profile add address-list=l2tp-active-clients dns-server=8.8.8.8,8.8.4.4 interface-list=list-l2tp-tunnels local-address=10.0.0.1 name=l2tp-no-encrypt-site2site only-one=no remote-address=pool-vpn use-ipv6=no
/ppp profile add address-list=l2tp-active-clients dns-server=8.8.8.8,8.8.4.4 interface-list=list-l2tp-tunnels local-address=10.0.0.1 name=l2tp-no-encrypt-ios-rw only-one=no remote-address=pool-rw
/ppp profile add bridge-learning=no change-tcp-mss=no comment="used by \$SECRET" local-address=0.0.0.0 name=null only-one=yes remote-address=0.0.0.0 session-timeout=1s use-compression=no use-encryption=no use-mpls=no use-upnp=no
/routing bgp template set default disabled=no output.network=bgp-networks
/routing id add comment="OSPF Common" disabled=no id=10.255.255.1 name=chr-10.255.255.1 select-dynamic-id=""
/routing ospf instance add comment="OSPF Common - inject into \"main\" table" disabled=no in-filter-chain=ospf-in name=routes-inject-into-main originate-default=never redistribute="" router-id=chr-10.255.255.1 routing-table=main
/routing ospf area add disabled=no instance=routes-inject-into-main name=backbone
/routing ospf area add area-id=0.0.0.1 default-cost=10 disabled=no instance=routes-inject-into-main name=chr-space-main no-summaries type=stub
/routing table add comment="tunnel swing" fib name=rmark-vpn-redirect
/snmp community set [ find default=yes ] authentication-protocol=SHA1 encryption-protocol=AES name=globus
/snmp community add addresses=::/0 disabled=yes name=public
/system logging action set 1 disk-file-name=journal disk-lines-per-file=500
/system logging action add name=IpsecOnScreenLog target=memory
/system logging action add disk-file-count=5 disk-file-name=ScriptsDiskLog disk-lines-per-file=300 name=ScriptsDiskLog target=disk
/system logging action add disk-file-count=5 disk-file-name=ErrorDiskLog disk-lines-per-file=300 name=ErrorDiskLog target=disk
/system logging action add name=TerminalConsoleLog remember=no target=echo
/system logging action add name=OnScreenLog target=memory
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
/system logging action add disk-file-count=1 disk-file-name=REBOOTLog disk-lines-per-file=100 name=REBOOTDoskLog target=disk
/system logging action add name=DockerOnscreenLog target=memory
/system script add dont-require-permissions=yes name=doBackup owner=owner policy=ftp,read,write,policy,test,password,sensitive source=":global globalScriptBeforeRun;\
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
/system script add dont-require-permissions=yes name=doRandomGen owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive source="\
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
    \n\r\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doFreshTheScripts owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
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
/system script add dont-require-permissions=yes name=doEnvironmentSetup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalNoteMe;\
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
/system script add dont-require-permissions=yes name=doNetwatchHost owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local SafeScriptCall do={\
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
/system script add dont-require-permissions=yes name=doStartupScript owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# reset current\
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
/system script add dont-require-permissions=yes name=doEnvironmentClearance owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n#clear all global variables\
    \n/system script environment remove [find];\
    \n\r\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doFlushLogs owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
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
/system script add dont-require-permissions=yes name=doImperialMarch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#test\r\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doIPSECPunch owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# ============================================================\
    \n# IPSec/L2TP Connection Monitor & Auto-Recovery Script\
    \n# Version: 2.1\
    \n# ============================================================\
    \n\
    \n# === INITIALIZATION ===\
    \n:global globalScriptBeforeRun\
    \n:global globalNoteMe\
    \n:global globalTgMessage\
    \n\
    \n# Prevent concurrent execution\
    \n\$globalScriptBeforeRun \"doIPSECTest\"\
    \n\
    \n# === CONFIGURATION ===\
    \n:local Config {\
    \n    \"pingCount\"=10;\
    \n    \"pingSuccessRate\"=80;\
    \n    \"pingInterval\"=1000ms;\
    \n    \"pingRetryDelay\"=20s;\
    \n    \"maxRetryAttempts\"=3;\
    \n    \"flushHour\"=23;\
    \n    \"enableAutoRecovery\"=true\
    \n}\
    \n\
    \n:local PingTrigger ((\$Config->\"pingCount\") * (\$Config->\"pingSuccessRate\") / 100)\
    \n\
    \n\
    \n# Log with timestamp\
    \n:local Log do={\
    \n    :global globalNoteMe\
    \n    :local message [:tostr \$1]\
    \n    :local level [:tostr \$2]\
    \n    :if ([:len \$level] = 0) do={ :set level \"info\" }\
    \n    :local timestamp [/system clock get time]\
    \n    :local fullMessage (\"[\" . \$timestamp . \"][\" . \$level . \"] \" . \$message)\
    \n    \$globalNoteMe value=\$fullMessage\
    \n  \
    \n}\
    \n\
    \n# Calculate IP details from CIDR\
    \n:local IPCalc do={\
    \n    :local cidr [:tostr \$1]\
    \n    :local address [:toip [:pick \$cidr 0 [:find \$cidr \"/\"]]]\
    \n    :local bits [:tonum [:pick \$cidr ([:find \$cidr \"/\"] + 1) [:len \$cidr]]]\
    \n    :local mask ((255.255.255.255 << (32 - \$bits)) & 255.255.255.255)\
    \n    :return {\
    \n        \"network\"=(\$address & \$mask);\
    \n        \"hostmin\"=((\$address & \$mask) | 0.0.0.1);\
    \n        \"broadcast\"=(\$address | ~\$mask)\
    \n    }\
    \n}\
    \n\
    \n# Extract first IP from CIDR or return as-is\
    \n:local ExtractIP do={\
    \n    :local input [:tostr \$1]\
    \n    :if ([:find \$input \"/\"] >= 0) do={\
    \n        :return [:pick \$input 0 [:find \$input \"/\"]]\
    \n    }\
    \n    :return \$input\
    \n}\
    \n\
    \n# Find L2TP session info\
    \n:local FindL2TPSession do={\
    \n    :local dstIP [:tostr \$1]\
    \n    :local result {\"found\"=false; \"type\"=\"none\"}\
    \n\
    \n    # Incoming L2TP (server)\
    \n    :local incoming [/ppp/active find caller-id=\$dstIP]\
    \n    :if ([:len \$incoming] != 0) do={\
    \n        :set (\$result->\"running\") true\
    \n        :set (\$result->\"found\") true\
    \n        :set (\$result->\"type\") \"incoming\"\
    \n        :set (\$result->\"session\") \$incoming\
    \n        :set (\$result->\"peer\") [/ppp/active get \$incoming name]\
    \n        :set (\$result->\"remoteIP\") [/ppp/active get \$incoming address]\
    \n        :local network [/ip/address get [find network=(\$result->\"remoteIP\")] address]\
    \n        :set (\$result->\"localIP\") [:pick \$network 0 [:find \$network \"/\"]]\
    \n        :return \$result\
    \n    }\
    \n\
    \n    # Outgoing L2TP (client)\
    \n    :local outgoing [/interface/l2tp-client find where !disabled connect-to=\$dstIP]\
    \n    :if ([:len \$outgoing] != 0) do={\
    \n\
    \n        :local online [/interface/l2tp-client get \$outgoing running]\
    \n        :set (\$result->\"running\") \$online\
    \n        :set (\$result->\"found\") true\
    \n        :set (\$result->\"type\") \"outgoing\"\
    \n        :set (\$result->\"session\") \$outgoing\
    \n        :set (\$result->\"peer\") [/interface/l2tp-client get \$outgoing name]\
    \n\
    \n        :if ( \$online ) do={\
    \n            :local monitor [/interface l2tp-client monitor \$outgoing once as-value]\
    \n            :set (\$result->\"remoteIP\") (\$monitor->\"remote-address\")\
    \n            :local network [/ip/address get [find network=(\$result->\"remoteIP\")] address]\
    \n            :set (\$result->\"localIP\") [:pick \$network 0 [:find \$network \"/\"]]\
    \n\
    \n        }  else={\
    \n\
    \n            :set (\$result->\"remoteIP\") 0.0.0.1\
    \n            :set (\$result->\"localIP\") 0.0.0.1\
    \n            \
    \n        }\
    \n\
    \n        :return \$result\
    \n    }\
    \n\
    \n    :return \$result\
    \n}\
    \n\
    \n# Test connectivity with retry\
    \n:local TestConnectivity do={\
    \n    :local targetIP [:toip \$1]\
    \n    :local sourceIP [:toip \$2]\
    \n    :local count [:tonum \$3]\
    \n    :local threshold [:tonum \$4]\
    \n    :local retryDelay \$5\
    \n\
    \n    :local result1 [/ping address=\$targetIP src-address=\$sourceIP count=\$count interval=1000ms]\
    \n    :if (\$result1 >= \$threshold) do={\
    \n        :return {\"success\"=true; \"attempts\"=1; \"received\"=\$result1; \"required\"=\$threshold}\
    \n    }\
    \n\
    \n    :delay \$retryDelay\
    \n    :local result2 [/ping address=\$targetIP src-address=\$sourceIP count=\$count interval=1000ms]\
    \n    :if (\$result2 >= \$threshold) do={\
    \n        :return {\"success\"=true; \"attempts\"=2; \"received\"=\$result2; \"required\"=\$threshold}\
    \n    }\
    \n\
    \n    :return {\"success\"=false; \"attempts\"=2; \"received\"=\$result2; \"required\"=\$threshold}\
    \n}\
    \n\
    \n# Check route availability\
    \n:local CheckRoute do={\
    \n    :local dstIP [:toip \$1]\
    \n    :local srcIP [:toip \$2]\
    \n    :local check [/ip/route/check dst-ip=\$dstIP src-ip=\$srcIP once as-value]\
    \n    :local status (\$check->\"status\")\
    \n    :if (\$status = \"ok\") do={\
    \n        :return {\
    \n            \"reachable\"=true;\
    \n            \"interface\"=(\$check->\"interface\");\
    \n            \"gateway\"=(\$check->\"gateway\");\
    \n            \"nexthop\"=(\$check->\"nexthop\")\
    \n        }\
    \n    }\
    \n    :return {\"reachable\"=false; \"status\"=\$status}\
    \n}\
    \n\
    \n# Kill L2TP session\
    \n:local KillL2TPSession do={\
    \n    :local sessionInfo \$1\
    \n    :local Log \$2\
    \n    :if (!(\$sessionInfo->\"found\")) do={ :return false }\
    \n\
    \n    :do {\
    \n        :if ((\$sessionInfo->\"type\") = \"incoming\") do={\
    \n            /ppp/active remove (\$sessionInfo->\"session\")\
    \n            :local msg (\"Killed incoming L2TP session: \" . (\$sessionInfo->\"peer\"))\
    \n            \$Log \$msg\
    \n        } else={\
    \n            /interface/l2tp-client disable (\$sessionInfo->\"session\")\
    \n            :delay 4s\
    \n            /interface/l2tp-client enable (\$sessionInfo->\"session\")\
    \n            :local msg (\"Restarted outgoing L2TP client: \" . (\$sessionInfo->\"peer\"))\
    \n            \$Log \$msg\
    \n        }\
    \n        :return true\
    \n    } on-error={\
    \n        :local msg (\"FAILED to kill L2TP session for peer: \" . . (\$sessionInfo->\"peer\"))\
    \n        \$Log \$msg \"error\"\
    \n        :return false\
    \n    }\
    \n}\
    \n\
    \n# Kill IPSec active peers\
    \n:local KillIPSecPeers do={\
    \n    :local peerIP [:tostr \$1]\
    \n    :local Log \$2\
    \n    :local activePeers [/ip/ipsec/active-peers find remote-address=\$peerIP]\
    \n\
    \n    :if ([:len \$activePeers] = 0) do={\
    \n        :local msg (\"No active IPSec peers found for \" . \$peerIP)\
    \n        \$Log \$msg \"warning\"\
    \n        :return false\
    \n    }\
    \n\
    \n    :local killCount 0\
    \n    :foreach peer in=\$activePeers do={\
    \n        :do {\
    \n            /ip/ipsec/active-peers remove \$peer\
    \n            :set killCount (\$killCount + 1)\
    \n        } on-error={ \
    \n            :local err\
    \n            :local msg (\"FAILED to kill IPSec peer: \" . \$peerIP)\
    \n            \$Log \$msg \"error\"\
    \n        }\
    \n    }\
    \n\
    \n    :if (\$killCount > 0) do={\
    \n        :local msg (\"Killed \" . \$killCount . \" IPSec active peer(s) for \" . \$peerIP)\
    \n        \$Log \$msg\
    \n        :return true\
    \n    }\
    \n\
    \n    :return false\
    \n}\
    \n\
    \n# Perform recovery actions\
    \n:local RecoverPeer do={\
    \n\
    \n    :global globalPeerRetryCount\
    \n    :local peerIP [:tostr \$1]\
    \n    :local peerName [:tostr \$2]\
    \n    :local l2tpSession \$3\
    \n    :local Config \$4\
    \n    :local Log \$5\
    \n    :local KillL2TP \$6\
    \n    :local KillIPSec \$7\
    \n\
    \n    :local retryCount (\$globalPeerRetryCount->\$peerIP)\
    \n\
    \n    :if ([:typeof \$retryCount] != \"num\") do={ :set retryCount 0 }\
    \n   \
    \n    :set retryCount (\$retryCount + 1)\
    \n    :set (\$globalPeerRetryCount->\$peerIP) \$retryCount\
    \n\
    \n    :if (\$retryCount > (\$Config->\"maxRetryAttempts\")) do={\
    \n        :local msg (\"Peer \" . \$peerName . \" (\" . \$peerIP . \") exceeded max retry attempts (\" . \$retryCount . \") - MANUAL INTERVENTION REQUIRED\")\
    \n        \$Log \$msg \"error\"\
    \n        :return false\
    \n    }\
    \n\
    \n    :local startMsg (\"=== RECOVERY START: \" . \$peerName . \" (\" . \$peerIP . \") - Attempt \" . \$retryCount . \" ===\")\
    \n    \$Log \$startMsg\
    \n\
    \n    :if ((\$l2tpSession->\"found\")) do={\
    \n        :local killed [\$KillL2TP \$l2tpSession \$Log]\
    \n        :if (\$killed) do={ :delay 2s }\
    \n    }\
    \n\
    \n    :local ipsecKilled [\$KillIPSec \$peerIP \$Log]\
    \n    :if (\$ipsecKilled) do={ :delay 2s }\
    \n\
    \n    :local endMsg (\"=== RECOVERY COMPLETE: \" . \$peerName . \" (\" . \$peerIP . \") ===\")\
    \n    \$Log \$endMsg\
    \n    :return true\
    \n}\
    \n\
    \n# === MAIN EXECUTION ===\
    \n\
    \n\$Log \"=== IPSec/L2TP Connection Monitor Started ===\"\
    \n\
    \n:local PoliciesOnline [/ip/ipsec/policy find ( !template !disabled) ]\
    \n\
    \n:local msgPolicies (\"Found \" . [:len \$PoliciesOnline] . \" IPSec policies to investigate\")\
    \n\$Log \$msgPolicies\
    \n\
    \n# === STATISTICS ===\
    \n:local Stats {\
    \n    \"totalPolicies\"=[:len \$PoliciesOnline];\
    \n    \"testedPeers\"=0;\
    \n    \"passedPeers\"=0;\
    \n    \"failedPeers\"=0;\
    \n    \"recoveredPeers\"=0;\
    \n    \"skippedPeers\"=0\
    \n}\
    \n\
    \n# === MAIN POLICY CHECK LOOP ===\
    \n\
    \n:foreach policy in=\$PoliciesOnline do={\
    \n\
    \n        :local peerName \
    \n        :local srcAddr\
    \n        :local dstAddr\
    \n        :local l2tpInfo\
    \n\
    \n    :do {\
    \n        :set peerName [/ip/ipsec/policy get \$policy peer]\
    \n        :local isTunnel [/ip/ipsec/policy get \$policy tunnel]\
    \n\
    \n        :local isActive [/ip/ipsec/policy get \$policy active]\
    \n        :local polState [/ip/ipsec/policy get \$policy ph2-state]\
    \n\
    \n\
    \n        :set srcAddr\
    \n        :set dstAddr\
    \n\
    \n        :if (\$isTunnel) do={\
    \n            :local dstSubnet [/ip/ipsec/policy get \$policy dst-address]\
    \n            :local srcSubnet [/ip/ipsec/policy get \$policy src-address]\
    \n            :local dstCalc [\$IPCalc \$dstSubnet]\
    \n            :local srcCalc [\$IPCalc \$srcSubnet]\
    \n            :set dstAddr (\$dstCalc->\"hostmin\")\
    \n            :set srcAddr (\$srcCalc->\"hostmin\")\
    \n        } else={\
    \n            :set dstAddr [\$ExtractIP [/ip/ipsec/policy get \$policy dst-address]]\
    \n            :set srcAddr [\$ExtractIP [/ip/ipsec/policy get \$policy src-address]]\
    \n        }\
    \n\
    \n        :set (\$Stats->\"testedPeers\") ((\$Stats->\"testedPeers\") + 1)\
    \n\
    \n        :local testMsg (\"Examine Peer \" . \$peerName . \" (\" . \$dstAddr . \")\")\
    \n        \$Log \$testMsg\
    \n\
    \n        # 1) Looking for host L2TP session\
    \n        :set l2tpInfo [\$FindL2TPSession \$dstAddr]\
    \n\
    \n        :if (!\$isActive) do={\
    \n\
    \n            :local errL2tp (\"Non-active policy investigated for \" . \$peerName . \"\")\
    \n            \$Log \$errL2tp \"error\"\
    \n            :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n            :error \"skip-continue\"\
    \n\
    \n        }\
    \n\
    \n        :if ( \$polState!=\"established\" ) do={\
    \n\
    \n            :local errL2tp (\"Non-established policy investigated for \" . \$peerName . \"\")\
    \n            \$Log \$errL2tp \"error\"\
    \n            \
    \n            # some more diagnostic\
    \n           :if ((\$l2tpInfo->\"found\")) do={\
    \n   \
    \n                :if (!(\$l2tpInfo->\"running\")) do={\
    \n\
    \n                     :local errL2tp (\"Disconnected (Rx-Tx 0-0) \". (\$l2tpInfo->\"type\") . \" L2TP host-tunnel found for IPSEC: \" . (\$l2tpInfo->\"peer\"))             \
    \n                     \$Log \$errL2tp \"error\"\
    \n\
    \n                 }\
    \n\
    \n             }\
    \n\
    \n            :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n            :error \"skip-continue\"\
    \n\
    \n        }\
    \n\
    \n\
    \n        :local policyDstIP \$dstAddr\
    \n        :local policySrcIP \$srcAddr\
    \n\
    \n        :local mustUseL2TP false\
    \n        \
    \n        :local l2tpIf \"\"\
    \n        :local l2tpRouteIf \"\"\
    \n        :local policyRouteIf \"\"\
    \n\
    \n        :if ((\$l2tpInfo->\"found\")) do={\
    \n   \
    \n           :if (!(\$l2tpInfo->\"running\")) do={\
    \n\
    \n                :local errL2tp (\"Disconnected (Rx-Tx 0-0) \". (\$l2tpInfo->\"type\") . \" L2TP host-tunnel found for IPSEC: \" . (\$l2tpInfo->\"peer\"))                  \
    \n                \$Log \$errL2tp \"error\"\
    \n                :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                :error \"skip-continue\"\
    \n\
    \n            }\
    \n\
    \n           :local l2tpMsg (\"Active \". (\$l2tpInfo->\"type\") . \" L2TP host-tunnel found for IPSEC: \" . (\$l2tpInfo->\"peer\"))\
    \n            \$Log \$l2tpMsg\
    \n\
    \n            :local L2TPDstadd (\$l2tpInfo->\"remoteIP\")\
    \n            :local L2TPSrcadd (\$l2tpInfo->\"localIP\")\
    \n            :set mustUseL2TP true\
    \n            :set l2tpIf (\$l2tpInfo->\"peer\")\
    \n\
    \n            :set l2tpMsg \"Looking for specific (l2tp) routes to \$L2TPDstadd from \$L2TPSrcadd\"\
    \n            \$Log \$l2tpMsg\
    \n\
    \n            # we need specific route in the main table to that subnet\
    \n            :local l2tpRouteCheck [\$CheckRoute \$L2TPDstadd \$L2TPSrcadd]\
    \n            :if (!(\$l2tpRouteCheck->\"reachable\")) do={\
    \n\
    \n                :local errL2tp (\"Cannot find specific route (l2tp) to \" . \$L2TPDstadd . \" from \" . \$L2TPSrcadd . \" - status: \" . (\$l2tpRouteCheck->\"status\"))\
    \n                \$Log \$errL2tp \"error\"\
    \n                :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                :error \"skip-continue\"\
    \n\
    \n            } else={\
    \n\
    \n                :set l2tpRouteIf (\$l2tpRouteCheck->\"interface\")\
    \n                :local okL2tp (\"Found specific route (l2tp) to \" . \$L2TPDstadd .  \" from \" . \$L2TPSrcadd . \" via \" . (\$l2tpRouteCheck->\"nexthop\") . \" (\" . \$l2tpRouteIf . \")\")\
    \n                \$Log \$okL2tp\
    \n\
    \n            }\
    \n\
    \n            :set policyDstIP \$L2TPDstadd\
    \n            :set policySrcIP \$L2TPSrcadd\
    \n        \
    \n        } else={\
    \n\
    \n            :if (!\$isTunnel) do={\
    \n                # on transtort mode l2tp session have to exist (just a local convinience)\
    \n                :local errL2tp (\"No active L2TP host-tunnel found for IPSEC peer - \" . \$peerName . \" (on transport policy l2tp session have to exist)\")\
    \n                \$Log \$errL2tp \"error\"\
    \n                :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                :error \"skip-continue\"\
    \n\
    \n            } else={\
    \n                :local l2tpMsg (\"No active L2TP host-tunnel found for IPSEC peer - \" . \$peerName . \" (pure IPSEC, tunneled=\$isTunnel)\")\
    \n                \$Log \$l2tpMsg\
    \n            }\
    \n\
    \n        }\
    \n\
    \n\
    \n        :local polMsg \"Looking for specific (policy) routes to \$policyDstIP from \$policySrcIP\"\
    \n        \$Log \$polMsg\
    \n\
    \n        # 2) Policy route check\
    \n\
    \n        # we need specific route in the main table to that subnet\
    \n        :local policyRouteCheck [\$CheckRoute \$policyDstIP \$policySrcIP]\
    \n        :if (!(\$policyRouteCheck->\"reachable\")) do={\
    \n\
    \n            :local errPol (\"Cannot find specific route (policy) to \" . \$policyDstIP . \" from \" . \$policySrcIP . \" - status: \" . (\$policyRouteCheck->\"status\"))\
    \n            \$Log \$errPol \"error\"\
    \n            :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n            :error \"skip-continue\"\
    \n\
    \n        } else={\
    \n\
    \n            :set policyRouteIf (\$policyRouteCheck->\"interface\")\
    \n            :local okPol (\"Found specific route (policy) to \" . \$policyDstIP .  \" from \" . \$policySrcIP . \" via \" . (\$policyRouteCheck->\"nexthop\") . \" (\" . \$policyRouteIf . \")\")\
    \n            \$Log \$okPol\
    \n\
    \n                # 3) both routes have to be via the same catched L2TP interface\\gw\
    \n            :if (\$mustUseL2TP) do={\
    \n\
    \n                :local pingMsg \"Checking policy-l2tp routes' interfaces match\"\
    \n                \$Log \$pingMsg\
    \n\
    \n                # \D0\9E\D0\B1\D0\B0 \D0\BC\D0\B0\D1\80\D1\88\D1\80\D1\83\D1\82\D0\B0 (policy \D0\B8 test) \D0\B4\D0\BE\D0\BB\D0\B6\D0\BD\D1\8B \D0\B1\D1\8B\D1\82\D1\8C \D1\87\D0\B5\D1\80\D0\B5\D0\B7 L2TP\E2\80\91\D0\B8\D0\BD\D1\82\D0\B5\D1\80\D1\84\D0\B5\D0\B9\D1\81\
    \n                :if ((\$policyRouteIf != \$l2tpIf) or (\$l2tpRouteIf != \$l2tpIf)) do={\
    \n                    :local errIf (\"Found routes mismatch (policy via \" . \$policyRouteIf . \", l2tp via \" . \$l2tpRouteIf . \", expected \" . \$l2tpIf . \")\")\
    \n                    \$Log \$errIf \"error\"\
    \n                    :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                    :error \"skip-continue\"\
    \n\
    \n                } else={\
    \n\
    \n                    :local rL2tp (\"Found routes' interfaces are the same on L2TP \" . \$l2tpIf . \" and Policy \" . \$peerName )\
    \n                    \$Log \$rL2tp\
    \n\
    \n                    :set rL2tp (\"Pinging remote IP \" . \$policyDstIP )\
    \n                    \$Log \$rL2tp\
    \n\
    \n                    :local pingResult [\$TestConnectivity \$policyDstIP \$policySrcIP (\$Config->\"pingCount\") \$PingTrigger (\$Config->\"pingRetryDelay\")]\
    \n                    :if ((\$pingResult->\"success\")) do={\
    \n                        \
    \n                        :local pMsg (\"PASS: Ping test successful \" . (\$pingResult->\"received\") . \"/\" . (\$pingResult->\"required\") . \" (\" . (\$pingResult->\"attempts\") . \" attempt(s))\")\
    \n                        \$Log \$pMsg\
    \n\
    \n                        :set (\$Stats->\"passedPeers\") ((\$Stats->\"passedPeers\") + 1)\
    \n\
    \n                        # :set (\$globalPeerRetryCount->\$dstAddr) 0\
    \n                    } else={\
    \n\
    \n                        :local fMsg (\"FAIL: Ping test failed \" . (\$pingResult->\"received\") . \"/\" . (\$pingResult->\"required\") . \" after \" . (\$pingResult->\"attempts\") . \" attempts\")\
    \n\
    \n                        :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n\
    \n                        \$Log \$fMsg \"error\"\
    \n                       #going to recover\
    \n                       :error \"skip-continue\"\
    \n\
    \n                    }\
    \n                }\
    \n            \
    \n            } else={\
    \n\
    \n                :local pingMsg \"Skip policy-l2tp routes' interfaces match - no active L2TP host-tunnel available\"\
    \n                \$Log \$pingMsg\
    \n\
    \n                :local rL2tp (\"Pinging remote IP \" . \$policyDstIP )\
    \n                \$Log \$rL2tp\
    \n\
    \n                :local pingResult [\$TestConnectivity \$policyDstIP \$policySrcIP (\$Config->\"pingCount\") \$PingTrigger (\$Config->\"pingRetryDelay\")]\
    \n                :if ((\$pingResult->\"success\")) do={\
    \n                    \
    \n                    :local pMsg (\"PASS: Ping test successful \" . (\$pingResult->\"received\") . \"/\" . (\$pingResult->\"required\") . \" (\" . (\$pingResult->\"attempts\") . \" attempt(s))\")\
    \n                    \$Log \$pMsg\
    \n\
    \n                    :set (\$Stats->\"passedPeers\") ((\$Stats->\"passedPeers\") + 1)\
    \n\
    \n                    # :set (\$globalPeerRetryCount->\$dstAddr) 0\
    \n                } else={\
    \n\
    \n                    :local fMsg (\"FAIL: Ping test failed \" . (\$pingResult->\"received\") . \"/\" . (\$pingResult->\"required\") . \" after \" . (\$pingResult->\"attempts\") . \" attempts\")\
    \n \
    \n                    :set (\$Stats->\"failedPeers\") ((\$Stats->\"failedPeers\") + 1)\
    \n                  \
    \n                    \$Log \$fMsg \"error\"\
    \n                    # going to recover\
    \n                    :error \"skip-continue\"\
    \n\
    \n                }\
    \n\
    \n            }\
    \n\
    \n        } \
    \n\
    \n        \$Log \"Continue next\"\
    \n\
    \n    } on-error={ \
    \n\
    \n        # just go next policy\
    \n\
    \n                        :if ((\$Config->\"enableAutoRecovery\")) do={\
    \n                            :local recovered [\$RecoverPeer \$dstAddr \$peerName \$l2tpInfo \$Config \$Log \$KillL2TPSession \$KillIPSecPeers]\
    \n                            :if (\$recovered) do={\
    \n\
    \n                                :set (\$Stats->\"recoveredPeers\") ((\$Stats->\"recoveredPeers\") + 1)\
    \n\
    \n                            }\
    \n                        } else={\
    \n                            \$Log \"Auto-recovery disabled - manual intervention required\" \"warning\"\
    \n                        }\
    \n\
    \n\
    \n        \$Log \"Continue next (in case of skip or erros)\" \"warning\"\
    \n\
    \n    }\
    \n\
    \n\
    \n}\
    \n\
    \n# === POST-CHECK VALIDATION ===\
    \n\
    \n\$Log \"Waiting for system to come up after autorecovery\"\
    \n\
    \n:delay 5s\
    \n:local PoliciesOnlineAfter [/ip/ipsec/policy find active ph2-state=established]\
    \n:local PoliciesOfflineAfter [/ip/ipsec/policy find ( !template !disabled ph2-state!=established) ]\
    \n\
    \n# === FINAL SUMMARY ===\
    \n\
    \n\$Log \"=== TEST SUMMARY ===\"\
    \n\
    \n:local sumMsg1 (\"Total policies: \" . (\$Stats->\"totalPolicies\"))\
    \n\$Log \$sumMsg1\
    \n\
    \n:local sumMsg2 (\"Tested: \" . (\$Stats->\"testedPeers\") . \" | Passed: \" . (\$Stats->\"passedPeers\") . \" | Failed: \" . (\$Stats->\"failedPeers\"))\
    \n\$Log \$sumMsg2\
    \n\
    \n:local sumMsg3 (\"Recovered: \" . (\$Stats->\"recoveredPeers\") . \" | Skipped: \" . (\$Stats->\"skippedPeers\"))\
    \n\$Log \$sumMsg3\
    \n\
    \n:local sumMsg4 (\"Policies after check: Online=\" . [:len \$PoliciesOnlineAfter] . \" | Offline=\" . [:len \$PoliciesOfflineAfter])\
    \n\$Log \$sumMsg4\
    \n\
    \n# === RESULT ===\
    \n\
    \n:local testPassed true\
    \n:local errorMessage \"\"\
    \n\
    \n:if ((\$Stats->\"failedPeers\") > 0) do={\
    \n    :set testPassed false\
    \n    :set errorMessage ((\$Stats->\"failedPeers\") . \" peer(s) failed connectivity test\")\
    \n}\
    \n\
    \n:if ([:len \$PoliciesOfflineAfter] != 0) do={\
    \n    :set testPassed false\
    \n    :set errorMessage (\$errorMessage . \"; \" . [:len \$PoliciesOfflineAfter] . \" policies offline after recovery\")\
    \n}\
    \n\
    \n:if (\$testPassed) do={\
    \n    \$Log \"=== IPSec/L2TP Monitor: ALL CHECKS PASSED ===\" \"info\"\
    \n} else={\
    \n    \$Log \"=== IPSec/L2TP Monitor: FAILURES DETECTED ===\" \"error\"\
    \n    :local errLog (\"Error: \" . \$errorMessage)\
    \n    \$Log \$errLog \"error\"\
    \n\
    \n    :local tgMsg (\"IPSec Monitor ALERT: \" . \$errorMessage)\
    \n    \$globalTgMessage value=\$tgMsg\
    \n\
    \n    :error \$errorMessage\
    \n}\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doUpdatePoliciesRemotely owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n:local sysname [/system identity get name];\
    \n:local scriptname \"doUpdatePoliciesRemotely\";\
    \n:global globalScriptBeforeRun;\
    \n\$globalScriptBeforeRun \$scriptname;\
    \n\
    \n:global globalNoteMe;\
    \n:local itsOk true;\
    \n:local state \"\";\
    \n\
    \n# variables should be set before via remote SSH call\
    \n:global globalRemoteIp;\
    \n:global globalPolicyComment;\
    \n\
    \n\
    \n:do {\
    \n    :if ([:len \$globalRemoteIp] > 0) do={\
    \n\
    \n    :local peerID \$globalPolicyComment;\
    \n\
    \n    /ip ipsec policy {\
    \n        :foreach vpnEndpoint in=[find (!disabled and template and comment=\"\$peerID\")] do={\
    \n        \
    \n            :local dstIp;\
    \n            :set dstIp [get value-name=dst-address \$vpnEndpoint];\
    \n\
    \n            :if ((\$itsOk) and (\$globalRemoteIp != \$dstIp )) do={\
    \n\
    \n                [set \$vpnEndpoint disabled=yes];\
    \n\
    \n                :set state \"IPSEC policy template found with wrong IP (\$dstIp). Going change it to (\$globalRemoteIp)\";\
    \n                \$globalNoteMe value=\$state;\
    \n\
    \n                /ip ipsec peer {\
    \n                    :foreach thePeer in=[find name=\$peerID] do={\
    \n\
    \n                        :if (\$itsOk) do={\
    \n\
    \n                            :set state \"Setting up peer remote address..\"\
    \n                            \$globalNoteMe value=\$state;\
    \n\
    \n                            [set \$thePeer disabled=yes];\
    \n\
    \n                            :delay 5;\
    \n\
    \n                            [set \$thePeer disabled=no address=\$globalRemoteIp];\
    \n\
    \n                          \
    \n                        }\
    \n\
    \n                    }\
    \n\
    \n                }\
    \n\
    \n                :delay 5;\
    \n                \
    \n                [set \$vpnEndpoint dst-address=\$globalRemoteIp disabled=no];\
    \n\
    \n            }\
    \n\
    \n        }\
    \n\
    \n    }\
    \n    \
    \n    }\
    \n} on-error= {\
    \n    :local state (\"globalIPSECPolicyUpdateViaSSH error\");\
    \n    \$globalNoteMe value=\$state;\
    \n    :set itsOk false;\
    \n};\
    \n\
    \n\
    \n:local inf \"\"\
    \n:if (\$itsOk) do={\
    \n  :set inf \"\$scriptname on \$sysname: policies refreshed Successfully\"\
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
    \n  \$globalTgMessage value=\$inf;  \
    \n  :error \$inf; \
    \n\
    \n  \
    \n}\
    \n\
    \n\
    \n\r\
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doUpdateExternalDNS owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
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
    \n\r\
    \n"
/system script add dont-require-permissions=yes name=doCoolConsole owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\
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
/system script add dont-require-permissions=yes name=doCloudBackup owner=owner policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":global globalScriptBeforeRun;\
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
/user group set read policy=local,telnet,ssh,read,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!write,!policy,!sensitive
/user group set write policy=local,telnet,ssh,read,write,test,winbox,password,web,sniff,api,romon,rest-api,!ftp,!reboot,!policy,!sensitive
/app set cinny firewall-redirects=8094:80:tcp:web
/app set goaway container-command-lines=goaway:none:docker.io/pommee/goaway:latest
/app set home-assistant container-command-lines=home-assistant:none:lscr.io/linuxserver/homeassistant
/app set lorawan-stack secrets=lorawan-stack__admin_password:kXIdsIQlJeTIJmcJVPEzKJpXBWjhebMI
/app set n8n firewall-redirects=5678:5678:tcp:web
/app set nextcloud container-command-lines="db:none:docker.io/postgres:17,redis:none:docker.io/valkey/valkey:/bin/sh -c 'valkey-server --port 6379 --appendonly yes --requirepass \$VALKEY_PASSWORD',server:none:docker.io/nextcloud:apache"
/app set pihole environment="pihole:FTLCONF_dns_listeningMode=all,pihole:FTLCONF_webserver_api_password=password"
/app set redlib firewall-redirects=8087:8080:tcp:web
/app set solr container-command-lines=solr:none:docker.io/solr:latest
/app set uptime-kuma container-command-lines=uptime-kuma:none:docker.io/louislam/uptime-kuma:1
/app set zulip secrets=zulip__postgres_password:JvMVlVAXmHyDXzfUiCEadxGiQMeEREHM,zulip__memcached_password:ozfWGsehdZXDDGbWPPhFgUcxGxwSvmkE,zulip__rabbitmq_password:MDDJoIfnmqafZnrhRaSgvRqubSTKTdtZ,zulip__redis_password:YbmBetZbgKbZzPKoLcBVYoMfLKjxyKan,zulip__secret_key:AFtYIdnhAQbhASCmdSBUuaeMfVixsLyS,zulip__email_password:YyEoFvfAtmPakqAtAvgBRqdZmCPTYCsN
/app settings set disk=ssd lan-bridge=main-infrastructure-br
/certificate scep-server add ca-cert=ca@CHR days-valid=365 path=/scep/grant request-lifetime=5m
/container config set layer-dir=/docker/layers memory-high=768.0MiB registry-url=https://registry-1.docker.io tmpdir=/docker/pulls
/container envs add key=CADDY_INT_PORT list=CADDY_ENVS value=4430
/container envs add key=CADDY_MAIN_PORT list=CADDY_ENVS value=1443
/container envs add key=DOMAIN list=CADDY_ENVS value=usetheforce.io
/container envs add key=INTERNAL_DOMAIN list=CADDY_ENVS value=internal.chr.home
/container envs add key=COMMIT_ON_START list=GITWATCH_ENVS value=true
/container envs add key=GIT_BRANCH list=GITWATCH_ENVS value=_autobranch
/container envs add key=GIT_REMOTE list=GITWATCH_ENVS value=origin
/container envs add key=GIT_WATCH_DIR list=GITWATCH_ENVS value=/app/watched-repo
/container envs add key=PULL_BEFORE_PUSH list=GITWATCH_ENVS value=true
/container envs add key=SLEEP_TIME list=GITWATCH_ENVS value=40
/container envs add key=VERBOSE list=GITWATCH_ENVS value=true
/container envs add comment=debug key=RUST_LOG list=TELEMT_ENVS value=info
/container mounts add dst=/srv list=CADDY_VOLUMES mode=ro src=/docker/runs/caddy/caddy_site
/container mounts add dst=/data list=CADDY_VOLUMES src=/docker/runs/caddy/caddy_data
/container mounts add dst=/config list=CADDY_VOLUMES src=/docker/runs/caddy/caddy_config
/container mounts add dst=/etc/caddy list=CADDY_VOLUMES mode=ro src=/docker/runs/caddy/caddy_setup
/container mounts add dst=/app/watched-repo list=GITWATCH_VOLUMES src=/REPO/raw
/container mounts add dst=/usr/local/etc/haproxy list=HAPROXY_VOLUMES mode=ro src=/docker/runs/haproxy
/container mounts add dst=/etc/telemt list=TELEMT_VOLUMES src=/docker/runs/telemt
/container mounts add dst=/etc/telemt-panel/config.toml list=TELEMT_WEBUI_VOLUMES src=/docker/runs/telemt-webui/webui_config.toml
/container mounts add dst=/etc/telemt list=TELEMT_WEBUI_VOLUMES src=/docker/runs/telemt
/container mounts add dst=/etc/caddy list=TELEMT_WEBUI_VOLUMES src=/docker/runs/caddy/caddy_setup
/disk settings set auto-media-interface=main-infrastructure-br
/ip smb set domain=HNW interfaces=main-infrastructure-br
/interface bridge port add bridge=docker-infrastructure-br interface=veth-telemt trusted=yes
/interface bridge port add bridge=docker-infrastructure-br interface=veth-gitwatch trusted=yes
/interface bridge port add bridge=docker-infrastructure-br interface=veth-telemt-webui trusted=yes
/interface bridge port add bridge=docker-infrastructure-br interface=veth-caddy trusted=yes
/interface bridge port add bridge=main-infrastructure-br interface=veth-haproxy trusted=yes
/interface bridge settings set use-ip-firewall=yes
/ip firewall connection tracking set enabled=yes udp-timeout=10s
/ip neighbor discovery-settings set discover-interface-list=list-neighbors-lookup
/ip settings set accept-source-route=yes allow-fast-path=no max-neighbor-entries=8192 rp-filter=loose tcp-syncookies=yes
/ipv6 settings set disable-ipv6=yes max-neighbor-entries=8192 soft-max-neighbor-entries=8191
/interface detect-internet set internet-interface-list=list-autodetect-INTERNET lan-interface-list=list-autodetect-LAN wan-interface-list=list-autodetect-WAN
/interface l2tp-server server set authentication=mschap2 default-profile=l2tp-no-encrypt-site2site enabled=yes keepalive-timeout=60 max-mru=1360 max-mtu=1360 max-sessions=1 one-session-per-host=yes
/interface list member add comment=GERMANY interface=wan list=list-untrusted
/interface list member add comment=LAN interface=main-infrastructure-br list=list-trusted
/interface list member add comment="DISCOVERY: allow neighbors lookup" interface=main-infrastructure-br list=list-neighbors-lookup
/interface list member add comment="FW: winbox allowed" interface=main-infrastructure-br list=list-winbox-allowed
/interface list member add comment="FW: winbox allowed" interface=wan list=list-winbox-allowed
/interface list member add comment="FW: drop invalid" interface=wan list=list-drop-invalid-connections
/interface list member add comment="FW: allow router cerfices from LAN" interface=main-infrastructure-br list=list-FW-allow-router-services-LAN
/interface list member add comment="FW: allow router cerfices from WAN" interface=wan list=list-FW-allow-router-services-WAN
/interface list member add comment=OSPF interface=main-infrastructure-br list=list-ospf-master
/interface list member add comment="DISCOVERY: allow neighbors lookup" interface=tunnel-mikrotik list=list-neighbors-lookup
/interface list member add comment="DISCOVERY: allow neighbors lookup" interface=tunnel-anna list=list-neighbors-lookup
/interface list member add comment=OSPF interface=tunnel-mikrotik list=list-ospf-bearing
/interface list member add comment=OSPF interface=tunnel-anna list=list-ospf-bearing
/interface list member add comment=OSPF interface=ospf-lo list=list-ospf-bearing
/interface list member add comment="FW: block incoming DNS requests" interface=wan list=list-FW-prevent-dns-requests-WAN
/interface list member add comment="FW: do port redirect from WAN" interface=wan list=list-FW-allow-port-redirect-WAN
/interface list member add interface=main-infrastructure-br list=list-mangle-loopback-LAN
/interface list member add interface=docker-infrastructure-br list=list-mangle-loopback-LAN
/interface list member add interface=ospf-lo list=list-mangle-loopback-LAN
/interface list member add comment="FW: listen to Portknocking" interface=wan list=list-FW-portknocking
/interface list member add comment="FW: allow router cerfices from LAN" interface=docker-infrastructure-br list=list-FW-allow-router-services-LAN
/interface ovpn-server server add mac-address=FE:65:0F:57:76:B9 name=ovpn-server1
/interface wireguard peers add allowed-address=172.30.30.0/24,10.0.0.5/32 client-allowed-address=::/0 endpoint-port=12000 interface=wg-to-capax name=capax persistent-keepalive=10s preshared-key="6PSob1UuVEIfEnWMGNK5BXd8buISTldvbKy9iIYvEmU=" public-key="rUDu2JBEFFtsgr3uZTGFBvWXTXolY2hYMUQo0/lTiBI="
/ip address add address=192.168.97.1/29 comment="local IP" interface=main-infrastructure-br network=192.168.97.0
/ip address add address=10.255.255.1 comment="router id" interface=ospf-lo network=10.255.255.1
/ip address add address=172.17.0.1/29 comment="docker network" interface=docker-infrastructure-br network=172.17.0.0
/ip address add address=10.0.0.1/28 comment=vpn interface=wg-to-capax network=10.0.0.0
/ip cloud set ddns-enabled=yes ddns-update-interval=10m
/ip dhcp-client add add-default-route=no dhcp-options=clientid,hostname interface=wan name=wan
/ip dhcp-server add add-arp=yes address-pool=pool-dhcp authoritative=after-2sec-delay interface=main-infrastructure-br lease-time=1d name=main-dhcp-server
/ip dhcp-server network add address=10.0.0.0/29 dns-server=8.8.8.8,8.8.4.4 gateway=10.0.0.1
/ip dhcp-server network add address=192.168.97.0/29 gateway=192.168.97.1
/ip dns set allow-remote-requests=yes cache-max-ttl=1d max-concurrent-queries=200 max-concurrent-tcp-sessions=30 query-server-timeout=3s
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
/ip dns static add address=172.17.0.4 match-subdomain=yes name=internal.chr.home type=A
/ip dns static add address=192.168.97.4 match-subdomain=yes name=haproxy.chr.home type=A
/ip dns static add address=172.17.0.3 match-subdomain=yes name=webui.chr.home type=A
/ip dns static add address=172.17.0.2 match-subdomain=yes name=telemt.chr.home type=A
/ip dns static add address=172.17.0.4 match-subdomain=yes name=caddy.chr.home type=A
/ip dns static add cname=chr.home name=chr type=CNAME
/ip dns static add address=192.168.90.10 name=capxl.home type=A
/ip dns static add cname=capxl.home name=capxl type=CNAME
/ip dns static add address=192.168.90.85 name=MbpAlxm.home type=A
/ip dns static add cname=MbpAlxm.home name=MbpAlxm type=CNAME
/ip dns static add cname=victoria.home name=victoria type=CNAME
/ip dns static add address=192.168.90.1 name=victoria.home type=A
/ip dns static add address=185.13.148.14 name=ftpserver.org type=A
/ip firewall address-list add address=192.168.97.0/24 list=alist-fw-local-subnets
/ip firewall address-list add address=192.168.97.0/24 list=alist-nat-local-subnets
/ip firewall address-list add address=0.0.0.0/8 comment="RFC 1122 \"This host on this network\"" disabled=yes list=alist-fw-rfc-special
/ip firewall address-list add address=10.0.0.0/8 comment="RFC 1918 (Private Use IP Space)" disabled=yes list=alist-fw-rfc-special
/ip firewall address-list add address=100.64.0.0/10 comment="RFC 6598 (Shared Address Space)" list=alist-fw-rfc-special
/ip firewall address-list add address=127.0.0.0/8 comment="RFC 1122 (Loopback)" disabled=yes list=alist-fw-rfc-special
/ip firewall address-list add address=169.254.0.0/16 comment="RFC 3927 (Dynamic Configuration of IPv4 Link-Local Addresses)" list=alist-fw-rfc-special
/ip firewall address-list add address=172.16.0.0/12 comment="RFC 1918 (Private Use IP Space)" disabled=yes list=alist-fw-rfc-special
/ip firewall address-list add address=192.0.0.0/24 comment="RFC 6890 (IETF Protocol Assingments)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.0.2.0/24 comment="RFC 5737 (Test-Net-1)" list=alist-fw-rfc-special
/ip firewall address-list add address=192.168.0.0/16 comment="RFC 1918 (Private Use IP Space)" disabled=yes list=alist-fw-rfc-special
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
/ip firewall address-list add address=lostfilm.tv list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=nnmclub.to list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=radarr.video list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=themoviedb.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=tmdb.org list=alist-mangle-vpn-tunneled-sites
/ip firewall address-list add address=192.168.99.0/24 comment="Add DNS Server to this List" list=alist-fw-dns-allow
/ip firewall address-list add address=haproxy.chr.home comment="Do not masquarade HAProxy" list=alist-nat-preserve-wan-ip
/ip firewall address-list add address=185.13.148.14 list=alist-nat-external-ip
/ip firewall filter add action=accept chain=input comment="CADDY INP" log-prefix="~~CADDY INP" port=443,4430,1443 protocol=tcp
/ip firewall filter add action=accept chain=forward comment="CADDY FWD" log-prefix="~~CADDY FWD" port=443,4430,1443 protocol=tcp
/ip firewall filter add action=accept chain=output comment="CADDY OUT" log-prefix="~CADDY OUT" port=443,4430,1443 protocol=tcp
/ip firewall filter add action=accept chain=input comment="WG roadwarrior" dst-port=65114 protocol=udp
/ip firewall filter add action=accept chain=output comment="Telemt proxy Accept" port=443 protocol=tcp
/ip firewall filter add action=accept chain=output log=yes log-prefix=SYSLOG port=514 protocol=udp
/ip firewall filter add action=log chain=input protocol=ipsec-esp
/ip firewall filter add action=log chain=forward dst-port=22,5022 log=yes log-prefix=--SSH-5022 protocol=tcp src-port=""
/ip firewall filter add action=accept chain=input comment="Allow NTP server" connection-state="" log=yes log-prefix=~~NTP port=123 protocol=udp
/ip firewall filter add action=accept chain=output comment="Allow NTP server" connection-state="" log=yes log-prefix=~~NTP port=123 protocol=udp
/ip firewall filter add action=accept chain=input comment=WINBOX port=8291 protocol=tcp
/ip firewall filter add action=drop chain=input comment="Drop Invalid Connections (HIGH PRIORIRY RULE)" connection-state=invalid in-interface-list=list-drop-invalid-connections
/ip firewall filter add action=drop chain=forward comment="Drop Invalid Connections (HIGH PRIORIRY RULE)" connection-state=invalid dst-address-list=!alist-fw-vpn-subnets
/ip firewall filter add action=jump chain=input comment="Jump to KNOCK Chain" dst-port=30004,30005,30006 jump-target=chain-knock-staged-control protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-knock address-list-timeout=2s chain=input comment=Knock dst-port=30004 in-interface-list=list-FW-portknocking protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-knockAgain address-list-timeout=2s chain=input comment=Knock-Knock dst-port=30005 in-interface-list=list-FW-portknocking protocol=tcp src-address-list=alist-fw-knock
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-knockSuccess address-list-timeout=3m chain=input comment=Knock-Knock-Knock dst-port=3006 in-interface-list=list-FW-portknocking protocol=tcp src-address-list=alist-fw-knockAgain
/ip firewall filter add action=return chain=chain-knock-staged-control comment="Return From KNOCK Chain"
/ip firewall filter add action=accept chain=forward comment="Accept Related or Established Connections (HIGH PRIORIRY RULE)" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=accept chain=input comment="OSFP neighbour-ing allow" log-prefix=~~~OSFP protocol=ospf
/ip firewall filter add action=accept chain=input comment="Allow mikrotik self-discovery" dst-address-type=broadcast dst-port=5678 protocol=udp
/ip firewall filter add action=accept chain=forward comment="Allow mikrotik neighbor-discovery" dst-address-type=broadcast dst-port=5678 protocol=udp
/ip firewall filter add action=jump chain=input comment="VPN Access" jump-target=chain-vpn-rules
/ip firewall filter add action=accept chain=chain-vpn-rules comment="L2TP tunnel" dst-port=1701 protocol=udp
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IPSec-ah\"" protocol=ipsec-ah src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IPSec-esp\"" protocol=ipsec-esp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow IKE\" - IPSEC connection establishing" dst-port=500 log=yes log-prefix=~~~VPN_FRW protocol=udp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=accept chain=chain-vpn-rules comment="VPN \"Allow UDP\" - IPSEC data trasfer" dst-port=4500 log=yes log-prefix=~~~VPN_FRW protocol=udp src-address-list=alist-fw-vpn-server-addr
/ip firewall filter add action=return chain=chain-vpn-rules comment="VPN Access"
/ip firewall filter add action=accept chain=forward comment=VPN dst-address-list=alist-fw-vpn-subnets log-prefix=~~~VPN_FRW src-address-list=alist-fw-local-subnets
/ip firewall filter add action=accept chain=forward comment=VPN dst-address-list=alist-fw-local-subnets log-prefix=~~~VPN_FRW src-address-list=alist-fw-vpn-subnets
/ip firewall filter add action=jump chain=forward comment="Jump to chain-rdp-staged-control" jump-target=chain-rdp-staged-control
/ip firewall filter add action=drop chain=chain-rdp-staged-control comment="drop rdp brute forcers" dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-block
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-block address-list-timeout=10h chain=chain-rdp-staged-control connection-state=new dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage3 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage2 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new dst-port=3389 protocol=tcp src-address-list=alist-fw-rdp-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-rdp-stage1 address-list-timeout=1m chain=chain-rdp-staged-control connection-state=new dst-port=3389 protocol=tcp src-address-list=!alist-fw-rdp-allow
/ip firewall filter add action=return chain=chain-rdp-staged-control comment="Return From chain-rdp-staged-control"
/ip firewall filter add action=jump chain=forward comment="jump to chain-smb-staged-control" jump-target=chain-smb-staged-control src-address-list=!alist-fw-smb-allow
/ip firewall filter add action=add-src-to-address-list address-list=alist-smb-shares-track address-list-timeout=10h chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=~~~SMB protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list=alist-smb-shares-track address-list-timeout=10h chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=~~~SMB protocol=tcp
/ip firewall filter add action=drop chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=~~~SMB protocol=tcp src-address-list=alist-smb-shares-track
/ip firewall filter add action=drop chain=chain-smb-staged-control comment="TCP/UDP ports necessary for SMB DROP" dst-port=137-139,445 log-prefix=~~~SMB protocol=udp src-address-list=alist-smb-shares-track
/ip firewall filter add action=return chain=chain-smb-staged-control comment="Return from chain-smb-staged-control"
/ip firewall filter add action=drop chain=input comment="drop ftp brute forcers" dst-port=21 protocol=tcp src-address-list=alist-fw-ftp-block
/ip firewall filter add action=accept chain=output comment="drop ftp brute forcers" content="530 Login incorrect" dst-limit=1/1m,9,dst-address/1m protocol=tcp
/ip firewall filter add action=add-dst-to-address-list address-list=alist-fw-ftp-block address-list-timeout=3h chain=output comment="drop ftp brute forcers" content="530 Login incorrect" protocol=tcp
/ip firewall filter add action=jump chain=input comment="Jump to DNS Amplification" jump-target=chain-dns-amp-attack
/ip firewall filter add action=accept chain=chain-dns-amp-attack comment="Make exceptions for DNS" port=53 protocol=udp src-address-list=alist-fw-dns-allow
/ip firewall filter add action=drop chain=chain-dns-amp-attack comment="Drop incoming for DNS" in-interface-list=list-FW-prevent-dns-requests-WAN port=53 protocol=udp
/ip firewall filter add action=accept chain=chain-dns-amp-attack comment="Make exceptions for DNS" dst-address-list=alist-fw-dns-allow log-prefix=~~~DNS port=53 protocol=udp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-dns-amp-block address-list-timeout=10h chain=chain-dns-amp-attack comment="Add DNS Amplification to Blacklist" port=53 protocol=udp src-address-list=!alist-fw-dns-allow
/ip firewall filter add action=drop chain=chain-dns-amp-attack comment="Drop DNS Amplification" src-address-list=alist-fw-dns-amp-block
/ip firewall filter add action=return chain=chain-dns-amp-attack comment="Return from DNS Amplification"
/ip firewall filter add action=accept chain=input comment="Self fetch requests" log-prefix=WEB port=80 protocol=tcp
/ip firewall filter add action=jump chain=input comment="Allow router services on the lan" in-interface-list=list-FW-allow-router-services-LAN jump-target=chain-router-services-lan
/ip firewall filter add action=accept chain=chain-router-services-lan comment="Winbox (8291/TCP)" dst-port=8291 protocol=tcp
/ip firewall filter add action=accept chain=chain-router-services-lan comment=SNMP port=161 protocol=udp
/ip firewall filter add action=accept chain=chain-router-services-lan comment="WEB, SCEP" port=80,8888 protocol=tcp
/ip firewall filter add action=return chain=chain-router-services-lan comment="Return from chain-router-services-lan Chain"
/ip firewall filter add action=jump chain=input comment="Allow router services on the wan" in-interface-list=list-FW-allow-router-services-WAN jump-target=chain-router-services-wan
/ip firewall filter add action=return chain=chain-router-services-wan comment="Return from chain-router-services-wan Chain"
/ip firewall filter add action=jump chain=input comment="Check for ping flooding" jump-target=chain-detect-ping-flood protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="0:0 and limit for 5 pac/s Allow Ping" icmp-options=0:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="3:3 and limit for 5 pac/s Allow Traceroute" icmp-options=3:3 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="3:4 and limit for 5 pac/s Allow Path MTU Discovery" icmp-options=3:4 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="8:0 and limit for 5 pac/s Allow Ping" icmp-options=8:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="11:0 and limit for 5 pac/s Allow Traceroute" icmp-options=11:0-255 limit=5,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="0:0 and limit for 50 pac/s Allow Ping tool speed-test" icmp-options=0:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="8:0 and limit for 50 pac/s Allow Ping tool speed-test" icmp-options=8:0-255 limit=50,5:packet protocol=icmp
/ip firewall filter add action=accept chain=chain-detect-ping-flood comment="drop everything else" log-prefix="#ICMP DROP" protocol=icmp
/ip firewall filter add action=return chain=chain-detect-ping-flood comment="Return from chain-detect-ping-flood Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY1 log-prefix=~~~DUMMY1 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Manually Added)" src-address-list=alist-fw-manual-block
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Manually Added)" src-address-list=alist-fw-manual-block
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (SSH)" src-address-list=alist-fw-ssh-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (SSH)" src-address-list=alist-fw-ssh-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Telnet)" src-address-list=alist-fw-telnet-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Telnet)" src-address-list=alist-fw-telnet-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the Black List (Winbox)" src-address-list=alist-fw-winbox-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the Black List (Winbox)" src-address-list=alist-fw-winbox-ban
/ip firewall filter add action=drop chain=input comment="Drop anyone in the WAN Port Scanner List" src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=drop chain=forward comment="Drop anyone in the WAN Port Scanner List" src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=passthrough chain=input comment="Drop anyone in the LAN Port Scanner List" src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=passthrough chain=forward comment="Drop anyone in the LAN Port Scanner List" src-address-list=alist-fw-port-scanner-ban
/ip firewall filter add action=drop chain=input comment="Drop all Bogons" log=yes log-prefix="#DROP BOGONS (INPUT)" src-address-list=alist-fw-rfc-special
/ip firewall filter add action=drop chain=forward comment="Drop all Bogons" log=yes log-prefix="#DROP BOGONS (FWD)" src-address-list=alist-fw-rfc-special
/ip firewall filter add action=passthrough chain=forward comment=DUMMY2 log-prefix=~~~DUMMY2 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC SSH Chain" dst-port=22,5022,2223 jump-target=chain-ssh-staged-control protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-ban address-list-timeout=1w3d chain=chain-ssh-staged-control comment="Transfer repeated attempts from SSH Stage 3 to Black-List" connection-state=new protocol=tcp src-address-list=alist-fw-ssh-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage3 address-list-timeout=3m chain=chain-ssh-staged-control comment="Add succesive attempts to SSH Stage 3" connection-state=new protocol=tcp src-address-list=alist-fw-ssh-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage2 address-list-timeout=40s chain=chain-ssh-staged-control comment="Add succesive attempts to SSH Stage 2" connection-state=new protocol=tcp src-address-list=alist-fw-ssh-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-ssh-stage1 address-list-timeout=5s chain=chain-ssh-staged-control comment="Add intial attempt to SSH Stage 1 List" connection-state=new protocol=tcp src-address-list=!alist-fw-knockknock
/ip firewall filter add action=return chain=chain-ssh-staged-control comment="Return From RFC SSH Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY3 log-prefix=~~~DUMMY3 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Telnet Chain" jump-target=chain-telnet-staged-control
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-ban address-list-timeout=1w3d chain=chain-telnet-staged-control comment="Transfer repeated attempts from Telnet Stage 3 to Black-List" connection-state=new dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage3 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add succesive attempts to Telnet Stage 3" connection-state=new dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage2 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add succesive attempts to Telnet Stage 2" connection-state=new dst-port=23 protocol=tcp src-address-list=alist-fw-telnet-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-telnet-stage1 address-list-timeout=1m chain=chain-telnet-staged-control comment="Add Intial attempt to Telnet Stage 1" connection-state=new dst-port=23 protocol=tcp
/ip firewall filter add action=return chain=chain-telnet-staged-control comment="Return From RFC Telnet Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY4 log-prefix=~~~DUMMY4 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to RFC Winbox Chain" jump-target=chain-winbox-staged-control
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-ban address-list-timeout=1w3d chain=chain-winbox-staged-control comment="Transfer repeated attempts from Winbox Stage 3 to Black-List" connection-state=new dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage3
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage3 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add succesive attempts to Winbox Stage 3" connection-state=new dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage2
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage2 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add succesive attempts to Winbox Stage 2" connection-state=new dst-port=8291 protocol=tcp src-address-list=alist-fw-winbox-stage1
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-winbox-stage1 address-list-timeout=1m chain=chain-winbox-staged-control comment="Add Intial attempt to Winbox Stage 1" connection-state=new dst-port=8291 protocol=tcp src-address-list=!alist-fw-vpn-subnets
/ip firewall filter add action=return chain=chain-winbox-staged-control comment="Return From RFC Winbox Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY5 log-prefix=~~~DUMMY5 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-port-scanner-ban address-list-timeout=10h chain=input comment="Add TCP Port Scanners to Address List" protocol=tcp psd=40,3s,2,1 src-address-list=!alist-fw-port-scanner-allow
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-port-scanner-ban address-list-timeout=10h chain=forward comment="Add TCP Port Scanners to Address List" protocol=tcp psd=40,3s,2,1 src-address-list=!alist-fw-port-scanner-allow
/ip firewall filter add action=passthrough chain=forward comment=DUMMY6 log-prefix=~~~DUMMY6 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-highload address-list-timeout=1h chain=input comment=alist-fw-highload connection-limit=100,32 protocol=tcp
/ip firewall filter add action=add-src-to-address-list address-list=alist-fw-highload address-list-timeout=10h chain=forward comment=alist-fw-highload connection-limit=100,32 protocol=tcp
/ip firewall filter add action=jump chain=input comment="Jump to Virus Chain" jump-target=chain-worms-detector
/ip firewall filter add action=drop chain=chain-worms-detector comment=Conficker dst-port=593 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm dst-port=1024-1030 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="ndm requester" dst-port=1363 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="ndm server" dst-port=1364 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="screen cast" dst-port=1368 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=hromgrafx dst-port=1373 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom" dst-port=1080 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=cichlid dst-port=1377 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm dst-port=1433-1434 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dumaru.Y" dst-port=2283 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle" dst-port=2535 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle.C-K" dst-port=2745 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom" dst-port=3127-3128 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Backdoor OptixPro" dst-port=3410 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Sasser" dst-port=5554 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm dst-port=4444 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment=Worm dst-port=4444 protocol=udp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Beagle.B" dst-port=8866 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dabber.A-B" dst-port=9898 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Dumaru.Y" dst-port=10000 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop MyDoom.B" dst-port=10080 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop NetBus" dst-port=12345 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop Kuang2" dst-port=17300 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop SubSeven" dst-port=27374 protocol=tcp
/ip firewall filter add action=drop chain=chain-worms-detector comment="Drop PhatBot, Agobot, Gaobot" dst-port=65506 protocol=tcp
/ip firewall filter add action=return chain=chain-worms-detector comment="Return From Virus Chain"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY7 log-prefix=~~~DUMMY7 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=jump chain=input comment="Jump to \"Manage Common Ports\" Chain" jump-target=chain-self-common-ports
/ip firewall filter add action=accept chain=chain-self-common-ports comment="\"All hosts on this subnet\" Broadcast" src-address=224.0.0.1
/ip firewall filter add action=accept chain=chain-self-common-ports comment="\"All routers on this subnet\" Broadcast" src-address=224.0.0.2
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DVMRP (Distance Vector Multicast Routing Protocol)" src-address=224.0.0.4
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OSPF - All OSPF Routers Broadcast" src-address=224.0.0.5
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OSPF - OSPF DR Routers Broadcast" src-address=224.0.0.6
/ip firewall filter add action=accept chain=chain-self-common-ports comment="RIP Broadcast" src-address=224.0.0.9
/ip firewall filter add action=accept chain=chain-self-common-ports comment="EIGRP Broadcast" src-address=224.0.0.10
/ip firewall filter add action=accept chain=chain-self-common-ports comment="PIM Broadcast" src-address=224.0.0.13
/ip firewall filter add action=accept chain=chain-self-common-ports comment="VRRP Broadcast" src-address=224.0.0.18
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" src-address=224.0.0.19
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" src-address=224.0.0.20
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IS-IS Broadcast" src-address=224.0.0.21
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IGMP Broadcast" src-address=224.0.0.22
/ip firewall filter add action=accept chain=chain-self-common-ports comment="GRE Protocol (Local Management)" protocol=gre
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPdata transfer" log-prefix=~~~FTP port=20 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPcontrol (command)" log-prefix=~~~FTP port=21 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPdata transfer  " log-prefix=~~~FTP port=20 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Secure Shell(SSH)" port=22,2223 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Secure Shell(SSH)   " port=22,2223 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment=Telnet port=23 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment=Telnet port=23 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Priv-mail: any privatemailsystem." port=24 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Priv-mail: any privatemailsystem.  " port=24 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Mail Transfer Protocol(SMTP)" port=25 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Mail Transfer Protocol(SMTP)  " port=25 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TIME protocol" port=37 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TIME protocol  " port=37 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="ARPA Host Name Server Protocol & WINS" port=42 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="ARPA Host Name Server Protocol  & WINS  " port=42 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WHOIS protocol" port=43 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WHOIS protocol" port=43 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Domain Name System (DNS)" port=53 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Domain Name System (DNS)" port=53 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Mail Transfer Protocol(RFC 780)" port=57 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="(BOOTP) Server & (DHCP)  " port=67 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="(BOOTP) Client & (DHCP)  " port=68 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Trivial File Transfer Protocol (TFTP)  " port=69 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Gopher protocol" port=70 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Finger protocol" port=79 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Webfig, SCEP" log=yes port=80,8888 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="RemoteTELNETService protocol" port=107 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocolv2 (POP2)" port=109 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocolv3 (POP3)" port=110 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="IdentAuthentication Service/Identification Protocol" port=113 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Authentication Service (auth)  " port=113 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple File Transfer Protocol (SFTP)" port=115 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Network Time Protocol(NTP)" port=123 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Name Service" port=137 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Name Service  " port=137 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Datagram Service" port=138 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Datagram Service  " port=138 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Session Service" port=139 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="NetBIOSNetBIOS Session Service  " port=139 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP)" port=143 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Background File Transfer Program (BFTP)" port=152 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Background File Transfer Program (BFTP)  " port=152 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SGMP,Simple Gateway Monitoring Protocol" port=153 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SGMP,Simple Gateway Monitoring Protocol  " port=153 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DMSP, Distributed Mail Service Protocol" port=158 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="DMSP, Distributed Mail Service Protocol  " port=158 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management Protocol(SNMP)  " port=161 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management ProtocolTrap (SNMPTRAP)" port=162 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Simple Network Management ProtocolTrap (SNMPTRAP)  " port=162 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGP (Border Gateway Protocol)" port=179 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP), version 3" port=220 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol (IMAP), version 3" port=220 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGMP, Border Gateway Multicast Protocol" port=264 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="BGMP, Border Gateway Multicast Protocol  " port=264 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Lightweight Directory Access Protocol (LDAP)" port=389 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Lightweight Directory Access Protocol (LDAP)" port=389 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="SSTP TCP Port 443 (Local Management) & HTTPS" port=443 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Microsoft-DSActive Directory, Windows shares" port=445 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP/ IPSEC UDP Port 500 (Local Management)" port=500 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Modbus, Protocol" port=502 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Modbus, Protocol  " port=502 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Shell (Remote Shell, rsh, remsh)" port=514 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Syslog - used for system logging  " port=514 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Routing Information Protocol (RIP)  " port=520 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="e-mail message submission (SMTP)" port=587 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="LDP,Label Distribution Protocol" port=646 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="LDP,Label Distribution Protocol" port=646 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (data):FTP over TLS/SSL" port=989 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (data):FTP over TLS/SSL" port=989 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (control):FTP over TLS/SSL" port=990 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="FTPS Protocol (control):FTP over TLS/SSL" port=990 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TELNET protocol overTLS/SSL" port=992 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="TELNET protocol overTLS/SSL" port=992 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Internet Message Access Protocol over TLS/SSL (IMAPS)" port=993 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="Post Office Protocol3 over TLS/SSL (POP3S)" port=995 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="OVPN TCP Port 1194 (Local Management)" port=1194 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="PPTP Port 1723 (Local Management)" port=1723 protocol=tcp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP UDP Port 1701 (Local Management)" port=1701 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="L2TP UDP Port 4500 (Local Management)" port=4500 protocol=udp
/ip firewall filter add action=accept chain=chain-self-common-ports comment="WINBOX TCP Port 8291 (Local Management)" port=8291 protocol=tcp
/ip firewall filter add action=accept chain=input comment="TCP/UDP ports necessary for SMB" dst-port=137-138 log-prefix=~~~SMB protocol=udp src-address-list=alist-fw-smb-allow
/ip firewall filter add action=accept chain=input comment="TCP/UDP ports necessary for SMB" dst-port=137,139 log-prefix=~~~SMB protocol=tcp src-address-list=alist-fw-smb-allow
/ip firewall filter add action=accept chain=input comment="Accept Related or Established Connections" connection-state=established,related log-prefix="#ACCEPTED UNKNOWN (INPUT)"
/ip firewall filter add action=accept chain=forward comment="Accept New Connections" connection-state=new log-prefix="#ACCEPTED UNKNOWN (FWD)"
/ip firewall filter add action=passthrough chain=forward comment=DUMMY8 log-prefix=~~~DUMMY8 src-address-list=alist-fw-empty-dummy
/ip firewall filter add action=drop chain=forward comment="WAN static-routes intruders not DSTNATed drop" connection-nat-state=dstnat connection-state=new in-interface=wan log=yes log-prefix="#DROP UNKNOWN (FWD/no DSTN)"
/ip firewall filter add action=drop chain=forward comment="Drop all other LAN Traffic" log=yes log-prefix="#DROP UNKNOWN (FWD)"
/ip firewall filter add action=drop chain=input comment="Drop all other WAN Traffic" log=yes log-prefix="#DROP UNKNOWN (INPUT)"
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" in-interface=all-ppp new-mss=1390 protocol=tcp tcp-flags=syn tcp-mss=1391-65535
/ip firewall mangle add action=change-mss chain=forward comment="fix MSS for l2tp/ipsec" new-mss=1390 out-interface=all-ppp protocol=tcp tcp-flags=syn tcp-mss=1391-65535
/ip firewall mangle add action=change-mss chain=output comment="fix MSS for l2tp/ipsec (self)" new-mss=1390 protocol=tcp src-address-list=alist-fw-vpn-subnets tcp-flags=syn tcp-mss=1391-65535
/ip firewall mangle add action=jump chain=prerouting comment=loopback-detect-chain-set-cmark connection-mark=no-mark disabled=yes in-interface-list=list-mangle-loopback-LAN jump-target=loopback-detect-chain-set-cmark
/ip firewall mangle add action=mark-connection chain=loopback-detect-chain-set-cmark comment=loopback-detect-chain-set-cmark-UTF dst-address-list=alist-nat-external-ip new-connection-mark=cmark-loopback-connection-UTF
/ip firewall mangle add action=return chain=loopback-detect-chain-set-cmark comment=loopback-chain-set-cmark
/ip firewall mangle add action=jump chain=prerouting comment=loopback-detect-chain-set-pmark in-interface-list=list-mangle-loopback-LAN jump-target=loopback-detect-chain-set-pmark packet-mark=!pmark-nat-loopback
/ip firewall mangle add action=mark-packet chain=loopback-detect-chain-set-pmark comment=loopback-detect-chain-set-pmark-UTF connection-mark=cmark-loopback-connection-UTF new-packet-mark=pmark-nat-loopback
/ip firewall mangle add action=return chain=loopback-detect-chain-set-pmark comment=loopback-detect-chain-set-pmark
/ip firewall mangle add action=mark-connection chain=input comment="Mark IPsec" ipsec-policy=in,ipsec new-connection-mark=ipsec
/ip firewall mangle add action=mark-connection chain=output comment="Mark IPsec" ipsec-policy=out,ipsec new-connection-mark=ipsec
/ip firewall mangle add action=mark-routing chain=prerouting comment="VPN Sites" dst-address-list=alist-mangle-vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-routing chain=output comment="VPN Sites (self)" dst-address-list=alist-mangle-vpn-tunneled-sites log-prefix="#VPN ROUTE MARK" new-routing-mark=rmark-vpn-redirect passthrough=no
/ip firewall mangle add action=mark-packet chain=input comment="VPN Traffic" log-prefix="#VPN PCKT MARK" new-packet-mark="IPSEC PCKT" protocol=ipsec-esp
/ip firewall mangle add action=mark-connection chain=forward comment="Mark IPsec" ipsec-policy=out,ipsec new-connection-mark=ipsec
/ip firewall mangle add action=mark-connection chain=forward comment="Mark IPsec" ipsec-policy=in,ipsec new-connection-mark=ipsec
/ip firewall nat add action=masquerade chain=srcnat comment="fix the ntp client by changing its source port 123 with something higher (mikrotik forum 794718)" disabled=yes protocol=udp src-port=123 to-ports=12400-12440
/ip firewall nat add action=masquerade chain=srcnat comment="NAT Loopback replace address" disabled=yes packet-mark=pmark-nat-loopback
/ip firewall nat add action=masquerade chain=srcnat comment="CAPAX - VPN masq (WG)" in-interface=wg-to-capax
/ip firewall nat add action=masquerade chain=srcnat comment="masq docker" src-address=172.17.0.0/29
/ip firewall nat add action=dst-nat chain=dstnat comment="caddy 80,1443,8000,4430" disabled=yes dst-address-list=alist-nat-external-ip dst-port=80,1443,8000,4430 log=yes protocol=tcp to-addresses=172.17.0.4
/ip firewall nat add action=jump chain=dstnat comment=port-rdr-docker-chain jump-target=port-rdr-docker-chain protocol=tcp
/ip firewall nat add action=jump chain=output comment="port-rdr-docker-chain (self)" jump-target=port-rdr-docker-chain protocol=tcp
/ip firewall nat add action=dst-nat chain=port-rdr-docker-chain comment=port-rdr-docker-chain-haproxy-443 dst-address-list=alist-nat-external-ip dst-port=443 log=yes protocol=tcp to-addresses=192.168.97.4 to-ports=443
/ip firewall nat add action=dst-nat chain=port-rdr-docker-chain comment="port-rdr-docker-chain-caddy 8000,4430 (tcp)" dst-address-list=alist-nat-external-ip dst-port=8000,4430 log=yes protocol=tcp to-addresses=172.17.0.4
/ip firewall nat add action=dst-nat chain=port-rdr-docker-chain comment="port-rdr-docker-chain-caddy 80,1443 (tcp)" dst-address-list=alist-nat-external-ip dst-port=80,1443 log=yes protocol=tcp to-addresses=172.17.0.4
/ip firewall nat add action=dst-nat chain=port-rdr-docker-chain comment="port-rdr-docker-chain-caddy 80,1443,8000,4430 (udp)" disabled=yes dst-port=80,1443,8000,4430 log=yes protocol=udp to-addresses=172.17.0.4
/ip firewall nat add action=dst-nat chain=port-rdr-docker-chain comment="port-rdr-docker-chain-telemt (metrics)" dst-port=9090 protocol=tcp to-addresses=172.17.0.2 to-ports=9090
/ip firewall nat add action=dst-nat chain=port-rdr-docker-chain comment="port-rdr-docker-chain-telemt (web ui) 8088" dst-port=8088 protocol=tcp to-addresses=172.17.0.3 to-ports=8088
/ip firewall nat add action=return chain=port-rdr-docker-chain comment=port-rdr-docker-chain
/ip firewall nat add action=accept chain=srcnat comment="accept tunnel traffic" dst-address-list=alist-fw-vpn-subnets log-prefix=#VPN src-address-list=alist-nat-local-subnets
/ip firewall nat add action=accept chain=dstnat comment="accept tunnel traffic" dst-address-list=alist-nat-local-subnets log-prefix=#VPN src-address-list=alist-fw-vpn-subnets
/ip firewall nat add action=masquerade chain=srcnat comment="ANNA - VPN masq (pure L2TP, w/o IPSEC)" out-interface=tunnel-anna
/ip firewall nat
# tunnel-mikrotik not ready
add action=masquerade chain=srcnat comment="MIK - VPN masq (pure L2TP, w/o IPSEC)" out-interface=tunnel-mikrotik
/ip firewall nat add action=masquerade chain=srcnat comment="all WAN allowed" dst-address-list=alist-nat-preserve-wan-ip
/ip firewall service-port set ftp disabled=yes
/ip firewall service-port set tftp disabled=yes
/ip firewall service-port set h323 disabled=yes
/ip firewall service-port set sip disabled=yes
/ip firewall service-port set pptp disabled=yes
/ip ipsec profile set [ find default=yes ] dh-group=modp1024 dpd-interval=2m dpd-maximum-failures=5
/ip kid-control add fri=0s-1d mon=0s-1d name=totals sat=0s-1d sun=0s-1d thu=0s-1d tue=0s-1d wed=0s-1d
/ip route add check-gateway=ping comment=GLOBAL disabled=no distance=10 dst-address=0.0.0.0/0 gateway=185.13.148.1 routing-table=main scope=30 target-scope=10
/ip route add blackhole comment=OSPF-LOCAL-AREA-blackhole disabled=no distance=200 dst-address=192.168.90.0/24 gateway=tunnel-anna routing-table=main scope=30 target-scope=10
/ip route add blackhole comment=OSPF-LOCAL-AREA-blackhole disabled=no distance=200 dst-address=192.168.98.0/24 gateway=tunnel-anna routing-table=main scope=30 target-scope=10
/ip service set ftp disabled=yes
/ip service set telnet disabled=yes
/ip service set ssh port=2223
/ip service set reverse-proxy certificate=chr.webserver@CHR port=4443 tls-version=only-1.2
/ip service set www-ssl certificate=chr.webserver@CHR disabled=no port=5443
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes tls-version=only-1.2
/ip service set www port=8888
/ip ssh set ciphers=aes-gcm,aes-ctr,aes-cbc,3des-cbc,null forwarding-enabled=remote password-authentication=yes
/ip tftp add disabled=yes real-filename=NAS/ req-filename=.*
/ip traffic-flow set cache-entries=64k interfaces=wan
/ip upnp set show-dummy-rule=no
/ip upnp interfaces add disabled=yes interface=wan type=external
/ip upnp interfaces add disabled=yes interface=main-infrastructure-br type=internal
/ipv6 nd set [ find default=yes ] advertise-dns=yes
/ppp secret add local-address=10.0.0.1 name=vpn-remote-mic password=123 profile=l2tp-no-encrypt-site2site remote-address=10.0.0.2 service=l2tp
/ppp secret add local-address=10.0.0.1 name=vpn-remote-anna password=123 profile=l2tp-no-encrypt-site2site remote-address=10.0.0.3 service=l2tp
/ppp secret add disabled=yes local-address=10.0.0.1 name=vpn-user-alx profile=l2tp-no-encrypt-site2site remote-address=10.0.0.4 service=l2tp
/ppp secret add local-address=10.0.0.1 name=vpn-remote-self password=123 profile=l2tp-no-encrypt-site2site remote-address=10.0.0.5 service=l2tp
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_TOKEN password=8954042546:AAHg_MJ7sK4sUFKSvcQ1YsGAnep_UYnuBO0 profile=null service=async
/ppp secret add comment="used by \$SECRET" name=TELEGRAM_CHAT_ID password=-1001798127067 profile=null service=async
/ppp secret add comment="used by \$SECRET" name=BACKUP_PASSWORD password=RHWbJxAje profile=null service=async
/routing filter rule add chain=ospf-in comment="drop DEFAULT ROUTE" disabled=no rule="if ( protocol ospf && dst-len==0 ) { set comment DISCARDED-GLOBAL ; set pref-src 10.0.0.1 ; reject; }"
/routing filter rule add chain=ospf-in comment="accept inter area routes" disabled=no rule="if ( protocol ospf && ospf-type inter ) { set comment OSPF-LOCAL-AREA ;  accept; }"
/routing filter rule add chain=ospf-in comment="discard intra area routes" disabled=no rule="if ( protocol ospf && ospf-type intra) { set comment DISCARDED-INTRA-AREA ; reject; }"
/routing filter rule add chain=ospf-in comment="mark other OSPF" disabled=no rule="if ( protocol ospf) { set comment PENDING; }"
/routing filter rule add chain=ospf-in comment="drop others PROTO" disabled=no rule="set comment UNKNOWN; reject;"
/routing filter rule add chain=ospf-out-filter-reject-all comment="drop ANY outgoing" disabled=yes rule="set comment UNKNOWN; reject;"
/routing ospf interface-template add area=chr-space-main auth-id=1 auth-key="" disabled=no interfaces=main-infrastructure-br networks=192.168.97.0/29 passive priority=100
/routing ospf interface-template add area=backbone comment="ANNA routes" cost=200 disabled=no interfaces=tunnel-anna type=ptp
/routing ospf interface-template add area=backbone comment="MIKROTIK routes" cost=300 disabled=yes interfaces=tunnel-mikrotik type=ptp
/snmp set contact=defm.kopcap@gmail.com enabled=yes location=RU trap-generators=interfaces trap-interfaces=main-infrastructure-br trap-version=2
/system clock set time-zone-name=Europe/Berlin
/system logging set 0 action=OnScreenLog topics=info,!ipsec,!script,!dns,!debug
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
/system logging add action=DNSOnScreenLog topics=dns,!packet
/system logging add action=OSPFOnscreenLog topics=ospf,!raw
/system logging add action=OnScreenLog topics=event
/system logging add action=L2TPOnScreenLog topics=l2tp
/system logging add action=AuthDiskLog topics=account
/system logging add action=CertificatesOnScreenLog topics=certificate,!debug
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
/system logging add action=REBOOTDoskLog regex="^.*reboot.*\$" topics=!dhcp
/system logging add action=PKGInstallationLog regex="^.*package.*\$"
/system logging add action=DockerOnscreenLog topics=container,!debug
/system logging add action=VictoriaRemoteLog disabled=yes topics=firewall
/system logging add action=VictoriaRemoteLog topics=!packet,!debug,!raw,!dns,!firewall,!ssh
/system logging add action=REBOOTDoskLog regex="^.*supout.*\$"
/system logging add action=AuthDiskLog regex="^.*login.*\$"
/system note set note="Ipsec:         okay \
    \nRoute:     185.13.148.1 \
    \nVersion:         7.23.1 \
    \nUptime:        1w3d23:15:20  \
    \nTime:        2026-06-24 21:10:12  \
    \nPing:    0 ms  \
    \nChr:        185.13.148.14  \
    \nMik:        178.65.91.156  \
    \nAnna:        46.39.51.221  \
    \nClock:        synchronized  \
    \n * routeros  \
    \n * container  \
    \n" show-at-cli-login=yes
/system ntp client set enabled=yes
/system ntp client servers add address=de.pool.ntp.org
/system ntp client servers add address=ptbtime2.ptb.de
/system scheduler add interval=5d name=doBackup on-event="/system script run doBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=2020-08-04 start-time=21:13:00
/system scheduler add interval=1w3d name=doRandomGen on-event="/system script run doRandomGen" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-03-01 start-time=15:55:00
/system scheduler add interval=1d name=doFreshTheScripts on-event="/system script run doFreshTheScripts" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2018-03-01 start-time=08:00:00
/system scheduler add interval=10m name=doIPSECPunch on-event="/system script run doIPSECPunch" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2019-05-07 start-time=09:00:00
/system scheduler add name=doStartupScript on-event="/system script run doStartupScript" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add interval=7m name=doUpdateExternalDNS on-event="/system script run doUpdateExternalDNS" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2022-01-26 start-time=14:34:19
/system scheduler add interval=10m name=doCoolConsole on-event="/system script run doCoolConsole" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-04-08 start-time=07:00:00
/system scheduler add interval=6h name=doFlushLogs on-event="/system script run doFlushLogs" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=2020-08-04 start-time=21:00:00
/system scheduler add interval=30m name=doCloudBackup on-event="/system script run doCloudBackup" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2026-02-04 start-time=18:48:55
/tool bandwidth-server set authenticate=no enabled=no
/tool e-mail set certificate-verification=no from=defm.kopcap@gmail.com password=lpnaabjwbvbondrg port=587 server=smtp.gmail.com tls=starttls user=defm.kopcap@gmail.com
/tool netwatch add disabled=no down-script=":global NetwatchHostName \"mikrouter.home\";\r\
    \n/system script run doNetwatchHost;" host=192.168.99.1 interval=1m timeout=1s type=simple up-script=":global NetwatchHostName \"mikrouter.home\";\r\
    \n/system script run doNetwatchHost;"
/tool sniffer set filter-ip-address=172.17.0.4/32 filter-ip-protocol=tcp filter-port=4430 streaming-enabled=yes streaming-server=192.168.97.1:30000
