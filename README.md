# PuTTY Extractor

PuTTY Extractor is a simple script that extracts your PuTTY config for SSH & Telnet and parses it out as connection strings for linux/unix/osx command lines.

I put this together in an evening so it's not feature rich. I personally didn't require this tool but thought it might be a nice learning experience.

My main intention was to use the output of the tool to create aliases or port over my sessions to another operating system. It is also helpful at showing where all your keys are if you're untidy like me and spread them all over your system.

## Example

	> python putty-extractor.py
	> ssh nullmode@example.com -p "22" -i "C:\secret.txt" -t "screen -xRR"
	> ssh nullmode@192.168.0.1 -p "22"
	> telnet 192.168.0.1 22

## Install

The script comes in two flavours: PowerShell and Python. Both scripts work the same.

The PowerShell script should be able to be run as is.

The Python script requires the dependancy in the requirements file, so before running you'll need to:

	pip install -r requirements.txt

If you don't have pip you'll need to install winreg_unicode: <http://https://pypi.python.org/pypi/winreg_unicode>

## Limitations

Currently only SSH and Telnet sessions will be extracted, along with a couple
of options from the settings file. This may change in the future.

If your PuTTY config is saved outside of the system registry the extraction will fail.

## Getting PuTTY

If you use windows but not PuTTY you can download it from the following site:
<http://http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html>

You may also be interested in the following:

* KiTTY - http://www.9bis.net/kitty/
* MTPuTTY -  <http://http://ttyplus.com/multi-tabbed-putty/>

## TODO
* Hunt down other useful options to extract
* Implement output formats with arguments
* Support for reading PuTTY settings file (not in registry)
* Tidy up dirty dirty PowerShell
