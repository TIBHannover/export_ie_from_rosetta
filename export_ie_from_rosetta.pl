#!/usr/bin/perl

# sudo apt install libsoap-lite-perl

# sudo apt install libxml2-utils
# if desired to pretty print output via piping to
# xmllint --format -

# Perl module documentation
# https://metacpan.org/pod/SOAP::Lite

# Ex Libris API documentation
# https://developers.exlibrisgroup.com/rosetta/apis/
# https://developers.exlibrisgroup.com/blog/Web-Service-Updates-in-Rosetta-5-1/

use warnings;
use strict;

use Getopt::Long;
use MIME::Base64 qw(encode_base64);
use SOAP::Lite;# +trace => 'all';

my ($user_name, $institution_code, $pass_word, $proxy_url, $ie_pid, $path,);

GetOptions( "user_name=s" => \$user_name,
			"institution_code=s" => \$institution_code,
			"pass_word=s" => \$pass_word,
			"proxy_url=s" => \$proxy_url,
			"ie_pid=s" => \$ie_pid,
			"path=s" => \$path,);

if (not $user_name
or not $institution_code
or not $pass_word
or not $proxy_url
or not $ie_pid
or not $path) {
	print "
	Usage:
	perl $0 --user_name=<user_name> --institution_code=<institution_code> --pass_word=<pass_word> --proxy_url=<proxy_url> --ie_pid=<ie_pid> --path=<path>
	All arguments are named.
	All arguments are mandatory.
	";
	exit 1;
}

my $credentials = "$user_name-institutionCode-$institution_code:$pass_word";
my $credentials_base64 = encode_base64($credentials);

my $client = SOAP::Lite->new()->proxy($proxy_url);

$client->transport->default_header(Authorization => "local $credentials_base64");

$client->outputxml('true');

$client->on_action(sub{ '' });

$client->ns('http://dps.exlibris.com/', 'dps');

my $result = $client->call(
	'exportIE',
	SOAP::Data->name('pid')->value($ie_pid),
	SOAP::Data->name('path')->value($path),
);

print $result . "\n";


