@echo off
setlocal

:: Set up source variables
set cartName="game0.p8"
echo Attempting to build cartridge %cartName%

set luaSource="game0.lua"
echo Lua Source: %luaSource%

set assetsSource="game0.p8"
echo Assets Source: %assetsSource%

:: Attempt to build
@echo on
py ../../tools/p8tool/p8tool.py build %cartName% --gfx %assetsSource% --gff %assetsSource% --sfx %assetsSource% --music %assetsSource% --map %assetsSource% --lua %luaSource%
@echo off

if errorlevel 1 (
	echo.
	echo Build failed. Check p8tool output above for errors.
) else (
	echo Build succeeded! Running PICO-8 with cart.
	:: Run the cart if build succeeded
	"C:\Program Files (x86)\PICO-8\pico8.exe" -run %cartName%
)

endlocal
@echo on
