---
layout: page
title: Security
---

Following these simple steps should ensure that data stays secure

### Hardware:

1. Always encrypt your hard-drive. In Ubuntu use full-disc encryption, in OSX use File Vault.
2. Do not connect to public WiFi. Never. Anywhere.
   - if you need internet access, take the company’s 3g-router
   - if it’s not possible, use your mobile as 3g-hotspot and just ask for a refund for using mobile data
4. If possible, have Bluetooth turned off. Always have Bluetooth turned off when you’re not in the office or at home.
5. If you’re using Google Authenticator on your mobile, ensure that accessing your mobile phone data is not possible without the password.
   - make sure, that after 10 tries it will auto-wipe
   - ensure that no one can read text messages on your phone without providing the password first (turn off text-message notification on lock screen)


### Software:

1. 2F Auth must be turned on wherever this is possible; ensure that you have turned it on for GSuite, GitHub, Bitbucket, Gitlab and other services we’re using on a daily basis.
2. Your computer must have auto-lock turned on, the suggested timeout is 1 minute. Every team member caught leaving his computer unlocked is obliged to buy doughnuts to the office as penalty compensation.
3. Use a secure password manager, ie. [KeePassXC](https://keepassxc.org/){:target="_blank"}
4. Use GPG to sign your mail
	- on OSX you can use either [Thunderbird](https://www.mozilla.org/en-US/thunderbird/) or [GPG Suite](https://gpgtools.org/) with Mail.app. [MailMate](https://freron.com/) also has nice support for GPG
	- GnuPG is most likely installed on Linux, if you're using one
5. Use your GPG to [sign your commits](https://help.github.com/articles/signing-commits-using-gpg/)
6. Never send credentials / API keys / etc in plain text
7. To share files within company use intranet and shared hard drive
8. To share files with clients, use S3 bucket and signed links (with expiry set to max 24h)

