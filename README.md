[![GitHub release](https://img.shields.io/badge/release-v1.0-brightgreen?style=flat-square)](https://github.com/samhaxr/SXDork/releases/tag/1.1.2)
[![GitHub stars](https://img.shields.io/github/stars/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/network)
[![GitHub issues](https://img.shields.io/github/issues/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/issues)
[![GitHub pulls](https://img.shields.io/github/issues-pr/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/pulls)
[![GitHub license](https://img.shields.io/github/license/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/blob/main/LICENSE)

# Recox v2.0
RecoX is a powerful tool that is specifically designed to help in identifying and classifying vulnerabilities in web applications. It uses a unique methodology that is able to spot weaknesses that may not be included in the OWASP top ten vulnerabilities list. The script is designed to gather information about the target system in a recursive manner, covering all subdomains and IP addresses that may be used in a sophisticated attack. The information gathered by RecoX is then presented in a clear and organized manner, making it easy for security professionals to understand and address the vulnerabilities. Additionally, the script automates several functions that are typically performed manually during a penetration test, saving a significant amount of time and effort for the user.
<br>For more detail please read this  <a href="https://drive.google.com/file/d/1oOshL5Fc3WiSy3SQFv26UE3YKo5N211i/view?usp=sharing" >document</a>.

# Usage
```
git clone https://github.com/samhaxr/recox
chmod +x recox.sh
./recox.sh
```
Paste the below command to run the tool from anywhere in the terminal.
```
mv recox.sh /usr/local/bin/recox
```

The deep scanner comprises many check-ups including subdomain takeover, A record, passive scan, active scan, CORS misconfiguration, zone transfer test, and web content discovery.
![Alt text](/Flowchart.png?raw=true "RecoX Flowchart" )

# Update
New version v2.0 includes bug fixes and CVE Reporting.

# Youtube Tutorial
[![RecoX](RecoX.png)](https://www.youtube.com/watch?v=rsl97682xXA&feature=youtu.be)

# Credit

<a href="https://github.com/RUB-NDS" >Ruhr University Bochum - Chair for Network and Data Security
</a>, 
<a href="https://github.com/deibit" >David García</a>, <a href="https://github.com/jobertabma" >Jobert Abma</a>, <a href="https://github.com/antichown" >antichown</a>
