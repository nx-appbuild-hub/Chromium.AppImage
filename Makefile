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
PWD:=$(shell pwd)
LATEST="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"
DESTINATION="build.zip"
OUTPUT="Chromium.AppImage"
REVISION=$(shell curl -s -S $(LATEST))


all: clean
	mkdir --parents $(PWD)/build
	mkdir --parents $(PWD)/build/AppDir	
	mkdir --parents $(PWD)/build/AppDir/chromium		
	mkdir --parents $(PWD)/build/AppDir/share

	wget --output-document=${PWD}/build/build.zip  https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$(REVISION)%2Fchrome-linux.zip?alt=media
	unzip ${PWD}/build/build.zip -d ${PWD}/build

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/zlib-1.2.11-16.el8_2.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	cp --force --recursive ${PWD}/build/chrome-linux/* $(PWD)/build/AppDir/chromium
	cp --force --recursive $(PWD)/build/usr/* $(PWD)/build/AppDir/
	cp --force --recursive $(PWD)/AppDir/* $(PWD)/build/AppDir

	chmod +x $(PWD)/build/AppDir/AppRun
	chmod +x $(PWD)/build/AppDir/*.desktop

	export ARCH=x86_64 && bin/appimagetool.AppImage $(PWD)/build/AppDir $(PWD)/Chromium.AppImage

	chmod +x $(PWD)/Chromium.AppImage

clean:
	rm -rf 	$(PWD)/build
