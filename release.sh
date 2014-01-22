#!/bin/sh 

stamp=`date +%C%y%m%d%H%M`
pkgdir=gen/dotfiles-$stamp

[ -d gen ] && rm -rf gen
mkdir -p $pkgdir

for f in `git ls-files`; do
  cp $f $pkgdir
done

meta=$pkgdir/META

echo "Packaged by `whoami`" > $meta
echo "Packaged at `hostname`" >> $meta
echo "Packaged on `date`" >> $meta
 

(
cd gen
tar cfz ../dotfiles-$stamp.tar.gz *
)

