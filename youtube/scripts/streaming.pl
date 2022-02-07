use warnings;
use LWP::Simple;
use utf8;
use strict;
use Time::Piece;

#scraping the webpages with streams from the pre-made list
system("wget -i streaming.txt -O streaminghtmls.txt");

open(SOURCE, '<streaminghtmls.txt') or die $!;
open(TARGET, '>>streamingcounter.txt') or die $!;

#timestamping the current row
print TARGET localtime->strftime("%F %H:%M:%S");

#extracting the number of viewers for each of the streams
while(<SOURCE>){
	if(m/.*text\"\:\"(.*?)\"\}\]\}\,\"isLive\"\:true.*/){
		(my $v = $1) =~ s/[^0-9]//g;#removing non-breaking spaces within numbers
		print TARGET "\t", $v;
	};
};

print TARGET "\n";

close TARGET;
close SOURCE;
unlink "streaminghtmls.txt";
