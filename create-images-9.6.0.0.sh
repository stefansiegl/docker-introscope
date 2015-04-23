#!/bin/sh
path=$(pwd)

echo "Building Database image"
cd $path/database/9.6.0.0; ./build-image.sh ;

echo "Building enterprise manager image"
cd $path/enterprise-manager/9.6.0.0 ; ./build-image.sh ;

echo "Building webview image"
cd $path/webview/9.6.0.0; ./build-image.sh ;

echo "Building sample application image"
cd $path/sample/9.6.0.0; ./build-image.sh ;
