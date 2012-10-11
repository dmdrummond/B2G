#!/bin/sh
# Copyright (C) 2012 Infinimint
# http://github.com/Infinimint
# http://uniteddev.com/

. "./.config"

rm -rf rom.zip
mkdir work
cd work

# Setup the Folders
cp -r ../rom-tools/$DEVICE-META-INF ./META-INF
mkdir system
mkdir data

# Copy the compiled files
cp ../out/target/product/$DEVICE/system.img ./system/system.img
cp ../out/target/product/$DEVICE/userdata.img ./data/userdata.img
cp ../out/target/product/$DEVICE/boot.img ./boot.img

# Unyaffs the files
cd system
../../rom-tools/unyaffs ./system.img
cd ../data
../../rom-tools/unyaffs ./userdata.img
cd ..

# Delete un-needed files
rm ./system/system.img
rm ./data/userdata.img

# Create Archive
zip -ry rom.zip ./*
java -classpath ../rom-tools/testsign.jar testsign rom.zip rom-signed.zip

# Clean Up
cp ./rom-signed.zip ../rom.zip
cd ..
rm -rf ./work

