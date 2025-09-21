#!/bin/bash

set -e

echo "downloading openssl ..."

wget -nc -i openssl.txt

echo "building openssl ..."

tar xvf openssl-1.0.2n.tar.gz

OPENSSL_PATH=`realpath ./openssl-1.0.2n`

(cd $OPENSSL_PATH && ./config && $MAKE)

$MAKE CFLAGS="-I$OPENSSL_PATH/include -I../include" LDFLAGS="-static -L$OPENSSL_PATH"

