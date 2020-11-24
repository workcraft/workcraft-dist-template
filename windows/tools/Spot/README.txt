This is ltl2tgba tool from Spot platform (https://spot.lrde.epita.fr/).

Static binaries for all supported platforms are built from Spot v2.9.5
source code (http://www.lrde.epita.fr/dload/spot/spot-2.9.5.tar.gz
or https://workcraft.org/_media/spot/spot-2.9.5.tar.gz) as follows:

* Linux (using GCC v9.3.0):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations
  make LDFLAGS=-all-static
  make install-strip

* Windows (using MingGW v5.3.1 toolchain):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations --host x86_64-w64-mingw32
  make LDFLAGS=-all-static
  make install-strip

* OSX (using GCC v8.4.0):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations
  make LDFLAGS="-all-static -static-ligstdc++ -static-libgcc"
  make install-strip
