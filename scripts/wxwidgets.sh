#!/usr/bin/bash

set -e

export BUILDDIR=$PWD/build-$TARGET

cd src
tar -xf wxWidgets-3.0.5.tar.bz2
cd wxWidgets-3.0.5
./configure CPPFLAGS="-I$BUILDDIR/zlib/include" LDFLAGS="-L$BUILDDIR/zlib/lib" \
    --host=$TARGET --prefix=$BUILDDIR/wxwidgets --with-zlib=sys --with-msw --with-libiconv-prefix=$BUILDDIR/libiconv \
    --disable-shared --disable-debug_flag --disable-mediactrl --enable-optimise --enable-unicode 
mkdir -p $BUILDDIR/wxwidgets/lib
ln -s lib $BUILDDIR/wxwidgets/lib64
make -j$(nproc) && make install
cd ..
rm -rf wxWidgets-3.0.5