#!/usr/bin/env bash

set -ex

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"

./configure --prefix="$PREFIX" \
    --with-cfitsio-prefix="$PREFIX" \
    --with-gsl-prefix="$PREFIX" || {
    echo "===== config.log files ====="
    cat config.log
    echo "===== end config.log ====="
    exit 1
}

if [[ "$target_platform" == win-* ]]; then
    patch_libtool
    make -j1 V=1
else
    make -j"${CPU_COUNT}"
fi

make install

"$PYTHON" -m pip install -vv --no-deps --ignore-installed .
