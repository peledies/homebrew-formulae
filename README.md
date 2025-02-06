## Updating the version

1. change the versions in the xxx.rb file
2. download the tagged release from github (tar.gz)
3. get a new checksum
```
shasum -a 256 ~/Downloads/ktx-0.2.tar.gz
```
4. add the checksum to the xxx.rb file
5. push