#!/bin/bash

if [ -z "$6" ]
	then
		echo ""
		echo "Usage:"
		echo "bash export_ie_from_rosetta.sh <user_name> <institution_code> <pass_word> <proxy_url> <ie_pid> <path>"
		echo "All arguments are positional."
		echo "All arguments are mandatory."
		exit 1
fi

user_name=$1
institution_code=$2
pass_word=$3
proxy_url=$4
ie_pid=$5
path=$6

credentials_base64=$(echo -n "${user_name}-institutionCode-${institution_code}:${pass_word}" | base64)

read -r -d '' soaprequestdata << END_HEREDOC
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope 
    soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" 
    xmlns:dps="http://dps.exlibris.com/" 
    xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" 
    xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <soap:Body>
    <dps:exportIE>
      <pid>$ie_pid</pid>
      <path>$path</path>
    </dps:exportIE>
  </soap:Body>
</soap:Envelope>
END_HEREDOC

curl --header "Content-Type: text/xml;charset=UTF-8" --header 'SOAPAction: ""' --header "Authorization: local $credentials_base64" --data "$soaprequestdata" "$proxy_url"
