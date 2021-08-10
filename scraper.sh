#! /bin/bash

#                                            _     
#                                           | |    
#   ___  ___ _ __ __ _ _ __   ___ _ __   ___| |__  
#  / __|/ __| '__/ _` | '_ \ / _ \ '__| / __| '_ \ 
#  \__ \ (__| | | (_| | |_) |  __/ |_   \__ \ | | |
#  |___/\___|_|  \__,_| .__/ \___|_(_)  |___/_| |_|
#                     | |                          
#                     |_|                          
#
# Author: Hudson Smith
# Github: @hudsonsmith
# Description: A web scraper program that will get info off sites.

# Get the web address from the command line.
ADDRESS=$1

declare -A colors
colors=(
	["red"]="\033[31m"
	["blue"]="\033[34m"
	["green"]="\033[32m"
	["purple"]"\033[35m"
	["brown"]="\033[33m"
	["yellow"]="\033[1;33m"
	["cyan"]="\033[36m"
	["pink"]="\033[35;1m"
	["reset"]="\033[0m"
)


main () {
	# A function that holds the main program.

	# Check if the user inputs a web url,
	# If not, then show them how to use the program.
	if [ ! $ADDRESS ]; then
		echo "Scraper.sh: Missing parameter \$1"
		usage
		exit
	fi
	
	# Get the web server, DNS addresses, and IP address of the server that replied.
	SERVER=$(curl -I $ADDRESS | grep "Server" | awk '{print $2}')
	DNS_LIST=$(dig www.google.com +noall +answer | awk '{print $5}')

	# Clear the screen before printing the information.
	clear

	echo -e "
	${colors["green"]}Address:${colors["reset"]} ${colors["cyan"]}$ADDRESS${colors["reset"]}

	${colors["green"]}Web Server:${colors["reset"]} ${colors["cyan"]}$SERVER${colors["reset"]}

	DNS Lookup for $ADDRESS:
	$DNS_LIST
	"
}

usage () {
	echo "
	Scraper.sh -- Usage:

		scraper.sh <param>
			@param must be:
				- Web url,
				- --help
	"
}	

main
