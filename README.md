[![GitHub release](https://img.shields.io/badge/release-v2.0-brightgreen?style=flat-square)](https://github.com/samhaxr/SXDork/releases/tag/1.1.2)
[![GitHub stars](https://img.shields.io/github/stars/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/network)
[![GitHub issues](https://img.shields.io/github/issues/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/issues)
[![GitHub pulls](https://img.shields.io/github/issues-pr/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/pulls)
[![GitHub license](https://img.shields.io/github/license/samhaxr/recox?style=flat-square)](https://github.com/samhaxr/recox/blob/main/LICENSE)

# Recox v2.0
RecoX is an incredibly versatile and powerful tool that is specifically designed to aid in the identification and classification of vulnerabilities within web applications. The script is able to detect vulnerabilities that are not typically included in the OWASP top ten vulnerabilities list, making it a valuable addition to any security professional's toolkit.

One of the key strengths of RecoX is its ability to recursively gather information about the target system. The script is designed to thoroughly cover all subdomains and IP addresses that could potentially be used in a sophisticated attack. This allows security professionals to quickly and efficiently identify potential vulnerabilities in even the most complex web applications.

Another important feature of RecoX is its ability to automate several functions that are typically performed manually during a penetration test. This includes tasks such as URL extraction, parameter identification, and SQL injection testing. By automating these functions, RecoX is able to significantly reduce the amount of time and effort required for a comprehensive web application security assessment.

The information gathered by RecoX is presented in a clear and organized format, making it easy for security professionals to understand and address the vulnerabilities. The script generates a detailed report that includes information about each vulnerability, along with recommended actions for remediation.

RecoX is an invaluable asset for any security professional looking to improve their web application security. With its advanced features, unique methodology, and user-friendly interface, RecoX is a highly effective tool that can help organizations identify and address potential security risks before they can be exploited by attackers.
<br>For more detail please read this  <a href="https://drive.google.com/file/d/1oOshL5Fc3WiSy3SQFv26UE3YKo5N211i/view?usp=sharing" >document</a>.

# Usage
```
git clone https://github.com/samhaxr/recox
cd recox
chmod +x recox.sh
./recox.sh
```
Paste the below command to run the tool from anywhere in the terminal.
```
sudo mv recox.sh /usr/local/bin/recox
```

The deep scanner is a comprehensive function that performs a variety of check-ups to identify potential security vulnerabilities within a web application. Its many features include subdomain takeover, A record analysis, passive and active scanning, CORS misconfiguration testing, zone transfer testing, and web content discovery.

One of the key strengths of the deep scanner is its ability to perform subdomain takeover checks. This is a critical security concern as a deleted external service can leave the subdomain pointing to a non-existent website. By performing subdomain takeover checks, the deep scanner can quickly identify whether a subdomain is vulnerable to a takeover attack.

In addition to subdomain takeover checks, the deep scanner also performs A record analysis to identify potential DNS misconfigurations. This helps to prevent attackers from exploiting weaknesses in the DNS system to gain unauthorized access to the web application.

The deep scanner also performs both passive and active scans to identify potential vulnerabilities within the web application. This includes identifying common vulnerabilities such as SQL injection, cross-site scripting (XSS), and remote file inclusion.

CORS misconfiguration testing is another important feature of the deep scanner, as it can help identify potential security risks related to cross-origin resource sharing (CORS). Zone transfer testing is also performed, as it can help identify potential security vulnerabilities related to DNS zone transfers.

Finally, web content discovery is a crucial component of the deep scanner, as it can help identify sensitive information that may be exposed on the web application. This includes files, directories, and other resources that could be exploited by attackers.

The deep scanner is an incredibly powerful function that can help organizations identify and address potential security risks within their web applications. Its many features and comprehensive approach make it an invaluable asset for any security professional looking to improve the security of their web applications.

![Alt text](/Flowchart.png?raw=true "RecoX Flowchart" )

# Update
New version v2.0 includes bug fixes and CVE Reporting.

# Youtube Tutorial
[![RecoX](RecoX.png)](https://www.youtube.com/watch?v=rsl97682xXA&feature=youtu.be)

# Credit

<a href="https://github.com/RUB-NDS" >Ruhr University Bochum - Chair for Network and Data Security
</a>, 
<a href="https://github.com/deibit" >David García</a>, <a href="https://github.com/jobertabma" >Jobert Abma</a>, <a href="https://github.com/antichown" >antichown</a>
