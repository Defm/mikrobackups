
# iPhone as roadwarrior IPSEC IKEv2 + Certificates VPN
- form your OSX/iOS *.mobileconfig VPN-ondemand IKEv2 profile using Apple Configurator 2
 * dont forget to include the CA, sign and client Certificates[^cert] 
- sign it using [Hancock](https://github.com/JeremyAgost/Hancock/tree/master) tool 
  * you should put the CA and sign Cert to youre Keychain before[^cert]

**Markdown**[^wiki_markdown] — облегчённый язык разметки.
[^wiki_markdown]: [ru.wikipedia.org](/wiki/Markdown "ru.wikipedia.org")

[^cert]: you can generate code signing certificate with [doCertificatesIssuing](https://github.com/Defm/mikrobackups/blob/master/scripts/doCertificatesIssuing.rsc.txt)
