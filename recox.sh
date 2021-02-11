#!/bin/bash
#!Coded by Suleman Malik
#!www.sulemanmalik.com
#!Twitter: @sulemanmalik_3
#!Linkedin: http://linkedin.com/in/sulemanmalik03/

VTOTAL_API_KEY="" # VIRUSTOTAL API KEY HERE
SHODAN_API_KEY="" # SHODAN API KEY HERE

###################################################################################################################
###################################################################################################################
###												 		###
###				*** DISCLAIMER *** 						 		###
###												 		###
###	This tool is written for educational purpose only.					 		###
###	Usage of RecoX for attacking targets without prior mutual consent is illegal.		 	 	###
###	It is the end user's responsibility to obey all applicable local, state and federal laws.		###
###	Developer assume no liability and are not responsible for any misuse or damage caused by this program	###
###												 		###
###################################################################################################################
###################################################################################################################


cont(){
	rm -rf ${base_dir} > /dev/null 2>&1
}

checkOS(){
	oscheck="$(uname -s)"
	case "${oscheck}" in
	    Linux*)     machine=Linux;;
	    Darwin*)    machine=Mac;;
	    CYGWIN*)    machine=Cygwin;;
	    MINGW*)     machine=MinGw;;
	    *)          machine="UNKNOWN:${oscheck}"
	esac
}

package(){
	checkOS
	if [ "$machine" = "Linux" ]
	then
		jq=$(command -v jq); nmap=$(command -v  nmap); pcregrep=$(command -v  pcregrep); beautify=$(command -v js-beautify);
		if [ -z $jq ] || [ -z $nmap ] || [ -z $pcregrep ] || [ -z $beautify ];then echo -e "${YELLOW}[!] Installing Libraries...\n"; sleep 2; sudo whoami > /dev/null 2>&1 ;fi
		echo -ne "${YELLOW}[-]${LIGHTGRAY} Checking dependencies...\r";sleep 1;echo -ne "${RED}              [#                         0%]\r";
		[ -z $jq ]&& sudo apt install jq -y > /dev/null 2>&1;echo -ne 'Checking JQ  [##                        10%]\r';
		[ -z $nmap ]&& sudo apt-get install nmap -y > /dev/null 2>&1;echo -ne 'Checking Nmap[#####                     20%]\r';
		[ -z $pcregrep ]&& sudo apt-get install pcregrep -y > /dev/null 2>&1;echo -ne 'Checking Pcre[########                  30%]\r';
		[ -z $beautify ]&& sudo apt-get install python-setuptools -y > /dev/null 2>&1 && git clone https://github.com/einars/js-beautify.git > /dev/null 2>&1 &&cd js-beautify/python \
		&& sudo python setup.py install > /dev/null 2>&1 && cd ..&& rm -rf js-beautify;echo -ne 'Checking JS-B[########                  40%]\r';
		[ ! -f "~/CORStest" ]&& git clone https://github.com/recoxv1/CORStest ~/CORStest > /dev/null 2>&1 && sudo apt install python3-pip -y > /dev/null 2>&1 && sudo apt install php -y \
		> /dev/null 2>&1 && pip3 install dnspython > /dev/null 2>&1;apt-get install bsdmainutils > /dev/null 2>&1;echo -ne 'Checking Cors[##########                50%]\r';
		[ ! -f "~/cansina" ]&& git clone --depth=1 https://github.com/recoxv1/cansina ~/cansina > /dev/null 2>&1 && pip3 install -r ~/cansina/requirements.txt > /dev/null 2>&1;\
		echo -ne 'Checking Cans[#############             60%]\r';[ ! -f "~/cansina/wlist" ]&& curl -s -L https://raw.githubusercontent.com/recoxv1/SecLists/master/Discovery/Web-Content/common.txt \
		> ~/cansina/wlist;echo -ne "${GREEN}Checking List[################          70%]\r";[ ! -f "~/relative-url-extractor" ]&& git clone https://github.com/recoxv1/relative-url-extractor.git \
		~/relative-url-extractor > /dev/null 2>&1;echo -ne 'Checking URLx[###################       80%]\r';[ ! -f "~/subdomain-takeover" ]&& git clone https://github.com/recoxv1/subdomain-takeover.git \
		~/subdomain-takeover > /dev/null 2>&1 && pip install -r ~/subdomain-takeover/requirements.txt > /dev/null 2>&1;echo -ne 'Checking URLx[######################    90%]\r';
		echo -ne "${RESTORE}DONE${CYAN}           [######################### 100%]\r";echo -e "\n"
	elif [ "$machine" = "Mac" ]
	then
		echo -ne "${YELLOW}[-]${LIGHTGRAY} Checking dependencies...\r";sleep 1;echo -ne "${RED}              [#                         0%]\r";
		jq=$(command -v jq);[ -z $jq ]&& brew install jq > /dev/null 2>&1;echo -ne 'Checking JQ  [##                        10%]\r';
		nmap=$(command -v  nmap);[ -z $nmap ]&& brew install nmap > /dev/null 2>&1 &&brew link nmap > /dev/null 2>&1;echo -ne 'Checking Nmap[#####                     20%]\r';
		echo -ne 'Checking Pcre[########                  30%]\r';beautify=$(command -v js-beautify);[ -z $beautify ]&& sudo apt-get install python-setuptools -y > /dev/null \
		2>&1&&git clone https://github.com/einars/js-beautify.git > /dev/null 2>&1&&cd js-beautify/python&& python setup.py install > /dev/null 2>&1 && pip3 install jsbeautifier && \
		cd .. && rm -rf js-beautify;echo -ne 'Checking JS-B[########                  40%]\r';[ ! -f "~/CORStest" ]&& git clone https://github.com/recoxv1/CORStest ~/CORStest > /dev/null 2>&1;\
		echo -ne 'Checking Cors[##########                50%]\r';[ ! -f "~/cansina" ]&& git clone --depth=1 https://github.com/recoxv1/cansina ~/cansina > /dev/null \
		2>&1 && pip3 install -r ~/cansina/requirements.txt > /dev/null 2>&1;echo -ne 'Checking Cans[#############             60%]\r';[ ! -f "~/cansina/wlist" ]&& curl \
		-s -L https://raw.githubusercontent.com/recoxv1/SecLists/master/Discovery/Web-Content/common.txt > ~/cansina/wlist;echo -ne "${GREEN}Checking List[################          70%]\r";
		[ ! -f "~/relative-url-extractor" ]&& git clone https://github.com/recoxv1/relative-url-extractor.git ~/relative-url-extractor > /dev/null 2>&1;\
		echo -ne 'Checking URLx[###################       80%]\r';[ ! -f "~/subdomain-takeover" ]&& git clone https://github.com/recoxv1/subdomain-takeover.git \
		~/subdomain-takeover > /dev/null 2>&1 && pip install -r ~/subdomain-takeover/requirements.txt > /dev/null 2>&1;echo -ne 'Checking URLx[######################    90%]\r';
		echo -ne "${RESTORE}DONE${CYAN}           [######################### 100%]\r";echo -e "\n"
	else
		echo -e "\n${RED}[!] The current Operating System does not support this program. Exiting...${RESTORE}\n"; sleep 3;exit 1;
	fi
}

c_code(){
	RESTORE='\033[0m'; RED='\033[00;31m'; GREEN='\033[00;32m'; YELLOW='\033[00;33m'; BLUE='\033[00;34m'; 
	_L='\033[00;37m'; _C='\033[00;36m'; PURPLE='\033[00;35m'; CYAN='\033[00;36m'; LIGHTGRAY='\033[00;37m';
	LRED='\033[01;31m'; LGREEN='\033[01;32m'; LYELLOW='\033[01;33m'; LBLUE='\033[01;34m'; LPURPLE='\033[01;35m'; 
	LCYAN='\033[01;36m'; WHITE='\033[01;37m';
}

connectivity(){
	if nc -zw1 google.com 443 >/dev/null 2&>1; then
		echo -e "\n${GREEN}[+]${LIGHTGRAY} Done"; 
		echo -e "${GREEN}[+]${LIGHTGRAY} Connection : ${LGREEN}OK${RESTORE}"
	else
		echo -e "${LRED}[!]${RESTORE}${LIGHTGRAY} Please check your internet connection and then try again...${LIGHTGRAY}";exit 1
	fi
}

ban(){
	echo -e "${_L}██████${_C}╗${_L} ███████${_C}╗${_L} ██████${_C}╗${_L} ██████${_C}╗ ${_C}██╗  ██╗"
	echo -e "${_L}██${_C}╔══${_L}██${_C}╗${_L}██${_C}╔════╝${_L}██${_C}╔════╝${_L}██${_C}╔═══${_L}██${_C}╗${_C}╚██╗██╔╝"
	echo -e "${_L}██████${_C}╔╝${_L}█████${_C}╗${_L}  ██${_C}║${_L}     ██${_C}║${_L} ${_C}//${_L}██${_C}║${_C} ╚███╔╝ "
	echo -e "${_L}██${_C}╔══${_L}██${_C}╗${_L}██${_C}╔══╝${_L}  ██${_C}║${_L}     ██${_C}║${_C}//${_L} ██${_C}║${_C} ██╔██╗"
	echo -e "${_L}██${_C}║  ${_L}██${_C}║${_L}███████${_C}╗╚${_L}██████${_C}╗╚${_L}██████${_C}╔╝${_C}██╔╝ ██╗${_L}"
	echo -e "${_C}╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ${_C}╚═╝  ╚═╝";
	echo -e "${_C}\nTwitter: @sulemanmalik_3\t\tV2.0\033[0m";ban_ln
}

disclaimer(){
	echo -e "${LRED}DISCLAIMER${RESTORE}"
	echo -e "${_L}This tool is written for educational purpose only${RESTORE}" 
	echo -e "${_L}Usage of RecoX for attacking targets without prior mutual consent is illegal.${RESTORE} "
	echo -e "${_L}It is the end user's responsibility to obey all applicable local, state and federal laws${RESTORE} "
	echo -e "${_L}Developer assume no liability and are not responsible for any misuse or damage caused by this program${RESTORE}"; sleep 3
}

validate(){
	regex='(https?|http)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
	if [[ ! $1 =~ $regex ]]; then ban_ln;echo -e "\n${RED}[!] ${RESTORE}Invalid URL. Try Again."
		echo -e "    Example https://example.com\n";ban_ln; c=1;main; fi
}

func_finder(){
	echo -e "${YELLOW}[-]${RESTORE} Processing ${url}\n"
	count=$(grep -i -c "function" ${logdir}/${1}); passwd=$(grep -i -c "password" ${logdir}/${1}); user=$(grep -i -c "user" ${logdir}/${1})
	api=$(grep -i -c "api" ${logdir}/${1}); token=$(grep -i -c "token" ${logdir}/${1}); pass=$(grep -i -c "pass" ${logdir}/${1})
	username=$(grep -i -c "username" ${logdir}/${1}); email=$(grep -i -c "email" ${logdir}/${1});
	 [ "${count}" -eq 0 ]&& echo -e "${LYELLOW}Found ${LRED}${count}${LYELLOW} function keywords ${RESTORE}" \
	 || echo -e "${LYELLOW}Found ${LGREEN}${count}${LYELLOW} JS functions ${RESTORE}";
	 [ "${passwd}" -eq 0 ]&& echo -e "${LYELLOW}Found ${LRED}${passwd}${LYELLOW} Password keywords ${LRED}"\
	 || echo -e "${LYELLOW}Found ${LGREEN}${passwd}${LYELLOW} Password keywords ${LRED}";
	 [ "${pass}" -eq 0 ]&& echo -e "${LYELLOW}Found ${LRED}${pass}${LYELLOW} Pass keywords ${LRED}"\
	 || echo -e "${LYELLOW}Found ${LGREEN}${pass}${LYELLOW} Pass keywords ${LRED}";
	 [ "${user}" -eq 0 ]&& echo -e "${LYELLOW}Found ${LRED}${user}${LYELLOW} User keywords ${LGREEN}" \
	 || echo -e "${LYELLOW}Found ${LGREEN}${user}${LYELLOW} User keywords ${LGREEN}";
	 [ "${username}" -eq 0 ]&& echo -e "${LYELLOW}Found ${LRED}${username}${LYELLOW} Username keywords ${LGREEN}" \
	 || echo -e "${LYELLOW}Found ${LGREEN}${username}${LYELLOW} Username keywords ${LGREEN}";
	 [ "${api}" -eq 0 ]&& echo -e "${LYELLOW}Found ${LRED}${api}${LYELLOW} API keywords ${LGREEN}" \
	 || echo -e "${LYELLOW}Found ${LGREEN}${api}${LYELLOW} API keywords ${LGREEN}";
	 [ "${token}" -eq 0 ]&& echo -e "${LYELLOW}Found ${LRED}${token}${LYELLOW} token keywords ${LGREEN}" \
	 || echo -e "${LYELLOW}Found ${LGREEN}${token}${LYELLOW} token keywords ${LGREEN}";
	 [ "${email}" -eq 0 ]&& echo -e "${LYELLOW}Found ${LRED}${email}${LYELLOW} email keywords ${LGREEN}" \
	 || echo -e "${LYELLOW}Found ${LGREEN}${email}${LYELLOW} email keywords ${LGREEN}";
	 [ "${count}" -eq 0 ]&& echo -e "\n\n${RED}\t\t${count} keywords Found!${RESTORE}\n\n" \
	 || echo -e "\n${GREEN}[+]${RESTORE} Process Done";
}

srch(){
	GREP_COLOR="00;31;4;157;48;5;226" egrep -i --color=always "$1|$" $2
}

arg_connection(){
	url=$1
	if [ -z "${url}" ]
	then
		echo -e "\n\n${RED}\tInvalid argument!${RESTORE} \n\tPaste URL e.g https://example.com/\n\t'https://example.com/index.php?option=com_users'\n";exit 1;
	fi
	response_code=$(curl -L -s -m 10 ${url} -I | grep -Eo '[0-9]{3}' | head -n1)
	if [ -z "${response_code}" ]; then echo -e "\n\n${RED}\t\tCan not connect! check your internet connection and then try again..${RESTORE}\n\n";exit 1 \
		; else echo -e "${GREEN}[+]${RESTORE} Connection ${LGREEN}OK${RESTORE}"; fi
}

crawl_validate(){
	regex='(https?|http)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
	if [[ ! $1 =~ ${regex} ]]; then ban_ln;echo -e "\n${RED}[!] ${RESTORE}Invalid URL. Try Again."
		echo -e "Example-1 https://example.com\nExample-2 https://example.com/example_path/file.js\n";ban_ln;sleep 1;c=1;main; fi
}

bl(){
	echo -e "\033[0;31m---------------------------------------------------------------------------------\033[0m"
}

crawl_function(){
	NUMBER=$(( $RANDOM % 9 ))
	AGENTS=(
		"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/37.0.2062.94 Chrome/37.0.2062.94 Safari/537.36"
		"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36"
		"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"
		"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"
		"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9"
		"Mozilla/5.0 (iPad; CPU OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H321 Safari/600.1.4"
		"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36"
		"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36"
		"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10240"
		"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"
		"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko"
		"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36"
		"Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"
		"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/600.7.12 (KHTML, like Gecko) Version/8.0.7 Safari/600.7.12"
		"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36"
		"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:40.0) Gecko/20100101 Firefox/40.0"
		"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/7.1.8 Safari/537.85.17"
		"Mozilla/5.0 (iPad; CPU OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4"
		"Mozilla/5.0 (iPad; CPU OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12F69 Safari/600.1.4"
		"Mozilla/5.0 (Windows NT 6.1; rv:40.0) Gecko/20100101 Firefox/40.0"
		)
	logdir='/tmp/crawler'; rm -rf ${logdir};mkdir ${logdir}/ > /dev/null 2>&1
	USER_AGENT=$(echo ${AGENTS[$NUMBER]}); curl -iL -s -A "$USER_AGENT" -H \
	"referer:$1" $1 -B > ${logdir}/crawl1; cat ${logdir}/crawl1| grep -Eoi \
	'<a [^>]+>' > ${logdir}/crawl2; bod; echo -e "${LYELLOW}Extracted Links ${RESTORE}"; bod
	cat ${logdir}/crawl2 | grep -Eo 'href="[^\"]+"' | sed 's/href=//g' \
	| sed 's/\"//g' > ${logdir}/crawl_link; srch "=" ${logdir}/crawl_link
	cat ${logdir}/crawl1| grep href=\" | grep "http://" | grep -Eoi '<a [^>]+>' \
	| grep -o "http:\/\/[^\"]*" > ${logdir}/crawl3;cat ${logdir}/crawl3;
	cat ${logdir}/crawl1 | grep -oE  "[A-Za-z0-9\.-_]+.js" | sort -u > ${logdir}/crawl4;
	srch "(.*?).js" ${logdir}/crawl4; cat ${logdir}/crawl1 | pcregrep --buffer-size=200k \
	--context=3 -Mo '.*?\(.*?\)(\{([^{}]++|(?1))*\})' > ${logdir}/func;
	bod; func_finder func; bod
	if [ "$count" -ne 0 ]
	then
		read -r -p "Do you want to search keywords? [y/N] " response
		if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
		then
			beautify=$(cat ${logdir}/func | js-beautify > ${logdir}/beautify)
			cat ${logdir}/beautify | php -r "echo urldecode(file_get_contents('php://stdin'));" \
			> ${logdir}/beautify2; less ${logdir}/beautify2; bod
		fi
	fi
	read -r -p "Do you want to parse or beautify js/link? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		echo -e "\n[1] Beautify Js\n[2] Parse JS\n";
		read -r -p "=§> " response;
		if [[ "$response" = 1 ]]
		then
			bod; read -r -p "URL: " url;echo -e "${YELLOW}[-] Beautifying Js...${RESTORE}";
			validate ${url}; curl -iL -s -A "$USER_AGENT" -H "referer:$url" ${url} -B \
			| js-beautify > ${logdir}/beautify3;func_finder beautify3;
		    read -r -p "Do you want to search keywords? [y/N] " response
			if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
			then
				less ${logdir}/beautify3; echo -e "${GREEN}[+]${RESTORE} Done\n"; bod;
			else
				echo ''
			fi
		elif [[ "$response" = 2 ]]; then
			bod; read -r -p "URL: " url; echo -e "${YELLOW}[-] Extracting endpoints...${RESTORE}\n";
			validate ${url}; curl -s ${url} | ~/relative-url-extractor/extract.rb ;echo '';
		    echo -e "${GREEN}[+]${LIGHTGRAY} Process Done";bod;
		else
		    echo -e "${RED}[!] Wrong Selection!${RESTORE}"; bod
		fi
		rm -rf ${logdir}  	
	else
		echo ''
	fi; c=1;
}

bod(){
	echo -e "${BLUE}xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx${RESTORE}"
}

cve(){
	xcot=0;
	while read cve_record
	do
		cve_loc="${base_dir}/cve_result"; cve_domain="https://cve.circl.lu/api/cve/$cve_record"; curl -s ${cve_domain} > "${cve_loc}"
		summary=$(jq '.summary' ${cve_loc} | sed 's/"//g'); cvss=$(jq '.cvss' ${cve_loc}); id=$(jq '.id' ${cve_loc})
		references=$(jq '.references' ${cve_loc} | sed 's/[][]//g' | sed 's/"//g'); authentication=$(jq '.access.authentication' \
		${cve_loc}); complexity=$(jq '.access.complexity' ${cve_loc}); vector=$(jq '.access.vector' ${cve_loc});
		refmap=$(jq '.refmap.confirm' ${cve_loc} | sed 's/[][]//g' | sed 's/"//g'| sed 's/,//g'); availability=$(jq '.impact.availability' \
		${cve_loc}); confidentiality=$(jq '.impact.confidentiality' ${cve_loc}); integrity=$(jq '.impact.integrity' ${cve_loc})
		echo -e "${domain} - REPORT - ${date}\n\n\n" >> ${base_dir}/CVE_REPORT;
		if [ "${id}" != "null" ]
		then
			echo -e "${RED}${cve_record}~${RESTORE} -->~ ${GREEN}${1}~${LIGHTGRAY}" >> ${base_dir}/_CVE_REP;
			[[ ${xcot} -le 10 ]]&& echo -e "${RED}[!]${RESTORE} POSSIBLE~ ${LRED}${cve_record}~${RESTORE}" \
			> ${base_dir}/CVE_LIN && cat ${base_dir}/CVE_LIN | sort -n | column -t -s "~" || break;
			[[ ${xcot} -ge 10 ]]&& echo -e "\n${YELLOW}[-]${LIGHTGRAY} There are few more CVE's. Plz read the detailed report when finish... ${RESTORE}";
			date=$(date);echo -e "POSSIBLE ${cve_record} IN ${1}\nID: ${id}" >> ${base_dir}/CVE_REPORT
			echo -e "CVSS: ${cvss}\nAuthentication: ${authentication}" >> ${base_dir}/CVE_REPORT
			echo -e "Availability: ${availability}\nConfidentiality: ${confidentiality}" >> ${base_dir}/CVE_REPORT
			echo -e "Integrity: ${integrity}\nComplexity: ${complexity} \nVector: ${vector}" >> ${base_dir}/CVE_REPORT
			echo -e "Summary: ${summary}\nRefmap: ${refmap} " >> ${base_dir}/CVE_REPORT
			echo -e "\nReferences: ${references}" >> ${base_dir}/CVE_REPORT;
			echo -e "\n---------------------------------------------------------------" >> ${base_dir}/CVE_REPORT;
		fi
		_CVE_COUNT=$(wc -l ${base_dir}/_CVE_REP | awk '{print $1}');
	done < ${base_dir}/cve;
}

arecord(){
	bod;echo ''
	read -r -p "Do you want to check A record of discovered subdomains? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
	    cat ${base_dir}/arecord
	else
	    echo ''
	fi
	bod;echo -e "${YELLOW}Found ${GREEN}${arc}${YELLOW} Unique IP's ${RESTORE}"
}

Passive_scanning(){
	read -r -p "Passive Scan the discovered IP's? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		date=$(date); echo -e "\n${YELLOW}[+]${LIGHTGRAY} Scan Started (${YELLOW}${date}${LIGHTGRAY})\n"; countx=0;
	    while read ip_addr
	    do
			countx=$(($countx + 1)); PTR=$(dig -x ${ip_addr} | grep "PTR" | awk '{print $5}' | sed '/^$/d')
			bl;echo -e "[${GREEN}${countx}${RESTORE}] ${YELLOW}Scanning${RESTORE} ${GREEN}$ip_addr${RESTORE}\n";
			[ ! -z "${PTR}" ]&& echo -e "${RED} PTR: ${RESTORE}${PTR}";shodan_req="${base_dir}/shodanapi"; store_cve="${base_dir}/cve"
				curl -s "https://api.shodan.io/shodan/host/${ip_addr}?key=${shodan_api}" > ${shodan_req}; 
				error=$(cat ${shodan_req} | grep -o "error");
				if [ "${error}" != "error" ]
				then
					software=$(jq '.data[].dns.software' ${shodan_req} | grep -o '"[^"]*"' | sort -u | sed 's/"//g'); 
					country=$(jq '.country_name' ${shodan_req} | sed 's/"//g'); hostname=$(jq '.hostnames' ${shodan_req} | sed 's/[][]//g' \
					| sed 's/"//g' | tr -d '\n' | sed 's/ //g' | sed 's/,/, /g'); isp=$(jq '.data[].isp' ${shodan_req} \
					| sed 's/"//g' | sort -u); asn=$(jq '.data[].asn' ${shodan_req} | sed 's/"//g' | sort -u); vulns=$(jq -r ".vulns" ${shodan_req} \
					| grep -o '"[^"]*"' | sed 's/"//g' > ${store_cve}); port=$(jq '.ports' ${shodan_req} ); count=0; tports="${base_dir}/tports"; 
					jq '.ports' ${shodan_req} | sed 's/[][]//g' | sed '/^$/d' > ${tports}; cnt=$(wc -l < ${tports} | sed 's/ //g'); 
					echo -e "${PURPLE} Country:${RESTORE} ${LIGHTGRAY}${country}";[ ! -z "${hostname}" ]&& \
					echo -e "${PURPLE} Hostname:${RESTORE} ${LIGHTGRAY}${hostname}";echo -e "${PURPLE} ISP:${RESTORE} ${LIGHTGRAY}${isp}";
					echo -e "${PURPLE} ASN:${RESTORE} ${LIGHTGRAY}${asn}\n${PURPLE} OPEN PORTS:${RESTORE} ${LIGHTGRAY}$cnt";
					[ ! -z ${software} ]&& echo -e "${PURPLE} OS: ${LIGHTGRAY}${software}\n${RESTORE}"; bold=$(tput bold); normal=$(tput sgr0); 
					port_scan="${base_dir}/pscan";echo '';echo -e " ${bold}PORT~    SERVICE~    CPE~    SSL${normal}~${GREEN}" > ${port_scan};
					while true; do
						versions=$(jq -r ".data[$count].ssl.versions" ${shodan_req} | sed 's/[][]//g' | sed 's/"//g' | tr -d '\n' | sed 's/  //g' \
						| sed 's/,/ /g'); port=$(jq -r ".data[$count].port" ${shodan_req}); product=$(jq -r ".data[$count].product" ${shodan_req})
						software=$(jq -r ".data[].dns.software" ${shodan_req}); transport=$(jq -r ".data[$count].transport" ${shodan_req})
						cpe=$(jq -r ".data[$count].cpe" ${shodan_req} | grep -o '"[^"]*"' | sed 's/"//g' | tr -d '\n'); count=$(($count + 1))
						[ "${product}" == "null" ] && product='';[ "${versions}" == "null" ] && versions='';[ "${cpe}" == "null" ] && cpe='';
						echo " $port/${transport}~ ${product}~ ${cpe}~ ${versions}~" >> ${port_scan}; [ "${count}" -eq "$cnt" ] && break;
					done
					cat ${port_scan} | sort -n | column -t -s "~"; [ ! -z ${store_cve} ] && echo '';cve ${ip_addr};
				else
					echo -e "${RED} [!]${RESTORE}${LIGHTGRAY} No Passive Info Available. Try Active Scan.${RESTORE}\n"
				fi
	    done < ${base_dir}/allrecord
	else
	    echo ''
	fi;if [[ ! -f "${base_dir}/CVE_REPORT" ]]; then
		echo ''
	else
		echo -e "${RESTORE}";bl;echo -e "${LRED}[!]${YELLOW} ${_CVE_COUNT}${LIGHTGRAY} CVE's Found";echo '';
		cat ${base_dir}/_CVE_REP | sort -n | column -t -s "~"; _RECOX_REPORT='Desktop/RecoX_Report';
		[ ! -f "~/${_RECOX_REPORT}" ]&& mkdir ~/${_RECOX_REPORT} > /dev/null 2>&1; 
		[ ! -f "~/${_RECOX_REPORT}" ]&& mkdir ~/${_RECOX_REPORT}/${url} > /dev/null 2>&1; 
		_NAME_=$(date | awk '{print "_"$1"_"$2"_"$3"_"$4"_"$5}')
		cp ${base_dir}/CVE_REPORT ~/${_RECOX_REPORT}/${url}/CVE_REPORT${_NAME_}
		echo -e "\n${GREEN}Report Saved @ ~/${_RECOX_REPORT}/${url}/CVE_REPORT${_NAME_}${RESTORE}\n"
		read -r -p "View CVE Report? [y/N] " response
		if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
		then
			less ~/${_RECOX_REPORT}/${url}/CVE_REPORT${_NAME_}
		else
			echo ''
		fi
	fi
}

subtakover(){
	bod;echo '';
	read -r -p "Do you want to check subdomain takeover vulnerability? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		echo -e "\n${GREEN}[+]${LIGHTGRAY} Running Subdomain Takeover ${LGREEN}OK${RESTORE}\n"
		python3 ~/subdomain-takeover/takeover.py -d ${url} -f ${inp} -t 30;echo '';ban_ln
	else
		echo ''
	fi
}

Active_scan(){
	bod; read -r -p "Active Scan the discovered IP's? [y/N] " response
	
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		date=$(date);read -r -p "+-----------> Fingerprints Scan? [y/N] " response2
		echo -e "\n${YELLOW}[+]${LIGHTGRAY} Scan Started (${YELLOW}${date}${LIGHTGRAY})\n"
	    while read ips
		do
		fingerprint="${base_dir}/fingerprint"; active_scan="${base_dir}/active_scan";
		Cmd=$(nmap -PN -T4 -F $ips > ${active_scan} ); dom="$(cat ${active_scan} | awk '{print $5}'| head -n 2 \
		| tail -n 1)"; agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, 
		like Gecko) Ubuntu Chromium/37.0.2062.94 Chrome/37.0.2062.94 Safari/537.36"; stat="$(sed -n 5p ${active_scan})"; 
		port="$(cat ${active_scan} | grep open)"; hostIP="$(ping $ips -c1 | grep PING | awk '{print $3}' | sed 's/(//g' \
		| sed 's/)//g')"; p80=$(echo "${port}" | grep -o "80/tcp" | head -n1); p8080=$(echo "${port}" | grep -o "8080/tcp" \
		| head -n1); p443=$(echo "${port}" | grep -o "443/tcp" | head -n1); echo -e "\n${RED}Now Scanning${RESTORE}" 
		echo -e "IP:${GREEN}${hostIP}${RESTORE}\nDomain: ${YELLOW}$dom${RESTORE}\n"
		echo -e "${GREEN}${stat}${RESTORE}" ;echo -e "${GREEN}${port}${RESTORE}\n";
		if [[ "$response2" =~ ^([yY][eE][sS]|[yY])$ ]]
		then
			if [ "${p80}" == "80/tcp" ] || [ "${p8080}" == "8080/tcp" ] || [ "${p443}" == "443/tcp" ]
			then
				curl -A ${agent} -I ${ips} -L -s --max-time 5 > ${fingerprint}
				echo -e "${RED}Scanning Fingerprints...${RESTORE}\n"
				cat ${fingerprint}; bl
			else
				bl
			fi
		fi
		done < ${base_dir}/allrecord
	else
	    echo ''
	fi
}

cors(){
	bod;read -r -p "Do you want to check CORS Misconfiguration? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
	    echo -e "${GREEN}[+]${LIGHTGRAY}Checking CORS misconfiguration ${LGREEN}OK${RESTORE}\n"
	    python ~/CORStest/corstest.py ${base_dir}/subdomains; python ~/CORStest/corstest.py -s ${base_dir}/subdomains
	else
	    echo ''
	fi
}

ban_ln(){
	echo -e "${LRED}-----------------------------------------------${RESTORE}"
}

ztransfer(){
	bod
	read -r -p "Do you want to check the Zone Transfer on subdomains? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
	    echo -e "${GREEN}[+]${LIGHTGRAY}Checking Zone transfer ${LGREEN}OK${RESTORE}\n"
	    while read domain
	    do
			nameserver=$(host -t ns $domain | awk 'NF>1{print $NF}' \
			| sed 's/.$//' | head -n+1); connect_error=$(echo ${nameserver} \
			| grep -o "SERVFAIL"); AXFR_LOC="${base_dir}/diglookup"
			if [ "$nameserver" == "recor"  ]
			then
				echo -e "\n${GREEN}[+]${YELLOW} Performing test on ${LIGHTGRAY}Hostname: ${GREEN}${domain}${RESTORE}"
				echo -e "${RED}[!] ${LIGHTGRAY}NS RECORD NOT FOUND${RESTORE}"
			elif [ "${connect_error}" == "SERVFAIL" ]
			then
				echo -e "\n${GREEN}[+]${YELLOW} Performing test on ${LIGHTGRAY}Hostname: ${GREEN}${domain}${RESTORE}"
				echo -e "${RED}[!]${LIGHTGRAY} NO CONNECTION${RESTORE}";
			else
				echo -e "\n${GREEN}[+]${YELLOW} Performing test on ${LIGHTGRAY}Hostname: ${GREEN}${domain}" 
				echo -e "${LIGHTGRAY}NameServer: ${GREEN}${nameserver}${RESTORE}"
				AXFR=$(dig +time=5 +tries=1 @${nameserver} -t AXFR ${domain} > ${AXFR_LOC})
				AXFR_Error=$(sed 's/;//g' ${AXFR_LOC} | tail -n -1 | sed 's/^ //' | awk 'NF>1{print $NF}' | sed 's/.$//' )
				if [ "${AXFR_Error}" == "out" ]
				then
					echo -e "${RED}[!]${LIGHTGRAY} TIMEOUT${RESTORE}"
				elif [ "${AXFR_Error}" == "failed" ]
				then
					echo -e "${LRED}[!] TRANSFER FAILED!${RESTORE}"
				elif [ "${AXFR_Error}" == "refused" ]
				then
					echo -e "${RED}[!] ${LIGHTGRAY}Connection Refused..${RESTORE}"
				else
					cat ${AXFR_LOC}
				fi
			fi
		  done < ${inp}
	else
	    echo ''
	fi
}

discovery(){
	bod; read -r -p "Do you want to run content discovery on subdomains? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		echo -e "\n${GREEN}[+]${LIGHTGRAY}Running Content discovery ${LGREEN}OK${RESTORE}"
		while read dom
		do
			ban_ln; python3 ~/cansina/cansina.py -u ${dom} -p ~/cansina/wlist -B \
			100,200,300,301,302,500,400,401,402,405 -b 404,403 -t 15 --recursive -T 0.25
		done < ${inp}
	else
		echo ''
	fi
}

Deep_web_scan(){
	cont > /dev/null 2>&1;mkdir ${base_dir};connectivity
	url=$(echo ${1} | sed 's/https:\/\///g' | sed 's/http:\/\///g'); curl -s --request GET \
	--url "https://www.virustotal.com/vtapi/v2/domain/report?apikey=${vtotal_api}&domain=$url" \
	| python -m json.tool > ${base_dir}/subdomain; subdomain=$(cat ${base_dir}/subdomain | jq '.subdomains' \
	| sed 's/"//g' | sed 's/,//g' | sed -e 's/<.*>//g' | sed 's/[][]//g' | sed 's/ //g' | sed '/^$/d' \
	> ${base_dir}/subdomains);inp="${base_dir}/subdomains"; cot=0; lof=$(wc -l < $inp | sed 's/ //g')
	while read dom
	do 
		cot=$(($cot + 1)); echo -ne "\033[0;33m[-] Scanning Subdomains:\033[0m ${cot}/${lof}\r"
		cname=$( dig CNAME $dom | grep "CNAME" | tail -n1 | cut -c"29-" | sed 's/^.*E//' \
		>> ${base_dir}/cnames); bl >> ${base_dir}/arecord; echo -e "[${GREEN}${cot}${RESTORE}] Extracted IP's from ${YELLOW}${dom}${RESTORE}" \
		>> ${base_dir}/arecord; bl >> ${base_dir}/arecord; Arecord=$(dig A ${dom} | sed '$d' | sed '$d' | sed '$d' | sed '$d' | grep -E -o \
		"([0-9]{1,3}[\.]){3}[0-9]{1,3}"  | uniq >> ${base_dir}/arecord); echo "${cot} - ${dom}~ -->~ " >> ${base_dir}/cname-ln;
	done < ${inp}
	prog=$(awk 'NR==FNR{a[++y]=$0;next}{b[++x]=$0}
	END{z=x>y?x:y;while(++i<=z){print a[i],b[i]}}' ${base_dir}/cname-ln ${base_dir}/cnames > ${base_dir}/fn-py)
	allrecord=$(cat ${base_dir}/arecord | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | sort -u > ${base_dir}/allrecord)
	arc=$(wc -l ${base_dir}/allrecord | awk '{print $1}');echo -e '\n';
	bl;echo -e "Extracted CNAME from ${YELLOW}${url}${RESTORE} subdomains";bl;cat ${base_dir}/fn-py | column -t -s "~";
	sleep 1;subtakover;arecord;Passive_scanning;Active_scan;cors;ztransfer;discovery;cont > /dev/null 2>&1;bod; c=1;
}

web_infoga(){
	echo -e "${LYELLOW}[-] Processing${RESTORE}";
	parent_dir='/tmp/vtdom'; resp_log='/tmp/vtdom/res'; weboftrust='/tmp/vtdom/wot';
	dns_log='/tmp/vtdom/dns'; subdomains='/tmp/vtdom/subdomains'; mkdir ${parent_dir} > /dev/null 2>&1;
	url=$(echo $1 | sed 's/https:\/\///g' | sed 's/http:\/\///g'); curl -s --request GET \
	--url "https://www.virustotal.com/vtapi/v2/domain/report?apikey=${vtotal_api}&domain=${url}" \
	| python -m json.tool > ${resp_log};bod;echo -e "\t\t\t${GREEN}WEB OF TRUST DOMAIN INFORMATION${RESTORE}";
	bod; cat ${resp_log}| jq '."WOT domain info"' | sed 's/"//g' | sed 's/,//g' | sed 's/{//g' | sed 's/}//g' \
	| sed '/^$/d' | sed 's/ //g' | sed 's/:/ -> /g' > ${weboftrust}; wot=$(cat ${weboftrust});
	if [ "$wot" == "null" ];then echo -e "\n\t\t\t${RED}NO RECORD FOUND!${RESTORE}\n";else cat ${weboftrust}; fi
	bod;echo -e "\t\t\t${YELLOW}DNS RECORD of $url${RESTORE}";bod; dns=$(cat ${resp_log} | jq '.dns_records' \
	> ${dns_log});cat ${dns_log} | jq -r '.[] | [.type, .value] | @csv' | tr -d '"' | sed 's/,/ -> /g';echo '';
	subdomain=$(cat ${resp_log} | jq '.subdomains' | sed 's/"//g' | sed 's/,//g' | sed -e 's/<.*>//g' \
	| sed 's/[][]//g' | sed 's/ //g' | sed '/^$/d' > ${subdomains})
	len=$(wc -l ${subdomains} | awk '{print $1}');bod; 
	echo -e "\t\t\t${YELLOW}Discovered ${GREEN}$len ${YELLOW}subdomains from ${url}${RESTORE}";
	bod;echo '';count=0;
	while read subdomain
	do
		count=$(($count + 1))
		echo -e " [${GREEN}${count}${RESTORE}] ${LIGHTGRAY}${subdomain}${RESTORE}"
	done < ${subdomains}
	bod;echo '';c=1;rm -rf ${parent_dir} > /dev/null 2>&1
}

apikeys_validation(){
	vtotal_res="bb94f820988562d5ffed31864bd165ce";vtotal_src="https://www.virustotal.com/vtapi/v2/file/report";
	shodan_src="https://api.shodan.io/shodan/host/8.8.8.8";vtotal_validate=$(curl --request GET -s --url \
	"${vtotal_src}?apikey=${VTOTAL_API_KEY}&resource=${vtotal_res}")
	if [ -z "${vtotal_api}" ];then echo -e "${RED}[!] Missing VirusTotal API${RESTORE}";elif [ -z "${vtotal_validate}" ];then \
		echo -e "${RED}[!] VirusTotal API (Wrong API KEY)${RESTORE}";else echo -e "${CYAN}[\xE2\x9C\x94]${LIGHTGRAY} VirusTotal API OK ${RESTORE}";fi
	shodan_verify=$(curl -s "${shodan_src}?key=${shodan_api}" | grep -o "bad password")
	if [ -z "${shodan_api}" ];then echo -e "${RED}[!] Missing Shodan API${RESTORE}";elif [ "$shodan_verify" == "bad password" ] \
		;then echo -e "${RED}[!] Shodan API (Wrong API KEY)${RESTORE}" ;else echo -e "${CYAN}[\xE2\x9C\x94]${LIGHTGRAY} Shodan API OK ${RESTORE}";fi
}

main(){
	vtotal_api="${VTOTAL_API_KEY}"; shodan_api="${SHODAN_API_KEY}"
	if [ $c -eq 1 ];then echo '';else c=0; fi
	if [ $c -eq 0 ];then clear;ban;package;apikeys_validation; fi
	base_dir="/tmp/samhax"; cr=`echo $'\n.'`; cr=${cr%.};checkOS;cont;
	while true
	do
		if [ $c -ne 0 ];then ban; fi
		echo -e "\n[1] Deep-Dom Scanner";echo -e "[2] Deep-JS";echo -e "[3] Web-Info";echo -e "[0] Exit\n"
		if [ -z ${vtotal_api} ] || [ -z ${shodan_api} ] || [ "$shodan_verify" == "bad password" ] || [ -z "${vtotal_validate}" ]
		then 
			echo -e "${RED}[!] API Keys are Missing. Exiting Program\n${RESTORE}";
			ban_ln;exit 1;
		fi
		read -r -p "=§> " choice
		choice=$(echo $choice | grep -x -E '[[:digit:]]+')
		[ -z $choice ]&& c=1 && main	
		if [ "${choice}" -eq 1 ]
		then
			read -r -p "${cr}Domain: " domain
			validate ${domain};Deep_web_scan ${domain}
		elif [ "${choice}" -eq 2 ]
		then
			read -r -p "${cr}Domain: " domain
			crawl_validate ${domain};connectivity;crawl_function ${domain}
		elif [ "${choice}" -eq 3 ]
		then
			read -r -p "${cr}Domain: " domain
			validate ${domain};connectivity;web_infoga ${domain}
		elif [ "${choice}" -eq 0 ]
		then
			echo -e "\n${LRED}[x]${RESTORE} Exiting program...\n";cont;ban_ln;exit 1;
		else
			echo -e "\n${RED}[!]${RESTORE} Wrong choice. Try again..."
		fi
	done
}
c_code;clear;ban;disclaimer;main
