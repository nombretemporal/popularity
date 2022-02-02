use warnings;
use LWP::Simple;
use utf8;
use strict;
use Time::Piece;
use POSIX qw(strftime);
use HTML::Entities;

#German
system("wget https://de.akinator.com -O de.akinator.txt");#download the HTML code

open(SOURCE, '<de.akinator.txt') or die $!;
open(TARGET, '>>de.lastplayed.txt') or die $!;

while(<SOURCE>){
	if(m/\<li class\=\"\"\>(.*?)\<\/li\>|\<li class\=\"glue\"\>(.*?)\<\/li\>/){#match character names
		(my $v = $1) =~ s/\t//g;#delete tabs (cause chaos in R)
		print TARGET localtime->strftime("%F"), "\t", localtime->strftime("%Y%m%d %H:%M:%S"), "\t", decode_entities($v), "\n";#print the character name (with HTML escapes restored) with timestamps
	};
};

close TARGET;
close SOURCE;
unlink "de.akinator.txt";#delete the HTML code

#English
system("wget https://en.akinator.com -O en.akinator.txt");

open(SOURCE, '<en.akinator.txt') or die $!;
open(TARGET, '>>en.lastplayed.txt') or die $!;

while(<SOURCE>){
	if(m/\<li class\=\"\"\>(.*?)\<\/li\>|\<li class\=\"glue\"\>(.*?)\<\/li\>/){
		(my $v = $1) =~ s/\t//g;
		print TARGET localtime->strftime("%F"), "\t", localtime->strftime("%Y%m%d %H:%M:%S"), "\t", decode_entities($v), "\n";
	};
};

close TARGET;
close SOURCE;
unlink "en.akinator.txt";

#Spanish
system("wget https://es.akinator.com -O es.akinator.txt");

open(SOURCE, '<es.akinator.txt') or die $!;
open(TARGET, '>>es.lastplayed.txt') or die $!;

while(<SOURCE>){
	if(m/\<li class\=\"\"\>(.*?)\<\/li\>|\<li class\=\"glue\"\>(.*?)\<\/li\>/){
		(my $v = $1) =~ s/\t//g;
		print TARGET localtime->strftime("%F"), "\t", localtime->strftime("%Y%m%d %H:%M:%S"), "\t", decode_entities($v), "\n";
	};
};

close TARGET;
close SOURCE;
unlink "es.akinator.txt";

#French
system("wget https://fr.akinator.com -O fr.akinator.txt");

open(SOURCE, '<fr.akinator.txt') or die $!;
open(TARGET, '>>fr.lastplayed.txt') or die $!;

while(<SOURCE>){
	if(m/\<li class\=\"\"\>(.*?)\<\/li\>|\<li class\=\"glue\"\>(.*?)\<\/li\>/){
		(my $v = $1) =~ s/\t//g;
		print TARGET localtime->strftime("%F"), "\t", localtime->strftime("%Y%m%d %H:%M:%S"), "\t", decode_entities($v), "\n";
	};
};

close TARGET;
close SOURCE;
unlink "fr.akinator.txt";

#Italian
system("wget https://it.akinator.com -O it.akinator.txt");

open(SOURCE, '<it.akinator.txt') or die $!;
open(TARGET, '>>it.lastplayed.txt') or die $!;

while(<SOURCE>){
	if(m/\<li class\=\"\"\>(.*?)\<\/li\>|\<li class\=\"glue\"\>(.*?)\<\/li\>/){
		(my $v = $1) =~ s/\t//g;
		print TARGET localtime->strftime("%F"), "\t", localtime->strftime("%Y%m%d %H:%M:%S"), "\t", decode_entities($v), "\n";
	};
};

close TARGET;
close SOURCE;
unlink "it.akinator.txt";

close TARGET;
close SOURCE;

#Russian
system("wget https://ru.akinator.com -O ru.akinator.txt");

open(SOURCE, '<ru.akinator.txt') or die $!;
open(TARGET, '>>ru.lastplayed.txt') or die $!;

while(<SOURCE>){
	if(m/\<li class\=\"\"\>(.*?)\<\/li\>|\<li class\=\"glue\"\>(.*?)\<\/li\>/){
		(my $v = $1) =~ s/\t//g;
		print TARGET localtime->strftime("%F"), "\t", localtime->strftime("%Y%m%d %H:%M:%S"), "\t", decode_entities($v), "\n";
	};
};

close TARGET;
close SOURCE;
unlink "ru.akinator.txt";
