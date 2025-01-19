# docker build . -t mysql:5.7 

# Add the --platform option to explicitly get the amd64 image.
docker build . -t mysql:5.7 --platform linux/x86_64
