#!/bin/bash
rm -r dist
mkdir -p dist/client
mkdir -p dist/backend

cd client
./build.sh
cp -a build/. ../dist/client

cd ..
cd react-backend
./build.sh
cp -a dist/. ../dist/backend


