# save start dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# get GeographicLib
GEOGRAPHICLIB_VERSION="1.49"
GEOGRAPHICLIB_URL="https://sourceforge.net/projects/geographiclib/files/distrib/GeographicLib-$GEOGRAPHICLIB_VERSION.tar.gz"
GEOGRAPHICLIB_DIR="GeographicLib-$GEOGRAPHICLIB_VERSION"

if (ldconfig -p | grep -q libGeographic.so.17 ); then
    echo "GeographicLib version $GEOGRAPHICLIB_VERSION is already installed."
else
    echo "Installing GeographicLib version $GEOGRAPHICLIB_VERSION ..."
    cd ~/Downloads
    wget "$GEOGRAPHICLIB_URL"
    tar -xf "GeographicLib-$GEOGRAPHICLIB_VERSION.tar.gz"
    rm -rf "GeographicLib-$GEOGRAPHICLIB_VERSION.tar.gz"

    cd "$GEOGRAPHICLIB_DIR"
    mkdir BUILD
    cd BUILD
    cmake ..

    make -j3
    make test
    sudo make install > /dev/null
fi

# return to start dir and build
cd $DIR
mkdir BUILD
cd BUILD
cmake ..
make

#test
./Tutorial

