This repo aims to show how to build and use gnupoc-package on modern Linux (debian-based distributions).

# Requirements

1. GCC is required (GCC 10 was tested) clang or other compilers probably won't work.

2. 32-bit libraries, you need them to run the pre-built tools GCCE3 and (p7zip, unshield) used for extracting SDK packages, of course assuming your machine is 64bit.

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install ia32-libs
sudo apt install libc6:i386
sudo apt install libstdc++6:i386
sudo apt install zlib1g:i386
```

3. wget used for downloading openssl.

4. dos2unix.

```bash
sudo apt install dos2unix
```

5. an older version of perl5 is required by abd build-system (5.10.1 works fine) i tested an easy way to install it via perlbrew.

```bash
sudo apt install perlbrew
```

```bash
perlbrew init
```
Please read the Instructions... you will be asked to add "source ~/perl5/perlbrew/etc/bashrc" to ~/.profile
after doing so, type bash, then do:

```bash
perlbrew install 5.10.1 --force
```

# EKA2 Build Tools Installation

First clone the repo or download it manually to your home directory.

```bash
git clone https://github.com/JigokuMaster/gnupoc-package.git
```
Note: you can skip building the tools and use the static binaries including GCCE3 , see the release page. 

if you want to build then just like the original [guide](tools/README), download [gcce-3.4](https://www.martin.st/symbian/gnu-csl-arm-2005Q1C-arm-none-symbianelf-i686-pc-linux-gnu.tar.bz2) to your home directory

```bash
cd ~
mkdir csl-gcc
cd csl-gcc
tar -jxvf ../gnu-csl-arm-2005Q1C-arm-none-symbianelf-i686-pc-linux-gnu.tar.bz2
```
Now build & install:

```bash
cd ~/gnupoc-package/tools
./install_eka2_tools ~/csl-gcc
```
to build static binaries run:

```bash
./install_eka2_statictools ~/csl-gcc
```

# SDKs Installation

again, just like the original [guide](sdks/README) ... example installing S60v3 FP 2 SDK:

```bash
cd ~/gnupoc-package/sdks
./install_gnupoc_s60_32 S60_SDK_3.2_v1.1.1_en.zip ~/symbian-sdks/s60_32 
./install_wrapper ~/gnupoc
```
S60 SDKs can be downloaded from [here](https://archive.org/download/nokia_sdks_n_dev_tools)

# Usage

1. find the path of your perl5.10.1 installation and edit PERL5_PATH in ~/gnupoc/gnupoc-common.sh

example:

```bash
#!/bin/sh
EKA1TOOLS=~/symbian-gcc/bin
EKA2TOOLS=~/csl-gcc/bin
PERL5_PATH=~/perl5/perlbrew/perls/perl-5.10.1
```

2. if you have the static binaries extracted in ~/csl-gcc do:
```bash
ln -sf $(which true) ~/csl-gcc/bin/rem
```

3. if your are using S60v3 FP2 SDK ... add this to your .bashrc

```bash
export PATH=~/gnupoc:${PATH}
export EPOCROOT=~/symbian-sdks/s60_32/
```

```bash
source ~/.bashrc
cd ~/symbian-sdks/s60_32/s60cppexamples/helloworldbasic/group
bldmake bldfiles
abld build -v gcce urel
cd ../sis
makesis helloworldbasic_gcce.pkg
```
# Qt Development

First you need GCCE 4.6.3 or higher.

link for [32bit](https://mega.nz/file/e0dzADLA#3bOw1EAhke79HT9EWVlZarCz1tXpa6gkFYjTE1SFiFI)

link for [64bit](https://github.com/xsacha/SymbianGCC/releases/download/4.6.3/gcc4.6.3_x86-64.tar.bz2)

install or extract the archive in your home  directory and rename the gcce directory e.g to ~/csl-gcc4

patch libgcc

```bash
cd ~/gnupoc-package/tools
./fix_csl_gcc_eh ~/csl-gcc4
```
Next download [qt-symbian-opensource-4.7.1-s60.exe](https://ftp.icm.edu.pl/packages/qt.old/source/qt-symbian-opensource-4.7.1-s60.exe)

alternative [link](https://drive.google.com/file/d/1uhEqKeSRqrzhXYYL7A7c6Kb6itnKAeIv/view?usp=sharing) 

download s60_open_c_cpp_plug_in_v1_7_en.zip from [achive.org](https://archive.org/download/nokia_sdks_n_dev_tools)

```bash
./install_openc_175_s60 s60_open_c_cpp_plug_in_v1_7_en.zip ~/symbian-sdks/s60_32
```
Install the Qt SDK

```bash
./install_qt_4.7.1 qt-symbian-opensource-4.7.1-s60.exe -qt ~/symbian-sdks/qt_4.7.1 -sdk ~/symbian-sdks/s60_32
```

Next edit your PATH , you don't need ~/gnupoc wrappers  abld, bldmake etc ...

```bash
export PATH=~/csl-gcc4/bin:~/symbian-sdks/qt_4.7.1/bin:$PATH
export QMAKESPEC=symbian/linux-gcce
```
We need the buildtools at ~/csl-gcc/bin to be in ~/csl-gcc4/bin


```bash
for i in bmconv elf2e32 elftran gendirective \
	genstubs getexports extmake makekeys makesis mifconv rcomp signsis uidcrc
do
	cp ~/csl-gcc/bin/$i ~/csl-gcc4/bin
done

```
or

```bash
for i in bmconv elf2e32 elftran gendirective \
	genstubs getexports extmake makekeys makesis mifconv rcomp signsis uidcrc
do
	ln -s ~/csl-gcc/bin/$i ~/csl-gcc4/bin/$i
done
```

Now build some example

```bash
cd ~/symbian-sdks/qt_4.7.1/examples/widgets/lineedits
qmake
make
make sis
```
