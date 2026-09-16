@echo on
setlocal enabledelayedexpansion

set "CHERE_INVOKING=1"
for /f "delims=" %%i in ('bash -lc "cygpath -u %PREFIX%"') do set "PREFIX_UNIX=%%i"

bash -lc "set -e; ./configure --prefix='!PREFIX_UNIX!'; make -j; make install; '$PYTHON' -m pip install -vv --no-deps --ignore-installed ."
if errorlevel 1 exit /b 1
