# Description
Example client implementations for the exportIE() method of the Ex
Libris Rosetta SOAP API DataManagerServicesWS which is unfortunately
not covered by the official Ex Libris Java SDK.

One client is a bash script using curl.
The other is implemented as a perl script. Using SOAP::Lite, obtainable
via CPAN or `apt install libsoap-lite-perl` on debian based linux distros.

# Usage
Usage perl script:
`perl export_ie_from_rosetta.pl --user_name=<user_name> --institution_code=<institution_code> --pass_word=<pass_word> --proxy_url=<proxy_url> --ie_pid=<ie_pid> --path=<path>`
All arguments are named.
All arguments are mandatory.

Usage bash script:
`bash export_ie_from_rosetta.sh <user_name> <institution_code> <pass_word> <proxy_url> <ie_pid> <path>`
All arguments are positional.
All arguments are mandatory.

# Caveat
These examples work with a Rosetta installation that allows for local
authentication. If your Rosetta installation authenticates via PDS
you need to provide the PDS handle instead of the local authentication
in the HTTP header. PDS authentication is not possible with these
examples, you would have to modify them accordingly.
