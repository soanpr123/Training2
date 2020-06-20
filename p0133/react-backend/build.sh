rm -r dist
yarn
yarn build
cp package.json dist/
cp yarn.lock dist/
#cp -r node_modules dist/