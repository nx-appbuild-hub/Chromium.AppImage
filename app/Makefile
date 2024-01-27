# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REVISION:=$(shell curl -s -S https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media)

.PHONY: all

all: clean init

	mkdir --parents build/Boilerplate.AppDir/chromium
	./apprepo --destination=build appdir boilerplate \
	    libgdk-pixbuf2.0-0 libatk1.0-0 libatk-bridge2.0-0 libgtk2.0-0 \
	    libreadline8 at-spi2-core libpango-1.0-0 libselinux1 \
	    libgtk-3-0 libwayland-cursor0

	printf '%s\n'                                                  \
		 ''                                                        \
		 'LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:$${APPDIR}/chromium' \
		 'export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}'              \
		 ''                                                        \
		 ''                                                        \
		 'exec $${APPDIR}/chromium/chrome "$${@}"'                 >> build/Boilerplate.AppDir/AppRun


	wget --output-document=build/build.zip https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$(REVISION)%2Fchrome-linux.zip?alt=media
	unzip build/build.zip -d build

	cp --force --recursive build/chrome-linux/* build/Boilerplate.AppDir/chromium

	rm -f build/Boilerplate.AppDir/*.desktop 		    \
	      build/Boilerplate.AppDir/*.png 		  	    \
	      build/Boilerplate.AppDir/*.svg 		  	    \
	      build/Boilerplate.AppDir/lib64/libstdc++.so.6*

	cp --force AppDir/*.desktop build/Boilerplate.AppDir/ || true
	cp --force AppDir/*.png     build/Boilerplate.AppDir/ || true
	cp --force AppDir/*.svg     build/Boilerplate.AppDir/ || true

	ARCH=x86_64 ./appimagetool build/Boilerplate.AppDir Chromium.AppImage
	chmod +x Chromium.AppImage

init:
	curl -o apprepo https://github.com/area-of-dev/apprepo.AppImage/releases/download/latest/apprepo.AppImage
	curl -o appimagetool https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage
	chmod +x apprepo appimagetool

clean:
	rm -rf *.AppImage build
