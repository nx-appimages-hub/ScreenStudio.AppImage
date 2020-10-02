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
SOURCE="https://github.com/subhra74/snowflake/releases/download/v1.0.4/snowflake-1.0.4-setup-amd64.deb"
DESTINATION="build.deb"
OUTPUT="ScreenStudio.AppImage"


all:
	echo "Building: $(OUTPUT)"

	mkdir --parents AppDir/application
	mkdir --parents AppDir/jre
	mkdir --parents build

	wget --output-document=build.tar.gz --continue http://screenstudio.crombz.com/archives/ubuntu/ScreenStudio-Ubuntu-3.4.2-bin.tar.gz
	tar -zxvf build.tar.gz --directory ./build


	wget --no-check-certificate --output-document=build.rpm --continue https://forensics.cert.org/centos/cert/8/x86_64/jdk-12.0.2_linux-x64_bin.rpm
	rpm2cpio build.rpm | cpio -idmv


	cp --recursive --force build/ScreenStudio.*/* AppDir/application
	cp --recursive --force usr/java/jdk-*/* AppDir/jre

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

	rm -rf *.deb *.rpm
	rm -rf AppDir/application
	rm -rf AppDir/jre
	rm -rf build
	rm -rf usr
