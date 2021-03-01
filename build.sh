cp -r ./source ./tmp
find ./tmp -name '*.md' | xargs gsed -i -E 's/\$([^$]+)\$/``$`\1`$``/g'
make html
rm -rf ./tmp
