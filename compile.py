#-*- coding: utf-8 -*-
#!/usr/bin/env python

import os
import shutil
import fnmatch
import time
import genbin

class MediaCompile(object):
	def combineFiles(self, sources, tempfile):
		with open(tempfile, "w") as dest:
			mainfile = "main.lua"
			for filename in sources:
				if filename == mainfile:
					continue
				print(filename)
				dest.write("--" + "#"*100 + '\n')
				dest.write("--" + " "*50 + filename + '\n')
				dest.write("--" + "#"*100 + '\n')
				with open(filename) as src:
					shutil.copyfileobj(src, dest)
			print(mainfile)
			dest.write("--" + "#"*100 + '\n')
			dest.write("--" + " "*50 + mainfile + '\n')
			dest.write("--" + "#"*100 + '\n')
			with open(mainfile) as src:
				shutil.copyfileobj(src, dest)	

	def compile(self, sources, binfile):
		tmpfile = binfile + ".tmp"
		self.combineFiles(sources, tmpfile)
		print("###compile --> %s" %(binfile))		
		os.system("luac -s -o %s %s" %(binfile, tmpfile))
		
if __name__ == '__main__':
	src = ["main.lua", "setting.lua", "timer.lua"]
	target = "main"
	machine="diancilu00001"

	luacfile = target + ".luac"
	tool = MediaCompile()
	tool.compile(src, luacfile)

	genbin.MediaScript().tobin(luacfile, target+".bin", machine)


	#os.remove(tmpfile)
	time.sleep(5)