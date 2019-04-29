@echo off
setlocal

:: Set up source variables
set cartName="debug/game0.p8"
echo Attempting to build cartridge %cartName%

set luaSource="game0.lua"
echo Lua Source: %luaSource%

set artSource="game0_art.p8"
echo Art Source: %artSource%

set mapSource="game0_map.p8"
echo Map Source: %mapSource%

set soundSource="game0_sound.p8"
echo Sound Source: %soundSource%

:: Attempt to build
@echo on
py ../../tools/p8tool/p8tool.py build %cartName% --lua %luaSource% --gfx %artSource% --gff %mapSource% --map %mapSource% --sfx %soundSource% --music %soundSource%
@echo off

if errorlevel 1 (
	echo.
	echo Build failed. Check p8tool output above for errors.
) else (
	echo Build succeeded! 
	if "%1" == "run" (
		echo Running PICO-8 with cart.
		:: Run the cart if build succeeded
		"C:\Program Files (x86)\PICO-8\pico8.exe" -run %cartName%
	)
)

endlocal
@echo on
