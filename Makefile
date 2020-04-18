DESTINATION="chrome-linux.zip"
OUTPUT="Chromium.AppImage"



all:
	@echo "Building: $(OUTPUT)\n"
	scripts/latest.sh

	unzip $(DESTINATION)
	rm -rf AppDir/opt

	mkdir --parents AppDir/opt/application
	mv chrome-linux/* AppDir/opt/application

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)

	chmod +x $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf AppDir/opt 
	rm -rf chrome-linux
	rm -f chrome-linux.zip	
