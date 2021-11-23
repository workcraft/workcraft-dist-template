This is ltl2tgba tool from Spot platform (https://spot.lrde.epita.fr/).

Static binaries for all supported platforms are built from Spot v2.10.1
source code (http://www.lrde.epita.fr/dload/spot/spot-2.10.1.tar.gz
or https://workcraft.org/_media/spot/spot-2.10.1.tar.gz) as follows:

* Linux (using GCC v9.4.0):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations --prefix ~/spot
  make LDFLAGS=-all-static
  make install-strip

* Windows (using MingGW v9.3.0 toolchain and https://github.com/meganz/mingw-std-threads for std::thread support):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations --host x86_64-w64-mingw32 --prefix ~/spot
  make LDFLAGS=-all-static
  make install-strip

* OSX (using GCC v8.4.0):
  ./configure --disable-shared --disable-python --disable-devel --enable-optimizations --prefix ~/spot
  make LDFLAGS="-all-static -static-ligstdc++ -static-libgcc"
  make install-strip
