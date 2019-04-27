******************
** INSTRUCTIONS **
******************

Building PICO-8 projects on Windows when using Notepad++:

0.

	Set the directory that PICO-8 looks for cartridges to a folder in to your repository.
	The config.txt included in this directory provides an example of this.

1. 

	Download picotool (if you don't already have it)
			https://github.com/dansanderson/picotool

		
2. 

	Create a Windows batch file with a format similar to the following:

			@echo off
			setlocal

			:: Set up source variables
			set cartName="game0.p8"
			echo Attempting to build cartridge %cartName%

			set luaSource="game0.lua"
			echo Lua Source: %luaSource%

			set assetsSource="../demos/collide.p8"
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

		(NOTE: If you're using additional carts for sound or art, feel free to create additional variables for those.)

	
3. 

	Add the following command shortcut to Notepad++ (I recommend binding to SHIFT-F5):
			cmd /K "cd /d $(CURRENT_DIRECTORY)" && build.bat
		
		(NOTE: /K tells cmd to stay open even when it is finished. If you want it to close instead, use /c.)

	
4. 

	Create as many lua files as you need to. You can use require("myFile.lua") 
	to include other lua files. Modify your batch file so it uses your main 
	game lua file as as the "lua source." Press SHIFT-F5 to build and run your cart.
