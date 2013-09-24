#!/usr/bin/env perl
# flycheck_haskell.pl

### Please rewrite the following 3 variables
### ($ghc, @ghc_options and @ghc_packages)

$runhaskell = 'runhaskell';  # where is runhaskell (for Cabal)
$ghc = 'ghc';                # where is ghc
@ghc_options  = ();          # e.g. ('-fglasgow-exts')
@ghc_packages = ();          # e.g. ('QuickCheck')

### the following should not been edited ###

use File::Temp qw /tempfile tempdir/;
File::Temp->safe_level( File::Temp::HIGH );

($source, $base_dir) = @ARGV;

$source =~ s/ /\\ /g;
$base_dir =~ s/ /\\ /g;
$source = glob $source;
$base_dir = glob $base_dir;

### Check if the project is Cabalized. We simply look for a
### Setup.[l]lhs and a *.cabal file in the current directory and three
### levels up the filesystem.
@levels = qw|. .. ../.. ../../..|;

undef $cabaldir;

foreach $up (@levels) {
    undef @setup;
    undef @cabal;
    opendir DIR, "$base_dir/$up";
    @files = readdir DIR;
    closedir DIR;
    @setup = grep /^Setup\.(lhs|hs)$/, @files;
    @cabal = grep /^.+\.cabal$/, @files;
    if($#setup == 0 && $#cabal == 0) {
        $cabaldir = "$base_dir/$up";
        last;
    }
}

if($cabaldir) {
    # Cabal file found. Use Setup.[l]hs to build.
    @command = ('cd',
                $cabaldir,
                '&&',
                $runhaskell,
                $setup[0],
                'build');

}
else {
    # No cabal file found. Use ghc --make.
    @command = ($ghc,
                '--make',
                '-fbyte-code',
                "-i$base_dir",
                "-i$base_dir/..",
                "-i$base_dir/../..",
                "-i$base_dir/../../..",
                "-i$base_dir/../../../..",
                "-i$base_dir/../../../../..",
                $source);

    while(@ghc_options) {
        push(@command, shift @ghc_options);
    }

    while(@ghc_packages) {
        push(@command, '-package');
        push(@command, shift @ghc_packages);
    }
}

$dir = tempdir( CLEANUP => 1 );
($fh, $filename) = tempfile( DIR => $dir );
print $filename;
system("@command >$filename 2>&1");
open(MESSAGE, $filename);
undef $processing;
while(<MESSAGE>) {
    if(/(^\S+)(\.hs|\.lhs)(:\d*:\d*:)\s?(.*)/) {
        $file = "$1$2";
        # We print only those error messages that are in the source
        # file passed on the command line.
        if(substr($source, -length($file)) eq $file) {

            $processing = 1;
            print "\n";
            print $source;
            print $3;
            $rest = $4;
            chomp $rest;
            print $rest;
            next;
        }
        else {
            undef $processing;
        }
    }
    if($processing) {
        if(/\s+(.*)/) {
            $rest = $1;
            chomp $rest;
            print $rest;
            print " ";
            next;
        }
    }
}
close($fh);
print "\n";
