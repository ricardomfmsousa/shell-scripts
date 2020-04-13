#!/bin/bash
# Generates a detailed report from a website (whois, server, open ports, etc.)
# $1: website url | ip

# Install required dependencies
which nmap xsltproc > /dev/null || sudo apt install -y nmap xsltproc

# Generate a XML report using nmap with the provided args
# (utility for network discovery and security auditing)
nmap_xml_output_file="`mktemp`.xml"
args=(
  # website url - list public ip and open ports
  $1
  # retrieve information about domain name
  --script whois-domain.nse
  # perform subdomain discovery
  --script dns-brute
  # perform fast server OS and service detection
  -A -T4
  # make a temporary XML report (to convert to HTML)
  -oX $nmap_xml_output_file
  # Print stats to stdout
  --stats-every 5s
)
nmap "${args[@]}"

# Convert the XML report into a readable HTML file and open it
xsltproc_html_output_file="$1-`date +%d%m%y`-report.html"
xsltproc "$nmap_xml_output_file" -o "$xsltproc_html_output_file"
xdg-open "$xsltproc_html_output_file"

