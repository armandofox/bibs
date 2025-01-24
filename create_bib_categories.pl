#!/usr/bin/env perl

sub get_bib_entries {
    my($bibfile) = shift;
    my $bibcontents = '';
    open(FH, $bibfile) or die "Cannot open $bibfile";
    $bibcontents .= $_ while <FH>;
    close FH;
    @bibentries = split(/^\s*(?=@)/m, $bibcontents);
    return @bibentries;
}

sub entry_has_category_keyword {
    my $key_regex = '^\s*@\w+\{([^,]+)';
    my $keywords_regex = '^\s*keywords\s*=\s*\{?([^\}]+)';
    my $kw = shift;

    if (($entry =~ /$keywords_regex/m)  &&
        ($1 =~ /$cat/) &&
        ($entry =~ /$key_regex/)) {
        return($1);
    }
}

sub main {
    my($bibfile) = shift @ARGV;
    my @category_names = @ARGV;

    my @bibentries = &get_bib_entries($bibfile);
    my $count;
    open(CAT, "> custom_bib_categories.tex") or die $!;

    foreach $cat (@category_names) {
        $count = 0;
        print CAT "\n\\DeclareBibliographyCategory{$cat}\n\n";
        foreach $entry (@bibentries) {
            if ($key = &entry_has_category_keyword($entry, $cat)) {
                print CAT "  \\addtocategory{$cat}{$key}\n";
                $count++;
            }
        }
        print STDERR "$count entries in category '$cat'\n";
    }
    close CAT;
}

die "Usage: $0 mybibfile.bib category1 category2 ... categoryN" unless $#ARGV >= 1;
&main;
