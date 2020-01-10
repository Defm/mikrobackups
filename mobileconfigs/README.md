# Adding your own CA to iPhones's trusted CA
- Pick your selfsigned CA Certificate (*.crt/*.cer) and e-mail (push via Airdrop) it to Iphone
- Open the email and click on the file attached - this will loads certificate to local iphone storage
- Install the Certificate by going (iOS 12.3.1) "Settings"-"Profile loaded" and hit "Install"
- Make it trusted by going "Settings"-"General"-"About"-"Cert. trust settings", find and check your CA

Now any other certificated issued by your CA will be trusted (including code signing certificate that used below).
Profiles, signed with such trusted code signing certificate will get `Verified` mark

# iPhone as roadwarrior IPSEC IKEv2 + Certificates VPN
- form your OSX/iOS *.mobileconfig VPN-ondemand IKEv2 profile using Apple Configurator 2
  * dont forget to include the CA, sign and client Certificates <sup id="a1">[1](#f1)</sup>, that will authorize iPhone on VPN server
- sign it using [Hancock](https://github.com/JeremyAgost/Hancock/tree/master) tool 
  * you should put the CA and sign Cert to youre Keychain before (sign Cert should have private key installed) <sup id="a1">[1](#f1)</sup>

<sup id="f1">1</sup> you can generate code signing certificate with [doCertificatesIssuing](https://github.com/Defm/mikrobackups/blob/master/scripts/doCertificatesIssuing.rsc.txt) [↩](#a1)
