This is ltl2tgba tool from Spot platform (https://spot.lrde.epita.fr/).

Static binaries for all supported platforms are built from Spot v2.8.6
source code (http://www.lrde.epita.fr/dload/spot/spot-2.8.6.tar.gz
or https://workcraft.org/_media/spot/spot-2.8.6.tar.gz) as follows:

* Linux (using GCC v8.3):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations
  make LDFLAGS=-all-static
  make install-strip

* Windows (using MingGW v5.3 toolchain):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations --host x86_64-w64-mingw32
  make LDFLAGS=-all-static
  make install-strip

* OSX (using GCC v8.2):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations
  make LDFLAGS="-all-static -static-ligstdc++ -static-libgcc"
  make install-strip
