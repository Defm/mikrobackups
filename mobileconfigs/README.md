
# iPhone as roadwarrior IPSEC IKEv2 + Certificates VPN
- form your OSX/iOS *.mobileconfig VPN-ondemand IKEv2 profile using Apple Configurator 2
  * dont forget to include the CA, sign and client Certificates <sup id="a1">[1](#f1)</sup>
- sign it using [Hancock](https://github.com/JeremyAgost/Hancock/tree/master) tool 
  * you should put the CA and sign Cert to youre Keychain before (sign Cert should have private key installed) <sup id="a1">[1](#f1)</sup>

<sup id="f1">1</sup> you can generate code signing certificate with [doCertificatesIssuing](https://github.com/Defm/mikrobackups/blob/master/scripts/doCertificatesIssuing.rsc.txt) [↩](#a1)
