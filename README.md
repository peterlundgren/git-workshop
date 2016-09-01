git-workshop
============


Install LaTeX
-------------

Follow installation instructions from (here)[1]. Here's a brief summary:

  [1]: http://tex.stackexchange.com/questions/1092/how-to-install-vanilla-texlive-on-debian-or-ubuntu

    cd /tmp
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar -xzf install-tl-unx.tar.gz
    cd install-tl-20160722
    sudo ./install-tl

Command `i` to start installation. This took an hour and a half.

Add /usr/local/texlive/2016/texmf-dist/doc/info to INFOPATH.
Add /usr/local/texlive/2016/texmf-dist/doc/man to MANPATH.
Add /usr/local/texlive/2016/bin/x86_64-linux to PATH.

    sudo apt-get install equivs
    mkdir -p /tmp/tl-equivs && cd /tmp/tl-equivs
    wget http://www.tug.org/texlive/files/debian-equivs-2016-ex.txt
    /bin/cp -f debian-equivs-2016-ex.txt texlive-local
    gedit texlive-local # only if necessary, see [here][2] for details


Build
-----

    sudo apt-get install python-pip
    sudo pip install Pygments

    make
