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
LATEST="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"
REVISION=$(shell curl -s -S $(LATEST))
PWD:=$(shell pwd)

all: 

	mkdir --parents $(PWD)/build
	mkdir --parents $(PWD)/build/Boilerplate.AppDir
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/chromium
	

	# apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libglib2.0-0 shared-mime-info libffi7 libselinux1 libpango-1.0-0 \
	# 										libgdk-pixbuf2.0-0 librsvg2-2 adwaita-icon-theme libgtk-3-0 libncurses5 libncurses6 gsettings-desktop-schemas

	# wget --output-document=${PWD}/build/build.zip  https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$(REVISION)%2Fchrome-linux.zip?alt=media
	# unzip ${PWD}/build/build.zip -d ${PWD}/build

	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:$${APPDIR}/chromium' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'UUC_VALUE=`cat /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null`' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'if [ -z "$${UUC_VALUE}" ]' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    then' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '        exec $${APPDIR}/chromium/chrome --no-sandbox "$${@}"' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    else' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '        exec $${APPDIR}/chromium/chrome "$${@}"' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    fi' >> $(PWD)/build/Boilerplate.AppDir/AppRun


	cp --force --recursive $(PWD)/build/chrome-linux/* $(PWD)/build/Boilerplate.AppDir/chromium

	rm --force $(PWD)/build/Boilerplate.AppDir/*.desktop

	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Boilerplate.AppDir/
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Boilerplate.AppDir/ || true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Chromium.AppImage
	chmod +x $(PWD)/Chromium.AppImage

clean:
	rm -rf $(PWD)/build
