#!/usr/bin/env bash

set -ex

./configure --prefix="$PREFIX"
if [[ "$target_platform" == win-* ]]; then
    patch_libtool
fi

make -j"${CPU_COUNT}"
make install

"$PYTHON" -m pip install -vv --no-deps --ignore-installed .
