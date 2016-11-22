#!/bin/bash
#####################
# generate_swiftgen #
#####################
#
# Takes the PROJECT_DIR as arg 1, and PROJECT_NAME as arg 2.
# Given those params, it will ensure you have swiftgen
# installed, and then use swiftgen to generate the latest
# files inside the PROJECT_DIR specified.
# 

generate_swiftgen() {
	PROJECT_DIR=$1
	PROJECT_NAME=$2	

	DOT_DIR="${PROJECT_DIR}/${PROJECT_NAME}"
	RESOURCE_DIR="$DOT_DIR""/Resources"
	CONST_DIR="$RESOURCE_DIR""/Constants"
	BUILD_DIR="$CONST_DIR""/Build"

	if which /usr/local/bin/swiftgen > /dev/null; then
		/usr/local/bin/swiftgen storyboards "$DOT_DIR" --output "$BUILD_DIR""/Storyboards.swift" --template swift3
		/usr/local/bin/swiftgen images "$RESOURCE_DIR""/Assets.xcassets" --output "$BUILD_DIR""/Images.swift" --template swift3
		/usr/local/bin/swiftgen colors "$CONST_DIR""/colors.txt" --output "$BUILD_DIR""/Colors.swift" --template swift3
		/usr/local/bin/swiftgen strings "$CONST_DIR""/Localizable.strings" -output "$BUILD_DIR""/Localizable_Strings.swift" --template swift3
	fi
}

generate_swiftgen $1 $2
